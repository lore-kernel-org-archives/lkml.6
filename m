Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 706FEC07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 302B6208E7
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 20:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zab/XM4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 302B6208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbeLGUPm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 15:15:42 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42262 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbeLGUPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 15:15:39 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so2176310pga.9;
        Fri, 07 Dec 2018 12:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AF6FjZ5bYHqrhn2j5NEFo6/8zOWEnmu3uN/KpDBNyX8=;
        b=Zab/XM4V325VwLDjQweH6/BjCmL72mI1hULkW0qXSRg8VLOY0XFTvNNtOPrJPZL50C
         eq1kPcbT++Kv9gQaRQassMfIIa4TjxnlWxGak0TIK7KWHKsTDevl5n1aPTBKIRaMtcH/
         365X7yjF6admMely003US2abDL4tEZEVQgPShcLtBSzu5G5XPFq+qeIcA4aakQh5koOR
         TORvjAVHpA3Qe53DyMmCvUk51knVyBPPacmJ+uHZyyIKVCbu5fVA1PIV8JJZS4UMqNcO
         0Bs1g+Zfffl7P022i3lO54vLdB20PdVYUCzQuEUJ8pOZHdDatawPP6aoODY3S4xa5tGg
         Cbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AF6FjZ5bYHqrhn2j5NEFo6/8zOWEnmu3uN/KpDBNyX8=;
        b=PxOWmIF9WmxBi0lZVkSsghhTGjebyDHYrMJoFOdRo5sBGsECQ4UMpbvhEjcTOQop5N
         1p+F4XA+sRy9Ym0vahcOVRaRGkOGKdHq3eYRPtOOBUfybaxxqZZz0ve6C+gW3CjgJ1Fd
         11WyqLDNxUjcwpbr52lELuGmnOji1knJH73hlTJ93ADtkSoMVdTayoU3WDNyoXukmSgk
         PUqHclnY1kz5kB9LM2Nhywis2dcoJOs6CKsnZe5Iy6F7j/mFhznraS52SFxRmh5SZkYZ
         R9ME0dfFUfoENNAbZl5nanhHdqwEofg0Ki98Z9p/fBjYeLjL+C3Rpt/Qb29EKl0xjtTj
         3ylA==
X-Gm-Message-State: AA+aEWbXLciIOVs00VD8ZOvtwHSFXoEkJ4+9CJ94sXnGI2pT6oW1RJoF
        MshZL7WOUPRBxngWJ9+n7+8=
X-Google-Smtp-Source: AFSGD/W9Uo+dyGKJC3EyYGG4gUbwzT3syau4aeixLuZm/XXzFbmUHUFNos5Py5QC5NN1ilRKzr/cjw==
X-Received: by 2002:a63:d846:: with SMTP id k6mr3216257pgj.251.1544213738150;
        Fri, 07 Dec 2018 12:15:38 -0800 (PST)
Received: from castle.thefacebook.com ([2620:10d:c090:200::6:d83b])
        by smtp.gmail.com with ESMTPSA id q75sm5870898pfa.38.2018.12.07.12.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Dec 2018 12:15:37 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v5 3/7] cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
Date:   Fri,  7 Dec 2018 12:15:27 -0800
Message-Id: <20181207201531.1665-4-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181207201531.1665-1-guro@fb.com>
References: <20181207201531.1665-1-guro@fb.com>
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
index 8fcbae1b8db0..03355d7008ff 100644
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
index 7519a4307021..f89dde50f693 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4723,9 +4723,11 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgroup_on_dfl(cgrp))
 			cgroup_rstat_flush(cgrp);
 
+		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
 		     tcgrp = cgroup_parent(tcgrp))
 			tcgrp->nr_dying_descendants--;
+		spin_unlock_irq(&css_set_lock);
 
 		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id = -1;
@@ -4943,12 +4945,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
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
@@ -5233,10 +5237,12 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
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
2.17.2

