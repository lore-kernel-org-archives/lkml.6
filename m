Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607035; cv=none;
        d=google.com; s=arc-20160816;
        b=ly3PEatswZKArtX4eTK5Ma2byBb5viW/jTqEwIeldBmKuzndFtrrCpTeS3FFDM6P6l
         DSqJf0lETPOCItwKvQ4u82dW3F8dAFwSvb+8Qfmq5C4XQquEukJwurMuSVAb6axJBZeo
         kJ1vX8QWc55+67LezDvh3jjqR1vOj04THtjTyB3uudtmQDFCgYGlJsmnHe+PQ1NcALPv
         95JEMiEH+0wFtAas4IjpK0Qh99ALKh6b/m1H2wpwQWpMXOxyX59sG59iocmCbXuLVWqa
         6gYV57M+X+Y7uJjhP9B+AcsBQNWIFQnZd1LOiH7pTpioumWmqYm8GdDkSzfkStC+S+F2
         DoBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=gAUsHSbOIFU6E1G8a/YdYu7okTBUkxYiiz5tKmU42xU=;
        b=q9iI5zxJdvmTfVpJV2k41f3mLAcuYjadVjXXgZYUZa7W/8Uw5qZ5sg8im/hzsCn8CJ
         +PaiOmnU/64PlPy6SPlaQc8W8GfIxFmAgfPWsFeLFetAt/xZnn33vmScoOEsaj3qo3FC
         2QHtuyTprGw7UIf7TAFE0Ge9j9m5xNJ+Vj5IN/ssRFhc5RSA0Ul4TfFEg/UEtbsibwK/
         AXZj7Fqw/JPj2RX1Bzi/iLOveWo2ORIYEmTi6qT0mTAWD7s5zOIyCCWfyFzoTmyt1eeh
         GNwe9+VGMNv55XoVUbUFw+dxoSLVLPNIakwoYjptxBZfTkpqgSbLR758JBsRBKIUnZx1
         zwtg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lan+og5r;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=Lan+og5r;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsuLYSvwU1MMOq4yDkueHxDNhUfHfdhMu5yiRSSnh5MAiTRdmXc93JRHdlztArrgJTEnjbG5g==
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
Subject: [PATCH 08/25] nvmem: rockchip-efuse: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:02 +0000
Message-Id: <20180309144719.29904-9-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472042763329463?=
X-GMAIL-MSGID: =?utf-8?q?1594472042763329463?=
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
 drivers/nvmem/rockchip-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index f13a8335f364..fec6e4c48b9a 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -289,25 +289,13 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	econfig.reg_read = match->data;
 	econfig.priv = efuse;
 	econfig.dev = efuse->dev;
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(dev, &econfig);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int rockchip_efuse_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver rockchip_efuse_driver = {
 	.probe = rockchip_efuse_probe,
-	.remove = rockchip_efuse_remove,
 	.driver = {
 		.name = "rockchip-efuse",
 		.of_match_table = rockchip_efuse_match,
-- 
2.15.1
