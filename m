Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A237C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BC9021571
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 10:10:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BC9021571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbeI0Q1h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 12:27:37 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52007 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726929AbeI0Q1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 12:27:36 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEmAV-1fzfoD3kEt-00GFmy; Thu, 27 Sep 2018 12:09:50 +0200
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue009 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MEmAV-1fzfoD3kEt-00GFmy; Thu, 27 Sep 2018 12:09:50 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thor Thayer <thor.thayer@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, David Frey <dpfrey@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] EDAC, altera: work around int-to-pointer-cast warnings
Date:   Thu, 27 Sep 2018 12:09:26 +0200
Message-Id: <20180927100949.973078-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:3QJ/C/Rf+i3z9FRlTihlNO24jKimfWyCxZq0uKh3BjBu7ik+OJk
 CLMxMnwdqkOfi/H2nGk15wipvvDpXE9nmTwMnTcnYdLn7Smm17iA/PhUJNINP6zUyiaAF9L
 VGm8+eo6/91gLtGwVhSUTKxMLPJcFgBULg370CFpIE0a1aqqf+jnypOLyCT+xuS1b/K7qYD
 g9v5ohKB2kCy9jbu6KorA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nfUj0+BZv9c=:8oGeiRVXSeLoQqLBX/nZHm
 xzEtWQ9i615K/rwxmytJAwNcZOcbl4Ti0Ae4xMZP+NabwWK+v/t7tm1PXsVK6pWUFplkuAe6r
 oVJJbY+cc9xjsstryYeKANa8zZYjCU8ZRyKw361Cd4nAkF1GTrHBUIJ7lxzjcqNEeqPA95KFa
 2QCmTyoNIcxIO+OuTM353PzuP6obpAG1Pwf1Wng3C5ohWBH1dYKCvVIHNG4ck7feN4065mvd6
 BVZkLlZ5KZJhCQO1Bbsu4Dm3PfJ4BGHYDqj9XQ5EYX0V2qc9nQ9/BkWF7Hv5TXpcU5zVrPjGa
 MfGuM5AGQ1ngp54Of9jC/4XgAsp6vtOXBaG9uLyhGtlUwnFXu0xtxD6pgc1B5N/AJ5PIst2gf
 ds6OhXRANI9m0qllCIUahUKOWA6cinXhE1l0lo89X5RFpximkzWRSDsdGnsoJZh7559uvUT+Y
 laXpyyo7AzPrGmln0lmD13YeADA9pfYQit2eRmdqPRhWiCH2DDQMLtBhsNOF+9fpK1r5pOYPb
 oh+QJNW55DsjVz9+qG4LOseafR99fc8tATsU0uZMvFqALG03rTyBHniTAhJHfe69zAdSXhQaJ
 KiX57CnJ6Bu7KO8LdriL9Lnt2SdCpJS9/xBcKb82A2VXcYau9C0Ivz85rz47a5+jyHz/+92am
 4vY8EtH3xoNota5vAEyxR5dmNyalMEPZXrJT3KKFNi2A/b7aFLwvOtV+Ad6jSkDAEMzo=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The altera edac driver passes a token from a DT resource as
resource_size_t into an SMC call, but casts it to an __iomem pointer
and then a plain void pointer inbetween, mixing three or four
incompatible types in the process. The compiler complains about
one of the conversions:

drivers/edac/altera_edac.c: In function 'altr_init_a10_ecc_block':
drivers/edac/altera_edac.c:1053:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   base = (void __iomem *)res.start;
          ^
drivers/edac/altera_edac.c: In function 'altr_edac_a10_probe':
drivers/edac/altera_edac.c:2062:10: error: cast to pointer from integer of different size [-Werror=int-to-pointer-cast]
   base = (void __iomem *)res.start;

Using a static checker probably also notices the __iomem cast.  Solving
this properly isn't trivial, but simply casting to a 'uintptr_t' instead
of 'void __iomem *' makes it less wrong and should avoid the warnings.

Fixes: d5fc9125566c ("EDAC, altera: Combine Stratix10 and Arria10 probe functions")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/edac/altera_edac.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 0e9e80789d99..c89d82aa2776 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -1036,7 +1036,7 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 	} else {
 		struct device_node *sysmgr_np;
 		struct resource res;
-		void __iomem *base;
+		uintptr_t base;
 
 		sysmgr_np = of_parse_phandle(np_eccmgr,
 					     "altr,sysmgr-syscon", 0);
@@ -1050,9 +1050,9 @@ altr_init_a10_ecc_block(struct device_node *np, u32 irq_mask,
 			return -ENOMEM;
 
 		/* Need physical address for SMCC call */
-		base = (void __iomem *)res.start;
+		base = res.start;
 
-		ecc_mgr_map = regmap_init(NULL, NULL, base,
+		ecc_mgr_map = regmap_init(NULL, NULL, (void *)base,
 					  &s10_sdram_regmap_cfg);
 	}
 	of_node_put(np_eccmgr);
@@ -2045,7 +2045,7 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	} else {
 		struct device_node *sysmgr_np;
 		struct resource res;
-		void __iomem *base;
+		uintptr_t base;
 
 		sysmgr_np = of_parse_phandle(pdev->dev.of_node,
 					     "altr,sysmgr-syscon", 0);
@@ -2059,9 +2059,10 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 			return -ENOMEM;
 
 		/* Need physical address for SMCC call */
-		base = (void __iomem *)res.start;
+		base = res.start;
 
-		edac->ecc_mgr_map = devm_regmap_init(&pdev->dev, NULL, base,
+		edac->ecc_mgr_map = devm_regmap_init(&pdev->dev, NULL,
+						     (void *)base,
 						     &s10_sdram_regmap_cfg);
 	}
 
-- 
2.18.0

