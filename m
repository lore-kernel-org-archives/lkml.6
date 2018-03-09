Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607036; cv=none;
        d=google.com; s=arc-20160816;
        b=yt3SOfTDf/ID53Ld0eKh9/4rXsY3LQleqhKOm/rWPqo/k5V5Kfbl7geQR3pciLQPeu
         eywWjzq/cbhdgUPTpp9IYUyXLLWTDlnxWzjB6kpTIPfzektIDeypTLFGBEMZkay7ylD8
         5T4wCdPHSdLeSTjM5j9utqwcZLTlGAlHzDvkbanBEk96mCa/7Bt2Pr8CT9lLhld4BKWM
         POw22kt1MSN+8IKObxQb1JXs6ox8JdQom9hLdyxgjyC5wTyMBBDSxGn+y4GGx9R+DNTf
         VDVD0Dy1em2IvHLgCPyPnXJRaZO7sicBUFZT/jJ5hoPGtLwtazZAUoppMfcMYNoSlJoG
         4E1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=KumflxtmCK4yZqAwSsdyJfWj2rBtjIqqQwGZdvKlUXk=;
        b=r0AURa5upZMliKrWmj0x/c+sA+xFd9KDzXdqhXXQOa/HYi16RnoE4RCSWMUSzbUp2a
         nkxzEEyTbTudg8ja+UvZRE4NHlOQT8Su62DoVgQ0sLumEDR0VzJuZs21Gna2j2GQaWNM
         viCcKNvJS17DsMDPAUjeWw4flkSUbz44GZ9vRmgzpvvr3G71AIIZ59x/zpkf7HvBufaz
         a82Vmyldb/P2Jk/DCBb4kOQL7B/2pSnqhFUxxRgtQycQ8QrET2OzzoK1s53+Mzyc0gWN
         Vzx5qV1CM/52t67l3GTVlf3yr4v1u9RIuwvlkSAwCfdn/OyatMJ7VAI+eG4D87DDTGUw
         lnEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fPtidxFT;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=fPtidxFT;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvTFeHpkVzyLdhiI22hedR3N1DGp4IC6lZ5hd/QSV5a4rM9aGBo6REOg/YJRkrhQCDVSVwWqA==
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
Subject: [PATCH 09/25] nvmem: mtk-efuse: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:03 +0000
Message-Id: <20180309144719.29904-10-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472044429943387?=
X-GMAIL-MSGID: =?utf-8?q?1594472044429943387?=
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
 drivers/nvmem/mtk-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
index 9ee3479cfc7b..e66adf17a747 100644
--- a/drivers/nvmem/mtk-efuse.c
+++ b/drivers/nvmem/mtk-efuse.c
@@ -72,20 +72,9 @@ static int mtk_efuse_probe(struct platform_device *pdev)
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
-static int mtk_efuse_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id mtk_efuse_of_match[] = {
@@ -97,7 +86,6 @@ MODULE_DEVICE_TABLE(of, mtk_efuse_of_match);
 
 static struct platform_driver mtk_efuse_driver = {
 	.probe = mtk_efuse_probe,
-	.remove = mtk_efuse_remove,
 	.driver = {
 		.name = "mediatek,efuse",
 		.of_match_table = mtk_efuse_of_match,
-- 
2.15.1
