Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D443FECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9968B2098A
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 18:51:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9968B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbeJRCs4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 22:48:56 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:46541 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727435AbeJRCs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 22:48:56 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mlvr3-1flWq10umZ-00j1sz; Wed, 17 Oct 2018 20:51:30 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mlvr3-1flWq10umZ-00j1sz; Wed, 17 Oct 2018 20:51:30 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mark Brown <broonie@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Lubomir Rintel <lkundrak@v3.sk>,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] spi: pxa2xx: fix PCI dependency
Date:   Wed, 17 Oct 2018 20:50:52 +0200
Message-Id: <20181017185128.2634666-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:Lk9D7S/uTiR88GE592s9OY8762St2G7Rp0iKSykQfhkboZLOjkx
 RogAee+KtRqeCppjwHsxkKJdl/XYuwDJdbjcE5FgTj5huPGiK3gqElDpIAwKl8Nn6EnyPL/
 YSl/kDo8KOgfiGBFF8mVk/RxHUv120NhK2Ofxd3O4kMa7N+nFMdsuRCE5Fi45WLY1ylDGTb
 KRGBE0ARB/MDS6kL63UyQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lc5GyvfVigE=:7RAA9k9uRilBjNaX3ej9wF
 wLpxsgCo0rc653x5KZh5VVDD4lpCNch1DQ/Sx9sBEZnBsSOjFN+YVhwxqGyG2D/9HeaMzSYzn
 vc99ZGVNnCBrURfxY+UQlherpLoc7EwsV8w2qzBL38BhMujhUCsalOLBGeTUOSEyT147jRu/4
 fiLXLWzX4u2wReY+qCk+SE/dyj/pIT7DA9cUx4RSaXQ3D46nAqSUrBX9j6ylXeHsq29wtHvl2
 Rt61RXYwhz/ZQ4l9dmKb+vtVH+ovylLkj46GdmLXeF/psY4MNxWTSHYS9CYXNVtnu2/Hcg+4j
 7bPc2ZWyJoElB3ySyA65WLBCs4t1zPerj8J7HhsWidb5GUqE3MzpZ7l5hi/Ma3q9aWm6ovnjz
 IgWHljzqR4+M0wd6v/zmzWf86Pr9+89VEMHxqSmAiAbuKlNYTn9Q1c8oLeJxVNFdwqYGcFGxG
 A/gh09Xp8ChcST6m8PuLabM9CgtooNzlGBlUZ+j6I1euFtqOSAHiIBLh9Opsn+UKDfF6AQIx1
 Pt7+pGzQtD7MRnT7/MFEC6tJO6jjS1iS7aPPH179r1ZmkGQOgdC35Hgg5zK5CbVviTP9ixn+k
 YBhbdxHSZgQpaXWMk4yL/YihAyqlX84ciQFiWtxmvKj/x8nUTxEgZ5I/JoXkjxE8pX9AV2sZf
 IergDRL3fLhajeJoSoVWwqa9SrsuzUbE80KDEojgvtTa3dSYvwrQ/Tzs5MZtC5VBEDgk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code reorganization broke building without CONFIG_PCI:

drivers/spi/spi-pxa2xx.c: In function 'pxa2xx_spi_init_pdata':
drivers/spi/spi-pxa2xx.c:1457:15: error: implicit declaration of function 'pci_match_id'; did you mean 'pci_map_sg'? [-Werror=implicit-function-declaration]

Add back an #ifdef around the code block that requires it.

Fixes: 87ae1d2d7077 ("spi: pxa2xx: Add devicetree support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/spi-pxa2xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-pxa2xx.c b/drivers/spi/spi-pxa2xx.c
index 612cc49db28f..c1c30109dd1f 100644
--- a/drivers/spi/spi-pxa2xx.c
+++ b/drivers/spi/spi-pxa2xx.c
@@ -1453,9 +1453,11 @@ pxa2xx_spi_init_pdata(struct platform_device *pdev)
 	if (pdev->dev.of_node)
 		of_id = of_match_device(pdev->dev.driver->of_match_table,
 					&pdev->dev);
+#ifdef CONFIG_PCI
 	else if (dev_is_pci(pdev->dev.parent))
 		pcidev_id = pci_match_id(pxa2xx_spi_pci_compound_match,
 					 to_pci_dev(pdev->dev.parent));
+#endif
 	else if (adev)
 		adev_id = acpi_match_device(pdev->dev.driver->acpi_match_table,
 					    &pdev->dev);
-- 
2.18.0

