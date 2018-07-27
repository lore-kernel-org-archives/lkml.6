Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97EFFC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 497F3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eXAt1Ahv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 497F3206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbeG0EmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:42:05 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36288 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbeG0EmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:42:05 -0400
Received: by mail-pf1-f195.google.com with SMTP id d14-v6so1247492pfo.3;
        Thu, 26 Jul 2018 20:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aDcdg20wqS6l0/q3CQjePZhEkFF3+kY6U4pe4Gk9R54=;
        b=eXAt1AhvKyMeezhPM4xyuU4IReMU66uHnWj5eEcpHKWhNXh5p0mde+5/Ww1t0Tmr3i
         SNkw1GXGSYdyMPgSa6otzHe9SkT5J/rd8XPjyogz4X+oFAiMmwFuN579HMQ0T4Qf4x8T
         esQWJ2WQqvG+/xNqHAqda6gPGvxgZTAqb7wrseC9XHEtwT8huR9U97PrsK9SonfjdTAw
         Yj9paL2k4KYQqyRYCybCXfmqUOrRQ/FA0+U3/zbXbVCnOHqgz2kJBMUnIaAJdGacUVBy
         kbx3mbfW/quYFMmhJ9207ixT6smnPIwhyqYXsEgPVTWmEcFospjuCZzhCYwE2BzqKDkc
         etFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aDcdg20wqS6l0/q3CQjePZhEkFF3+kY6U4pe4Gk9R54=;
        b=Xwxobb4qbXJc7/P1PCBjTeAIsBKYuINmyPkbRinifcNFZOLwgA5HI16dlm9X4g85y6
         e4Xr+YtWM4AUHlhRNkVthN53wV8c23Ma6pfI+HPsAn9HYJEeMWQuhTwfezBb0T4sUemR
         aCJ3fQKTMQIMhvGLl4lMftMqCzg8mf7L4rypPgmy0ictNGhIOXi26l1yT0eb+OnXh8AF
         h9McR2RWXEzHPhfkHiY/iQTb2NV9HNR/axJeR705ljuCEEGiEXANzeJ78Ws0JnfuwoEA
         Rc7GnviNZ1Wj10fMf88hfSlvv2mwExdjW1bTG0h2H0A5B0lAR+FU3S9sJEnp9FeJOqs9
         p/GQ==
X-Gm-Message-State: AOUpUlHajftmXmSCYkFFHLF9TuGNuLK2ZA0RD8KobqBQSXciwEqm/ZTR
        Kn29swvK7Sv6uCRAOJcb/CY=
X-Google-Smtp-Source: AAOMgpdz2ASloRBglwe8Cd1FqHgSWoJ0gW5oAZks2gsyx/AcPg8Mzk9eXpBWYUKHXowIBhYmbYUygA==
X-Received: by 2002:a62:591a:: with SMTP id n26-v6mr4831928pfb.94.1532661738417;
        Thu, 26 Jul 2018 20:22:18 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id d11-v6sm3861267pfo.135.2018.07.26.20.22.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:22:17 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org, hans.verkuil@cisco.com, bhumirks@gmail.com,
        colin.king@canonical.com, viro@zeniv.linux.org.uk,
        gregkh@linuxfoundation.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: cx25821: Replace mdelay() with msleep()
Date:   Fri, 27 Jul 2018 11:22:09 +0800
Message-Id: <20180727032209.3320-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cx25821_gpio_init(), cx25821_initialize() and cx25821_registers_init() 
are never called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cx25821/cx25821-core.c | 4 ++--
 drivers/media/pci/cx25821/cx25821-gpio.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/media/pci/cx25821/cx25821-core.c b/drivers/media/pci/cx25821/cx25821-core.c
index 040c6c251d3a..2f0171134f7e 100644
--- a/drivers/media/pci/cx25821/cx25821-core.c
+++ b/drivers/media/pci/cx25821/cx25821-core.c
@@ -428,7 +428,7 @@ static void cx25821_registers_init(struct cx25821_dev *dev)
 	tmp |= FLD_USE_ALT_PLL_REF;
 	cx_write(CLK_RST, tmp & ~(FLD_VID_I_CLK_NOE | FLD_VID_J_CLK_NOE));
 
-	mdelay(100);
+	msleep(100);
 }
 
 int cx25821_sram_channel_setup(struct cx25821_dev *dev,
@@ -803,7 +803,7 @@ static void cx25821_initialize(struct cx25821_dev *dev)
 	cx_write(CLK_DELAY, cx_read(CLK_DELAY) & 0x80000000);
 	cx_write(PAD_CTRL, 0x12);	/* for I2C */
 	cx25821_registers_init(dev);	/* init Pecos registers */
-	mdelay(100);
+	msleep(100);
 
 	for (i = 0; i < VID_CHANNEL_NUM; i++) {
 		cx25821_set_vip_mode(dev, dev->channels[i].sram_channels);
diff --git a/drivers/media/pci/cx25821/cx25821-gpio.c b/drivers/media/pci/cx25821/cx25821-gpio.c
index 76b8f619e55a..f5ffaf880e5f 100644
--- a/drivers/media/pci/cx25821/cx25821-gpio.c
+++ b/drivers/media/pci/cx25821/cx25821-gpio.c
@@ -88,7 +88,7 @@ void cx25821_gpio_init(struct cx25821_dev *dev)
 	default:
 		/* set GPIO 5 to select the path for Medusa/Athena */
 		cx25821_set_gpiopin_logicvalue(dev, 5, 1);
-		mdelay(20);
+		msleep(20);
 		break;
 	}
 
-- 
2.17.0

