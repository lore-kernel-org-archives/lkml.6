Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1776DC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D60582070B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 07:26:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="Ly+8Vl3Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfAIH0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 02:26:09 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:60218 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729435AbfAIH0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 02:26:06 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 3566AB1E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 07:26:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OLDtu1TYZ2Sr for <linux-kernel@vger.kernel.org>;
        Wed,  9 Jan 2019 01:26:05 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 06600B07
        for <linux-kernel@vger.kernel.org>; Wed,  9 Jan 2019 01:26:05 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id k4so5659133ioc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 23:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0Yj8Db8wXhEA1gYEAoxbFmsOXCni4n6GcIt+AD7Uyps=;
        b=Ly+8Vl3ZSBnaiKK2gMYiZJiB8vLlhJF4tmuSPeVc4nS8nT2rC9APQZMewKoPkUxT5q
         LJJDj6+7Zru+3lnbSECfgV0mNBZ9RKYX3RaOYnPAel/bpeM4zQEIkYLOdvMrku7FFZ93
         cIMx6QalqJ1/cikSFk60qAOUTmxqTMN33Xl9RMe9+9/V/Y0tsxzh5nI/WtXU+KHvFyfP
         2mVXHlBI5QorHQTDJxTU+PZ0AAE8O/nyvirPebkAALCO4ZKykTetrisEhKhFc/pqLiOd
         rmPeMjEVivx7PPYM2BicdaCsyHlkyQiCRWab9Q+9s25wYPTiSzky/uad5ggVYk77e4JE
         yZtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0Yj8Db8wXhEA1gYEAoxbFmsOXCni4n6GcIt+AD7Uyps=;
        b=Vpy7ovFqkD25dopbgXYHKC86jVBhrqOwZOVJEz8PqD2AQ6PG5K37YEE7logY9ESmF1
         w1dbI2triRD2IQVHJmZw7qDfIem5UNtTDUYQFnvXjfgze7SqTXlzNf/tEV60+vTobs8Z
         h7zXDDaf223+oHcdaaOc8aTdB9hweIaUmHn6YZmbiHprFZn2nKUatMEP+a+fCdCR84hu
         VuYNxek61Ks8ni3aI8v7DsJwp1BJYQD3A08dwo88i0y2kLO42rGp1EepGgBDHNr5/VjT
         bH3G5N8a+KL1HF8Wg4/AWCp07fOXPZoVgwfkWEBxobLl0SDe2TNfGHAKXSxCy8DeFjuo
         QeNQ==
X-Gm-Message-State: AJcUukc21Qj1EGkDoaA8io/aGillL3147gPdBQajcojA6bGSJrgRxcmx
        SHQd2TfOvVgzWhoXTaNyj5qAVWFfXuXpu0xJIAYzeZpTYzBerMeJE9En2qWy90qwPBhzuY1RLHJ
        3kPOFrj+8ktyK4dppJLb994cNOLir
X-Received: by 2002:a24:4016:: with SMTP id n22mr3845760ita.25.1547018764606;
        Tue, 08 Jan 2019 23:26:04 -0800 (PST)
X-Google-Smtp-Source: ALg8bN4a5046UyTA3tO1QrimZRmm0/+4RsxL0uLMteY53yOyuJ6SKxRhhXjRz/24ZEgfixvLzW/nsA==
X-Received: by 2002:a24:4016:: with SMTP id n22mr3845754ita.25.1547018764329;
        Tue, 08 Jan 2019 23:26:04 -0800 (PST)
Received: from bee.cs.umn.edu (cs-bee0u.cs.umn.edu. [134.84.121.28])
        by smtp.gmail.com with ESMTPSA id b73sm459931itd.0.2019.01.08.23.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 23:26:03 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: avoid a double-fetch and a redundant copy
Date:   Wed,  9 Jan 2019 01:25:57 -0600
Message-Id: <20190109072557.9818-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <e68496e2-248b-e7ec-9bc2-597446c5b495@interlog.com>
References: <e68496e2-248b-e7ec-9bc2-597446c5b495@interlog.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

What we need is only "pack_id", so do not create a heap object or copy
the whole object in. The fix efficiently copies "pack_id" only and
also avoids double-fetch.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/sg.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index c6ad00703c5b..13662c41058a 100644
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
+						&((sg_io_hdr_t *)buf)->pack_id);
 				if (retval) {
 					retval = -EFAULT;
 					goto free_old_hdr;
-- 
2.17.1

