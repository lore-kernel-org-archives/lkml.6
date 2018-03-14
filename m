Return-Path: <SRS0=5xW2=GE=gmail.com=htejun@kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2426127-1521056750-2-16709718180063306641
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='198.145.29.99', Host='mail.kernel.org', Country='US', FromHeader='org',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: SRS0=5xW2=GE=gmail.com=htejun@kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521056750; b=jJdajbHc1+1BDx7q4ugbx0yfAmdDEZiKSCQU09gKfSxmucj
    yp8YCW6c6nhz+ey18T+06BLdd7g/AhNst2grW1nAfuSZ8gIDYoJ+7QXcGuUMyHEe
    1VObVgCDp3qx7+zlrbzTnn6LoY52Gh3LEXS71ZWDJhd9bCSeIHnzfL4z/xbLbwwL
    sunlIgZQj5wOrSdohDDwIiy/lEAhogYaok3V4TOhd4le950oWlPfrHZcjCze1JY+
    EUAWjrb9ma0OQC62StlFrt3Q0sGOgLcouTzJmNnjfrtC2lFUbb9bG+tWt1L7xgag
    N+F6zoLWECLyYOgwXAET+aofBhdvNYHkmyDLHnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=sender:from:to:cc:subject:date:message-id
    :in-reply-to:references; s=arctest; t=1521056750; bh=lJ/OYVV3ay4
    rJl2V05XRaZMsotXLEQ2KAPUklVM9sXM=; b=Q2wHUCzawh/xPqrg1KpN9Pk3YD4
    b275GWHhjEUaSPmKq9hQF8SxzuoMB3nLpZvjpdiZxabAvmBDtN1xh98KPVMNFu9H
    jP2WBLWpIF8Z+/z3SKpK6uJU9L3gT/8eNnGOYELWCKc5O8GeUBkempQ/jPhuqDGV
    FRNa2alT+CbvBaNjxQFx0kpnxWxu7Q0Dkwgc9Wo2pqztolb/RAmcmecxhbtX5voP
    jjRlJyO3Pn2cOLWknaJ90xDc1D8179fMOPurW1wJDW5GoVOrspMULRvu/o3KHHwk
    jPF8O2sOHxbVnHTN1iY5bi48GS80yktyOzS8M607LZ5KNsZHZE2g0P5OxBA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=edjhmy7s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q2m9HKcG;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=edjhmy7s x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=198.145.29.99 (mail.kernel.org);
    spf=none smtp.mailfrom=SRS0=5xW2=GE=gmail.com=htejun@kernel.org smtp.helo=mail.kernel.org;
    x-aligned-from=domain_pass;
    x-category=clean score=0 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=q2m9HKcG;
    x-ptr=pass x-ptr-helo=mail.kernel.org x-ptr-lookup=mail.kernel.org;
    x-return-mx=pass smtp.domain=kernel.org smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: security@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67E682077A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=htejun@gmail.com
X-Google-Smtp-Source: AG47ELtGCqjFCaCYm7JPGAFtrhcqmofpbeU8U6FNgbH7SVUdzxeplb9u2h5sCg8XsPsvX9k4FAFRjg==
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org,
	jannh@google.com,
	paulmck@linux.vnet.ibm.com,
	bcrl@kvack.org,
	viro@zeniv.linux.org.uk,
	kent.overstreet@gmail.com
Cc: security@kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@fb.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7/8] cgroup: Use rcu_work instead of explicit rcu and work item
Date: Wed, 14 Mar 2018 12:45:14 -0700
Message-Id: <20180314194515.1661824-7-tj@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20180314194515.1661824-1-tj@kernel.org>
References: <20180314194205.1651587-1-tj@kernel.org>
 <20180314194515.1661824-1-tj@kernel.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Workqueue now has rcu_work.  Use it instead of open-coding rcu -> work
item bouncing.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Hello,

If there's no objection, I'll route this together with rcu_work patch
through wq/for-4.17.

Thanks.

 include/linux/cgroup-defs.h |  2 +-
 kernel/cgroup/cgroup.c      | 21 +++++++--------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 9f242b8..92d7640 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -151,8 +151,8 @@ struct cgroup_subsys_state {
 	atomic_t online_cnt;
 
 	/* percpu_ref killing and RCU release */
-	struct rcu_head rcu_head;
 	struct work_struct destroy_work;
+	struct rcu_work destroy_rwork;
 
 	/*
 	 * PI: the parent css.	Placed here for cache proximity to following
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 8cda3bc..4c5d4ca0 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4514,10 +4514,10 @@ static struct cftype cgroup_base_files[] = {
  * and thus involve punting to css->destroy_work adding two additional
  * steps to the already complex sequence.
  */
-static void css_free_work_fn(struct work_struct *work)
+static void css_free_rwork_fn(struct work_struct *work)
 {
-	struct cgroup_subsys_state *css =
-		container_of(work, struct cgroup_subsys_state, destroy_work);
+	struct cgroup_subsys_state *css = container_of(to_rcu_work(work),
+				struct cgroup_subsys_state, destroy_rwork);
 	struct cgroup_subsys *ss = css->ss;
 	struct cgroup *cgrp = css->cgroup;
 
@@ -4563,15 +4563,6 @@ static void css_free_work_fn(struct work_struct *work)
 	}
 }
 
-static void css_free_rcu_fn(struct rcu_head *rcu_head)
-{
-	struct cgroup_subsys_state *css =
-		container_of(rcu_head, struct cgroup_subsys_state, rcu_head);
-
-	INIT_WORK(&css->destroy_work, css_free_work_fn);
-	queue_work(cgroup_destroy_wq, &css->destroy_work);
-}
-
 static void css_release_work_fn(struct work_struct *work)
 {
 	struct cgroup_subsys_state *css =
@@ -4621,7 +4612,8 @@ static void css_release_work_fn(struct work_struct *work)
 
 	mutex_unlock(&cgroup_mutex);
 
-	call_rcu(&css->rcu_head, css_free_rcu_fn);
+	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
+	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 }
 
 static void css_release(struct percpu_ref *ref)
@@ -4755,7 +4747,8 @@ static struct cgroup_subsys_state *css_create(struct cgroup *cgrp,
 err_list_del:
 	list_del_rcu(&css->sibling);
 err_free_css:
-	call_rcu(&css->rcu_head, css_free_rcu_fn);
+	INIT_RCU_WORK(&css->destroy_rwork, css_free_rwork_fn);
+	queue_rcu_work(cgroup_destroy_wq, &css->destroy_rwork);
 	return ERR_PTR(err);
 }
 
-- 
2.9.5
