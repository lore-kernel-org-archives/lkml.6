Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E4FAC10F00
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4753421902
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:01:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbfBSJBY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:01:24 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41478 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbfBSJBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:01:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so9087962wrw.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 01:01:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lBFymejVO6nyQQvMVd1TUt4bRT7eP4YLeQu2FDz6j7M=;
        b=ggcJYyAE/MEaKNMleqcZLvgvXudegubzI27whCOcAksm2w1LWyZeyXbvDwNMIz18co
         Xrh0oRMDrrffHPYTSDYWjytCox8WHMHDGiscktOdUuiRugc4f930TP2C9lfi7Vw4c6kp
         zxOdd9hxFjp1VnHClSGKbU6yiOKjcQdQptl8mqCkPrv6tc6w0TPucfTRcUHxou4KWLMO
         0GT+MD1OMv8jm1+mqmb+pDjyCamI3h4NR/yryW8WCuCG67TZFyR6cCH6V1F940byiSXB
         AklV6HOVuK6OO+gdoFX4LOydv8L+0b4EYgpOnDQjATzx/E6Pd+Td3lfmDKa78S7DSXFD
         m7Kw==
X-Gm-Message-State: AHQUAuZ5VNKnHaUzhP/XebRLYcYyUzdR8KaZZzCxyWdqHZgfT/Cl4I9h
        FMGgr4R/jn8mXGDjabXUvwruxyeikMo=
X-Google-Smtp-Source: AHgI3IZqIulMrW23qsi+TjpzBIPzRnWNszRUrCEIbyeC+HTx9LCU/HtIFsKXuQ47oEbXLU4QHAfc9A==
X-Received: by 2002:a05:6000:128f:: with SMTP id f15mr19075527wrx.74.1550566881168;
        Tue, 19 Feb 2019 01:01:21 -0800 (PST)
Received: from minerva.redhat.com ([90.168.169.92])
        by smtp.gmail.com with ESMTPSA id f196sm2745727wme.36.2019.02.19.01.01.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 01:01:20 -0800 (PST)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        devel@driverdev.osuosl.org, Philipp Zabel <p.zabel@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Steve Longerbeam <slongerbeam@gmail.com>,
        linux-media@vger.kernel.org
Subject: [PATCH] media: staging/imx: Allow driver to build if COMPILE_TEST is enabled
Date:   Tue, 19 Feb 2019 10:01:04 +0100
Message-Id: <20190219090104.1143-1-javierm@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has runtime but no build time dependency with IMX_IPUV3_CORE,
so can be built for testing purposes if COMPILE_TEST option is enabled.

This is useful to have more build coverage and make sure that the driver
is not affected by changes that could cause build regressions.

Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>

---

 drivers/staging/media/imx/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/media/imx/Kconfig b/drivers/staging/media/imx/Kconfig
index 36b276ea2ec..5045e24c470 100644
--- a/drivers/staging/media/imx/Kconfig
+++ b/drivers/staging/media/imx/Kconfig
@@ -1,7 +1,7 @@
 config VIDEO_IMX_MEDIA
 	tristate "i.MX5/6 V4L2 media core driver"
 	depends on ARCH_MXC || COMPILE_TEST
-	depends on MEDIA_CONTROLLER && VIDEO_V4L2 && IMX_IPUV3_CORE
+	depends on MEDIA_CONTROLLER && VIDEO_V4L2 && (IMX_IPUV3_CORE || COMPILE_TEST)
 	depends on VIDEO_V4L2_SUBDEV_API
 	depends on HAS_DMA
 	select VIDEOBUF2_DMA_CONTIG
-- 
2.20.1

