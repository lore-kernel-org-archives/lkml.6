Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C4C5C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17172206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 03:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwjcH+ZX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17172206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeG0Ef0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 00:35:26 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33377 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeG0Ef0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 00:35:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id r5-v6so2372961pgv.0;
        Thu, 26 Jul 2018 20:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=0IkSzewAd/VeffZhMAfUjhKscKdE9XuQouYlw3f38zk=;
        b=IwjcH+ZXjyhHar9xsQtXUuzQFIuJaskNToQUSn6q8wqeshxFaEYiiYF4owchRziugm
         3iyPhMkV+HNsScsT5D5mnsEnfZ6eaTRp5UJRrohnSMkuNcGkEXr9m4yReHD/mgfV+xGn
         8xmalL2o6Rm7iSdZOKGv75R3+Z78gn7D04ropj93b0EYZsPQ45pnw+dUg4DuSTBoRPiO
         czZ4jROAcZCelyqYmHjRKIZXOfMACIfD5rEgtmyNHn6CABP6Eu7uSm72q2/51kOJ1ynb
         YntVyzIMxgfSpf/PZncOvXi4oZT68gHPsO1TMXOteDzU9ITz4hIZGKmXMHZJPgkZCivj
         EEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0IkSzewAd/VeffZhMAfUjhKscKdE9XuQouYlw3f38zk=;
        b=LdlLpBmaEA4r2RZA3EQzsZNtWWmmXErXw6x3o1mDlEur81ijxbo54H2l2O/SgFFibj
         6Jw7BUwanwWcPV3FAYOsLX+rMQ17Ylawn7NMG+fie3rsb07f8VzeXI7lSzmGoLL5GjBQ
         aBW0PC3nZLfkj4DSA6XmrXyB+C4gNCq1++PxOrSCe5nq5FH6ZYrCjDaMSiBXjOXpnQhC
         C3P73y4RJL2I+QpqFBo7TAngg41POEMfi8fnvVjaZPGL5zVucvfXU5UabZV2Xm2ziUFm
         ql+aYsNiRNKOI3fe63Vj/Yq1AJ85juIBUEbaImfNOORVQrhh/0xcJ7HvKZRryIgZn1WW
         7mUg==
X-Gm-Message-State: AOUpUlFxRTRQctTxX8e5jvLRTyBkY2z+p4M/KXv+08BF0A86/mTkRaDw
        BPG9j2mv84RpoWBCbevOSKA=
X-Google-Smtp-Source: AAOMgpfIv2Paw+WP8QkWvX2NQZrtQ5etKzzXNEN1v852JkmZxG0jzLWk6wUVML/z2e4eNDZqemGfEg==
X-Received: by 2002:a62:2646:: with SMTP id m67-v6mr4821780pfm.254.1532661341364;
        Thu, 26 Jul 2018 20:15:41 -0700 (PDT)
Received: from localhost.localdomain ([2402:f000:1:4414:6c14:7712:e625:1be4])
        by smtp.gmail.com with ESMTPSA id a20-v6sm3631754pfi.124.2018.07.26.20.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 26 Jul 2018 20:15:40 -0700 (PDT)
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
To:     mchehab@kernel.org, brad@nextdimension.cc, hansverk@cisco.com,
        colin.king@canonical.com, zzam@gentoo.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] media: pci: cx23885: Replace mdelay() with msleep() and usleep_range() in cx23885_gpio_setup()
Date:   Fri, 27 Jul 2018 11:15:34 +0800
Message-Id: <20180727031534.2988-1-baijiaju1990@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cx23885_gpio_setup() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/media/pci/cx23885/cx23885-cards.c | 82 +++++++++++------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/media/pci/cx23885/cx23885-cards.c b/drivers/media/pci/cx23885/cx23885-cards.c
index 3a1c55187b2a..4148ab4f3af0 100644
--- a/drivers/media/pci/cx23885/cx23885-cards.c
+++ b/drivers/media/pci/cx23885/cx23885-cards.c
@@ -1497,20 +1497,20 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the demod into reset and protect the eeprom */
 		mc417_gpio_clear(dev, GPIO_15 | GPIO_14);
-		mdelay(100);
+		msleep(100);
 
 		/* Bring the demod and blaster out of reset */
 		mc417_gpio_set(dev, GPIO_15 | GPIO_14);
-		mdelay(100);
+		msleep(100);
 
 		/* Force the TDA8295A into reset and back */
 		cx23885_gpio_enable(dev, GPIO_2, 1);
 		cx23885_gpio_set(dev, GPIO_2);
-		mdelay(20);
+		msleep(20);
 		cx23885_gpio_clear(dev, GPIO_2);
-		mdelay(20);
+		msleep(20);
 		cx23885_gpio_set(dev, GPIO_2);
