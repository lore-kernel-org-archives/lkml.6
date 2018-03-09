Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607043; cv=none;
        d=google.com; s=arc-20160816;
        b=YqkFAiVF653pZVQsRRXQFq2WIEEtsTx7BKML5O6s8Dxi//287fIv5YWOXKjd1t9vKJ
         xhyBlnyi8UcPtpcmkoeaVdFR0q+aPqKBT+mOHhNwx5KHpX4WsxPJXtKnxuukIg8mtrUN
         ptOq59EWrblNVOzm38EjEcgF8YO3MWzuBDQUw7R6tfIP3vAFT0cb29Eih35N1QqoVwew
         KB6XfMFuNKcbxZIems4uv4NjJz1li+701BpStem9wvAtLn/6CwNHS8hjcelvPmgXIHgh
         +hu1Ow3GHfq3hiK1oCFCAbDGhrio/C81EApK5sz6VTGnlKzhduAI1oiMNowabAR1pYIv
         MQ4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=HNnsiLc9yf+W4lfxSi/47y81SkTcPUabpKQPBMCemyA=;
        b=JsEJ3EXxCZdenzqyXQZ3wYoaoMPyaZQeN9aLrPxSn4TwPJzYWmJHCwF8oG4G69ojiE
         3IIJ65BoBjRH5m1MnYYQMsYGtJioUIBHtmbCVIZPwyvPh1jbFeRFvDMx8oKXR3RwzIp6
         Hv0xK7fVvl5rvosv/VX+6A8uY9yfNkqSl/LijBw8Gzi4Lka8888x4uKTV7s6QILiII4W
         ilotTAXN75L4M9Py0vZvB12thaLwjZhtz4SLkcZr9VItrW+U+CN7iZkBLLaPCpIdXvlm
         ALVp3QTZWyDJw1V6FcgIcET+ZFRBXA9yUVXsqk2VMxva/oAdCOCI9AFpravMWK4k2xkq
         wCsQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=F6DzIFCx;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=F6DzIFCx;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtuIESYIgAX5LWoyoYbj2UHrLn2/fJjnTyLjgbY3+H/9c3cnX1mya1h6OWVqHuaFkfNv7NYcg==
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
Subject: [PATCH 15/25] nvmem: qfprom: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:09 +0000
Message-Id: <20180309144719.29904-16-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472051633702918?=
X-GMAIL-MSGID: =?utf-8?q?1594472051633702918?=
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
 drivers/nvmem/qfprom.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/qfprom.c b/drivers/nvmem/qfprom.c
index cb3b48b47d64..4f650baad983 100644
--- a/drivers/nvmem/qfprom.c
+++ b/drivers/nvmem/qfprom.c
@@ -47,13 +47,6 @@ static int qfprom_reg_write(void *context,
 	return 0;
 }
 
-static int qfprom_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static struct nvmem_config econfig = {
 	.name = "qfprom",
 	.stride = 1,
@@ -82,13 +75,9 @@ static int qfprom_probe(struct platform_device *pdev)
 	econfig.dev = dev;
 	econfig.priv = priv;
 
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
-
-	platform_set_drvdata(pdev, nvmem);
+	nvmem = devm_nvmem_register(dev, &econfig);
 
-	return 0;
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id qfprom_of_match[] = {
@@ -99,7 +88,6 @@ MODULE_DEVICE_TABLE(of, qfprom_of_match);
 
 static struct platform_driver qfprom_driver = {
 	.probe = qfprom_probe,
-	.remove = qfprom_remove,
 	.driver = {
 		.name = "qcom,qfprom",
 		.of_match_table = qfprom_of_match,
-- 
2.15.1
