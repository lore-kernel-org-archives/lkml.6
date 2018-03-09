Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607039; cv=none;
        d=google.com; s=arc-20160816;
        b=eNDYe4DAEjJYbEOZOflKHZVmnOV2aS0QZj8TGF9Y27UaLnIobYLEkLuKG2hL4FDpqj
         sdupS6LtOwFatmnRnC8njhjJ74DbLEfSyA47hHrzmYsRhCUqi2RAibUJPQDECxxCY9fO
         5BE3+MRL3mcAeTFVj4TTlM+fTpb/5j1J3M8OJjtK9O6rD0fcix1dgVL3+zculWHQ+/fY
         eTjYRXCtV/TaQebcUuptP+VuEBNnUwmATo/jdib7eUCi5lUQ6BF/Uhzd/O/okZyNRCgJ
         AO8TUqS/bRn+m3qfPd+pU3M21Eqk5yZ+haTMCu+OvheoAr/lsXzbKWF6nOQXqGcJQoSA
         cfiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=Kj3Wgn8PCDjUYLmW96ZzmQO1V0hWd6X4T456qfUITAw=;
        b=mYgAIEWB1/QNkB4/VvJEeD6+cidQakK2IEZO51rtgBNdmpydMDMr9nZ7SVmLBJY2C1
         +dUWuRSM6O5BClu4Ugv2iyvngUnbefq8fiEiCijXyzltE9JMYAPkwjuvrU+NAL2//7VR
         WXrRgXV0Vs9OAQrXEQamKzjflFRqng36g/6eK82x8HpIzQEOl51gtPn+OJhkZLU+E3GR
         8fBJefDJH36N4jNFqWn6jda8H0/ux6J7WomXZA3RampuVKAt05j8H8rQxWmKycbf5ov9
         LckJs5Zl6b1h0yapGiqnoGvvVQbUBum2bylJJs3ilfUykzrivj1TodoRAveBHApAIvkS
         GlSw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=AUS1Fyl8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=AUS1Fyl8;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELsX/CQJ99n0mP8eUDxONwGOzrg1ZFFwIhzOu6n7oSivO0G4hoRz47zp+5l44LGZiWkgijD75Q==
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
Subject: [PATCH 11/25] nvmem: meson-efuse: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:05 +0000
Message-Id: <20180309144719.29904-12-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472046561313826?=
X-GMAIL-MSGID: =?utf-8?q?1594472046561313826?=
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
 drivers/nvmem/meson-efuse.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/meson-efuse.c b/drivers/nvmem/meson-efuse.c
index a43c68f90937..71823d1403c5 100644
--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -60,25 +60,13 @@ static int meson_efuse_probe(struct platform_device *pdev)
 	econfig.reg_read = meson_efuse_read;
 	econfig.size = size;
 
-	nvmem = nvmem_register(&econfig);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(&pdev->dev, &econfig);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int meson_efuse_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static struct platform_driver meson_efuse_driver = {
 	.probe = meson_efuse_probe,
-	.remove = meson_efuse_remove,
 	.driver = {
 		.name = "meson-efuse",
 		.of_match_table = meson_efuse_match,
-- 
2.15.1
