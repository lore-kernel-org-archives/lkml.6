Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607030; cv=none;
        d=google.com; s=arc-20160816;
        b=OvXFWjuQ18IxU5NUkjYB6Q0YeW0rsIOaJnhAC6QGUVsF2hH/lFQ7fJUZ15eTkvESzp
         t/GASsKjRdTD7LagBFarGDOiAoLYRK5iYpEFS4Lfknpsaz0NjcwzQqNuvoKmiE/D/kgs
         1fqVubRiGB+Jl/W4WhankPTXfbK+QX3NzfrvvvS5gw+nXJ4t9btcSe5mYlR+OTAxG5Hg
         t6qLB5zUad4CuwKcDKxGMJ2BTM3g3NWZdw0K2ARaMsflpdNYM7VGc7/yIRYc1bJ5fIe+
         1N9tZnp5nOs5Rf/QbW8lml4+hoUE1CxiMuuuwTdK2w/iDAYD3Zm/jNjqeaNdOS8YO/vs
         GBeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=BRXbg/NYMkWx49UVLwrgUxtCLt0980URCxFsjoA8MUw=;
        b=lCkLY6LIFpok3M2PzkAyoD2+7RWzl+YqUvBTHpMAsjE5Kn5Xy08gazITSW/MgbzVvg
         vPhOKAmJHL8it4ot/fuaAsb2ChoeeqR83rE4yDSk0KeJCdZwTB8vsyv9kcaxqBCU9Xym
         hMnOceR+6K1xgeWxGzgUPywjqsEfdyEgum7Uor8FoiBtrVqLkl3cgaWzdhHYY/tsGq9P
         Te9TgDI7DnMImli0/m8PFrG2UcGnWsF8p/p9TVgtNFGeyrtE2kJkQPLpEwxrIYAOARZ7
         ujg02LN64V9IDdpzhW2hQS+ez10BH9OjF9hId6U/c4OODzWrmG+jYbY6Q4cBMz1JQ5EZ
         n/9g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iL4ZQnm/;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=iL4ZQnm/;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsabrghsp7fYgUyGzWKBOtdInBWLHLDTvPSUsNDHFpuNnhC5OOqZ2uH3SbYCxj3+xaRfGUHSg==
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
Subject: [PATCH 04/25] nvmem: vf610-ocotp: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:46:58 +0000
Message-Id: <20180309144719.29904-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472038252442967?=
X-GMAIL-MSGID: =?utf-8?q?1594472038252442967?=
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
 drivers/nvmem/vf610-ocotp.c | 21 ++++-----------------
 1 file changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index 5ae9e002f195..5a395ffb2ca8 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -217,13 +217,6 @@ static const struct of_device_id ocotp_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, ocotp_of_match);
 
-static int vf610_ocotp_remove(struct platform_device *pdev)
-{
-	struct vf610_ocotp *ocotp_dev = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(ocotp_dev->nvmem);
-}
-
 static int vf610_ocotp_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -246,26 +239,20 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
 			PTR_ERR(ocotp_dev->clk));
 		return PTR_ERR(ocotp_dev->clk);
 	}
+	ocotp_dev->dev = dev;
+	ocotp_dev->timing = vf610_ocotp_calculate_timing(ocotp_dev);
 
 	ocotp_config.size = resource_size(res);
 	ocotp_config.priv = ocotp_dev;
 	ocotp_config.dev = dev;
 
-	ocotp_dev->nvmem = nvmem_register(&ocotp_config);
-	if (IS_ERR(ocotp_dev->nvmem))
-		return PTR_ERR(ocotp_dev->nvmem);
+	ocotp_dev->nvmem = devm_nvmem_register(dev, &ocotp_config);
 
-	ocotp_dev->dev = dev;
-	platform_set_drvdata(pdev, ocotp_dev);
-
-	ocotp_dev->timing = vf610_ocotp_calculate_timing(ocotp_dev);
-
-	return 0;
+	return PTR_ERR_OR_ZERO(ocotp_dev->nvmem);
 }
 
 static struct platform_driver vf610_ocotp_driver = {
 	.probe = vf610_ocotp_probe,
-	.remove = vf610_ocotp_remove,
 	.driver = {
 		.name = "vf610-ocotp",
 		.of_match_table = ocotp_of_match,
-- 
2.15.1
