Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A08C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E6E208E7
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 00:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ru0kcIM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6E6E208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730796AbeKQKxP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:53:15 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:35215 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbeKQKxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:53:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id v9-v6so12151732pff.2;
        Fri, 16 Nov 2018 16:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g+x0Z8u1o4aOWMcidhd9IWCml4xwrNc4H7EaMb8VtdA=;
        b=Ru0kcIM4utPcHoBGfTYmpaShtLyReVfIpaLr6Zj+WPIlxZKnKd7zIQiCVjzDexKfgs
         IzhMurfmNkQAWAy7yZn4zAr2xbuF0CdESDr2V1/entgxH7URYTOJ3O2oguyhuIYGgJP1
         wQsyPuEBilOFqZTCVTchgjtalPoEMIl8hhKIPJt1nGGdiKWInZiXslus0fg9OhEpBPik
         oXdBX+2kIXfAFhbn1bLeBm7EV5FaMttE1d5Bdjykz+sfbSGuCSSium5m1hkEg0gPBpaA
         lSMTqkmxYCv2Ma0YV/5Ix1lhSZxrpvYWfS0UMPdzDdCbk+kT2clNnMlzwR7VYHShF1lS
         E67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g+x0Z8u1o4aOWMcidhd9IWCml4xwrNc4H7EaMb8VtdA=;
        b=HdlgyuLNQZPqeRy2lnRwPUhMhdP0KDPxqkTqQQdH4/lhjAYXyOHz2+TNl5rfr2GNih
         ozx3so1Spy4sjSqZdvRslzTNHdTsN7N0G9xwvUQ8aEdUI2VSAE9lMKTalrzC+ITeFRAQ
         hbXvIJ4eUqYIpiRRzhrxicHVgE2vSlXKZNz869TK04CRtTLa1IJ4ZCAzQpOy2uN3KTXI
         WNoiN6VvUFDQx1XkxJKMEPGI/3uuO7a3PFMZMPD7LbukgnzWPgp6lICtOlxdvPwONEMZ
         cSOGv39nh3VtgVsB+KQj5zg7IfSTZVzT78T1q1uF1xpojUsHPSOZi/tJesMdngQqZaIT
         OLsg==
X-Gm-Message-State: AGRZ1gK+ni7rLoC+lXSGiMF1XxybxOk9P891wS+hlXfSyX01tTuEBHRZ
        tp5CNKD/Ozva1/KNW656NRelVLUNFbo=
X-Google-Smtp-Source: AJdET5eIf/+hAiYWlrnR4HuiB3wU7YYAKWLLB3QxBl4jrpcKniC1TJq6p5uMyugwFCUlctevGagPsQ==
X-Received: by 2002:a63:64c:: with SMTP id 73mr11809507pgg.373.1542415118072;
        Fri, 16 Nov 2018 16:38:38 -0800 (PST)
Received: from tower.thefacebook.com ([2620:10d:c090:200::4:2b73])
        by smtp.gmail.com with ESMTPSA id f6sm1981177pfg.188.2018.11.16.16.38.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Nov 2018 16:38:37 -0800 (PST)
From:   Roman Gushchin <guroan@gmail.com>
X-Google-Original-From: Roman Gushchin <guro@fb.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Roman Gushchin <guro@fb.com>
Subject: [PATCH v3 3/7] cgroup: protect cgroup->nr_(dying_)descendants by css_set_lock
Date:   Fri, 16 Nov 2018 16:38:26 -0800
Message-Id: <20181117003830.15344-4-guro@fb.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20181117003830.15344-1-guro@fb.com>
References: <20181117003830.15344-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now the number of descendant cgroups and the number of dying
descendant cgroups are synchronized using the cgroup_mutex.

The number of descendant cgroups will be required by the cgroup v2
freezer, which will use it to determine if a cgroup is frozen
(depending on total number of descendants and number of frozen
descendants). It's not always acceptable to grab the cgroup_mutex,
especially from quite hot paths (e.g. exit()).

