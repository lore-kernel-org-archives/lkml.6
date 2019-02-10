Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3B5C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:11:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11E9320844
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbfBJRL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:11:27 -0500
Received: from mout.gmx.net ([212.227.17.22]:42603 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725896AbfBJRL0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:11:26 -0500
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MaW7Z-1gdg6C3yA5-00KCk1; Sun, 10
 Feb 2019 18:11:22 +0100
From:   =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     linux-spi@vger.kernel.org
Cc:     =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] spi: gpio: Advertise support for SPI_CS_HIGH
Date:   Sun, 10 Feb 2019 18:10:08 +0100
Message-Id: <20190210171008.28852-1-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Jc2L4eV0WCdbAef+uufOIBJErUN4USltrcjpsMuRUlF8WIdRUaV
 nGcwg0oRCYqEWa774NJjNfzIUmE3YnLWZg9ibK15+jCrFHlTSFcmzvW/7ye07JeouDESs/5
 +sRv1m7mvOymFBAP0hSIGkXhIWwmd6zqj2wLdINF8d+J4nOc1pQk7Djn1FjR1Edt3HI/G6K
 AY4v3d0vf3kUYJoY7b1aQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JPbgZxJkmHI=:6R6auG8m0rETIhbcHH7eE+
 aHsdXxx0wk+SfZbD5elfFyczuPrJBGj9YqXURsXs4fyz2JfKszO66pmOK0zOeVdsZZxlDfhJi
 nfJlo6bAMwcTWd91uNvrR12fcPMaVL2e2oV0ZFxnxG/JamVOm0xdoZRpl1jlvIvtSZ0ZSYn9b
 /mFGfbVLd4MBVYiCljg7SH3dpjkcZOLKLSu8IXfNaUI44r3CvgNZL9iOBm+VIHE4PMKoITUbO
 2qyLi8Xadg/YwK8kwn578d/+1lICxRCk0vkSBB+XuU46l+KQekckKxBep1D36eayw9pYbewqC
 k4VmDYPP6cGYh2/kA1A6EtJx6R6iZI5db2Eqomh54wuawQYhzZVMlfjKjMyM3c93G/0972Pnq
 A1yNYW9TdboBx8KHgBOUwz+P8BJ3ikZ6K+yLRlE2A2ERdgG+nUrx9K+JtxPq4VvcylVXvXA4i
 7duZMFQBxuEMf16MXUeORenyQCgkdpVK6T+ClAOjOJzVV4Lfbn4xo6X7ksPPO6kyBAbfQHCNs
 dNgCG6V+9qU3RgJAmaH6rhxHpDrYF55uXuiHKl2vBjSkKxzq8PYP2ScaF6hXXJ5H0fPayFprB
 UD9NsA3f47x9/k/eUCIg+VJsWoSPx7MmIoo+qANUh/aPuW2mW7fKoZeUxGOpy8a0tdyeSzqX/
 zrj8F9pTblt8X9xdNRhdaCZz3RIgpVZerp2uShF3i18zkzDQ2KsLpmyox1Lf7YwOqzBKZXyLT
 uN+EdBqSdITdkXfgt35y1/UfV+J2iI5Tw2CneyAv1ACbtdLuJzvtGvu2gtK8aXUN7y0UseIK3
 3jUKehElYLIqX/a1K6aYcmwTQTlY7y2cmnFrpBikA5s2qcZT+jc8TW/qwpFpRzPkHz89oFsV3
 8NQjokiAaVejiIzVP7EVYLCf/NHnoxpisl+ql5oFcHtuX39ZK3BCYbtkZb9+fMeWkhJT+MGNM
 dVck6gF5kcQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The spi-gpio driver already handles different chip select polarities,
but so far this was not advertised in master->mode_bits.

This patch fixes mmc_spi on top of spi_gpio, which is useful in some
testing scenarios.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 drivers/spi/spi-gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/spi/spi-gpio.c b/drivers/spi/spi-gpio.c
index a4aee26028cd..3e98c1a0ba6d 100644
--- a/drivers/spi/spi-gpio.c
+++ b/drivers/spi/spi-gpio.c
@@ -428,7 +428,8 @@ static int spi_gpio_probe(struct platform_device *pdev)
 		return status;
 
 	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(1, 32);
-	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL;
+	master->mode_bits = SPI_3WIRE | SPI_3WIRE_HIZ | SPI_CPHA | SPI_CPOL |
+			    SPI_CS_HIGH;
 	master->flags = master_flags;
 	master->bus_num = pdev->id;
 	/* The master needs to think there is a chipselect even if not connected */
-- 
2.20.1

