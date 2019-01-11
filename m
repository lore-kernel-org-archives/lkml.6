Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EA1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:44:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92A8420879
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 00:44:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TIyUDQ18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbfAKAoK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 19:44:10 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:42775 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfAKAoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 19:44:09 -0500
Received: by mail-io1-f68.google.com with SMTP id x6so10826744ioa.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 16:44:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7vFDpaFab4XrBOItErL5ETNofRzPtvP7mzD1JwIlN4=;
        b=TIyUDQ18AAomkB7n8nicph9ecVZaAyVqKrXmC7Bk0ywpteroDDZqb9yrj3+Ri5x9yK
         FiYVS4VYlp08FS7FZJ3bzkWBYXtweJ8ttmOKPq4vjzg1ab1FcqY4WumbMPAaL9/btr3F
         i3+iSpayHKO3Wmb0R+2wr9ZWv0I1dwX2wLnTFg81y5jgScogr+Fuy/AEaGilG6Sm8L8c
         jxbm3gb5qsbWOWvwmRuT9vXLmOJcndnaoYiqqyJRTbJPV45AWDqoy3Z+Msg9lXLs97n7
         sm4M7ZoTQcs6Z3gaQru3YA6maEZ0q/cPx2yFEKDBmFYeFGt6BZW4od46jeUoUTkCSi84
         rjkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7vFDpaFab4XrBOItErL5ETNofRzPtvP7mzD1JwIlN4=;
        b=rKCsWNcopgQWyxcXeMjUxKlTgs7RGDAPTbEBLVb8RNXKhLycWRaFHknrMPYGJBPKEz
         o0+SeavQii3UyaiOdgtV8FTtWUR5PE+XxX9X2TZoTahu+iiMrMLWS3TfQUZrGG5/7CNE
         8pHwuDg9oLBpLqcNPiINwrX/XEKnVodew19VHxP+cuH84n1AOTMUjB7eeoVLiOZoLb43
         YegoF2tEdUoCGL5isQWfXITRlCWCW+plLcTv6FyTXJ4Bfa7KduXfmFN27AGMHMp5hid+
         WGhEv8fn2lMjQjvWQylFT3mxVWT1JMQo8pwacwrnqXK7nazkMCDiaFG1RGm7j9Dk3uux
         L8ow==
X-Gm-Message-State: AJcUukdpPRGvtu2Ec5XYnJZ+CaNAk5SPDKRFvIOlqEOKOlWx/iHJvuO4
        xk2vgDapLaEIOD5Stxp7ayc=
X-Google-Smtp-Source: ALg8bN5KJn3880gZftypM07ZIby+yZ9OBD0V37HDa7iqFgAJKQj4h0ChxHFxklPskjHJWAgZNhgN3g==
X-Received: by 2002:a6b:5a14:: with SMTP id o20mr7876952iob.206.1547167448086;
        Thu, 10 Jan 2019 16:44:08 -0800 (PST)
Received: from localhost.localdomain (c-73-242-244-99.hsd1.nm.comcast.net. [73.242.244.99])
        by smtp.gmail.com with ESMTPSA id t7sm31142310iom.27.2019.01.10.16.44.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 16:44:07 -0800 (PST)
From:   thirtythreeforty@gmail.com
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     George Hilliard <thirtythreeforty@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        NeilBrown <neil@brown.name>
Subject: [PATCH v2 2/2] Mediatek staging: Use individual config flags in Makefile
Date:   Thu, 10 Jan 2019 17:43:37 -0700
Message-Id: <20190111004337.7223-2-thirtythreeforty@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111004337.7223-1-thirtythreeforty@gmail.com>
References: <CACmrr9gHucWaWtz07kQms6AsquLKAHbK+_Q0kF=92RGo6HmAFA@mail.gmail.com>
 <20190111004337.7223-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: George Hilliard <thirtythreeforty@gmail.com>

These drivers are useful on other MT76xx SoCs, which have compatible
peripherals.  The drivers are selectable in Kconfig, but they were
quietly excluded from the build because the SOC_MT7621 chip was not
selected.  So, make the main staging Makefile use the same flags as
everything else for these drivers.

mt7621-dma and mt7621-dts are left alone because they truly do require
that SoC.

I have personally confirmed that the mt7621-spi driver works on the
MT7688, which was what prompted this change.

Cc: linux-kernel@vger.kernel.org
Cc: devel@driverdev.osuosl.org
Cc: NeilBrown <neil@brown.name>
Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
---
 drivers/staging/Makefile | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index e095f427177c..4b78ea2c7848 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -42,12 +42,12 @@ obj-$(CONFIG_BCM2835_VCHIQ)	+= vc04_services/
 obj-$(CONFIG_DRM_VBOXVIDEO)	+= vboxvideo/
 obj-$(CONFIG_PI433)		+= pi433/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-pci/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-pinctrl/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-spi/
+obj-$(CONFIG_PINCTRL_RT2880)	+= mt7621-pinctrl/
+obj-$(CONFIG_SPI_MT7621)	+= mt7621-spi/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dma/
-obj-$(CONFIG_SOC_MT7621)	+= ralink-gdma/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-mmc/
-obj-$(CONFIG_SOC_MT7621)	+= mt7621-eth/
+obj-$(CONFIG_DMA_RALINK)	+= ralink-gdma/
+obj-$(CONFIG_MTK_MMC)		+= mt7621-mmc/
+obj-$(CONFIG_NET_MEDIATEK_SOC_STAGING)	+= mt7621-eth/
 obj-$(CONFIG_SOC_MT7621)	+= mt7621-dts/
 obj-$(CONFIG_STAGING_GASKET_FRAMEWORK)	+= gasket/
 obj-$(CONFIG_XIL_AXIS_FIFO)	+= axis-fifo/
-- 
2.20.1

