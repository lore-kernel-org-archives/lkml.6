Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C467C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C47C621726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="iGLfZORH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbeLYUQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 15:16:28 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:57732 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbeLYUQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 15:16:28 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 67621BAD
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4HcDaUH5H2t7 for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 14:16:26 -0600 (CST)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 3F332B77
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 14:16:26 -0600 (CST)
Received: by mail-io1-f70.google.com with SMTP id o22so17561593iob.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 12:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0YUMMuCcROi6BYXQKq+oTPJcB4cWoYymcC+8Kji7Wyk=;
        b=iGLfZORHA8qB+d7Jihz9UyCfaHkNOf+nRiiEB2p6blIxM/npuuqL3po3wClw7PMgD9
         KP5gciARCQcLuATfSGukkSmCLghV2+eKtb84vwBKYm2Y56qj6QVVMBlUOWXLg7SAdblj
         xiz9rTT/Mz/Pyt4Mk0OUuJsF+jaG9fG1BfmU51yHRnUoKQ2YGt5ljGHtUCCna/2IVh0/
         1/1qx8HXbTIiwdTeaDqo/5d8aPb8iSomNG9WoPkIJfvY5XuA38mQVO85GHdDdDcjBJDh
         cjbSyHdTLBrEjr8k4uKP81I0V0cMT7y7tSAFIb2rCgCFB1AIZfPlPTKWNkrQQoLB76ts
         pMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0YUMMuCcROi6BYXQKq+oTPJcB4cWoYymcC+8Kji7Wyk=;
        b=Xk7PhgVOXB5aKyBJPOMPJztMzvkwWEeXX00KaTasM4fgK5wm7thz1rifu6kC3iw2K8
         e7nITELQXrAVBu15ua3+sBMvfsQ+F/dUR1l+q7hdrI/3VXWGARtnXx4v/+YvqYwSVOPF
         irBn9JQXEtobG6jmEVFt1Oal8BblksiYR88bzTV79weCNltyTUp7kcgcqTsXiWq+1QKR
         19ZeTLfp9tqJHj+wGbLgnAYkvVPG5NkQEybpWA4+GdxbFIriQIPofMF5duuw0rxDYxr0
         DHm0fOPCxJRWa+VEXCH6iVQlxPd19YfdHnQJQumIzfezNahs7ePJwBwqkNlhYo1S74yg
         kxzQ==
X-Gm-Message-State: AA+aEWamerzEu5Pf4fvpO6TiUWqLVlOa4OG1yMz7/jUZ5kvfE3b5kdVp
        jvzEVUIpcbXPRG5YbJ12DWV7g+H5Gl5AWbdqGmCDHvTz/dvz6w9ukSk8Z1D0DttljdRJgdSa7bN
        bF0MAE1kwVEYG0n50YSRzbqFGc1hu
X-Received: by 2002:a24:e44:: with SMTP id 65mr10043150ite.154.1545768985806;
        Tue, 25 Dec 2018 12:16:25 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XQ/0jwH+kjCNpEa7mPRGPYn7NUTqpMQ2DnT6zaosNml7C4Da4ccmjbMQZEqZvwx2gzMeCgow==
X-Received: by 2002:a24:e44:: with SMTP id 65mr10043141ite.154.1545768985548;
        Tue, 25 Dec 2018 12:16:25 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id y3sm15643619iol.55.2018.12.25.12.16.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 12:16:24 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: avoid a double-fetch and a redundant copy
Date:   Tue, 25 Dec 2018 14:15:54 -0600
Message-Id: <20181225201554.69395-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we need is only "pack_id", so do not create a heap object or copy
the whole object in. The fix efficiently copies "pack_id" only.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/sg.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c6ad00703c5b..4dacbfffd113 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -446,16 +446,8 @@ sg_read(struct file *filp, char __user *buf, size_t count, loff_t * ppos)
 		}
 		if (old_hdr->reply_len < 0) {
 			if (count >= SZ_SG_IO_HDR) {
-				sg_io_hdr_t *new_hdr;
-				new_hdr = kmalloc(SZ_SG_IO_HDR, GFP_KERNEL);
-				if (!new_hdr) {
-					retval = -ENOMEM;
-					goto free_old_hdr;
-				}
-				retval =__copy_from_user
-				    (new_hdr, buf, SZ_SG_IO_HDR);
-				req_pack_id = new_hdr->pack_id;
-				kfree(new_hdr);
+				retval = get_user(req_pack_id,
+						&((sg_io_hdr_t *)buf->pack_id));
 				if (retval) {
 					retval = -EFAULT;
 					goto free_old_hdr;
-- 
2.17.2 (Apple Git-113)