To avoid this, let's additionally synchronize these counters
using the css_set_lock.

Signed-off-by: Roman Gushchin <guro@fb.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: kernel-team@fb.com
---
 include/linux/cgroup-defs.h |  3 +++
 kernel/cgroup/cgroup.c      | 20 ++++++++++++++++----
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 22254c1fe1c5..9e77559c7f49 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -346,6 +346,9 @@ struct cgroup {
 	 * Dying cgroups are cgroups which were deleted by a user,
 	 * but are still existing because someone else is holding a reference.
 	 * max_descendants is a maximum allowed number of descent cgroups.
+	 *
+	 * nr_descendants and nr_dying_descendants are protected
+	 * by css_set_lock.
 	 */
 	int nr_descendants;
 	int nr_dying_descendants;
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index ef3442555b32..2241cb1d1238 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -3409,11 +3409,15 @@ static int cgroup_events_show(struct seq_file *seq, void *v)
 static int cgroup_stat_show(struct seq_file *seq, void *v)
 {
 	struct cgroup *cgroup = seq_css(seq)->cgroup;
+	int nr_descendants, nr_dying_descendants;
 
-	seq_printf(seq, "nr_descendants %d\n",
-		   cgroup->nr_descendants);
-	seq_printf(seq, "nr_dying_descendants %d\n",
-		   cgroup->nr_dying_descendants);
+	spin_lock_irq(&css_set_lock);
+	nr_descendants = cgroup->nr_descendants;
+	nr_dying_descendants = cgroup->nr_dying_descendants;
+	spin_unlock_irq(&css_set_lock);
+
+	seq_printf(seq, "nr_descendants %d\n", nr_descendants);
+	seq_printf(seq, "nr_dying_descendants %d\n", nr_dying_descendants);
 
 	return 0;
 }
@@ -4684,9 +4688,11 @@ static void css_release_work_fn(struct work_struct *work)
 		if (cgroup_on_dfl(cgrp))
 			cgroup_rstat_flush(cgrp);
 
+		spin_lock_irq(&css_set_lock);
 		for (tcgrp = cgroup_parent(cgrp); tcgrp;
 		     tcgrp = cgroup_parent(tcgrp))
 			tcgrp->nr_dying_descendants--;
+		spin_unlock_irq(&css_set_lock);
 
 		cgroup_idr_remove(&cgrp->root->cgroup_idr, cgrp->id);
 		cgrp->id = -1;
@@ -4899,12 +4905,14 @@ static struct cgroup *cgroup_create(struct cgroup *parent)
 	if (ret)
 		goto out_idr_free;
 
+	spin_lock_irq(&css_set_lock);
 	for (tcgrp = cgrp; tcgrp; tcgrp = cgroup_parent(tcgrp)) {
 		cgrp->ancestor_ids[tcgrp->level] = tcgrp->id;
 
 		if (tcgrp != cgrp)
 			tcgrp->nr_descendants++;
 	}
+	spin_unlock_irq(&css_set_lock);
 
 	if (notify_on_release(parent))
 		set_bit(CGRP_NOTIFY_ON_RELEASE, &cgrp->flags);
@@ -4956,6 +4964,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 
 	lockdep_assert_held(&cgroup_mutex);
 
+	spin_lock_irq(&css_set_lock);
 	for (cgroup = parent; cgroup; cgroup = cgroup_parent(cgroup)) {
 		if (cgroup->nr_descendants >= cgroup->max_descendants)
 			goto fail;
@@ -4968,6 +4977,7 @@ static bool cgroup_check_hierarchy_limits(struct cgroup *parent)
 
 	ret = true;
 fail:
+	spin_unlock_irq(&css_set_lock);
 	return ret;
 }
 
@@ -5187,10 +5197,12 @@ static int cgroup_destroy_locked(struct cgroup *cgrp)
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

