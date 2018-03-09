Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607047; cv=none;
        d=google.com; s=arc-20160816;
        b=zquJi/r2nyKv8HpCpzuiQtpse7AJqFDDwZHHm2mgpE+baZsaHmwKNI71pLVreAhhbe
         83SGSqYxAPC2Bm/aXkzSyc8K8T1qK9TtXGJmFKqFCTKP8Heh+/OVRdA+2EDyF5b3Fs2w
         vh0uqTOLzRDELO27k8fojeL9Lod2dnp3H4pQMLTvEnZNoT9VzXNtgTU3uAY0Er43SiiQ
         GqyH2sp3K2cmWYYe4a3ZxRpGN6iBeLsyAvb6QM47zWxS/Nbwr+785ZJZZqLVzWIte+W+
         KiRLj2PlsB2MbELOJd/eT7AGndjX/cSx3PRBERTWY5RD1D1tQPb4/2jQrXvhIVzzgl70
         Z4FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=GD6bLYBRCS/d7tbmXKvDegmT5vCtX9uh12GfjuFtTG4=;
        b=jVTrnCC23T9F4YjESRLw4SIRwcrtUtBXlOg1Lz3j7Jn4bxCp+sF8H8BnIcAA3CHzv2
         AFzP1FW3nSqyGdMcTl6ipPheQGPfxVOMip4qtF48pwaz/SJFuD5Ycbc2Nvy3Z7Jrsnzy
         qHMqTlZVOPWei06EI9Z+FvZZfkOQGkd0oAT6l9n62d7MCEYQr5mzSVyyGziu9IQoPmO7
         hRtv/JeyRDw2sBVHhqbrQnZD5Qs33YJJqmXGoZb/ik1VTWi2CwcLoP1wm/b6ePBQT3Ew
         DKvX5G33zhoKI3DbiHv+Yb68gm+0chUcQ5sYbJ6P4YPzitrfFLtHytTeA+m72qNOiqqh
         8xqQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HBdnerQA;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=HBdnerQA;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELusaKjfl5TzhvBuG8O6YMA7n6u64HPDbbckUoxmCRjTCQ20xZd+a6FJAIx4XR4mHz244zPYDw==
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
Subject: [PATCH 18/25] nvmem: vf610-ocotp: Do not use "&pdev->dev" explicitly
Date: Fri,  9 Mar 2018 14:47:12 +0000
Message-Id: <20180309144719.29904-19-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472054723089803?=
X-GMAIL-MSGID: =?utf-8?q?1594472054723089803?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

There already a "dev" variable for that. Use it.

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
 drivers/nvmem/vf610-ocotp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvmem/vf610-ocotp.c b/drivers/nvmem/vf610-ocotp.c
index 5a395ffb2ca8..4662309489db 100644
--- a/drivers/nvmem/vf610-ocotp.c
+++ b/drivers/nvmem/vf610-ocotp.c
@@ -223,8 +223,7 @@ static int vf610_ocotp_probe(struct platform_device *pdev)
 	struct resource *res;
 	struct vf610_ocotp *ocotp_dev;
 
-	ocotp_dev = devm_kzalloc(&pdev->dev,
-			sizeof(struct vf610_ocotp), GFP_KERNEL);
+	ocotp_dev = devm_kzalloc(dev, sizeof(struct vf610_ocotp), GFP_KERNEL);
 	if (!ocotp_dev)
 		return -ENOMEM;
 
-- 
2.15.1
