Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F37DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33FBB20842
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 14:09:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YV1QO/vo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393222AbfBNOI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 09:08:59 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33366 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388106AbfBNOI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 09:08:59 -0500
Received: by mail-pl1-f193.google.com with SMTP id y10so3243669plp.0;
        Thu, 14 Feb 2019 06:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NuIdQ8KWvJC0L5puF7av3t6NmHGhpnNz9I+ArjAqJPQ=;
        b=YV1QO/vovbZvhHybyuL4RTSrOJQuLoKuIXOFQenDOWZVnsh1KUcCsPN4hy48YUnzNB
         7G0X1RX7t5YYzNmJvxOySY7DylQ4BH6j8ilKG2Fe9qB8kuJCs5dwhLGqLdXPTekPxn1X
         LqUzK4URelN0dsXVYZlhRfSB1aXDH5mWddHuu9X8mZhmHQaa8fpEp1DV5LEvcSEc7b6Z
         9yJjBNNOLKUo06MyM8Lhyxh+/Ipud2EphWuIhnl9MH9YpWQD0i0e08PhIs25BTdzWUoU
         PNj9hmBWMWWxUoJox0vzOdZP7gqUnszyshaYH2qfG5V5VYCg1VN2B32t2MI8w6Y+9x1B
         ZagA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NuIdQ8KWvJC0L5puF7av3t6NmHGhpnNz9I+ArjAqJPQ=;
        b=Ytt7BCKDGbk0KbAML/A5ySpgek/CGWCWNbAwfypTCb3QRPzpj8R/+SHuJ/l0Td2YJD
         XJbPoUGGvEmyaFBOxrh2iTtJmQ4E7qY3RCwHUt8SUwcz4VLA4IxTv16JQUUo4w5siN02
         NdniyOiB2cj7P1aTYfcO0/Tk3xqkBz6wqhpQShP9OUc2Y9Y5+adGbfMKS6vSKCvKz0yi
         +CDJ9+XrWRkA3HGDSBBnHSeOTvCO4U5WuAzj82Hem8jCmCL6isfpf/4qOd9c6mlU8eqf
         W7VGF5b1oy6usyYXqqIop0hdrFb9/8vvW7mcZW/zqmOZSQCRK/Y1Dob06NEV+8eOnsgE
         YQ5w==
X-Gm-Message-State: AHQUAuYYkd4mSTZcvPn0n9/WWdNpYUFVEGfRowCOXDU7rMkQqln2h/xF
        23+MQGMZ0KdqDZAm2i4mzLE=
X-Google-Smtp-Source: AHgI3IYoFi3MICt4VI5lHw/lK//pc79eGvBOze4QqXIeB0YcvYTlOr/MOUq5LW7n+EAs/vSJ3Q6GFQ==
X-Received: by 2002:a17:902:ab84:: with SMTP id f4mr4268632plr.207.1550153338100;
        Thu, 14 Feb 2019 06:08:58 -0800 (PST)
Received: from localhost.localdomain ([222.129.233.237])
        by smtp.gmail.com with ESMTPSA id 186sm9609377pga.36.2019.02.14.06.08.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 06:08:57 -0800 (PST)
From:   Zhiwei Jiang <qq282012236@gmail.com>
To:     qq282012236@gmail.com
Cc:     mikecyr@linux.ibm.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, martin.petersen@oracle.com
Subject: [PATCH] scsi: target: move spin_lock_bh to spin_lock in tasklet
Date:   Thu, 14 Feb 2019 22:06:51 +0800
Message-Id: <20190214140651.65514-1-qq282012236@gmail.com>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

as you are already in a tasklet, it is unnecessary to call
spin_lock_bh, because softirq already disable BH.

Signed-off-by: Zhiwei Jiang <qq282012236@gmail.com>
---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
index cc9cae469c4b..29e7c51fcc4b 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3346,7 +3346,7 @@ static void ibmvscsis_handle_crq(unsigned long data)
 	bool ack = true;
 	volatile u8 valid;
 
-	spin_lock_bh(&vscsi->intr_lock);
+	spin_lock(&vscsi->intr_lock);
 
 	dev_dbg(&vscsi->dev, "got interrupt\n");
 
@@ -3360,7 +3360,7 @@ static void ibmvscsis_handle_crq(unsigned long data)
 
 		dev_dbg(&vscsi->dev, "handle_crq, don't process: flags 0x%x, state 0x%hx\n",
 			vscsi->flags, vscsi->state);
-		spin_unlock_bh(&vscsi->intr_lock);
+		spin_unlock(&vscsi->intr_lock);
 		return;
 	}
 
@@ -3437,7 +3437,7 @@ static void ibmvscsis_handle_crq(unsigned long data)
 		(int)list_empty(&vscsi->schedule_q), vscsi->flags,
 		vscsi->state);
 
-	spin_unlock_bh(&vscsi->intr_lock);
+	spin_unlock(&vscsi->intr_lock);
 }
 
 static int ibmvscsis_probe(struct vio_dev *vdev,
-- 
2.19.0