-		mdelay(20);
+		msleep(20);
 		break;
 	case CX23885_BOARD_HAUPPAUGE_HVR1200:
 		/* GPIO-0 tda10048 demodulator reset */
@@ -1518,9 +1518,9 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the parts into reset and back */
 		cx_set(GP0_IO, 0x00050000);
-		mdelay(20);
+		msleep(20);
 		cx_clear(GP0_IO, 0x00000005);
-		mdelay(20);
+		msleep(20);
 		cx_set(GP0_IO, 0x00050005);
 		break;
 	case CX23885_BOARD_HAUPPAUGE_HVR1700:
@@ -1539,9 +1539,9 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the parts into reset and back */
 		cx_set(GP0_IO, 0x00050000);
-		mdelay(20);
+		msleep(20);
 		cx_clear(GP0_IO, 0x00000005);
-		mdelay(20);
+		msleep(20);
 		cx_set(GP0_IO, 0x00050005);
 		break;
 	case CX23885_BOARD_HAUPPAUGE_HVR1400:
@@ -1551,9 +1551,9 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the parts into reset and back */
 		cx_set(GP0_IO, 0x00050000);
-		mdelay(20);
+		msleep(20);
 		cx_clear(GP0_IO, 0x00000005);
-		mdelay(20);
+		msleep(20);
 		cx_set(GP0_IO, 0x00050005);
 		break;
 	case CX23885_BOARD_DVICO_FUSIONHDTV_7_DUAL_EXP:
@@ -1564,9 +1564,9 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the parts into reset and back */
 		cx_set(GP0_IO, 0x000f0000);
-		mdelay(20);
+		msleep(20);
 		cx_clear(GP0_IO, 0x0000000f);
-		mdelay(20);
+		msleep(20);
 		cx_set(GP0_IO, 0x000f000f);
 		break;
 	case CX23885_BOARD_DVICO_FUSIONHDTV_DVB_T_DUAL_EXP:
@@ -1578,9 +1578,9 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the parts into reset and back */
 		cx_set(GP0_IO, 0x000f0000);
-		mdelay(20);
+		msleep(20);
 		cx_clear(GP0_IO, 0x0000000f);
-		mdelay(20);
+		msleep(20);
 		cx_set(GP0_IO, 0x000f000f);
 		break;
 	case CX23885_BOARD_LEADTEK_WINFAST_PXDVR3200_H:
@@ -1596,9 +1596,9 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the parts into reset and back */
 		cx_set(GP0_IO, 0x00040000);
-		mdelay(20);
+		msleep(20);
 		cx_clear(GP0_IO, 0x00000004);
-		mdelay(20);
+		msleep(20);
 		cx_set(GP0_IO, 0x00040004);
 		break;
 	case CX23885_BOARD_TBS_6920:
@@ -1608,11 +1608,11 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 		cx_write(MC417_CTL, 0x00000036);
 		cx_write(MC417_OEN, 0x00001000);
 		cx_set(MC417_RWD, 0x00000002);
-		mdelay(200);
+		msleep(200);
 		cx_clear(MC417_RWD, 0x00000800);
-		mdelay(200);
+		msleep(200);
 		cx_set(MC417_RWD, 0x00000800);
-		mdelay(200);
+		msleep(200);
 		break;
 	case CX23885_BOARD_NETUP_DUAL_DVBS2_CI:
 		/* GPIO-0 INTA from CiMax1
@@ -1630,7 +1630,7 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 		cx_set(GP0_IO, 0x00040000); /* GPIO as out */
 		/* GPIO1 and GPIO2 as INTA and INTB from CiMaxes, reset low */
 		cx_clear(GP0_IO, 0x00030004);
-		mdelay(100);/* reset delay */
+		msleep(100);/* reset delay */
 		cx_set(GP0_IO, 0x00040004); /* GPIO as out, reset high */
 		cx_write(MC417_CTL, 0x00000037);/* enable GPIO3-18 pins */
 		/* GPIO-15 IN as ~ACK, rest as OUT */
@@ -1653,7 +1653,7 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 		cx23885_gpio_enable(dev, GPIO_9 | GPIO_6 | GPIO_5, 1);
 		cx23885_gpio_set(dev, GPIO_9 | GPIO_6 | GPIO_5);
 		cx23885_gpio_clear(dev, GPIO_9);
-		mdelay(20);
+		msleep(20);
 		cx23885_gpio_set(dev, GPIO_9);
 		break;
 	case CX23885_BOARD_MYGICA_X8506:
@@ -1664,18 +1664,18 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 		/* GPIO-2 demod reset */
 		cx23885_gpio_enable(dev, GPIO_0 | GPIO_1 | GPIO_2, 1);
 		cx23885_gpio_clear(dev, GPIO_1 | GPIO_2);
-		mdelay(100);
+		msleep(100);
 		cx23885_gpio_set(dev, GPIO_0 | GPIO_1 | GPIO_2);
