Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607032; cv=none;
        d=google.com; s=arc-20160816;
        b=UKsvEwwK9ce076j3m2bwRdGYsOb1OGIu4lbj1M2HNX2U2PScHFqIWn2nN0wuXTlGSr
         Y+Od1kJeCk7ePsRer1oHLcbrmzWs8W2NhVnaacuSXoSW824BoJq610ExdRU4/VzKka5D
         FQtmgHdewhPiI3OhKDRwBxjp8D6DiSZjWXFB0z81sYde+ZSfJ71FiHbfFIu5l0qgqvNu
         nXaNx5HtceJa6PjZlHWQ+xnzPpRaeAS7QHF7RVMd4JHylmuBMqPaoUcSHFsuEhGV4Vek
         RK2rJd9l9/H2NdD1ph1vCFYU0dAa2RqzFSOr1qLk1w3zhj/+dLFhXTc/64q+bvBf2Mfr
         qeZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=QB0wCS0zDECArGE81snX7r2xwwYd0ZHIjoAtnv+XtT4=;
        b=a9Z3/J3qN8J4hHKi3LxJy7iDS5aCMDYcAiZB3co/R0hZx+2rwcdb6V+U6CWK1j/Wmw
         ldwaJyXnFFVmxs6BLYgeYlJTcMi3xkusVfZHNn28ZDNfz4F8PLMSnZP09si/DFBpAva8
         tzWlnKzsegBKA3wHpyYrUI92cMdsiLChBoIVYVO/wFjPRw8sPbdD5IjKyap4hfHVeWZn
         9o92TGWribDnX95XHq4cIVnesuT1VD2Gj+nySWGJHBX4BMAU3M1VOHhtWl5QKuQfN2/s
         6djupm5z/L9O1238GAFhfaiXlVWCYkWRAvkZ9oC4HiRlGEnS7hd4dWoyutC9IC1ANmIV
         dDLA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ML52Cz+d;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ML52Cz+d;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELulT1PYraV7Gj8kqr7+ViSni6nQW1x4X2BaGP7Zdqcfb6XcPbRP+QP4zTUIz7fF4z53AztcJA==
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
Subject: [PATCH 05/25] nvmem: imx-ocotp: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:46:59 +0000
Message-Id: <20180309144719.29904-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472039415393261?=
X-GMAIL-MSGID: =?utf-8?q?1594472039415393261?=
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
 drivers/nvmem/imx-ocotp.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/imx-ocotp.c b/drivers/nvmem/imx-ocotp.c
index d7ba351a70c9..f1482c664b19 100644
--- a/drivers/nvmem/imx-ocotp.c
+++ b/drivers/nvmem/imx-ocotp.c
@@ -466,26 +466,14 @@ static int imx_ocotp_probe(struct platform_device *pdev)
 	imx_ocotp_nvmem_config.dev = dev;
 	imx_ocotp_nvmem_config.priv = priv;
 	priv->config = &imx_ocotp_nvmem_config;
-	nvmem = nvmem_register(&imx_ocotp_nvmem_config);
+	nvmem = devm_nvmem_register(dev, &imx_ocotp_nvmem_config);
 
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int imx_ocotp_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver imx_ocotp_driver = {
 	.probe	= imx_ocotp_probe,
-	.remove	= imx_ocotp_remove,
 	.driver = {
 		.name	= "imx_ocotp",
 		.of_match_table = imx_ocotp_dt_ids,
-- 
2.15.1
