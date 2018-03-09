Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607050; cv=none;
        d=google.com; s=arc-20160816;
        b=HT2xEbcok3KtamT1MkWac1P5AX2tk3wdptvg/uiztPxDdE2Zto6WVL3iHiUftp+mVt
         mk+5wM2wN+ROVaNSCiB1P56iYBKJfYaNi/Fq4YeBVCHCyvooPxl6YJ9oCmVM0spCWcd3
         e3fwul/bn7Lnn8yTbc5UJNDJnQS9z2nIbzkUGITgl54nfrf+tdaUY1mtUcLLQxCXTbHm
         jbUaSaMB9UxFTD2pWfu5KdBPrYGWmjNTIb3JteimIv3UT8ZuSuL7bVlZe3bin3vMCXEm
         pKWXFWnWvgcBxbPGhK1iUAUkvtekuOGzMOupr5fdNVAUS2z/BOtZ2ZlZi7MDyT2XpvCC
         uQCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=3ZSCv8oSZg2owMLKNVQOSEpWttP2gkpTlAcGvmpr+DI=;
        b=G7QUSND5VHOwdrfTJr+aS/F1s1aYY7L9KfY2gYHf2iVO5ZuiqzKNwGQ1HNhVGaM0EW
         e9KJRNtq1PbfQ2+YWL2cLMiECtxt+v28xoM5paiADUfMK3JZPn9hF+NGboXKPnzA7tk4
         5RFcAhfc5C0xAL0XKJ6lq19IWQ7ihQs0PMGHblojxAhPNcL67/ajOUY+IjYNEbtnFMHh
         NM8XdW6y/yYaMiQayMnXEucjk0VzdKEi3k/EMEz9MEbtY7414ZCwTc7GxSad/spebxPu
         ZuTLi6MGcfqDmfzLcohMNBSuQlclFK9MV10rxBnRQhADMHck6Pf2vL+Yj6JBKI58KsFx
         TH4A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TqvcsK03;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=TqvcsK03;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELtrHhdgiZ8Y9kg/zNt9Kmz4pl2ytb6fYoXBiqi06hf3H454Kxba/SO94ufCInXfbuHBoGU49Q==
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
Subject: [PATCH 21/25] nvmem: bcm-ocotp: Do not use "&pdev->dev" explicitly
Date: Fri,  9 Mar 2018 14:47:15 +0000
Message-Id: <20180309144719.29904-22-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472058914370707?=
X-GMAIL-MSGID: =?utf-8?q?1594472058914370707?=
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
 drivers/nvmem/bcm-ocotp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/bcm-ocotp.c b/drivers/nvmem/bcm-ocotp.c
index 24c30fa475cc..4159b3f41d79 100644
--- a/drivers/nvmem/bcm-ocotp.c
+++ b/drivers/nvmem/bcm-ocotp.c
@@ -262,8 +262,7 @@ static int bcm_otpc_probe(struct platform_device *pdev)
 	else if (of_device_is_compatible(dev->of_node, "brcm,ocotp-v2"))
 		priv->map = &otp_map_v2;
 	else {
-		dev_err(&pdev->dev,
-			"%s otpc config map not defined\n", __func__);
+		dev_err(dev, "%s otpc config map not defined\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.15.1
