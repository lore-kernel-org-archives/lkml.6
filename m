Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607042; cv=none;
        d=google.com; s=arc-20160816;
        b=M0AZbaO2uteebEWb61EPN3FBCKgkRdfgiDkZiFy1bgJDrTULFbZGJwwYQ1kU30GL1q
         SFCTNX3SeIxB1YzR+KCWPLTJ3KSkNiatdNYwuCz32/R6CqYR02Oa9hk5zjeu9BFFwY3F
         MqhR5o7O8X9AT/AgNG6blt6lkzIr+Jabr3jxgnAcZly8PC+e4Znw1ATLGLadL0wxQGRr
         whhuF52H3jVxGcoRoftdKxQsocBss/prIkvpVAp8KenM+xBDQneBp58M2igsMhKcu393
         q+ZfqeICfP8kvGEvfOBUpYcn9D4xNqWmIs+fi7SVOGNVK9vPC6QyDc47SAFU/jPltktC
         YnBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=cX9nl+YTq+v5dxz2HWkpxIJ479dHsg9YyJ8aO5HY8eU=;
        b=O8UKbtffX78AgHkN6AwLX2QMOpV7ByAb3kCCbSHe7+vqhzZcxvfCmhQwYekNhVwa5U
         vOflCPbQfBhr93PuzBMZOeu7afkJv03SfWhaTyxDWa9kWLfAAvs7YVZP9Lwd86Vl8CA9
         extgMmb/3U7XYvSU3COKQkmAhAROL3VZOhloWUtcNvDAHvrQpmTY72dZda2b6gVKSqL8
         6eSN6PLweqEwj1tPCuwZ8ik+PDC9maSHFzrdkzqvYiHF88wJQ0N0zwYoJW0B9opsrACd
         fUIcuZgbowKDcpJ24Mlb/cy++TgR6A6AQ2IjngGt1LTNumtIZeWS3vp8NimOq0V+TXRz
         Uf+w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=IuoHpl5J;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=IuoHpl5J;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELuaTyGH4foMSPJS4Hpdv7EEys7ly4/dK9aVTuEupVYznC+DNfqlxIJY9SvrjhuRGUjGT++c3A==
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
Subject: [PATCH 14/25] nvmem: bcm-ocotp: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:08 +0000
Message-Id: <20180309144719.29904-15-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472050700186103?=
X-GMAIL-MSGID: =?utf-8?q?1594472050700186103?=
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
 drivers/nvmem/bcm-ocotp.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 5e9e324427f9..24c30fa475cc 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -302,27 +302,17 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 
 	priv->config = &bcm_otpc_nvmem_config;
 
-	nvmem = nvmem_register(&bcm_otpc_nvmem_config);
+	nvmem = devm_nvmem_register(dev, &bcm_otpc_nvmem_config);
 	if (IS_ERR(nvmem)) {
 		dev_err(dev, "error registering nvmem config\n");
 		return PTR_ERR(nvmem);
 	}
 
-	platform_set_drvdata(pdev, nvmem);
-
 	return 0;
 }
 
-static int bcm_otpc_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
-}
-
 static struct platform_driver bcm_otpc_driver = {
 	.probe	= bcm_otpc_probe,
-	.remove	= bcm_otpc_remove,
 	.driver = {
 		.name	= "brcm-otpc",
 		.of_match_table = bcm_otpc_dt_ids,
-- 
2.15.1
