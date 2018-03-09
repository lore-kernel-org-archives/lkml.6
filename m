Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607034; cv=none;
        d=google.com; s=arc-20160816;
        b=FbWO4FVYNaZnc6uzQucQ42pVK8VPGTHNk/AORBGyKTdYQEA3vBHm05aRsvj89zmLzB
         YLjQUeRTPgfcl8SnCQ5jdpDY97NjvkBZ9jHvcShALHjdTNNokQi1VwQUhDJxRxPkBI4f
         FelB4btC6aSJTT+azeriikbAxjJXXiKkQ8adWoDwYFHLtj68p1Kriwo4j01t52mhw09q
         FrPvndkQS8OYHb9BBe3g7latNM2uiAFaJ7EIry4qJPkGHGF2AQ2aSE8GdGoWvcp00cb+
         cQ7YWHV5OTIKRMrtzrHwgZPays6UV6aZr66gi94hy3ZbMQLj67QNJEW303DCh+L13jXf
         IxGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=iwbfmImi6BY1sK40ria0J88daj3+9B9MGMgTb34A6WE=;
        b=JqNPKQEa6qcPD6IfrzYovgBwp1D6PZdyXkteEbhrvs+M/nRuupmS+o5nYuv6Mnvj8K
         ln8jccZNczBKOqwtcFtTDt3lWnnK4H7bpAxxbFw3ynWgToWsG4nU5bZgdDDIjlmbALrP
         mkG9mCkvKfSW2jjFhbmTRYLjT/kifChmtKh07zXqVYAWnpTJibiyC4YP7wRRz30NJidR
         Ju489WalJbCb6MzQ6IId5uON6l52WJABBR3LHHfun+DfCJwFE0atrUG70X+CTK453DFg
         fFrUhbXpB2pETL0fFDVagsmymaH+bZ7UZtYpqvUK4kr3sUvj86dpwC8+pJVFnt6OZSer
         tEWg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=J344GYMH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=J344GYMH;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELvlbtk/szyqsVr9WP1vXWNclBPPWKh+hpCsnIioJiu8gfXw8jQ1mcPYnZnNbqtdAD4B4B1txQ==
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
Subject: [PATCH 07/25] nvmem: snvs_lgpr: Convert to use devm_nvmem_register()
Date: Fri,  9 Mar 2018 14:47:01 +0000
Message-Id: <20180309144719.29904-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472041746932809?=
X-GMAIL-MSGID: =?utf-8?q?1594472041746932809?=
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
 drivers/nvmem/snvs_lpgpr.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index e5c2a4a17f03..cb471d5e8e86 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -117,20 +117,9 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->reg_read  = snvs_lpgpr_read,
 	cfg->reg_write = snvs_lpgpr_write,
 
-	nvmem = nvmem_register(cfg);
-	if (IS_ERR(nvmem))
-		return PTR_ERR(nvmem);
+	nvmem = devm_nvmem_register(dev, cfg);
 
-	platform_set_drvdata(pdev, nvmem);
-
-	return 0;
-}
-
-static int snvs_lpgpr_remove(struct platform_device *pdev)
-{
-	struct nvmem_device *nvmem = platform_get_drvdata(pdev);
-
-	return nvmem_unregister(nvmem);
+	return PTR_ERR_OR_ZERO(nvmem);
 }
 
 static const struct of_device_id snvs_lpgpr_dt_ids[] = {
@@ -143,7 +132,6 @@ MODULE_DEVICE_TABLE(of, snvs_lpgpr_dt_ids);
 
 static struct platform_driver snvs_lpgpr_driver = {
 	.probe	= snvs_lpgpr_probe,
-	.remove	= snvs_lpgpr_remove,
 	.driver = {
 		.name	= "snvs_lpgpr",
 		.of_match_table = snvs_lpgpr_dt_ids,
-- 
2.15.1
