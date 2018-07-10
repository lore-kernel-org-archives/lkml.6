Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D65FC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E201A208E7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:19:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E201A208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934062AbeGJPTh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:19:37 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:39799 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933890AbeGJPTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:19:35 -0400
Received: from wuerfel.lan ([46.223.138.35]) by mrelayeu.kundenserver.de
 (mreue105 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MabPt-1fNhzL2APZ-00K9tB; Tue, 10 Jul 2018 17:19:18 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] gpio: mt7621: add OF_GPIO dependency
Date:   Tue, 10 Jul 2018 17:18:47 +0200
Message-Id: <20180710151915.2282622-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:NUlY5pvlps5aMCbaSfqT6ocqWCubQFTOY6X/Z/qC9kRGC5VUinc
 QLul2E8XytLuk8A3dzabMQ3xg6cx614p5lkiNDwbo50n96gnXUjW4MaimnDm5orMYYkdfTv
 cJMR88ostxx8bvK16Umbn1Hkv5AzGo7b3CeMprGQ8gnzbURoDXUFwUrV5XOenKDBNipMA54
 w2xNxtGXxuKxU60m3a1Xg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:MGax+xdqfC8=:0aY9GO6XKGbmYMIfnsPAWn
 E6Wq1zlhdnWo3djJsf+olDdkBY08gQiadaLhPaUyYgNBjCLzsmFuqXn9ckzFFdRjO6RTcTOx7
 8a26cjuZ6QTKi+GJ2aG+Yk3eDuJAtG3TAkrEbRxRcOxuv1nKVMiAaMmKRVkofd9P9OrO9nZbo
 g2xh80I2hKTMQMkcHsbvt12uPH3G8UklB0U1sZfKnMkr8pTliissFcwVEq9GVFJ+izEQYN2yV
 62a1v1lKd80hX5yDY/aU3Fwq2NKmPDrsisjXxmK6Zf2kQY19TeRtquf5Yg7aJD+TTQUbxU/zb
 D0eH37w7vp7npwd7LLfnGxbr86daETotLUZ/Ghkz/SKb54/nDPhb8L/EbIFrk9jJp+4HOHQuf
 DPK1135PQmQYc4kifN6HYFrheOg2xaXQi8eWC3GhxbYATfy6wMtClCOY0CP+e5HJzE5punfNE
 +LyQZ25yeKL1013al9usnxXehWi64EYHY1SaPglgXqljbxU3xTmBcKfIkjJya72xjQCaT5VbM
 w67KLNkEKddGOBIZ3HS01H1CUxMyB8ry/aQDldnzr2Jwo/Hwca2ud/UAf0pNYboO0ldJD8poF
 5XqiREiqgNVf/lYlUGa1iCW+Gu1XRSxhKm1xmLH3f+DYHQ+IAvSZiTTDJnidJ8XKFN252ifgl
 ozBEpMxBi/9CZsyKF1My9eGTJwrFMpj/1XS6pgcN5UcK+lEJDD+eH4EIchTEwCakNV84=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compile-testing the driver fails unless OF_GPIO is enabled:

drivers/gpio/gpio-mt7621.c: In function 'mediatek_gpio_bank_probe':
drivers/gpio/gpio-mt7621.c:228:10: error: 'struct gpio_chip' has no member named 'of_node'

Fixes: 4ba9c3afda41 ("gpio: mt7621: Add a driver for MT7621")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/gpio/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 836aa2173e44..7429b30e61b0 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -362,6 +362,7 @@ config GPIO_MPC8XXX
 config GPIO_MT7621
 	bool "Mediatek MT7621 GPIO Support"
 	depends on SOC_MT7620 || SOC_MT7621 || COMPILE_TEST
+	depends on OF_GPIO
 	select GPIO_GENERIC
 	select GPIOLIB_IRQCHIP
 	help
-- 
2.9.0

