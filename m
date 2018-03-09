Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607048; cv=none;
        d=google.com; s=arc-20160816;
        b=LlBFou8Q7dcxfpYROFAvW7jGX/wseFN+IFQZbnUctvCo6l02n80FU0LmfsHa8gqe9K
         D2cJ8C7PioKBvHtKzCTBN4mLy95tPO211+tlILoiEdq5/Qo/9/EueH8Eom9Ki22bEoUE
         DVk7QmmrbbpTXq4ShDbo/g47AQKA/NngLOH2/+ln9KTDRrzdIhGf16MCYHM1OZOzjPV7
         13BVZl3u/3h2c9s7uw3up/5/zX3QvF/ZxeRuEUcYvg/rpgXC8JMFBoV4nn+uRSJjgiSj
         MUy5H/5btbC9KJfOVNG0XLSYqpQdaUdjk1fMsYa+R39IXD8kMOj/TMMOPdClv9t7JTPI
         1Shg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=eAnGeza+RiSlIVu+0c9b5tCUTCvMOkR19d39VJCDXNg=;
        b=JHKuI+FoOciq43rl9JX4b/oEQO/YgHYy0LiM1Wq8O5dYnMbHe66iuTA4IX6q/uxMJv
         9ONhiop1ZQBuQdDq8UA+IhS+cyr8pkj9vJQf2ELmURdFiezE01JlZtQDKmVZbwcx3i0b
         dP91PVGxiL9lnEuU4xe1HMkkfeG+JBj/LYuQV5xY6kt2YCNA+qsOwoFmhhCiIammOFbu
         5kOZ3iaKP/OqR6NFt9d+0LV/5bf4zrJTotsmCTMWoIebEBs2vJ3ietxjXqPDbKHSA+M+
         C029iZzwzhm2yQWe4BWD2qAmM8Cv7zFhViC9xyWZgR0/B2j/GatCkhql4SLGinp5DgPz
         kK/w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ANbYRZ/K;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=ANbYRZ/K;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvm7txOEzzfQsVq8g7nCPGbT9UMnFZWqW/YAr/jSLKuUsv9eyS1ufeyD0e4yJpcpjeeNO6ucQ==
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
Subject: [PATCH 19/25] nvmem: rockchip-efuse: Do not use "&pdev->dev" explicitly
Date: Fri,  9 Mar 2018 14:47:13 +0000
Message-Id: <20180309144719.29904-20-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472056262197134?=
X-GMAIL-MSGID: =?utf-8?q?1594472056262197134?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

There's "dev" variable for this already. Use it.

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
 drivers/nvmem/rockchip-efuse.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/rockchip-efuse.c b/drivers/nvmem/rockchip-efuse.c
index ade8848adf82..b3b0b648be62 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -268,21 +268,21 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	efuse = devm_kzalloc(&pdev->dev, sizeof(struct rockchip_efuse_chip),
+	efuse = devm_kzalloc(dev, sizeof(struct rockchip_efuse_chip),
 			     GFP_KERNEL);
 	if (!efuse)
 		return -ENOMEM;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	efuse->base = devm_ioremap_resource(&pdev->dev, res);
+	efuse->base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(efuse->base))
 		return PTR_ERR(efuse->base);
 
-	efuse->clk = devm_clk_get(&pdev->dev, "pclk_efuse");
+	efuse->clk = devm_clk_get(dev, "pclk_efuse");
 	if (IS_ERR(efuse->clk))
 		return PTR_ERR(efuse->clk);
 
-	efuse->dev = &pdev->dev;
+	efuse->dev = dev;
 	if (of_property_read_u32(dev->of_node, "rockchip,efuse-size",
 				 &econfig.size))
 		econfig.size = resource_size(res);
-- 
2.15.1
