Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id E8BF7C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E410208D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 16:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sYBT8j2m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E410208D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755372AbeFNQIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 12:08:54 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42774 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754986AbeFNQIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 12:08:53 -0400
Received: by mail-pg0-f67.google.com with SMTP id c10-v6so3133377pgu.9;
        Thu, 14 Jun 2018 09:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BMg/sWOBML7dQr6i7+v7JGPkXb12jQDhPcfOY6adsJc=;
        b=sYBT8j2miwA6VaMnbZh9WrODVnYraG+uT+6PbktR/MLMYGNv4XZaz49lU52Y7Vd7XJ
         6NE53IHRECXNeHcttL7J9eO6znlDrd058cJNc4Rj2nD0/Ep5bPTjko4Zlk3/V2mqEH2L
         VnE45Y4cmWmMGiMb433rqGMwEOjO68Mb+xLi5DHfhqcgFbspZEnO2p8rdSse40zdsuTn
         R3BlkPzHvQrf1k686k5qoK2zlDDaDsgFyQZ/mCK0bR1DlRbJVnkXRyPj7qJ9GVrlElsu
         HUTKE+vKngrit2Fzu8UQlt/R3PveFXFx9DOqHqTyBm+RG+T0yXDhmNcDZh9WcGxddkaP
         lMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BMg/sWOBML7dQr6i7+v7JGPkXb12jQDhPcfOY6adsJc=;
        b=d1h4ZS+RY7fl6GkYNCjoANfS90N0aDUBLU/bISHdxrezxSzwJszk6Q3/jQFWgdq8Ce
         PENHKZEHpW4GBxXq4yeDNMbJ7LYcx/XnMrMKKTjVsKbZn+GGCmc2ShFRw7+fmV33RFrU
         mDSXx+FNkekwMEJLl0g8Lc6tzRXM3y+k77AReAUOrPPCuxxMIhudBZAtlUVo0JflfcA1
         LjaGy2PVwgJi7AxFNTgEuN/e8mWw1L3X/LKN1AjkyGL2reips9OlHxtvpazYJCuMFdsB
         ol8yXU61WbTGXAkql4ymxvG+pOiHV+fQ9vjAH87aAyAKDeV0qbV46TNRzzhzECF4fB55
         CjJQ==
X-Gm-Message-State: APt69E1Rn/CCIJ/WsLgVYZny65Pyv2zmHnStEGk1UskCV1Z3Eu8Iefob
        1b70KWprMkB7e9XUgViZ5HM=
X-Google-Smtp-Source: ADUXVKKXDLW6R/mCJaRwZzPM9pzp6lGLcRq5oAB0VdTz2xLhjZpJDThm+crmrytBXeZkz0Eht5lTPA==
X-Received: by 2002:a65:4783:: with SMTP id e3-v6mr2848852pgs.235.1528992532758;
        Thu, 14 Jun 2018 09:08:52 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id b84-v6sm9267058pfm.123.2018.06.14.09.08.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 09:08:52 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] scsi: xen-scsifront: add error handling for xenbus_printf
Date:   Fri, 15 Jun 2018 00:08:34 +0800
Message-Id: <1528992514-53963-1-git-send-email-jiazhouyang09@gmail.com>
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
- Fix dereferencing before checking
---
 drivers/scsi/xen-scsifront.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 36f59a1..a7f6111 100644
--- a/drivers/scsi/xen-scsifront.c
+++ b/drivers/scsi/xen-scsifront.c
@@ -654,10 +654,16 @@ static int scsifront_dev_reset_handler(struct scsi_cmnd *sc)
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
+			dev_err(&info->dev->dev, "writing dev_state_path\n");
+			return err;
+		}
+	}
 
 	return 0;
 }
@@ -665,10 +671,14 @@ static int scsifront_sdev_configure(struct scsi_device *sdev)
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
+			dev_err(&info->dev->dev, "writing dev_state_path\n");
+	}
 }
 
 static struct scsi_host_template scsifront_sht = {
@@ -1003,9 +1013,11 @@ static void scsifront_do_lun_hotplug(struct vscsifrnt_info *info, int op)
 
 			if (scsi_add_device(info->host, chn, tgt, lun)) {
 				dev_err(&dev->dev, "scsi_add_device\n");
-				xenbus_printf(XBT_NIL, dev->nodename,
+				err = xenbus_printf(XBT_NIL, dev->nodename,
 					      info->dev_state_path,
 					      "%d", XenbusStateClosed);
+				if (err)
+					dev_err(&dev->dev, "writing dev_state_path\n");
 			}
 			break;
 		case VSCSIFRONT_OP_DEL_LUN:
@@ -1019,10 +1031,13 @@ static void scsifront_do_lun_hotplug(struct vscsifrnt_info *info, int op)
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
+					dev_err(&dev->dev, "writing dev_state_path\n");
+			}
 			break;
 		default:
 			break;
-- 
2.7.4

