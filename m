Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C89A7C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8272521726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 22:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iJ09FRCn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLYWru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 17:47:50 -0500
Received: from mta-p7.oit.umn.edu ([134.84.196.207]:37602 "EHLO
        mta-p7.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbeLYWrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 17:47:49 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p7.oit.umn.edu (Postfix) with ESMTP id 5865BAD8
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 22:47:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p7.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p7.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8W806KOPWNc0 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 16:47:48 -0600 (CST)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p7.oit.umn.edu (Postfix) with ESMTPS id 23575AA5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 16:47:48 -0600 (CST)
Received: by mail-io1-f72.google.com with SMTP id d20so11233403iom.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 14:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=QepMCx4GmV19lUsN6LPDqZF7RwxnCTIxNw4M3Q4dt+0=;
        b=iJ09FRCn2BokaA0azmBK312PT1H5WZGreQzV1h7EJIC0/maE7iZRkf9k5F/97+cZ96
         mElvkQ+4Of9/IH5dRnuiPqP9IRowAlhQ2uk6zCsLVxxzj7RpdaUTE8KxR/VV+aM6cGqk
         wZt8lA1/8Tur3mksvwBsWaYmuhJfzV5rR2wyVt62hh0chrmvU2hexRDi2JiO2a4P/b+E
         AzT54L0fYFgPRsFl2wl9Y48zi4r3mOHnA7lDjvr7nLGhTzqrovD1SX8V2bhVSfbG5PnS
         NyEU0ei4aBjtc7J5O73oWyU+WmG20yL3nRYabSLUpSElMiAf7n86aycvFW/lMGS1Gwqw
         WvRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=QepMCx4GmV19lUsN6LPDqZF7RwxnCTIxNw4M3Q4dt+0=;
        b=gaG+XaXQtJVlBn7W7BfxIf/0XyEEM+tM+y/5ua1jblhjVznBcJGFbGJyTJpiZQ9ThO
         oudf5/BXU2gRxL3fkYJbGK9uWiIu3W0dfPSzuVj0pPw1nOYGxFrUXXfYkvKp0hBpMWLh
         1L4uT0wq8neWFcZ59Y4wUfQo73nq5CodbXEhppqV6np+KG0pY5vJdMMLeSJeRIHgpLT7
         1NB790GG9Ty0sqNA3/MTdtzhy+QhXydyEmvvd0/Xs+bNSFn2qkNuDwhquO0sMTA6Au0C
         dcK4a1imk/NytZHdcBWZBf/3LueGmm656nLPez9aZy1jeZ6ZK4EpZxKeIYekfhxhqgFp
         qhMw==
X-Gm-Message-State: AA+aEWb69OtbNMJQHhB7KPuPwLxJCxX1nMCcHpfQqHRHTmxC5AR2BRGd
        OgfOwINjdrtyPMMBlFVHXOdTlfIwgkHn5HFLToLmODeOmTsCtpFpl1QtGCt9oiMxdWP5YAldtdO
        +wOeIyfebBU+gHPSe1KorENXgKfMB
X-Received: by 2002:a02:4f88:: with SMTP id r8mr11822407jad.69.1545778067731;
        Tue, 25 Dec 2018 14:47:47 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XzxPLpIGjy/4GqMovYQ2LirFg6bGScGEqhoX5ApcbLvp7MuJwzg4mmk/I0nV1EcXUdSGMkGQ==
X-Received: by 2002:a02:4f88:: with SMTP id r8mr11822400jad.69.1545778067463;
        Tue, 25 Dec 2018 14:47:47 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id c21sm15183977iob.22.2018.12.25.14.47.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 14:47:46 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: avoid a double-fetch and a redundant copy
Date:   Tue, 25 Dec 2018 16:47:18 -0600
Message-Id: <20181225224718.70271-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we need is only "pack_id", so do not create a heap object or copy
the whole object in. The fix efficiently copies "pack_id" only.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/sg.c   |  4 ++--
 kernel/sched/core.c | 18 ++++++++++++------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 41774e4f9508..75842ceabc7f 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -446,8 +446,8 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 		}
 		if (old_hdr->reply_len < 0) {
 			if (count >= SZ_SG_IO_HDR) {
-				retval = get_user(req_pack_id,
-						&((sg_io_hdr_t *)buf->pack_id));
+				retval =
+					get_user(req_pack_id, &(sg_io_hdr_t __user *)buf->pack_id);
 				if (retval) {
 					retval = -EFAULT;
 					goto free_old_hdr;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6fedf3a98581..0a55bdce9a42 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4447,7 +4447,7 @@ do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
  */
 static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *attr)
 {
-	u32 size;
+	u32 size, size_cp;
 	int ret;
 
 	if (!access_ok(VERIFY_WRITE, uattr, SCHED_ATTR_SIZE_VER0))
@@ -4460,15 +4460,17 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	if (ret)
 		return ret;
 
+	size_cp = size;
+
 	/* Bail out on silly large: */
 	if (size > PAGE_SIZE)
 		goto err_size;
 
 	/* ABI compatibility quirk: */
 	if (!size)
-		size = SCHED_ATTR_SIZE_VER0;
+		size_cp = SCHED_ATTR_SIZE_VER0;
 
-	if (size < SCHED_ATTR_SIZE_VER0)
+	else if (size < SCHED_ATTR_SIZE_VER0)
 		goto err_size;
 
 	/*
@@ -4483,7 +4485,7 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 		unsigned char val;
 
 		addr = (void __user *)uattr + sizeof(*attr);
-		end  = (void __user *)uattr + size;
+		end  = (void __user *)uattr + size_cp;
 
 		for (; addr < end; addr++) {
 			ret = get_user(val, addr);
@@ -4492,13 +4494,17 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 			if (val)
 				goto err_size;
 		}
-		size = sizeof(*attr);
+		size_cp = sizeof(*attr);
 	}
 
-	ret = copy_from_user(attr, uattr, size);
+	ret = copy_from_user(attr, uattr, size_cp);
 	if (ret)
 		return -EFAULT;
 
+	/* Sanity check if size was changed in user space */
+	if (attr->size != size)
+		return -EINVAL;
+
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
-- 
2.17.2 (Apple Git-113)

