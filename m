Return-Path: <SRS0=Ytqw=PC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8426CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 458A821726
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Dec 2018 21:12:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="eD00LeYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLYVMI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Dec 2018 16:12:08 -0500
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:45552 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbeLYVMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Dec 2018 16:12:07 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id A9772C5B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 21:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 1SKxYYdwmgJn for <linux-kernel@vger.kernel.org>;
        Tue, 25 Dec 2018 15:12:06 -0600 (CST)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 7BAAEA3A
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 15:12:06 -0600 (CST)
Received: by mail-io1-f71.google.com with SMTP id q23so17380494ior.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Dec 2018 13:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=mBoB4pQ+YOOc6ishphiaade6t4erG59WztbH8MgNTPc=;
        b=eD00LeYmbAo5esxVuawTBLqADzWNa9KE3K21JvNME0K6k+8d1mShrWUTTzSqEEpHnC
         zDuusx3CJFCVHI63hMoiBf067xb9xUPwA76knA3QQ93DtobcoTiqrpOquluVeBNFwsQx
         q3bqwLCzv1U8eJEc1XTWfUc8PDDDoynZXf/dV/iJOCrYpE4X/SFE4RvnVHoYqfiB93kl
         7oD5/s3UduV3x1Tf2o0TlCE3hqlE/ZDWvfBQ4vXqeEbl1jLlR5m02fumlsUe6ZN/Cer5
         anu8ouVAv+U4P5jG9y4p6hciQV7QvLaBFICL8ikT10MHEtNlkZ0W9jj0jiR9/Iwyo1dT
         eUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mBoB4pQ+YOOc6ishphiaade6t4erG59WztbH8MgNTPc=;
        b=PXSD5FVTlM6ZSU5kP5prqP4YylSNaEJcW9S2pZpB+9z4Ik/xlg120eRk+YyBzD+5p+
         RTiFjQdI6gdsUp7r1rDwafhsaFp3Bd8pEnFbm6y5524iIOJ0c5ltu5xzbrNLNITrSD+K
         wqZag2YFM7jzqoUY5uVebRfPgFkYY8xIeCzsVweP0wSpFpHa3hfzKT4JmVWtqFuZBvg0
         JR1/5015BFtGf3SA42Jbxr77cptAiC3M08tBuOQZ+wnwgJtDlG4Gw+Kp1ngA3EG4OSkG
         aoLv7d5k2A+eUI0mFQkD87MiDkjpyVUeTw6tAqffJqLbjRHeHeHfIlvwC1HVikeHEF8O
         z+2Q==
X-Gm-Message-State: AJcUukfT5Uxbg56mF40AbOCtvwJqLOoThVjJy+n7nuNaVFBTO6+pP6FW
        ZBdBfdehqUTfSZybXLOb0gXqRRWoTs8E60BSgJ+SWRoz1GrH0HAMyKEkSI6/TuOGL5aF1RH2LVH
        a0SMMMvsQe96uVF92kjqrlluFjbaG
X-Received: by 2002:a6b:b90a:: with SMTP id j10mr11527139iof.172.1545772326135;
        Tue, 25 Dec 2018 13:12:06 -0800 (PST)
X-Google-Smtp-Source: ALg8bN5Fwrm1n3HIuKV0Wm51M5/J4WsBaHbtHG33YvvLsYTvjaAx9aXLVZxWzGfrPzXEXXTolVs6QQ==
X-Received: by 2002:a6b:b90a:: with SMTP id j10mr11527134iof.172.1545772325897;
        Tue, 25 Dec 2018 13:12:05 -0800 (PST)
Received: from localhost.localdomain (host-173-230-104-22.mnmigsc.mn.minneapolis.us.clients.pavlovmedia.net. [173.230.104.22])
        by smtp.gmail.com with ESMTPSA id t71sm6796846ita.32.2018.12.25.13.12.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Dec 2018 13:12:05 -0800 (PST)
From:   Kangjie Lu <kjlu@umn.edu>
To:     kjlu@umn.edu
Cc:     pakki001@umn.edu,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aacraid: fix a potential data inconsistency caused by double-fetch
Date:   Tue, 25 Dec 2018 15:11:36 -0600
Message-Id: <20181225211136.69702-1-kjlu@umn.edu>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"user_srb->count" may be changed by malicious user races. Let's set
"user_srbcmd->count" fetched in the second copy to be the one fetched in
the first copy.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/scsi/aacraid/commctrl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/aacraid/commctrl.c b/drivers/scsi/aacraid/commctrl.c
index 25f6600d6c09..eb18117c431a 100644
--- a/drivers/scsi/aacraid/commctrl.c
+++ b/drivers/scsi/aacraid/commctrl.c
@@ -539,6 +539,8 @@ static int aac_send_raw_srb(struct aac_dev* dev, void __user * arg)
 		rcode = -EFAULT;
 		goto cleanup;
 	}
+	/* Ensure user_srb->count is not changed */
+	user_srbcmd->count = fibsize;
 
 	flags = user_srbcmd->flags; /* from user in cpu order */
 	switch (flags & (SRB_DataIn | SRB_DataOut)) {
-- 
2.17.2 (Apple Git-113)

