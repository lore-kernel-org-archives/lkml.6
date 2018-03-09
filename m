Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607046; cv=none;
        d=google.com; s=arc-20160816;
        b=WV4Hnmb2WFbbpX4evB94PlQdF68vPv+WTpNf/a813+5UrmcRS0mNUvxy28KmOoWjo8
         8HjljpRxEPUf4uj6VHC36kxC2JLKzuS8xAaZiH+KI8z6tw53wnvx8ahbs+oX9ovVfbH7
         6HshvKUXR8WlJVNRLgQ7cO0vs6UigHQlWH2xievDTsPnW7BkCIl0Cph2f+DgmiL+wwT6
         c3ReulQN2IAsXP7AtbCZNxxa/jrfFrVz97KMGTw1zAtueM0TJIZmLFTuabfkNRXvdkhH
         9mtbe01IPbHbFNPjZuGuuogl6tP3P+McmXDwXBUvkzd/Z2UHGF4Gmvu3BVka4Ha249fX
         s0pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=AL3vSk4vvDm22SR1uW6+Qq0PXmzWtxma/3Yintv32TA=;
        b=ncxexHZXo79ljfY3bpy5dlTlRAuPR/K4mMdbXsl/6XWG2NPQYA2yW/cCFC8JlAyz8A
         44jeuXlGtrjh3mxUblI8msNCN2BQw6SOT3YOn6sA1a86r1zhHn6bXQcmuTrs0BQgzjBd
         n5fumKZKuj6PV3uaHV3JiNHROAuAP/NgH5RN7SH0KhUouzIG0XnRaq+H1RRHLGP4Mi/2
         C8+ZLzE1nY5rA7PvqfvgsILc2fIn5jHBdVgAUgCJpT3ViqsTqXepGtcdsygiA7l6nKVO
         iJs/cg8U/m09QWehQIGHcJNh8u8dj0OBn2DbLAceD3k3AgYrHftTmbYAgvu2dpBZlHfs
         uh5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YEPlV/Ju;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=YEPlV/Ju;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELt6RAdwft8KVMKEPHm6kuAdNQjDodlBfeAEQyUcCrkb7PKRFsUjU322S4/LUchvMbTPRGjXXQ==
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
Subject: [PATCH 17/25] nvmem: rockchip-efuse: Make use of of_device_get_match_data()
Date: Fri,  9 Mar 2018 14:47:11 +0000
Message-Id: <20180309144719.29904-18-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472053809058123?=
X-GMAIL-MSGID: =?utf-8?q?1594472053809058123?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

Simplify code a bit by using of_device_get_match_data() instead of
of_match_device().

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
index fec6e4c48b9a..ade8848adf82 100644
--- a/drivers/nvmem/rockchip-efuse.c
+++ b/drivers/nvmem/rockchip-efuse.c
@@ -259,11 +259,11 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct nvmem_device *nvmem;
 	struct rockchip_efuse_chip *efuse;
-	const struct of_device_id *match;
+	const void *data;
 	struct device *dev = &pdev->dev;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
+	data = of_device_get_match_data(dev);
+	if (!data) {
 		dev_err(dev, "failed to get match data\n");
 		return -EINVAL;
 	}
@@ -286,7 +286,7 @@ static int rockchip_efuse_probe(struct platform_device *pdev)
 	if (of_property_read_u32(dev->of_node, "rockchip,efuse-size",
 				 &econfig.size))
 		econfig.size = resource_size(res);
-	econfig.reg_read = match->data;
+	econfig.reg_read = data;
 	econfig.priv = efuse;
 	econfig.dev = efuse->dev;
 	nvmem = devm_nvmem_register(dev, &econfig);
-- 
2.15.1
