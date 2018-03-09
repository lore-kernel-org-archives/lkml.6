Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607033; cv=none;
        d=google.com; s=arc-20160816;
        b=DFPfXzeWpBXzLb1B43EeFkPzuUIZeWfOkuCdn5Vp75yNq8x+RAc3Hro+Syd26hZIIQ
         39uV1bzyGdHhCi5m+nEk6wuEYBJdc42vG6V5SLP/3z+1Qg40Zu9FpIed/vzspdZI5JgM
         XrcUTm/R9dfLiD22n70X4pmyMnz/u+qqLEbDucnfSNOAOLQV62555ejzyYBPd3/MADE1
         tydsLwLe4tpVC1g30kbWG7jTCrXLSwK831OdIr35qz62dSb4GwLRB2LnAnXW3qbO9hlx
         axoTQXbMDq9+CHzFxnooqG0pct1xxxON380fwGKzd+KHv/0xIDLPPsczrTHF7jeDrkRS
         +AjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=iUanzWQSXWeBvkXCvc41usxvXwyGqv6365hkQYXbiXU=;
        b=mGoFfvz/4nx0J0SCBwHVie+1K1CPZa8jv8hqgwI2oiTx1PuxqkAy4EKY+B0RZU3nLb
         bPF1NrtXuI209fy38o8a61NjC0HkwlPAxrcCYeOZ5r6Ev0Yx+w+Z3Vv29k6qgkPHuPGA
         c7TyRSXYMOICFYAmfr9mGtvIrRGl319b9eeHzSnSN7HqWDc1oH+saGzgO7+s7A/7/cxo
         fChqAYBoqU9cfGgjBOmBwN4vbyPKRYaU9ss5rtdyZQguoBAa7Rkuw7ptn/Qre7VB9T+f
         2/fBx1+wk164Gj7kmIMtltsjDv64cfNdmr5KSRfzZH4/bTR3AzRSlNRwU0PflEE7BQP5
         BdMA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Q+XtcRfo;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Q+XtcRfo;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtopU3iaoCLCEpjl2s+e6B9pbQ+XCS6hUCD5SBl56NbZMvziTpOdNBIeXB0c1G6FUU9wN3VvA==
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
Subject: [PATCH 06/25] nvmem: uniphier-efuse: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:00 +0000
Message-Id: <20180309144719.29904-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472040239734778?=
X-GMAIL-MSGID: =?utf-8?q?1594472040239734778?=
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
 drivers/nvmem/uniphier-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/uniphier-efuse.c b/drivers/nvmem/uniphier-efuse.c
index be11880a1358..271f0b2ff86a 100644
--- a/drivers/nvmem/uniphier-efuse.c
+++ b/drivers/nvmem/uniphier-efuse.c
@@ -60,20 +60,9 @@ static int uniphier_efuse_probe(struct platform_device *pdev)
 	econfig.size = resource_size(res);
 	econfig.priv = priv;
 	econfig.dev = dev;
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(dev, &econfig);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int uniphier_efuse_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id uniphier_efuse_of_match[] = {
@@ -84,7 +73,6 @@ MODULE_DEVICE_TABLE(of, uniphier_efuse_of_match);
 
 static struct platform_driver uniphier_efuse_driver = {
 	.probe = uniphier_efuse_probe,
-	.remove = uniphier_efuse_remove,
 	.driver = {
 		.name = "uniphier-efuse",
 		.of_match_table = uniphier_efuse_of_match,
-- 
2.15.1
