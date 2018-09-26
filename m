Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8CBC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:01:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE9920684
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 13:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE9920684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIZTNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 15:13:55 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:57905 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZTNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 15:13:54 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MHG4W-1g0nrM0qYa-00DGFy; Wed, 26 Sep 2018 15:00:48 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam/qi2 - add CONFIG_NETDEVICES dependency
Date:   Wed, 26 Sep 2018 15:00:34 +0200
Message-Id: <20180926130045.2295764-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:jFmvqKPYZ7wjK9eorhQrADMyBvZ0MG9gG4d8kLkp05yhiGADQiK
 t66jz/xvYHZ3VFEG0wCWfLhsMRFVci9kwYidKhWO/39ULnufaLwuv63yV5bxAu/HxxmjUKA
 obFdj9AHGL06JKeX8DIdbTlWbNEZW3oxMK7oIAyO+MyJ/cIzOk7xP6zcZN04o6ZnHxdbuSM
 qBdNVe5ViCm/gfYy0lC7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:LppjjwIISME=:c7sXElmBtAoa+NpRjCu1kZ
 ptKrR4rOALMwDBJT/2zquVWdjW/Y4eKjM0C4jlRwHISuJKUwgg1Mx4sfPRF9xFyS51YEYCZi5
 P2MdN6zL5gEbh6BKKbwAZhqzg5ZdynPQYm7pYq3VxUNHYwW8Je4sRmls9IL7iH3CPUt+5bnM8
 PtBEFWIGbHU5Ldyb9q51BWBPN22Cpzat2uI2yQw4oDteFNexb7QRjv1K7p+ZLNEC1NI1dIs8B
 UupfbHYrB23FdkEY0qDt1fC+ch46w3k01KAnpUIlyHTjyGzzqXbTi3Ex0IOu0leuY1cKwYx5s
 EG+KBwyq6NDmrO3rwhWVV3c219Y9EFAMCP5oJaOHq12NDoX4k21M9tiNX0Cac3svgm9hmwZGY
 682lcs/vQ8Mtt9x82mx2Wp7OMVXR6TgH6BC2RaI14zlImQxx39nomYnY433YkehMqVSIYi+dE
 p+pe8Wxsp8neJJxUHsEPeHJgqztF8Np/7pFTv9GlKZRa1IrMu3cn1v5HRP/3e8Jq30e5JZObO
 pqHLz9mfybiXT8PgQq4z5tFam+/NlSSPtHHy+DRYL/eZ3dB0AXEig5cJg8DbTY8YKgIXNP5K4
 hjMM7cSy3CNaFFEDn646M7NxLqxULuDqQEga6suZ2SPn7ONBTwrt+nt5dkdmh/XyyjAHs8Az5
 2rkL0OBBxe3IjCKUDeVZdwvT5h4oUiwVXaa6pskFOQTB7I/oNvtBjijBGRYZCDkEsbQY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver implements a (part of a) network driver, and fails to
build if we have turned off networking support:

drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_fqdan_cb':
caamalg_qi2.c:(.text+0x577c): undefined reference to `napi_schedule_prep'
caamalg_qi2.c:(.text+0x578c): undefined reference to `__napi_schedule_irqoff'
drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_dpseci_poll':
caamalg_qi2.c:(.text+0x59b8): undefined reference to `napi_complete_done'
drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_caam_remove':
caamalg_qi2.c:(.text.unlikely+0x4e0): undefined reference to `napi_disable'
caamalg_qi2.c:(.text.unlikely+0x4e8): undefined reference to `netif_napi_del'
drivers/crypto/caam/caamalg_qi2.o: In function `dpaa2_dpseci_setup':
caamalg_qi2.c:(.text.unlikely+0xc98): undefined reference to `netif_napi_add'

From what I can tell, CONFIG_NETDEVICES is the correct dependency here,
and adding it fixes the randconfig failures.

Fixes: 8d818c105501 ("crypto: caam/qi2 - add DPAA2-CAAM driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/caam/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index ec42fb652167..619a2c929f3e 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -156,6 +156,7 @@ endif # CRYPTO_DEV_FSL_CAAM
 config CRYPTO_DEV_FSL_DPAA2_CAAM
 	tristate "QorIQ DPAA2 CAAM (DPSECI) driver"
 	depends on FSL_MC_DPIO
+	depends on NETDEVICES
 	select CRYPTO_DEV_FSL_CAAM_COMMON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AUTHENC
-- 
2.18.0

