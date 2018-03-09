Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607044; cv=none;
        d=google.com; s=arc-20160816;
        b=pYn7S9eAZszUWuihIKwpVkSGiuPE2xbT6o28QMfz6ra/YPtrz5hltL/COztKo3mXDl
         ndJN42IniN6+3cP2YCqdE6F8kdbSK3AA+tq2B9Pwa/dQou+dSILf+2aJbsDj0/uzZd2N
         l5BU1bgmuFVrRtGt59GJecHVkFauu25Tj2Uy3hRJA0Yyvx1vFRCMboP/GVTfSS4MmV06
         D3kpJ7uwdP/yD89oelF9WnIb6wR+OXH7jhpmY41/ErN7l3K2Mb4P+XNjINB3KAktke7q
         EqwcT8pNfv+6JfQtemnPgSN4IPQ/1FjbA5Mvy1UXpMI5qJgaWjQCxl4sZgQizB7NGFyz
         nVoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=V1wYXU+KUDrx+qL3t9emawfRo3d+7vjAjrk7o5LYCD0=;
        b=k4+HEf1ZOw44T4bC9Q45tgbCXWAwxxurlzhrMfwbUWro9tVTae1YRJii+IGai3Cnxr
         jUVxJBIUdLHQy+G7uQZvdtdyE5m9/jjh7+6nUiFKVxw861vDmWGrNz6S/V/J73B+3W/z
         zlEyVhCTP6sA7S/A2G5ZlMyBCCwCb8MkLGr2WE4OirY72AhxuciwwWHh54V7+37lt4mn
         nOkUHBKs2+9Kvi/EQyLtY6eR4bIbW9CAN96wY4p4ui3Phf2tTIMnjPwgy+SzwVRhrFuS
         dj11Rh+1dUSPD7zypyj9rcHWWD8mUg2yPg9Xxf7+8jm/rjYMprL2rqKO+x9qj1SzVC/p
         LV4w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HruqlRxn;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HruqlRxn;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELszfAYlVIwI8u26ZyCE49bmG6IhUULcm4S0L9ejjgjku1MAkOGsc5ZzD+a+giVucVTnsADxgg==
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
Subject: [PATCH 16/25] nvmem: snvs_lpgpr: Convert commas to semicolons
Date: Fri,  9 Mar 2018 14:47:10 +0000
Message-Id: <20180309144719.29904-17-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472052688700914?=
X-GMAIL-MSGID: =?utf-8?q?1594472052688700914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Looks like commas were accidentally used where semicolons were
supposed to be. Fix that.

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
 drivers/nvmem/snvs_lpgpr.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/nvmem/snvs_lpgpr.c b/drivers/nvmem/snvs_lpgpr.c
index cb471d5e8e86..92e1e41d128e 100644
--- a/drivers/nvmem/snvs_lpgpr.c
+++ b/drivers/nvmem/snvs_lpgpr.c
@@ -110,12 +110,12 @@ static int snvs_lpgpr_probe(struct platform_device *pdev)
 	cfg->priv = priv;
 	cfg->name = dev_name(dev);
 	cfg->dev = dev;
-	cfg->stride = 4,
-	cfg->word_size = 4,
-	cfg->size = 4,
-	cfg->owner = THIS_MODULE,
-	cfg->reg_read  = snvs_lpgpr_read,
-	cfg->reg_write = snvs_lpgpr_write,
+	cfg->stride = 4;
+	cfg->word_size = 4;
+	cfg->size = 4;
+	cfg->owner = THIS_MODULE;
+	cfg->reg_read  = snvs_lpgpr_read;
+	cfg->reg_write = snvs_lpgpr_write;
 
 	nvmem = devm_nvmem_register(dev, cfg);
 
-- 
2.15.1
