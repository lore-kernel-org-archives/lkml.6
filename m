Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FDCC282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88C12084D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:37:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="sKVAHfBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfBKKhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:37:23 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40633 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727021AbfBKKhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:37:18 -0500
Received: by mail-wm1-f68.google.com with SMTP id q21so16300584wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tt06UGkm6C60fE3GnCLmVsdN1KETvFT9lYr7KKnVtso=;
        b=sKVAHfBSGT6IdWdNE5LktbYFBiksZLEdXjYNRPMNh/GHaXkR3ztP+XBnsm2wyoHB2q
         3cto1e4KOLLe/rXUPUAGVkHxDVxBs1x6pVtED2SMpSPk7Bv0LogoZQ5B3ea/t96px4ju
         J1GTy/Rgg3e1E7i/Ofwr0h1+9SWIHY0iGCHYshVVwCZ8uuK5U/bTgmA+0gKdRHndXe1H
         i6KFuoM7eNHrEqG4cpZIKGPJEfc2QXQdCigw99YbtgpVpnb+0B4qbad+lO+1QHhA2uw1
         eRTpomgOFVp6bUdXLqYSFc9+BcvOc3nqtJ/rWFQc2jFpDTEYOiCTgt8ZxBsjZOKClXVP
         H0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tt06UGkm6C60fE3GnCLmVsdN1KETvFT9lYr7KKnVtso=;
        b=gPkynCthDA87TtCi/5bLT/n6acXcG1Wo8NBpQQmFZhAX9/BFeOyQzvwNQ/mhEsnrZ0
         4/Oouu8Xs/WLz2CEV7VcaxWKb6Zyzzmxnc6X1yNhchEkNqIzEewf55mFhKNJKwtO/I9o
         vb9U8a3LnAX/3pZfhD5vaz90qo/mJjt2tESs1qGycUSC9Up2XE5WXBET8Pokx5V2D2vq
         x3awP7Tm+vW7Qn4DaiPe+5L9rhZGtE9YPNCu/wtZULQ+0Gzm5nlb1Duea/hUTvFvsHPZ
         kOwwnyaOLRjEJ7doSyywQnvz0pBRyR3b4KAP6qxLV5hoJt3RWfKs2hXNj5MlbZ0C4zBh
         vBnQ==
X-Gm-Message-State: AHQUAubKKQcDWBkD7vIOtTYRQTx661Ata64U4L1YK7ZYqVUrnQGYJ2lW
        3ejxr6kDKPIYcli94P6iuXJQ4w==
X-Google-Smtp-Source: AHgI3IZDb7JzDbFuJfzdE5f/zY5bCfx61C1chkHlbE9OBlu3hXjXN3Fp4mm2dOAV7e75keLcB04ftw==
X-Received: by 2002:a1c:7304:: with SMTP id d4mr6467825wmb.136.1549881435805;
        Mon, 11 Feb 2019 02:37:15 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id i192sm11121275wmg.7.2019.02.11.02.37.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 02:37:15 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH v2 8/8] usb: ohci-da8xx: remove unused callbacks from platform data
Date:   Mon, 11 Feb 2019 11:37:02 +0100
Message-Id: <20190211103702.4277-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211103702.4277-1-brgl@bgdev.pl>
References: <20190211103702.4277-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of the platform_data callbacks in ohci-da8xx.
Remove them.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
---
 include/linux/platform_data/usb-davinci.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/include/linux/platform_data/usb-davinci.h b/include/linux/platform_data/usb-davinci.h
index 0926e99f2e8f..879f5c78b91a 100644
--- a/include/linux/platform_data/usb-davinci.h
+++ b/include/linux/platform_data/usb-davinci.h
@@ -11,22 +11,8 @@
 #ifndef __ASM_ARCH_USB_H
 #define __ASM_ARCH_USB_H
 
-struct	da8xx_ohci_root_hub;
-
-typedef void (*da8xx_ocic_handler_t)(struct da8xx_ohci_root_hub *hub,
-				     unsigned port);
-
 /* Passed as the platform data to the OHCI driver */
 struct	da8xx_ohci_root_hub {
-	/* Switch the port power on/off */
-	int	(*set_power)(unsigned port, int on);
-	/* Read the port power status */
-	int	(*get_power)(unsigned port);
-	/* Read the port over-current indicator */
-	int	(*get_oci)(unsigned port);
-	/* Over-current indicator change notification (pass NULL to disable) */
-	int	(*ocic_notify)(da8xx_ocic_handler_t handler);
-
 	/* Time from power on to power good (in 2 ms units) */
 	u8	potpgt;
 };
-- 
2.20.1

