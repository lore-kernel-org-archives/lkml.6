Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-811314-1526501852-2-728657658131924073
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.248, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='at',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526501850; b=ZoKTj9TXnY8PSttaAvf2KYLiiDLVs7QMVJGhqUilxnmGT7uW1w
    lWPCFKOtwltfbQshBpki8K8pht5Kvl+kUmUwt/OhBoB/krFOcM/23j7GY34CSTAN
    +J+D4vv9xwOK52bMdOsrVRBSWMYoQPI5o4sLRnDFm1FarF9ZEdbbPJ/0ECyUf3gh
    sjpNlAx8UGYHvbu4KJARUc7sK1AvvRqZAfYtTmdvHJod94+mui3n9VGOOiWBPyy+
    2tf7USo0fBPrSy/dErN6U67Ooe4ryFwqCnSlgg9QsH8XeTseuqBYHp15N0NrXzOl
    +cyuH22MRqWCpiNtncW6D4eVzo98ouWOUY5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=fm2; t=1526501850; bh=z/SgghYSkKGr25yTmT70fUtDKiCkdK
    XFOhOwu8tFBdM=; b=kEKHPuH7WvyVQDrQHEayXaJ8kmnv6A+KEhFXy+ZP4aOJtz
    gh31+vS0ndlQXeDkvrCVYn3B8rwCJoWSBXTB+gS0JiYxknQC/gqHwotjjb6UWCDa
    Ww8I9DXaOvmEG87JBjtF4o8paYEtnQfM4psJn4+v/sA6RcToDEA9+EvQtAZTCsWz
    m02kfTkexxBgxxC185la82MCDJo60IT/p3I+n8b22Voyz8CoV9Eq8RymxGA2ibVv
    0kaT1ekAWTfwJPLEo+CNzdf2k8Abo1zkqDaQM7ZlUl/SaciOn3InODk1wFihpePL
    a40O6v5pxBVQCncB/FYellQwOqm1QvugvLHQtWSA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=nod.at header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=nod.at;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=nod.at header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfJnAls+bQVF9j4Gf7ja+5/4Zdjm7B0UNTssnPJKCP+J6aP0QcLz4ngz/y8YCpp2IhOBKDjBlQURo1L4TxafjcTHGJCa4EGDWgSiq2yYtAPElIEeODOvo
    mdd/RKcIPT1GTVXk5rYmyUHQAkY3i3UWTUPnzUhT5Cs0yv/u4jFSqUmhe6bwGGB+7Wfz1VReDsK/2yKo3uA5z3AhsW4c7ioIgplDuZIlga/xECin54s9e2oT
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8
    a=1EsaE_6oAAAA:8 a=pGLkceISAAAA:8 a=jgrq2Z4IqGr_Kvm92yEA:9
    a=G0afifPiGC5z3Ifn:21 a=4ZZup7lqkjlT2QFD:21 a=AjGcO6oz07-iQ99wixmX:22
    a=3ZumFrijQQ-2J9H5h8ct:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750937AbeEPUR1 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 16 May 2018 16:17:27 -0400
Received: from lilium.sigma-star.at ([109.75.188.150]:50082 "EHLO
        lilium.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeEPUR1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 16 May 2018 16:17:27 -0400
From: Richard Weinberger <richard@nod.at>
To: linux-mtd@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Martin Townsend <mtownsend1973@gmail.com>
Subject: [PATCH] ubi: fastmap: Cancel work upon detach
Date: Wed, 16 May 2018 22:17:03 +0200
Message-Id: <20180516201703.2586-1-richard@nod.at>
X-Mailer: git-send-email 2.13.6
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Ben Hutchings pointed out that 29b7a6fa1ec0 ("ubi: fastmap: Don't flush
fastmap work on detach") does not really fix the problem, it just
reduces the risk to hit the race window where fastmap work races against
free()'ing ubi->volumes[].

The correct approach is making sure that no more fastmap work is in
progress before we free ubi data structures.
So we cancel fastmap work right after the ubi background thread is
stopped.
By setting ubi->thread_enabled to zero we make sure that no further work
tries to wake the thread.

Fixes: 29b7a6fa1ec0 ("ubi: fastmap: Don't flush fastmap work on detach")
Fixes: 74cdaf24004a ("UBI: Fastmap: Fix memory leaks while closing the WL sub-system")
Cc: stable@vger.kernel.org
Cc: Ben Hutchings <ben.hutchings@codethink.co.uk>
Cc: Martin Townsend <mtownsend1973@gmail.com>

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/ubi/build.c | 3 +++
 drivers/mtd/ubi/wl.c    | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 6326a02e4568..0cf3356424cd 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1100,6 +1100,9 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 	if (ubi->bgt_thread)
 		kthread_stop(ubi->bgt_thread);
 
+#ifdef CONFIG_MTD_UBI_FASTMAP
+	cancel_work_sync(&ubi->fm_work);
+#endif
 	ubi_debugfs_exit_dev(ubi);
 	uif_close(ubi);
 
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 3cc302924899..6bbb968fe9da 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -1505,6 +1505,7 @@ int ubi_thread(void *u)
 	}
 
 	dbg_wl("background thread \"%s\" is killed", ubi->bgt_name);
+	ubi->thread_enabled = 0;
 	return 0;
 }
 
@@ -1514,9 +1515,6 @@ int ubi_thread(void *u)
  */
 static void shutdown_work(struct ubi_device *ubi)
 {
-#ifdef CONFIG_MTD_UBI_FASTMAP
-	flush_work(&ubi->fm_work);
-#endif
 	while (!list_empty(&ubi->works)) {
 		struct ubi_work *wrk;
 
-- 
2.13.6
