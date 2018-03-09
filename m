Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607040; cv=none;
        d=google.com; s=arc-20160816;
        b=PV9OrlSazKsiZdwFzGZqnU7a+17yZczMJ54yaJQjE+9mY5btzJ/BSo9V/qRmX/QVet
         0BlIte6g8rcvACbJn+qfl3ntnNn0/NTztUl9CyrZIu/t8DxmcPrR/NcwMn/kjOgzBQMd
         GuytRcB72+rWhPqJ7+76OCIPHQPnnRJ17/x6esswef6yl06d08WKmN8WUbC9PKjAfvpg
         HCx9eD35104uycYs7XyLUFgwMbUpA8puouYdGY39JfCOew6HqLbKATQxfTqCenPZI7bz
         jV2nqEk8nkZBnnfVduA2cbdkk1LCRuHyasNMa7pYWtMfSeoTHXUpNk71riuAc5lRNDry
         Q4Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RavD4BX1QznlPkzfSUZRMQAlKOGAL73sP/pXb7t41AQ=;
        b=zxzWCfnu/RYrNdEu020HtkgbEZgQJmWxB6aup6etj/0MReplfIqh/JUKBCfgKDAcTp
         uqXfQtRZxX4CFCJHP5eKP+9O0KkclxGnV53f+AqKR0LKgdLFjic6DcMRFvxbkuZOYQFs
         Tqo2OhOZ3ZoLO8DTpwED4gFgjgnR70PUSy+I2loidKNEQkfOpjqQnuEaoSL/qpht66th
         0IkwMhqVw1FoLABuQx7G51vX2z57BqBeNCnhM5fiaKj89plZw5JeWuyPIT4J7wcvvifW
         WuMoTnomqZ2X5kIFMJQ3zKawfSm27fPESlUdwNTMPwe6tTRfO0Vota2eDkPtip/IvvrY
         H14w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HqxbwN1e;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HqxbwN1e;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELt0PNis7hVsvlahS+F9Ba9ZLIiJ6IIR4w7NnF91ODUdnSr19YbfVaROXpRXDh6qQOSPgXcP6A==
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
Subject: [PATCH 12/25] nvmem: lpc18xx_otp: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:06 +0000
Message-Id: <20180309144719.29904-13-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472047860704662?=
X-GMAIL-MSGID: =?utf-8?q?1594472047860704662?=
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
 drivers/nvmem/lpc18xx_otp.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/lpc18xx_otp.c b/drivers/nvmem/lpc18xx_otp.c
index 95268db155e9..549b5298ac4c 100644
--- a/drivers/nvmem/lpc18xx_otp.c
+++ b/drivers/nvmem/lpc18xx_otp.c
@@ -86,20 +86,9 @@ static int lpc18xx_otp_probe(struct platform_device *pdev)
 	lpc18xx_otp_nvmem_config.dev = &pdev->dev;
 	lpc18xx_otp_nvmem_config.priv = otp;
 
-	nvmem = nvmem_register(&lpc18xx_otp_nvmem_config);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(&pdev->dev, &lpc18xx_otp_nvmem_config);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int lpc18xx_otp_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id lpc18xx_otp_dt_ids[] = {
@@ -110,7 +99,6 @@ MODULE_DEVICE_TABLE(of, lpc18xx_otp_dt_ids);
 
 static struct platform_driver lpc18xx_otp_driver = {
 	.probe	= lpc18xx_otp_probe,
-	.remove	= lpc18xx_otp_remove,
 	.driver = {
 		.name	= "lpc18xx_otp",
 		.of_match_table = lpc18xx_otp_dt_ids,
-- 
2.15.1