-		mdelay(100);
+		msleep(100);
 		break;
 	case CX23885_BOARD_MYGICA_X8558PRO:
 		/* GPIO-0 reset first ATBM8830 */
 		/* GPIO-1 reset second ATBM8830 */
 		cx23885_gpio_enable(dev, GPIO_0 | GPIO_1, 1);
 		cx23885_gpio_clear(dev, GPIO_0 | GPIO_1);
-		mdelay(100);
+		msleep(100);
 		cx23885_gpio_set(dev, GPIO_0 | GPIO_1);
-		mdelay(100);
+		msleep(100);
 		break;
 	case CX23885_BOARD_HAUPPAUGE_HVR1850:
 	case CX23885_BOARD_HAUPPAUGE_HVR1290:
@@ -1699,11 +1699,11 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		/* Put the demod into reset and protect the eeprom */
 		mc417_gpio_clear(dev, GPIO_14 | GPIO_13);
-		mdelay(100);
+		msleep(100);
 
 		/* Bring the demod out of reset */
 		mc417_gpio_set(dev, GPIO_14);
-		mdelay(100);
+		msleep(100);
 
 		/* CX24228 GPIO */
 		/* Connected to IF / Mux */
@@ -1728,7 +1728,7 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 		cx_set(GP0_IO, 0x00060000); /* GPIO-1,2 as out */
 		/* GPIO-0 as INT, reset & TMS low */
 		cx_clear(GP0_IO, 0x00010006);
-		mdelay(100);/* reset delay */
+		msleep(100);/* reset delay */
 		cx_set(GP0_IO, 0x00000004); /* reset high */
 		cx_write(MC417_CTL, 0x00000037);/* enable GPIO-3..18 pins */
 		/* GPIO-17 is TDO in, GPIO-15 is ~RDY in, rest is out */
@@ -1747,36 +1747,36 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 		cx23885_gpio_enable(dev, GPIO_8 | GPIO_9, 1);
 
 		cx23885_gpio_clear(dev, GPIO_8 | GPIO_9);
-		mdelay(100);
+		msleep(100);
 		cx23885_gpio_set(dev, GPIO_8 | GPIO_9);
-		mdelay(100);
+		msleep(100);
 
 		break;
 	case CX23885_BOARD_AVERMEDIA_HC81R:
 		cx_clear(MC417_CTL, 1);
 		/* GPIO-0,1,2 setup direction as output */
 		cx_set(GP0_IO, 0x00070000);
-		mdelay(10);
+		usleep_range(10000, 11000);
 		/* AF9013 demod reset */
 		cx_set(GP0_IO, 0x00010001);
-		mdelay(10);
+		usleep_range(10000, 11000);
 		cx_clear(GP0_IO, 0x00010001);
-		mdelay(10);
+		usleep_range(10000, 11000);
 		cx_set(GP0_IO, 0x00010001);
-		mdelay(10);
+		usleep_range(10000, 11000);
 		/* demod tune? */
 		cx_clear(GP0_IO, 0x00030003);
-		mdelay(10);
+		usleep_range(10000, 11000);
 		cx_set(GP0_IO, 0x00020002);
-		mdelay(10);
+		usleep_range(10000, 11000);
 		cx_set(GP0_IO, 0x00010001);
-		mdelay(10);
+		usleep_range(10000, 11000);
 		cx_clear(GP0_IO, 0x00020002);
 		/* XC3028L tuner reset */
 		cx_set(GP0_IO, 0x00040004);
 		cx_clear(GP0_IO, 0x00040004);
 		cx_set(GP0_IO, 0x00040004);
-		mdelay(60);
+		msleep(60);
 		break;
 	case CX23885_BOARD_DVBSKY_T9580:
 	case CX23885_BOARD_DVBSKY_S952:
@@ -1785,7 +1785,7 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 		cx_write(MC417_CTL, 0x00000037);
 		cx23885_gpio_enable(dev, GPIO_2 | GPIO_11, 1);
 		cx23885_gpio_clear(dev, GPIO_2 | GPIO_11);
-		mdelay(100);
+		msleep(100);
 		cx23885_gpio_set(dev, GPIO_2 | GPIO_11);
 		break;
 	case CX23885_BOARD_DVBSKY_T980C:
@@ -1807,7 +1807,7 @@ void cx23885_gpio_setup(struct cx23885_dev *dev)
 
 		cx_set(GP0_IO, 0x00060002); /* GPIO 1/2 as output */
 		cx_clear(GP0_IO, 0x00010004); /* GPIO 0 as input */
-		mdelay(100); /* reset delay */
+		msleep(100); /* reset delay */
 		cx_set(GP0_IO, 0x00060004); /* GPIO as out, reset high */
 		cx_clear(GP0_IO, 0x00010002);
 		cx_write(MC417_CTL, 0x00000037); /* enable GPIO3-18 pins */
-- 
2.17.0

