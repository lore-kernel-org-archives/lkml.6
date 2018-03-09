Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607041; cv=none;
        d=google.com; s=arc-20160816;
        b=lSZXXrTfzrRoej4RbYkstoxfPbox+RKRhWrQbLrZDbEkg9H/X+TDEzv0WXPKcljo4C
         aPRaALTiTpwOSgqDgHil4zh/bQSeXmrYwoXBfFPx/enG2iuKwr5SvQqkqtckiYGTAbtP
         Ph6FgnPUXIgna7r8Fz4SCi0HMYwtWlvsP0NxZ3jLCIOsu/9OrE5TThogG21fHm3jG/hI
         dXFKgzxNasdk9L4wxUfyY0D/04Ud/a9bJnvEH2YuY5PInm8bwAg8rFJsgz+zkttbHlgn
         KS6P61Yg7drOmz2sUSA4VHloE37dOv1MbbsabrZqvFuEpYC1E8fy7ul5R0pUuBZJDHLg
         aYcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=/mYmlEklSxmgWb3ph/DuGZ98vAdv2XK271WMG5BcyN8=;
        b=PURd6dgYvE1GOP4115fcfIDcILtTq2UBDW+L0mduIap0CSTuwiWLuMnzGmCUBIoBNF
         tN/grOh5iteYFoCvlNkpkvUN8Z6ILGJPWVlAHhlLE3gRx7ynDhoRV1L3T5HIiG+PrmUC
         sOJtBHjDCvHAtu7dMiaj2VS8/60+QtzPoz0tt2IHF2tutEagZaacs/4H0WfxSSswPWg9
         z5aGUSPSzArmA22pBT5Do8TA9KNYevM3Fte7BfA9FVt2R/c9V9J2HC3PG/g3BdC5aXit
         KDxRcx9z7G7iY9AcQEl/f6VX+4Ljn24fIlUNktkPDWrhPN5nLtENCaNfkUYF/p/lQqBu
         ibkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Oc286PCp;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Oc286PCp;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtCVNRjMy7ThCecHPaVdNtm2cTA3STwkRoTP90VCRS/TCMBczIWbJfGUVudCYmAwakPMjtVqw==
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	srinivas.kandagatla@linaro.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Masahiro Yamada <yamada.masahiro@socionext.com>,
	Carlo Caione <carlo@caione.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	cphealy@gmail.com,
	linux-mediatek@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 13/25] nvmem: imx-iim: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:07 +0000
Message-Id: <20180309144719.29904-14-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472048934734422?=
X-GMAIL-MSGID: =?utf-8?q?1594472048934734422?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Drop all of the code related to .remove hook and make use of
devm_nvmem_register() instead.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Heiko Stuebner <heiko@sntech.de>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Carlo Caione <carlo@caione.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: cphealy@gmail.com
Cc: linux-kernel@vger.kernel.org
Cc: linux-mediatek@lists.infradead.org
Cc: linux-rockchip@lists.infradead.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/imx-iim.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index 52cfe91d9762..b98d76ac7790 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -138,25 +138,13 @@ static int imx_iim_probe(struct platform_device *pdev)
 	cfg.size = drvdata->nregs;
 	cfg.priv = iim;
 
-	nvmem = nvmem_register(&cfg);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(dev, &cfg);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int imx_iim_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver imx_iim_driver = {
 	.probe	= imx_iim_probe,
-	.remove	= imx_iim_remove,
 	.driver = {
 		.name	= "imx-iim",
 		.of_match_table = imx_iim_dt_ids,
-- 
2.15.1
