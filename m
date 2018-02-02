Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753898AbeBBRdx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:33:53 -0500
Received: from mout.web.de ([212.227.15.14]:54274 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754019AbeBBRWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:22:43 -0500
Subject: [PATCH 2/2] i2c-davinci: Improve a size determination in
 davinci_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Message-ID: <e16ba754-078a-097a-7333-076f43718645@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:22:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:36QAdl1NNElsX9VydWdFWM9oCS1i19ealWs0Jii3zrRhHohkfY4
 Se0yodtUsRVkVJSfMOjFvsi6JsupDQDw5+d2sxjybEfowQZvGPMFeaESeMGIOqFN69VT8PN
 QIde9cUIeMO4F0E5LDg9dmBpzllkVgTCOGsDXPER8Jp7GqhRDLJy+fkYHJ91tVt7iW885MM
 Tc3eeXpgLQaJwQ+rqMK3Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YNI7N8PlpeA=:aRq54R7F5742vks+f7+gQg
 YAgv42bNOlTCpRk5qS9E8XZ/s0zE6gU3vvCwsa/wKrXXQQJEfmtP3AaTf7dyxWpz7if7P3MBj
 TZymZNXTFUa931+9Fxf72lSMW69PZzxXbgRBZ5dzyUQWwWQEfB7dwww0BrX/eQxIP+tZ+UTP6
 Dccy+RXzkr7KV1PQ7mwXwYEgg2LcEqMjKuz97LUAwobpqoLYJfKVmmlW7bJ96nWwVrvWd8oxH
 FjXQx55zoRC5MkNnux1kcqDe7yux6G04lCm6f0frOCis4OwAs4RhsxLt3hgatBwNMEeFwKX41
 wrcdqM0Tc4pOELTbt/OIMlCkErNv/iNgXiAvZC6B9Viw5SYLgo7jq3m0XbUkECxgbbiQAzSuL
 ow6AiVIi7ymVbgC4o23BvuHDGnddYcJOVOCqk1YRyIXr5KMVn9n9E2RP8fnlrYxqAyosmzXug
 4y8ZzB9smhxz/lsuTc6XsjiWonQss4cO/TPYxBxsIXzVikHDMPCG5d5zNX5s9oiw8SlYQiIif
 +IFhtGly/y1enF9MSm10DrZ10w3GfB8vRaRLGkYteqK3M4099rS9GDIBU58xcnbxBcFFQ6ZZG
 jbJnt+SSdrDnCiactlREbfwpVcFc2bwaXCRTUZ+8378FW+sp9/GbqF1Y7/fk6k6VvcQkR4bmA
 0OFJRkjHtQE7VsiqYcblf8d/CCoqFI7QVdecTHmtFbXDKM2Qoei8hdzdDvS+EPUbN6wQvYEdU
 cv3maJCBH7Pzb502iJygWBEGF8sDHitZaDkgdbW8NaO2MF43xDK1eJE2o64I79E8Li/ZWOyux
 5quwpUdjYqxqlgujdISU/zpdX3SQ7J1R7ZSWs0vZEB38nL/UA0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:02:49 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-davinci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index 71a9c29b3981..1702b1d1b000 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -782,8 +782,7 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 		return irq;
 	}
 
-	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
-			GFP_KERNEL);
+	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
 	if (!dev)
 		return -ENOMEM;
 
-- 
2.16.1
