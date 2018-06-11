Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1vrWAFc4HlsiMQAAmS7hNA
	; Mon, 11 Jun 2018 08:52:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DE624607A4; Mon, 11 Jun 2018 08:52:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOtKTTIi"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FROM,MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6B0B1606FA;
	Mon, 11 Jun 2018 08:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6B0B1606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932546AbeFKIwg (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 04:52:36 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34196 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeFKIwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:52:35 -0400
Received: by mail-pg0-f66.google.com with SMTP id q4-v6so8361649pgr.1;
        Mon, 11 Jun 2018 01:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cmCEKRLCAHwV9KostSrIThoAzGLeQHJXtToj8bM7bsE=;
        b=VOtKTTIiWpc2utmXPXLodkJUE0bQ7p8Erctgcl8mx7HWI9T79ovaJQIFJG+1Ld7+Dy
         opNFZDKFb8NUqnRACQTHfGROnHqUn9wUoHcvImnov26TCAJdtk0iXZL/7ulYo7ckXM5C
         FANNy1Fe/VRwsx7zJ1m+XexA7QIOd0CsrvjkYph9u3xn+LgA+esk9KBuOXite7ZdoIh4
         asMD6S1TRStx26BqfG90HHGko9ZVUoGg704EyYi1GPMd0DJ6aRBpHbWAbRI7wrhnaB6A
         /35yJSw8AbSwoyFXW8aZKZLw54QmoqMKES0oLmUFETWiesMLwe1oOVbCM6NgJK8+S9fV
         fKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cmCEKRLCAHwV9KostSrIThoAzGLeQHJXtToj8bM7bsE=;
        b=DdwxR+OhBvtSbN8ClQ9kyGGUsl0kpUKyi66TaN2sCTnCjJru9S+VKlKvhU70Vx5jyd
         JWCFCmg5N/R3Ahl4AXgli7gm+AjQuZbeFygxtTKJIGJByIA8m8+QPLSkdsKeP2XJCR1m
         QserZ2//8L92yK4uopMH3xFlh5ALf8abMXbtgfSJq+uJEP3XgKb8mqr2L4VRIad31wJg
         aui0GQM2F+aYptiv3Ki3YTOicplVnC8GNXpBbmIJN6VMfyq2hV6i44zm3t3qV74O4/4f
         TIpnjWmIMuzOGxJp+Q3RKW08l+prjSY2Elj0X9GM/pP6nslJJJXoGB1Ldylc+CdoOLPI
         wH2g==
X-Gm-Message-State: APt69E3BpbwbZoF/chJ8oH1H5+x6izLpAmzFECAH0eWs1GoCf7Dd5hph
        ygc+WfeGEo2ckg1aPdkriac=
X-Google-Smtp-Source: ADUXVKI8WCymay5ylCTnuU1YBqw7e1Xtjk/L3Gs2O+ytPWGdC5WyVtnaWGybDDrwp4CO91oNvf5K4Q==
X-Received: by 2002:a63:7001:: with SMTP id l1-v6mr14340350pgc.358.1528707154644;
        Mon, 11 Jun 2018 01:52:34 -0700 (PDT)
Received: from localhost ([103.88.46.82])
        by smtp.gmail.com with ESMTPSA id a14-v6sm29937731pgv.4.2018.06.11.01.52.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 01:52:34 -0700 (PDT)
From: Zhouyang Jia <jiazhouyang09@gmail.com>
Cc: Zhouyang Jia <jiazhouyang09@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: add error handling for kcalloc
Date: Mon, 11 Jun 2018 16:52:26 +0800
Message-Id: <1528707147-35623-1-git-send-email-jiazhouyang09@gmail.com>
X-Mailer: git-send-email 2.7.4
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When kcalloc fails, the lack of error-handling code may
cause unexpected results.

This patch adds error-handling code after calling kcalloc.

Signed-off-by: Zhouyang Jia <jiazhouyang09@gmail.com>
---
 drivers/usb/storage/alauda.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/storage/alauda.c b/drivers/usb/storage/alauda.c
index 900591d..c56355c 100644
--- a/drivers/usb/storage/alauda.c
+++ b/drivers/usb/storage/alauda.c
@@ -437,6 +437,11 @@ static int alauda_init_media(struct us_data *us)
 		+ MEDIA_INFO(us).blockshift + MEDIA_INFO(us).pageshift);
 	MEDIA_INFO(us).pba_to_lba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
 	MEDIA_INFO(us).lba_to_pba = kcalloc(num_zones, sizeof(u16*), GFP_NOIO);
+	if ((MEDIA_INFO(us).pba_to_lba == NULL)
+		|| (MEDIA_INFO(us).lba_to_pba == NULL)) {
+		pr_warn("alauda_init_media: memory allocation failed\n");
+		return USB_STOR_TRANSPORT_ERROR;
+	}
 
 	if (alauda_reset_media(us) != USB_STOR_XFER_GOOD)
 		return USB_STOR_TRANSPORT_ERROR;
-- 
2.7.4
