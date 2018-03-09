Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607037; cv=none;
        d=google.com; s=arc-20160816;
        b=lbGAnnGhnPOr4pSpT8uIiwiLtVyLel/wxAVvfrvn13bcBpMefM+N88KiNfdqrxdcQM
         wFwRho5KnmFtRrLRoslR3GVVutlW7E4/02b1yow1H9MaMHkm4UNN/NF2MCiHcnfDGuhH
         QEDOCqD7ZJlSSSHzh0uk0fcBoiAwPQMgbua5EPh7v7G40CH7uhKfDkrTh/rAp1NefkGn
         XX80C/n3uYBpIi94FFOmuj6ksqxIzgRNg7Uga5fNa7JdkT6C6o4On92qlD/PkANKr9m4
         F8NLAHcOGOfq+DrhsYrFDlY1a7FiNHLcK/RVoxMXW6rNeUJ7CsbZUg/hivJhLaM1kd/b
         IenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GiAJ0y/oM9bIBNlXIbJzrUS+2Mb/ffkH60fs1tEzvvc=;
        b=NniRtLBBA+p9XEH8AQYNgSxmUJ30OXDH6HZNkUB6Y8K0A/kFh/ddOMMAH+OX06xrdO
         CUOTGWDBMdv5AS0Vv/LnqXUMQ8IzVCqe/dv1nTmxj0+qbr7jdYnmL/AculVeCN7tewHT
         E4DbyU+yWrWTuILhg8JK7XrexNwQs+4at0jwcB3MPQa5YzBA7jtHCdOPiE8DT7OnIWWb
         tvZoyDkFtzUGhMhWZfSxmtnUFr/n8k1XMWSxcJwZ5SUrYC/R+APx6H5gPbtSy0MdzpVr
         dznnd5htckk0fcba7KSNT7et3Xezezm7OLToRlndpD/qgUq9XP1KoPHomgGwMjRlkoLl
         QQaA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WYcHWGWN;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=WYcHWGWN;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtsCJEYd6pT+7UgN4Sgb9TfzF2ulIA8uQFlXnbbbBLhMTD1NaoZCAU+Vsp4ILZY6uzdTXuGpQ==
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
Subject: [PATCH 10/25] nvmem: meson-mx-efuse: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:04 +0000
Message-Id: <20180309144719.29904-11-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472045858066139?=
X-GMAIL-MSGID: =?utf-8?q?1594472045858066139?=
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
 drivers/nvmem/meson-mx-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/meson-mx-efuse.c b/drivers/nvmem/meson-mx-efuse.c
index 41d3a3c1104e..a085563e39e3 100644
--- a/drivers/nvmem/meson-mx-efuse.c
+++ b/drivers/nvmem/meson-mx-efuse.c
@@ -233,25 +233,13 @@ static int meson_mx_efuse_probe(struct platform_device *pdev)
 		return PTR_ERR(efuse->core_clk);
 	}
 
-	efuse->nvmem = nvmem_register(&efuse->config);
-	if (IS_ERR(efuse->nvmem))
-		return PTR_ERR(efuse->nvmem);
+	efuse->nvmem = devm_nvmem_register(&pdev->dev, &efuse->config);
 
-	platform_set_drvdata(pdev, efuse);
-
-	return 0;
-}
-
-static int meson_mx_efuse_remove(struct platform_device *pdev)
-{
-	struct meson_mx_efuse *efuse = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(efuse->nvmem);
+	return PTR_ERR_OR_ZERO(efuse->nvmem);
 }
 
 static struct platform_driver meson_mx_efuse_driver = {
 	.probe = meson_mx_efuse_probe,
-	.remove = meson_mx_efuse_remove,
 	.driver = {
 		.name = "meson-mx-efuse",
 		.of_match_table = meson_mx_efuse_match,
-- 
2.15.1
