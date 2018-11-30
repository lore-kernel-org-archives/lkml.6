Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0276020834
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 23:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JThfV7kp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0276020834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeLALA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 06:00:26 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39364 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726852AbeLAK65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 05:58:57 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so3531375pld.6;
        Fri, 30 Nov 2018 15:47:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/h4U+0DlXHetF6XB/+D6rzr4Gg58Kl4UP4B7kNYPeno=;
        b=JThfV7kp9wcDzrPZgdTbabbZpSVI9ItSk8wpytvn7gublh82rCVNJCNegNGUWFzSa9
         Y45i1Xye15z/9mArt2XiZRxQIMX8Wov4/aLURF6CHH73guSQIxKvZollYo4uuF7czSZZ
         nITwdevuuth3Bdo278SY3QMNUXp9WA/1SqxH/8dADzCWDLeEY0PKWvppCkffvmqCo40R
         HLcT2jshxHhN0cy60zW1jTiFl71YjACtAaTdrAEcmKIMpEM9pPeq3RCdhOE+dkoTH04Y
         v7VyFBdH4B6dtMmjzSMIpXQAoeqsUaLsoYZsFH/2VJsswK9f7IYOAt5U++kGcunyPq+3
         7gcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/h4U+0DlXHetF6XB/+D6rzr4Gg58Kl4UP4B7kNYPeno=;
        b=VoZ7sUVXZU++DTtnziIC9F8cfQIZdNA8SWJS4xMv8STbO18tFQbRc5YEI7l9qn0/I7
         eFMyPnkLHa0HGdpKLmMfBcPrE0VPb+pNc1KyPFAvZBhgq41Nt8nlJe+aAw8XcD7VSYrW
         BtDANSLCA5oU0uQ1VqmkVN0XaKpkRRqL4SBt8zswXGi6VK9I5NmjK5/lZHNq9emL3EnH
         RT+GO4eNwmiNpZUg2YND5G3VBdqsfOkBYdJcvtQmrMx+Nl9BWNSB8doTP+T5KRnip3Up
         84JsBt88qJiR7xCeQl5kh60zI+mhVKcIcdnAv91dqoUhQHIcnwjb0jgWpM86ZtAC0ymX
         Cekw==
X-Gm-Message-State: AA+aEWY5HFEXQj31RjNCKjmsgHk3mdenn+iaDVcnzUyAOGi1tHUu8ces
        KHTUePvpSqj2EQSoTKiuOG8=
X-Google-Smtp-Source: AFSGD/U2s02inVCloo1rMj03UW06OtnoIHTLeNtEKvPEWOvIWkPRAvQ07YyG9W74tkLfYS9uxwhCQQ==
X-Received: by 2002:a17:902:722:: with SMTP id 31mr7588186pli.271.1543621676709;
        Fri, 30 Nov 2018 15:47:56 -0800 (PST)
Received: from castle.tfbnw.net ([2620:10d:c090:180::1:2b61])
        by smtp.gmail.com with ESMTPSA id e188sm9556742pfg.130.2018.11.30.15.47.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 30 Nov 2018 15:47:56 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>, Oleg Nesterov <oleg@redhat.com>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v4 3/7] cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
Date:   Fri, 30 Nov 2018 15:47:41 -0800
Message-Id: <20181130234745.6756-4-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181130234745.6756-1-guro@fb.com>
References: <20181130234745.6756-1-guro@fb.com>
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
 include/linux/cgroup-defs.h | 3 +++
 kernel/cgroup/cgroup.c      | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 8fcbae1b8db0..4327fd6e8121 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -348,6 +348,9 @@ struct cgroup {
 	 * Dying cgroups are cgroups which were deleted by a user,
 	 * but are still existing because someone else is holding a reference.
 	 * max_descendants is a maximum allowed number of descent cgroups.
+	 *
+	 * nr_descendants and nr_dying_descendants are protected
+	 * by cgroup_mutex and css_set_lock.
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

