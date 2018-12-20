Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD56C43444
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86674217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 15:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731537AbeLTP2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 10:28:33 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:39789 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbeLTP2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 10:28:33 -0500
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MFsIZ-1gcQpS3DwN-00HM8h; Thu, 20 Dec 2018 16:28:17 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam/qi2 - add a CRYPTO_DEV_FSL_CAAM dependency
Date:   Thu, 20 Dec 2018 16:28:08 +0100
Message-Id: <20181220152815.3613164-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:v+XQUo6SIUwwKZGgippx+SjKBDveMnmTODxVosA0iq5FZlQOOXd
 n2iBEOpQ1LviVUPL/OA3DHXBuqZqWDJfZKmoA0Ulaz6VHJUtU2dwmYNFmjldGHgvuOZv6vo
 8r192+m2vaguWotfpyIRTgGSNQSDKNhbPNOMkimNM/lcGgd6DJuPjG/+PqA3Tj6hIfCyyLt
 ZVmfzXQB6ScrelEPMz47A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cIHNk4CPPKI=:4KJK/bBC2nTM02kfsH51gI
 DuTry+pWBnTgeS9twJo/2C4ZFNZFIOGgrwip93f4yw/6UHUnm5bOuvQyKX++BhSAhhBTKpYXt
 gO6Goq1hZRf5eoeCABQk+GCLit4ziBHvVKQ70jBc3HFM0xXn8Lh/IC8NGPsCXMua60wpsR30P
 UKxlZYVdfE0xdF+22/NhJMpOq8oQiB+IVueB06q3+bF8NGGRpyZxH+RTcH//Y4yG9udOVZjLq
 EqDgqbceO3ev/VubiCm9pVtSoa65gbgWtRLT+t4VGb8+RN/JPDg6PIudPCdaapEM11kHoQxSM
 URh8nfNM4oVozcMkcmJjlg/tA1T6g3fCNp5KXA45ki8ggWvsWlZfRs7djGTGiYwueKLO7d8A/
 RZEJtgWVfYe3XJJnLsZBl6ZG9X1VCmTjuD8HJQoqRA5BJ1y0elIgHXLmYr2DtnjMKohl0BnRm
 HHyxkl8n8tos76lOvs0B2RDEIB3gqsouG4Grus7jjFROOaETiufoaMsp/HOujMRqGMEm1dr6n
 W134YQKyNiGIKI/ZmPU7QvU72uREGR/Twklw36L1cwOfwWuAf34M4ae9JdqfdGCkI+1Q1IRhM
 ggkmfC8S5f9LaX7OFxq4nQw7KxDhxDtKZfjAJitEP7K7zmx42ItWxztbe3LUYDiZIejVcfJ3X
 /4lHKnt/tPnN0mzqOBWnIc3PvwjFU51eqjWtFwHsEl6SEEb4rJ9lWn81MtNr57qJTmYIOXSYc
 AQXT1CmTq/Z+zyL/Pme2Xy+HXEF6ryH+wtU5BA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My previous bugfix was incomplete, we still have a broken kernel
with CRYPTO_DEV_FSL_CAAM=m and CRYPTO_DEV_FSL_DPAA2_CAAM=y:

drivers/crypto/caam/caamalg_desc.o: In function `cnstr_shdsc_aead_null_encap':
caamalg_desc.c:(.text+0x14): undefined reference to `caam_little_end'
drivers/crypto/caam/caamalg_desc.o: In function `cnstr_shdsc_aead_null_encap':
caamalg_desc.c:(.text+0x310): undefined reference to `caam_imx'
caamalg_desc.c:(.text+0x4a8): undefined reference to `caam_little_end'
drivers/crypto/caam/caamalg_desc.o: In function `cnstr_shdsc_aead_null_encap':
caamalg_desc.c:(.text+0x664): undefined reference to `caam_imx'

Everything is fine for the other combinations: if both are loadable
modules, or both are built-in, the flags work as expected, also if
only one of the two is enabled.

Add a dependency to enforce using one of the working configurations.
Overall, I'm still not happy with that dependency, but for now
it documents what the code requires.

Fixes: 52813ab24959 ("crypto: caam/qi2 - avoid double export")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/crypto/caam/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index c4b1cade55c1..4dff65e518e7 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -158,6 +158,7 @@ config CRYPTO_DEV_FSL_DPAA2_CAAM
 	tristate "QorIQ DPAA2 CAAM (DPSECI) driver"
 	depends on FSL_MC_DPIO
 	depends on NETDEVICES
+	depends on CRYPTO_DEV_FSL_CAAM || !CRYPTO_DEV_FSL_CAAM
 	select CRYPTO_DEV_FSL_CAAM_COMMON
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AUTHENC
-- 
2.20.0

