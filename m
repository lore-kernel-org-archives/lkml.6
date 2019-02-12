Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 370D5C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 041FF222CD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLRPP0yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732149AbfBLSsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:48:24 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:32929 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732130AbfBLSsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:48:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id c123so1726993pfb.0;
        Tue, 12 Feb 2019 10:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pSVREjPCAv5T2ZXAYt7SDw0JOGFlD724donHrtDZGs4=;
        b=GLRPP0yzDLzk0MN9BwvvmnuUtFsAUZLxv7dsvHDb7JDWWEfLIuqRdbg4iSK35Cwktj
         dNfoJAGoY4amkqZCUKX/+07ghQ92hKQYCuirfEjguyYz3ftBeEzZL31V1uyN360oR27H
         rEOmr9hWWHa/i8NqCZsMI8VVdVDRcZZesH7IrLKP9vGJuDzuZkm2IC1bz3v4PwBdhFgR
         5k/qe0PfxDx68KL9xNtNaV+w/fWZgkGWehmxDokcg7fI59t9q5ovYnHcrg8OyS1IEsSP
         B9YlzdBeClviN08HrNu93/iqcvxNiomGnRLoyb5zuo0xP5r/5xkwQM4eeo98cVPjtJ4u
         9Q4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pSVREjPCAv5T2ZXAYt7SDw0JOGFlD724donHrtDZGs4=;
        b=EchraUM0b88a75DUlR0zHJVCdCIeq4nCn4gYO4b8YVESNhLIMIdGDOfbSeGVWUFbpi
         BtPjyT7YgPZ1emZxBUyz6nN8MvvfTF4tMdVquvimlygpj024oU+VHcJVtP4mKADRyZ+9
         tPSsuQMfxbSgtcvoC7u5/4IoFyWCojkT/DR7mSd2idbT4rriydX+kROgmPqmXAP14cHX
         pMdJBkR/zJDN9vgHDZJjFDxBybFkvtBtzBzYbTdrKHz77dVOyN0b6B/fI9LsmoAfDzHL
         lfGEnrhxhGZOkFOVUnXwT7PI/JVYHlpd3sufokIyQ9aHq2GCDIh6YHaGxxYW15OU/pRR
         hz1w==
X-Gm-Message-State: AHQUAubVF5y89Dm8tXvHl3uPPwCTRj6ckyi2iixfFIOx6bS6h3ku1QqD
        oOYlKv1sLZzhsBJmNBzAKgA=
X-Google-Smtp-Source: AHgI3IbJpKreYkZiEqMxhjvslkc+KbQObjTE6pvdCJP9gNC+2er+9h7uhHhtKRLOdjHe96YfPVnJmA==
X-Received: by 2002:a63:f816:: with SMTP id n22mr4948399pgh.146.1549997299865;
        Tue, 12 Feb 2019 10:48:19 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::5:4d62])
        by smtp.gmail.com with ESMTPSA id f67sm25480102pfc.141.2019.02.12.10.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 10:48:19 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     kernel-team@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: [PATCH v7 3/7] cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
Date:   Tue, 12 Feb 2019 10:48:03 -0800
Message-Id: <20190212184807.20304-4-guro@fb.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212184807.20304-1-guro@fb.com>
References: <20190212184807.20304-1-guro@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of descendant cgroups and the number of dying
descendant cgroups are currently synchronized using the cgroup_mutex.

The number of descendant cgroups will be required by the cgroup v2
freezer, which will use it to determine if a cgroup is frozen
(depending on total number of descendants and number of frozen
descendants). It's not always acceptable to grab the cgroup_mutex,
especially from quite hot paths (e.g. exit()).

To avoid this, let's additionally synchronize these counters using
the css_set_lock.

So, it's safe to read these counters with either cgroup_mutex or
css_set_lock locked, and for changing both locks should be acquired.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 include/linux/cgroup-defs.h | 5 +++++
 kernel/cgroup/cgroup.c      | 6 ++++++
 2 files changed, 11 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 120d1d40704b..319c07305500 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -348,6 +348,11 @@ struct cgroup {
 	 * Dying cgroups are cgroups which were deleted by a user,
 	 * but are still existing because someone else is holding a reference.
 	 * max_descendants is a maximum allowed number of descent cgroups.
+	 *
+	 * nr_descendants and nr_dying_descendants are protected
+	 * by cgroup_mutex and css_set_lock. It's fine to read them holding
+	 * any of cgroup_mutex and css_set_lock; for writing both locks
+	 * should be held.
 	 */
 	int nr_descendants;
 	int nr_dying_descendants;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b230afccf635..7438c24297d4 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4758,9 +4758,11 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgroup_on_dfl(cgrp))
 			cgroup_rstat_flush(cgrp);
 
+		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
 		     tcgrp = cgroup_parent(tcgrp))
 			tcgrp->nr_dying_descendants--;
+		spin_unlock_irq(&css_set_lock);
 
 		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id = -1;
@@ -4978,12 +4980,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	if (ret)
 		goto out_psi_free;
 
+	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		cgrp->ancestor_ids[tcgrp->level] = tcgrp->id;
 
 		if (tcgrp != cgrp)
 			tcgrp->nr_descendants++;
 	}
+	spin_unlock_irq(&css_set_lock);
 
 	if (notify_on_release(parent))
 		set_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -5268,10 +5272,12 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
 	if (parent && cgroup_is_threaded(cgrp))
 		parent->nr_threaded_children--;
 
+	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgroup_parent(cgrp); tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		tcgrp->nr_descendants--;
 		tcgrp->nr_dying_descendants++;
 	}
+	spin_unlock_irq(&css_set_lock);
 
 	cgroup1_check_for_release(parent);
 
-- 
2.20.1

