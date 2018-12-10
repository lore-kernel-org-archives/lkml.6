Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB95C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:38:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E05720821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:38:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E05720821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbeLJUiu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 15:38:50 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:54079 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbeLJUiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 15:38:50 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MVNEv-1gvRIs3oFL-00SL7E; Mon, 10 Dec 2018 21:38:42 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Mark Brown <broonie@kernel.org>
Cc:     cyrille.pitchen@microchip.com, Arnd Bergmann <arnd@arndb.de>,
        stable@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Piotr Bugalski <bugalski.piotr@gmail.com>,
        linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: atmel-quadspi: disallow building on ebsa110
Date:   Mon, 10 Dec 2018 21:38:16 +0100
Message-Id: <20181210203837.2118450-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:dnNz1D1MsvnysDMUO24uu0P5e145KMttEK7BE/MvIaeQLbJ7tPG
 6Td3avJLC+cCyBNIecdoFydoo3D2lnwVCdhb2ZbXItagJm2ofxClw450rFgGGOrKuGG8x4M
 f6YIJ4EBr24eRrRUzfKl0h4IFdTnjjjCW/Das2WIBMZO9Vcjj9K60i5gzJZHvqRstzzU99c
 10UGvo4SM7kBIaFaaUBgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NDXrki2CU3M=:I02ouvXrUZBVAXMhXCOK9W
 WJpfZfQyym8Z7gBOay4UibE7QSwu8ge2jX9Dh4aEEUvzKxGpDHf1cL7OOTT9fWRqj6WVpfL1S
 eNkP8ctNmcdc6etsHsw76bHFNgYqz5dafy04mun4EBw+kHmva1yqJq2mnGIuXc0x6FKMGf4aM
 XNtMPd9W/T/+MKYmObyZsTKX9CLJjc8l3tk8cOAg3JRVYwc3HMvdSxXVWPQUXHf+koa+g7yfY
 K5Ee1+XZ430kEPWehTDjRDZ5ic4B0se/xah0zmxt8tx9sNOUcUAAEnN96M8JiIrzU+1Dwwh/Y
 iqfYqtiaBcLPF5GoPoc+LUnVrSwjLoizWiRbalgKNCYZVHZoKgrW9zCO1+w5YBBhaqyMx2LQv
 6sq5rjgFJ3CId1QlEyc+SR0iNyocwUANuds4412RgzCe/BX4OSetNnnPSYONBD032rd++fcqf
 uV+CMdc6nqdGXH+jKukFXPezr5CQaYsoB2IawZotn7AYse2QGk/21FRRPEMt9fh641K3AOGPa
 +YrXQwc75NeCVaM+JJLlEAWOFdXr209ROBiSWLgAcwklemH5EmC+m7co79mO1vcAW/6pFRMfK
 vyJP0biBKdJB9dZ+WBgNlNenrNHDNqxPKMRhHRjpMCOcu9LG9LOIHdKfupa8aQ8XU+PtTu6yt
 UKCMVewMXHAI5uHq8Lo3s5ecZwb7/4wepI9Y3eVGoclZUB93Oxz9/xBpzTFJaPDV9rm1IWXz4
 sB9n8chl24l3R6tvOMi9S60JOMGOIhjGCYoGWw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a link-time error with the atmel-quadspi driver on the
EBSA110 platform:

drivers/mtd/built-in.o: In function `atmel_qspi_run_command':
:(.text+0x1ee3c): undefined reference to `_memcpy_toio'
:(.text+0x1ee48): undefined reference to `_memcpy_fromio'

The problem is that _memcpy_toio/_memcpy_fromio are not available on
that platform, and we have to prevent building the driver there.

In case we want to backport this to older kernels: between linux-4.8
and linux-4.20, the Kconfig entry was in drivers/mtd/spi-nor/Kconfig
but had the same problem.

Link: https://lore.kernel.org/patchwork/patch/812860/
Fixes: 161aaab8a067 ("mtd: atmel-quadspi: add driver for Atmel QSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 55d5ffb50750..9f89cb134549 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -93,7 +93,7 @@ config SPI_AT91_USART
 
 config SPI_ATMEL_QUADSPI
 	tristate "Atmel Quad SPI Controller"
-	depends on ARCH_AT91 || (ARM && COMPILE_TEST)
+	depends on ARCH_AT91 || (ARM && COMPILE_TEST && !ARCH_EBSA110)
 	depends on OF && HAS_IOMEM
 	help
 	  This enables support for the Quad SPI controller in master mode.
-- 
2.18.0

