Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE70C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E0AE2148E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 20:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="oNWOGFtt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeLYUY6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 15:24:58 -0500
Received: from mta-p8.oit.umn.edu ([134.84.196.208]:36756 "EHLO
        mta-p8.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbeLYUY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 15:24:58 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p8.oit.umn.edu (Postfix) with ESMTP id D8BA8A07
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 20:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p8.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p8.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qsIaa5o3_qjM for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 14:24:56 -0600 (CST)
Received: from mail-it1-f199.google.com (mail-it1-f199.google.com [209.85.166.199])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p8.oit.umn.edu (Postfix) with ESMTPS id A97B55BB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 14:24:56 -0600 (CST)
Received: by mail-it1-f199.google.com with SMTP id x3so16886414itb.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 12:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=6Xpc/jXXMD1CRjJCYS94ZcbLnkSxhAxLsM+qmIkEfsQ=;
        b=oNWOGFttzfMkLszZ8qT/kRjfOvggEjyRCOHHOIU/Mx7edhTLMpiRf1eru6u/6wcQt/
         HMxUpko5wBVsjjy2TG5eomk0pnzhPUt4ZlqyTrkm83xevSHAEs/TeAFiz6yV4ly+CVWf
         KrPzBVmglRpEeI87knXPvcNAZZ9hHBqCvwPWov7VGep4EaJoHL7zW6BMEYe63YiV+udS
         UCvnh7w2hrZli5rtsv0/1iipCD5zNvoWRnADi3KvNAy+WiEwFabuJLzQsdhutFbH5jaH
         24fb3ceGdqqYnwvNIdGsDEsdQTj71qi9uaBhJDfkKiD4/y8XQ0EiEVwSA4LMDmSRMtcg
         ZnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6Xpc/jXXMD1CRjJCYS94ZcbLnkSxhAxLsM+qmIkEfsQ=;
        b=jzQ+Rhf6Brv4RjaieutVLfJIzxtXkFylytRxxe/9er13mL/JGC0OmJ09rxWWkLjIZA
         bmytQ+f4hTAi8+OoObrEppmmZh6Zwy1zI/IhJ87tJ4hcmEAy23YHnXXJfcjH71jvhfp6
         RNcHhE2AkA3IM0EAqS3q4WZvzaUeBMWJnjlrXhxTRG11zLlA5EpgYZ6hc23y8lO7vZEg
         75V1cUiLLAKOsLQIwABow+Ybb6ndTWbdUSXx6Hq5wGwyd0Q2k7dpw3n83iE/Y1hDZf0p
         W9+2kFMQ26cTQpPhDsAXV8MRZ+ceL9IQQcjwM0Wf5+pWB73BGf2wZl2hOGiEmKLt+MRX
         i9Mg==
X-Gm-Message-State: AA+aEWbtU77+RsLW6gsN2wlcYlW3lQnBlxdKiCCv61jgH1CCa2YKqkc6
        GTQmkn4UMd3g+mbRM9VDGEdup0+iFFouIsPhZ/3usb+CvxaBruKWUybzjIbGi0rxRqyaO6U3T06
        fo9R3u8Siv30ZRXp98MiShxuUdPUf
X-Received: by 2002:a02:660f:: with SMTP id k15mr11943747jac.38.1545769495469;
        Tue, 25 Dec 2018 12:24:55 -0800 (PST)
X-Google-Smtp-Source: AFSGD/XgYKncanRXgd9nq/5njohCnGXBFkJs84e4XFl8d0zBVgy/UWFgrVv2i4JMrKTjEyvSqmvGRw==
X-Received: by 2002:a02:660f:: with SMTP id k15mr11943737jac.38.1545769495219;
        Tue, 25 Dec 2018 12:24:55 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id 196sm11399324itu.33.2018.12.25.12.24.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 12:24:54 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu, Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fix a double-fetch bug in sg_write
Date:   Tue, 25 Dec 2018 14:24:26 -0600
Message-Id: <20181225202427.69476-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"opcode" has been copied in from user space and checked. We should not
copy it in again, which may have been modified by malicous
multi-threading user programs through race conditions. The fix uses the
opcode fetched in the first copy.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/sg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 4dacbfffd113..41774e4f9508 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -686,7 +686,8 @@ sg_write(struct file *filp, const char __user *buf, size_t count, loff_t * ppos)
 	hp->flags = input_size;	/* structure abuse ... */
 	hp->pack_id = old_hdr.pack_id;
 	hp->usr_ptr = NULL;
-	if (__copy_from_user(cmnd, buf, cmd_size))
+	cmnd[0] = opcode;
+	if (__copy_from_user(cmnd + 1, buf + 1, cmd_size - 1))
 		return -EFAULT;
 	/*
 	 * SG_DXFER_TO_FROM_DEV is functionally equivalent to SG_DXFER_FROM_DEV,
-- 
2.17.2 (Apple Git-113)

