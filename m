Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27998C282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E93C72145D
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="iWoQrZmy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbfBEK0Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:26:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37120 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729175AbfBEK0B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:26:01 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so3008050wmd.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YI7lGj6dJe+1jKSiIdUHdLpV0CJALW0y9vtqdcoWmhk=;
        b=iWoQrZmyEXVVLnvOIwM5PQVAvKBfwG5luEZW9f/zDaI2O4VZYwnJCOCGzKO1drdajw
         Jdlx8uDUelkhDw43lxxSIyJGcXjRLaiQDOH9BVqwz0RpcCMstHnysgTHdOqNqVw7AKIR
         AYv0VaP/sxhn1yM5VsVReX1iSJUPvHn5MqhZW0KyemDeSCMwk+S15yELF9t7Tt7yK3Jr
         WQUqzNXLO8AeVqz5eIKSAmPVxMtgP/Wb+mK4pL+g/BSJcq27apRzQkMo1J1ikntkZjzO
         2iD3KHv2uD8Tx3sY+stWfw78sW5kiMD14wUO1UtIlMU1qjIiHrUzGkrACEJoH+1RkFOt
         5+pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YI7lGj6dJe+1jKSiIdUHdLpV0CJALW0y9vtqdcoWmhk=;
        b=LvdCMQ3vn04illu7tK30BmEJbpxm8WkqCH91N86bdp5dV9eJ6D8b+ggKtxh1UO79Yi
         95IgiRkxKXAuiAuY2lgf7xHihSAZlyzyLu00KKeZtNdHHBA0bByNrQ/dnCTlqVv4qzWL
         iWmq45Y7r0kkh9ULr4kLb0+vgcbp8nxSGE2TxgP+bPULh6vDFxVc9HOZSP55k9kRCdt7
         COohqDsDx3v9sHEO2cROKIXH+6pIbePCgoFbrsmXE6YDMyOje2TIKGLvqn5xRLwv3R4n
         jTsNHphi6XgR9QFdbdTo29OPcrdgd23+vVRV4fE2OCRPiXITO9ulM5i4UZWfkwV2aUsk
         aeXQ==
X-Gm-Message-State: AHQUAuaTH5GtFg//Y1BoGixsRO07idDfjrrOGUA4jI8xZ2L1E20boxiM
        EN8ZCVWXI9o5FRmmX1Fo77cMbQ==
X-Google-Smtp-Source: AHgI3IZ4nPR1E+2u8hkBsTrLXyxyY8xsYuSmFe0pJpeHIc2QhG7pGS242qb/Zai3zg/pyR/6JexZLQ==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr3137760wme.104.1549362359927;
        Tue, 05 Feb 2019 02:25:59 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
        by smtp.gmail.com with ESMTPSA id r11sm5132396wrx.75.2019.02.05.02.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 02:25:59 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: [PATCH 8/8] usb: ohci-da8xx: remove unused callbacks from platform data
Date:   Tue,  5 Feb 2019 11:25:46 +0100
Message-Id: <20190205102546.29457-9-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190205102546.29457-1-brgl@bgdev.pl>
References: <20190205102546.29457-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

There are no more users of these callbacks.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
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

