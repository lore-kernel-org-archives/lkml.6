Return-Path: <colin.king@canonical.com>
X-Google-Smtp-Source: AG47ELtVDKJsy13u/t3W8N+QS+W9QmYpEea/WDgynqv3oY+B5nUTxiMyvMKWM9Wolgt26oyN8M20
ARC-Seal: i=1; a=rsa-sha256; t=1521711645; cv=none;
        d=google.com; s=arc-20160816;
        b=dB4murWIoY1Q6pHLJfnQwfCPLPLzuXf6EH9FVd+gtVUl6a/SVOsYh94gjeqXXU34ab
         /2vD58OtpcDpRUubUTAnpbDxLbLmde5cGrk5Z/WxCQtSZlkBtmv8weLkN04P6jjoiXRY
         59bffhtgkwu9OAwhxYQnv4TzosSToHSdofg649vBleG7d8fa3JkCuOwBmRh4JELxvrjs
         uzv9pdtva6+JbGSreYI7H/LwluLqLl8/X72CkT6BR7MWWKyGsu6C88pObjELnn9Do3RB
         w9+h8hpzDdREm4tlN6gX0Ee2GbICemkKa6vUkUj0uPx3Mp4tWVujq4k2ezl7Xt0/Hris
         85aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:arc-authentication-results;
        bh=W7dj7yyqqJeUcSZV3AdEeab8RWgm9W6xvunMkE+aGZA=;
        b=NAd988gOpoCHJJtse/5vwl6D4l7DNfLSHfAy8RAR6IvgzXa0jEXn86IOR+FeQeF+3v
         gEF+iZHvzUNGDoOsYmVm/CAvdemdldXi8c5aLs7yZdq+k4ajH8yV7kTeWzCdz0Vi7ThN
         WRI1Ewlo5nDt5zF6A7nvDIqzY4UWIwzh3nE2Ap0AJBy6p3Pg48Mrkql6RwDtNrEG7nfP
         C+bb/96SYXbpKDOSnEID4HOXSaaSd+eaibxoNAewqD3F2xdslSD+vf+ASSz+ND/X9sVC
         xPEnuzD4bGuGuCM2c3y6lhKlsPVTCW6uZLN2Yy5hYX/G1POYPHQ39YxM2e17kMDHVpvB
         JKJg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of colin.king@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=colin.king@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
From: Colin King <colin.king@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michael Lee <igvtee@gmail.com>,
	John Crispin <blogic@openwrt.org>,
	NeilBrown <neil@brown.name>,
	Felix Fietkau <nbd@openwrt.org>,
	devel@driverdev.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] staging: mt7621-eth: fix spelling mistake: "devictree" -> "devicetree"
Date: Thu, 22 Mar 2018 09:40:40 +0000
Message-Id: <20180322094040.12258-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595630310631816596?=
X-GMAIL-MSGID: =?utf-8?q?1595630310631816596?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_err message text

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/mt7621-eth/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/mt7621-eth/mtk_eth_soc.c b/drivers/staging/mt7621-eth/mtk_eth_soc.c
index 98b44629bc1d..eb3e14ae2929 100644
--- a/drivers/staging/mt7621-eth/mtk_eth_soc.c
+++ b/drivers/staging/mt7621-eth/mtk_eth_soc.c
@@ -2096,7 +2096,7 @@ static int mtk_probe(struct platform_device *pdev)
 	sysclk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(sysclk)) {
 		dev_err(&pdev->dev,
-			"the clock is not defined in the devictree\n");
+			"the clock is not defined in the devicetree\n");
 		return -ENXIO;
 	}
 	eth->sysclk = clk_get_rate(sysclk);
-- 
2.15.1
