Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBAEFC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8893D208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InADBVIA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8893D208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756296AbeFORFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:05:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38636 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756180AbeFORFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:05:08 -0400
Received: by mail-pf0-f195.google.com with SMTP id b74-v6so5153952pfl.5;
        Fri, 15 Jun 2018 10:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HRlDkwHHqxiBFNaR3UHGoZzqGBCJcg/h6N1jAZn2fd8=;
        b=InADBVIA48QTGwONCDb9uDZP37ztZTPC8x6fxFu+78xjhX2ycmKclsYc5YFas02m7x
         P0Vpkd1BSYItnAA3EkiI9ft450/9xjVGmgh/hSaidYRaQd41Rdsl8k4r078Z3xUsnE3U
         TE7kugEQrS5hTYwoThnNvMSucg+QYJwZ/jT9vyVkP+q0Zgo3tGZcThMaHaDjoLXf3fEH
         oCJHV29rpfK/xIi8GSzihvmLcRHQFvj1O3aRrUZQsPNJ1wX+HACUdkXGHFwKcEf+gkxF
         4PF9PiIXm75wUUpk9VJHED49LaZx+HYO2i/QG1/EUtbBXWKoYoxVFQ95/MvqyGvQhzWZ
         qy8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HRlDkwHHqxiBFNaR3UHGoZzqGBCJcg/h6N1jAZn2fd8=;
        b=TNWLIiHrw9KP2i6bPu/+U5ETqV/pvWhdZguUpyE5zO8LTEO85OHV+5Crq4l9dTL5qu
         6A5rgduViTU76jBptHImnRAG6dEkk6UQR+jXrJVkHofnrr1155cQbO4KfkAK/5jFa+sI
         K8pzEP7HBGnVo47NlyO85C7Nn6AXHSL8sqnfV18dPofuJwEA6pNioIaSgAFTjb9ChXWw
         G0sme9l+o4f/TFEPMAYGCeNPz8wUolj0q5HfkPMU4wcjoh1yl8P6yai8xGXC3iMn/v3e
         ZYgKLwK/UV6u5flNKD68j9QIL1g6Y4xbKnrRoigchd0gMKJA0NyYXWtG+CQsIHICLwOx
         Uh1Q==
X-Gm-Message-State: APt69E0VZM41Quh1F3Z54bqci8L7ZNFGtUCgaYz7zEGT8xdsioQ0+smr
        n1pA4Mg+YjO2LRvy/mo+KEA=
X-Google-Smtp-Source: ADUXVKK2mfXxDxhFSOU2FYq71iqtPGeENX6KRERhrd/dSAYzO/1PKj26IgJgtzv6Zvn6R5s3GWFw6Q==
X-Received: by 2002:a63:61d6:: with SMTP id v205-v6mr2364353pgb.432.1529082307601;
        Fri, 15 Jun 2018 10:05:07 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id f3-v6sm12130362pfn.149.2018.06.15.10.05.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jun 2018 10:05:06 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] scsi: xen-scsifront: add error handling for xenbus_printf
Date:   Sat, 16 Jun 2018 01:05:01 +0800
Message-Id: <1529082301-59038-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528774962-39173-1-git-send-email-jiazhouyang09@gmail.com>
References: <1528774962-39173-1-git-send-email-jiazhouyang09@gmail.com>
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When xenbus_printf fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling xenbus_printf.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
v1->v2:
- Fix dereferencing before checking.
v2->v3:
- Use xenbus_dev_error to report errors.
v3->v4:
- Fix compilation errors.
v4->v5:
- Fix compilation errors.
---
 drivers/scsi/xen-scsifront.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 36f59a1..61389bd 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -654,10 +654,17 @@ static int scsifront_dev_reset_handler(struct scsi_cmnd *sc)
 static int scsifront_sdev_configure(struct scsi_device *sdev)
 {
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
+	int err;
 
-	if (info && current == info->curr)
-		xenbus_printf(XBT_NIL, info->dev->nodename,
+	if (info && current == info->curr) {
+		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateConnected);
+		if (err) {
+			xenbus_dev_error(info->dev, err,
+				"%s: writing dev_state_path", __func__);
+			return err;
+		}
+	}
 
 	return 0;
 }
@@ -665,10 +672,15 @@ static int scsifront_sdev_configure(struct scsi_device *sdev)
 static void scsifront_sdev_destroy(struct scsi_device *sdev)
 {
 	struct vscsifrnt_info *info = shost_priv(sdev->host);
+	int err;
 
-	if (info && current == info->curr)
-		xenbus_printf(XBT_NIL, info->dev->nodename,
+	if (info && current == info->curr) {
+		err = xenbus_printf(XBT_NIL, info->dev->nodename,
 			      info->dev_state_path, "%d", XenbusStateClosed);
+		if (err)
+			xenbus_dev_error(info->dev, err,
+				"%s: writing dev_state_path", __func__);
+	}
 }
 
 static struct scsi_host_template scsifront_sht = {
@@ -1003,9 +1015,12 @@ static void scsifront_do_lun_hotplug(struct vscsifrnt_info *info, int op)
 
 			if (scsi_add_device(info->host, chn, tgt, lun)) {
 				dev_err(&dev->dev, "scsi_add_device\n");
-				xenbus_printf(XBT_NIL, dev->nodename,
+				err = xenbus_printf(XBT_NIL, dev->nodename,
 					      info->dev_state_path,
 					      "%d", XenbusStateClosed);
+				if (err)
+					xenbus_dev_error(dev, err,
+						"%s: writing dev_state_path", __func__);
 			}
 			break;
 		case VSCSIFRONT_OP_DEL_LUN:
@@ -1019,10 +1034,14 @@ static void scsifront_do_lun_hotplug(struct vscsifrnt_info *info, int op)
 			}
 			break;
 		case VSCSIFRONT_OP_READD_LUN:
-			if (device_state == XenbusStateConnected)
-				xenbus_printf(XBT_NIL, dev->nodename,
+			if (device_state == XenbusStateConnected) {
+				err = xenbus_printf(XBT_NIL, dev->nodename,
 					      info->dev_state_path,
 					      "%d", XenbusStateConnected);
+				if (err)
+					xenbus_dev_error(dev, err,
+						"%s: writing dev_state_path", __func__);
+			}
 			break;
 		default:
 			break;
-- 
2.7.4

