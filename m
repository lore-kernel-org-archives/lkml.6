Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7E16DC5CFC0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26CF3208D7
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 01:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RN2huSvU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26CF3208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965344AbeFOBsk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 21:48:40 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:45536 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965018AbeFOBsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 21:48:38 -0400
Received: by mail-pl0-f68.google.com with SMTP id c23-v6so4500460plz.12;
        Thu, 14 Jun 2018 18:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5IDqLLSuFvPXhP6vbXsap7z0cXiIu0GiqFE9AYSI/iw=;
        b=RN2huSvU6tZfODSlZFZ2GYMPFYleUx5sqeqkd2B/ap14hEBDeEyxXXJgI/62tgf70l
         lmDXW0u7GrSObmbJKBmS0wyHkJaFDizzA3+uk4qw70FJXYhgnO4MR/qn0HUvvKRChxNy
         TzxAONWXA3noXbDxHqeN7/4ro5AYK0QXuVy+IThVWQG/agJM1KpX2tJgtI1PwJtZM63H
         tQNNFNcyqYWJ1vt56lw/N5mgfORYCc8EXMNwL5eixQMHEpf1Rqa8xFd0x1d/7GlPNyvF
         winOfJAGdHji6MsZXYvrWEdoIjn6lYZOBa2evPnHkk+Lub/csc5T2r3c+CAHlb9atMOd
         2aeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5IDqLLSuFvPXhP6vbXsap7z0cXiIu0GiqFE9AYSI/iw=;
        b=exSt9HDdsxJPABK79jb6sIF7ZYYXfTajGzQh3Mhy7ZXCGHRqWcHs5FBs7Bqa06lSLM
         dn+3CZsObnQinxjZB9PXgRmvvdnoRqESuf/aQycDzACt+VNXW0VIPW36ZR5LhJLESIl+
         xB3TliOKUHV82aN9HYV6tJJXlM1xnMIaa04J79U8nf1PUYkRiNCwD4HWwYz8TZTrE5Us
         kClNnuQF6O2SW3Q605q6+Rarmoz1ltfNcTmXRHae1VKLRntxMCyQJPnP0YKReBSzt/Kh
         9bXXCDjNHw4DHF0+Y88tGOW3o5LOc4fD6HS1i82jPKP4riAGendcD4psn2J/EjCf2Q3W
         phSA==
X-Gm-Message-State: APt69E0i7LPsq6q5lsvRPD08TUTfmHC+HbBoPyFtHkmNNJOpIFyMyPFX
        gCd/84LYfHCnnr/F08kXeVM=
X-Google-Smtp-Source: ADUXVKLus5QwWR0AO/XtrPTSCg8AR1ntyhjqDutNAQIWch6dZW2QJKbtmnKDa99wL5ur6a+KXpByoA==
X-Received: by 2002:a17:902:820a:: with SMTP id x10-v6mr5573426pln.179.1529027318258;
        Thu, 14 Jun 2018 18:48:38 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id g8-v6sm2229628pgq.69.2018.06.14.18.48.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 18:48:37 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4] scsi: xen-scsifront: add error handling for xenbus_printf
Date:   Fri, 15 Jun 2018 09:48:31 +0800
Message-Id: <1529027312-56770-1-git-send-email-jiazhouyang09@gmail.com>
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
---
v1->v2:
- Fix dereferencing before checking.
v2->v3:
- Use xenbus_dev_error to report errors.
v3->v4:
- Fix compilation errors.
---
 drivers/scsi/xen-scsifront.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 36f59a1..be576cb 100644
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
+			xenbus_dev_error(&info->dev, err,
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
+			xenbus_dev_error(&info->dev, err,
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

