Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E863C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 705E32184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfBv1Xzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbfB0Qby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:31:54 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37536 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfB0Qby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:31:54 -0500
Received: by mail-wm1-f68.google.com with SMTP id x10so6125427wmg.2;
        Wed, 27 Feb 2019 08:31:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JljU3gMWORqdogeN6POaJ2V8lX+AcD+H5+D6KJoTc/I=;
        b=vfBv1XzmnCGahsFnE6RJyEzqBFvYW25cowr9V+UKSOkPEEJjJjICJ0mx+EXbAt0A0j
         fGhvH1aQpXaNLpnoQI530ER1dW1iH/IrgyexkaZvgFEdHRzfz+2232Fm7f13wUQqOvJr
         TFlwkbfKaHjQJg65wX7x5vI8L9EYmGNm7xixL/dp1sv0yzPuWja5LzTNZqmPwetwxy6C
         qs9mqPIxi9YsYiuTgKu1laOrxkolYlvIYIbBmvULdpXharhuUFmKhlRkKIYMUM0dIcNZ
         dwDWA6/LiAeoehneDWwcuChY0Wlsh/OXvSlUyflqf3OasJKBGxu6X5AKgeSkr9ddcLUq
         ylLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JljU3gMWORqdogeN6POaJ2V8lX+AcD+H5+D6KJoTc/I=;
        b=gxWPHtmIW7ltrS9x9yEZPzTegKGd7nHykV/hFM4kw+MDel4SuBj3FJLwsPsOAPzm7R
         HIIDZm5LOtP1Jani31rkju96jMEc9E8Q1I9/wdgqlRQxt7mM5BUmQj7ritMcWbj/pD+d
         mp+d5Bk15zNdyWA4eL+E53t7/xXFd9a2ilHXLrlPC4469XkXNwSgexpAfLu4p2SY2pDY
         MKqqmgS19c6fhdxb/RTzoGb0wAA0Z802JLXhDEuJ2WSQ1iu0P5GRBoo4NFoIazrpKK59
         3hv1XwWXR6nOn9kfthxzJrICqr1tCfTAXiL7UaymsvuzMJ+8oEU7OtT2X9bCDeK9gqYe
         +wrQ==
X-Gm-Message-State: APjAAAW0qfRSh4a6VgELQopO3vht0gEO4HS+lQX8fbEfn0tt5eEZacGS
        l/7ONYnywgzTW+nHrNrRhMs=
X-Google-Smtp-Source: APXvYqxHc93OgLIX7c8cWBK3XKIw/2hzTzkOxh1xWYwdAiEIKO+QB0InfUhHnPN8P1YuYLieT9bNeA==
X-Received: by 2002:a1c:6a18:: with SMTP id f24mr58466wmc.115.1551285111984;
        Wed, 27 Feb 2019 08:31:51 -0800 (PST)
Received: from laptop.criteois.lan ([91.199.242.236])
        by smtp.gmail.com with ESMTPSA id w10sm21374800wru.5.2019.02.27.08.31.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Feb 2019 08:31:50 -0800 (PST)
From:   Erwan Velu <erwanaliasr1@gmail.com>
X-Google-Original-From: Erwan Velu <e.velu@criteo.com>
Cc:     Erwan Velu <e.velu@criteo.com>,
        Don Brace <don.brace@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com (open list:MICROSEMI SMART ARRAY SMARTPQI
        DRIVER (smartpqi)),
        linux-scsi@vger.kernel.org (open list:MICROSEMI SMART ARRAY SMARTPQI
        DRIVER (smartpqi)), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] scsi: smartpqi_init: Reporting 'logical unit failure'
Date:   Wed, 27 Feb 2019 17:31:33 +0100
Message-Id: <20190227163133.26283-1-e.velu@criteo.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When this HARDWARE_ERROR/0x3e/0x1 case is triggered, the logical volume is offlined.
When reading the kernel log, the cause why the device got offlined isn't reported to the user.
This situation makes difficult for admins to estimate _why_ the volume got offlined.
Reading this part of the code makes clear this is because driver received a HARDWARE_ERROR/0x3e/0x1 which is a 'logical unit failure'.

This patch is just about reporting that fact to help admins making a relationship between this event and the offlining.

Signed-off-by: Erwan Velu <e.velu@criteo.com>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index f564af8949e8..89f37d76735c 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -2764,6 +2764,12 @@ static void pqi_process_raid_io_error(struct pqi_io_request *io_request)
 				sshdr.sense_key == HARDWARE_ERROR &&
 				sshdr.asc == 0x3e &&
 				sshdr.ascq == 0x1) {
+			struct pqi_ctrl_info *ctrl_info = shost_to_hba(scmd->device->host);
+			struct pqi_scsi_dev *device = scmd->device->hostdata;
+
+			dev_err(&ctrl_info->pci_dev->dev, "received 'logical unit failure' from controller for scsi %d:%d:%d:%d\n",
+							ctrl_info->scsi_host->host_no, device->bus,
+							device->target, device->lun);
 			pqi_take_device_offline(scmd->device, "RAID");
 			host_byte = DID_NO_CONNECT;
 		}
-- 
2.20.1

