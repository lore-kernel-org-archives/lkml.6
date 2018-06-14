Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0CA08C5CFC0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC6D208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 22:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/kuTaYX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBC6D208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965135AbeFNW71 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 18:59:27 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35138 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965006AbeFNW7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 18:59:25 -0400
Received: by mail-pl0-f66.google.com with SMTP id k1-v6so4336370plt.2;
        Thu, 14 Jun 2018 15:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8fAUVQ4DeolZcnrng4lwqlH6/zv84TJiAWY8EFRywiw=;
        b=m/kuTaYXhgRoiUihJGFnw/lzPkOZqpiO5ynJ9mxE0HgdBkW1a/9soKzgLjsa7/igBG
         7fm/1sh3OKZAGVUZqBf71TxfpiRY+2HrCwAPhlnLKzaGbxe8BChQnXfa8gddZAlBegp4
         xuOvuMafO8A8CiwnptL99+/pwx3hGXroKooeGS6egeD7faSojE70xnHzVyzNJ02qZegO
         ut6whoDnw0wiW/RhFfJJ+5tL0aXiqhzzaN4wh7izgH5plJCtuPOGil/9slP+IsVIGTut
         uHHc718wADBvklt4VXXdzGFYDD5XVHhPX5Qu55ehsWTmX5QwwYKELGQ59RBzKOxOro4i
         ea1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8fAUVQ4DeolZcnrng4lwqlH6/zv84TJiAWY8EFRywiw=;
        b=eN5y0QuTgk6rYcjvNCcIhR1crQJkREUDOu6iOHfimCz/R/gJ6qYOPaCwTUKHm9smh4
         2w22vtCjOR/EQVAuuUuWlS/arY8fPbssjnfZQOWnga2N10mjOw1W/c9ZCPhChvJPMnGk
         b3szcn4lD7pbxEqkJltW1YJH1Wh8qbBh/7tf/1/ncqcHQN8quNUbi4ApdOoOr/34/CT5
         bdPioxD/kQqFoGCLAPCLmxgvKTAcKvgE0Uknujf/+eS9VXSPSOYp8QFfmjHzIjiZa8J7
         6qOZSvXg9jcYVRKIUQynoovsYR2istg91bbxEsyex8TLFtwT05KSEoT+BkCXakpfeNhb
         dAfw==
X-Gm-Message-State: APt69E02ODRTdXB117gz2TXSlHt9AWXchFxwfWz1xjDMp/4s2nTN+h1w
        M0bHv9W2BT/WsMGdVs2KBhRkqRQ/h/4=
X-Google-Smtp-Source: ADUXVKLcQrbZ8GCYWqmeMmSy6pV5+P15yE3QDpD6zLXGVF4kV7c9gvx5mjhj/iaLokPLeLsH2qyosA==
X-Received: by 2002:a17:902:321:: with SMTP id 30-v6mr5206747pld.122.1529017165139;
        Thu, 14 Jun 2018 15:59:25 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id b72-v6sm12671743pfj.56.2018.06.14.15.59.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jun 2018 15:59:24 -0700 (PDT)
From:   Zhouyang Jia <jiazhouyang09@gmail.com>
Cc:     Zhouyang Jia <jiazhouyang09@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        xen-devel@lists.xenproject.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] scsi: xen-scsifront: add error handling for xenbus_printf
Date:   Fri, 15 Jun 2018 06:59:14 +0800
Message-Id: <1529017154-54719-1-git-send-email-jiazhouyang09@gmail.com>
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
v2->v3:
- Use xenbus_dev_error to report errors.
---
 drivers/scsi/xen-scsifront.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/scsi/xen-scsifront.c b/drivers/scsi/xen-scsifront.c
index 36f59a1..644d1ce 100644
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
+			xenbus_dev_error(&info->dev->dev, err,
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
+			xenbus_dev_error(&info->dev->dev, err,
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
+					xenbus_dev_error(&dev->dev, err,
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
+					xenbus_dev_error(&dev->dev, err,
+						"%s: writing dev_state_path", __func__);
+			}
 			break;
 		default:
 			break;
-- 
2.7.4

