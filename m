Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF0CC46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 978F1217B7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 15:13:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Nim+dOlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978F1217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403876AbeHGR2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 13:28:36 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49364 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389181AbeHGR2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 13:28:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GUWIlZ8RUG/i34piD/c1KndbP93iicdVbVLs+hrfJr0=; b=Nim+dOlRKTRVyXsLjLK+MD17pV
        Om+UgI7+xkv70OnhUnXDhEiy5XJmC0ORq2tW8rhlJ7im0Q4fUVxBP2g/uU62r5amWFMvV9P0d+Pws
        LLFp1C1YUco+otnjpxgihuSHHRiXvf4sskxsUQ784rDmFIBFc1dqrlChX01vk3cqo+2RY9+9T/JC9
        YhSJ7JUH7O9lw5uHm+3p4w4D7AbOeUqQGrKILVVCweEmcb2Xv61FdeH9t/xvc7Pmozrbm41erJh+f
        tK9oYFxEnWwwtd6quohGOp6ds6t3Vb/rH+oO0TQ9voGvVSUyj2Cj5nmrXhlDqMd+0/2PLtfsTb3LT
        /uHAyPrw==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fn3gA-0000nT-Pe; Tue, 07 Aug 2018 15:13:47 +0000
To:     linux-media <linux-media@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Jacopo Mondi <jacopo@jmondi.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] media/i2c: fix mt9v111.c build error
Message-ID: <61037652-d37e-387a-7f32-7730c03e1e45@infradead.org>
Date:   Tue, 7 Aug 2018 08:13:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error in mt9v111.c when
# CONFIG_VIDEO_V4L2_SUBDEV_API is not set

../drivers/media/i2c/mt9v111.c: In function ‘__mt9v111_get_pad_format’:
../drivers/media/i2c/mt9v111.c:801:3: error: implicit declaration of function ‘v4l2_subdev_get_try_format’ [-Werror=implicit-function-declaration]
   return v4l2_subdev_get_try_format(&mt9v111->sd, cfg, pad);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jacopo Mondi <jacopo@jmondi.org>
---
 drivers/media/i2c/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20180807.orig/drivers/media/i2c/Kconfig
+++ linux-next-20180807/drivers/media/i2c/Kconfig
@@ -875,7 +875,7 @@ config VIDEO_MT9V032
 
 config VIDEO_MT9V111
 	tristate "Aptina MT9V111 sensor support"
-	depends on I2C && VIDEO_V4L2
+	depends on I2C && VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API
 	depends on MEDIA_CAMERA_SUPPORT
 	help
 	  This is a Video4Linux2 sensor driver for the Aptina/Micron


