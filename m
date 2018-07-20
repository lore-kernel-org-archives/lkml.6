Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E91ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9087204EC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 14:31:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9087204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziswiler.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732983AbeGTPUD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 11:20:03 -0400
Received: from mout.perfora.net ([74.208.4.197]:37559 "EHLO mout.perfora.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731612AbeGTPTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 11:19:48 -0400
Received: from localhost.localdomain.ziswiler.net ([89.217.215.226]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPA (Nemesis) id
 0Luuvv-1g6PHO2Txp-0108VN; Fri, 20 Jul 2018 16:30:36 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Stefan Agner <stefan@agner.ch>,
        Tony Lindgren <tony@atomide.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Eric Anholt <eric@anholt.net>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms+renesas@verge.net.au>
Subject: [PATCH 3/6] ARM: multi_v7_defconfig: enable dynamic debug
Date:   Fri, 20 Jul 2018 16:30:09 +0200
Message-Id: <20180720143012.7740-3-marcel@ziswiler.com>
X-Mailer: git-send-email 2.14.4
In-Reply-To: <20180720143012.7740-1-marcel@ziswiler.com>
References: <20180720143012.7740-1-marcel@ziswiler.com>
X-Provags-ID: V03:K1:HWQvTMu+Kftpvtop9mFd9MI6Oxz/CbO3clQ2FrxRYV76B80/ONF
 SgVqULsIaa8zWL3xJMLtX1vhPbrTsxDUbP/FRDRvhj5Pwa/1aSHB2ieT1AauKcd/lIdyXAj
 0Bt4yxgG8VE5e4hHVdnkcwlDVeKTz3+vviPEpRJ07Ffull8dJh1SeF8Q9E/YGB0L2kHmxuu
 u+DCpdP+RexAKtJ7Mc+eg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nCwJwF/D83o=:oNFFlmHWAH2LFCgBOYrci0
 40Qk1Syk5WJcYoOvDgd09+KKC0uYqK+57Ct7q8JKX7uMn7Y0rP0DMXOAmCnkPrg6bfmN3PlXc
 5xGUmp29ZGZTI7Gix9eEKctsJczndqnIr4Oyux/DPIH5uQfsrMzEydP9A7Dtv7QEXOmKqg1jH
 zEn8FGorHQj0OCNGoSBc149fsYJT3BorIaLCDn8vKc316drSTKEncmHIazEiMJpvRZSE1ZSpq
 ht6/iVaewNZ+s4SjLjdKPDvJimQhqfVAiGc2QDI1w4Bu38ZvCUW2tVbZYt469PkueiX9VHB4q
 foxlLT8eUNJZmilIee2qewz2GaPvkrKN91i+QuqUCFz2MW5V7PrncTV4lk6TZAsdnt3KeqJsC
 8FmItEKf3YyT++Uaqo5O9ZhP0XCWDunbKbgdHf63EdcBk9ZxV6Vkoh0HJXwoa/8DEXRhyUX/3
 XYPzlMta+eReZRInsMzBj9ieSO67VDTyvCg1XFpHvrv5XAlO1xXDNKWx6xlHzNXZlkOmWOfVG
 TonhxRGsmBAsmtk3SOQWZfFWJmzrssB1cJXoizIRW2JttYXk5FgHUyX591OcEIYhcc+gGSHYU
 2A5u1nDGBVZXt+hId+sgq/tNTRDUAy9gOUh6PSM+FnRM9OnyTcXd7PNVVAEpZu/H00/gywFHO
 N8AlFd5uG6fG5WAuUCQBTY8jwI8TJ1OP5HQUExVWzqMf5la9hgNs4wtFoQnAjL8k44ys=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Dynamic debug is really helpful.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 4a47a9de6a5e..beacb02c734b 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -974,6 +974,7 @@ CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_UTF8=y
 CONFIG_PRINTK_TIME=y
+CONFIG_DYNAMIC_DEBUG=y
 CONFIG_MAGIC_SYSRQ=y
 CONFIG_CRYPTO_USER=m
 CONFIG_CRYPTO_USER_API_HASH=m
-- 
2.14.4

