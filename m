Return-Path: <srinivas.kandagatla@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1520607049; cv=none;
        d=google.com; s=arc-20160816;
        b=ldg0V+nNMGe9ErzmJX8D1SuH9tkGB4jCfeUoPo8/3myjSRL0pncwIvIYJrilumd4PE
         yPlOlr38bivEqHygnS9xQrd8d8bqnigFgL36y3fCR+gSIV5ZhR2VaagmLwGRji5BvKvF
         Kt+dsC4+wbi/ze3as5sXdsfcLREzn7088JeGgI2bLyjBnqBNgVwzM3gcPw7FHxbwYBCQ
         zTspKLsYKhESeM0is/bAlIv8YUHqJBhMGIuflNsGlKm/sMkPzTIyHhAYckxiRxeO7jnw
         fPH48+mh1dSExq1f2ESs2cOCjQ6hAdjwinRQgzrVpok9ZZ9iCP/I8sJqCo2eAdAbZJsO
         CX3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=l9nZCCAVM1Rm7EuPYppwHmZpGtMEgQGRKkW0EU0xWNE=;
        b=D0x0ngAif3vT845uSZjAxOD9MJMlE1DrCss21+iDLIKyckiNknVYNqV4JJa0qGv9ta
         I4QG5eG9F/YdwaEmfk73sCFbH8PslV6mTznJMi9em35zkGQoK2WE+dFZCOs9bmNryx+Z
         d444HQTUCk01Ysh9yAfWpqNeha/qi4JgvGUBXbIMT8A0+JLLL2X3F3Xi27KRV3y/82qg
         zc27gPf+iN91UasElxZWP/ari+BE4XqdRdygLzybWMSaovFX8ka6CeLJUaHxIrSo4Ui5
         8meEgv4R+RODm0f2oUCLGQxYCrKaEoPj+3jPcvvRHOVK0AJgWyQUZgj6ugwt/Puguc6n
         VjNg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=O+80t8Ec;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=O+80t8Ec;
       spf=pass (google.com: domain of srinivas.kandagatla@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=srinivas.kandagatla@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AG47ELs+lxkUsLS5xTLk2qW9T3F+USCG5SGQOnPYdvzLM8X0QUK1Q0tUGMn5HWJKeG8YfYNgyTsL6A==
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
Subject: [PATCH 20/25] nvmem: imx-iim: Do not use "&pdev->dev" explicitly
Date: Fri,  9 Mar 2018 14:47:14 +0000
Message-Id: <20180309144719.29904-21-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
References: <20180309144719.29904-1-srinivas.kandagatla@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594472057429365775?=
X-GMAIL-MSGID: =?utf-8?q?1594472057429365775?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Smirnov <andrew.smirnov@gmail.com>

There's already "dev" variable for that. Use it.

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
 drivers/nvmem/imx-iim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/imx-iim.c b/drivers/nvmem/imx-iim.c
index b98d76ac7790..6651e4cdc002 100644
--- a/drivers/nvmem/imx-iim.c
+++ b/drivers/nvmem/imx-iim.c
@@ -125,7 +125,7 @@ static int imx_iim_probe(struct platform_device *pdev)
 
 	drvdata = of_id->data;
 
-	iim->clk = devm_clk_get(&pdev->dev, NULL);
+	iim->clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(iim->clk))
 		return PTR_ERR(iim->clk);
 
-- 
2.15.1
