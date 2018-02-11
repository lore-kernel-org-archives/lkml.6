Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753384AbeBKMm3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 07:42:29 -0500
Received: from mout.web.de ([212.227.15.14]:34197 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752691AbeBKMm1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 07:42:27 -0500
To: linux-gpio@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] gpio: merrifield: Delete an error message for a failed memory
 allocation in mrfld_gpio_probe()
Message-ID: <d73420c9-60ee-ab28-e881-299441815afc@users.sourceforge.net>
Date: Sun, 11 Feb 2018 13:42:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:VeqzgrWNqeuZXeRJ+yEqvVxxpC16J0+gKBLQFMaPSZr7tfgUpeX
 xqkhc75uHkDX4NnGwdqTogrkWxjA12qfBIJ9StlR1LtFtJBHyCB9fJ/IeQ9ZSmB8XqOOrjk
 +gwxMWVZUnssKmgPTHuJNI00SXV3KNeIdD1ve65lipAkavpC0bZucioV05NX0nXtmUqakVB
 qNV8VprmA+9lXeVBohD8g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4KcP1eF4jcU=:y2i36i94INaHubjuimZGC/
 PxIiS3UmL5DEw7WDPWi89nW+6+lR1O7xvbztaZiUZMecZLwqpBkpWm9rUiO0SSzXdnEiYhLKW
 2FXgEXfV0bbrE4FrG3L0axz94AqFls6gvIsaYzpxaC/2dxNr1C+uvIHmqXUUXul5gmu6o/6xW
 brMjWgejiL3SddQEBy5Bhp2xEw9cAmNxZTgzKtquq9LM60KCNYFQSCjLSxtGV6IhQUbylZget
 rvKH8zigoBu3iUDmPCZ7vD9x0duDts8u9munsbVtFtSoM4kXk7liK6kN6ykigLkklM6+u3ze5
 PKvawWEbxvZ2F2HhYbrNTc2q4U5RFo+iBybTUiz/+0RbSlAANaB2onPKq/NB2quEy+CVwmypt
 wTRB3MaBbc55QB9t4YebS2LE4wvUsiIIaFPD3vVEj7nTcgGfNygjPqgCqIvcm9JZcgTGa/67s
 cOVLJqRFByt/TJvN9S4o6FWk2B8gWqRbjsDEh4pq7MkCxLmaCqX6ti6w0pNnrulvcNP9H825Z
 Rov2YkW1cPOhjvgggmaUYjXiRAo9UE+iitzQK3IWHlFNk/BWMmSy5LmDYZfOyDnij3bpEc/YU
 pRJNlqy5FvcXW3IJe9h1mkM+N0N5v+3pBaX8jHA0JvHE2gDWWiPd9TrgguMGShK+2/vyBozYt
 hydovwXUrI6yEd94mRj7aF2VMSh9rUbTRnmA/7cIWUMs55fjxoz994tpJIjO2vN/RkRzujYa3
 RhFH/mYQV4O/scSV6JfFA6KpHTHSOf22hPJayu1Y5q1CGHcki/wTBJSnYJO5bZqFQKjeX7XwY
 NzEhTl7/MK54Qh7AA4WR1xu8EYb4gPSutZ8bcdP2Dx8nwG6MsM=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Feb 2018 13:30:14 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-merrifield.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index dd67a31ac337..eec21122299e 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -408,10 +408,8 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	pcim_iounmap_regions(pdev, BIT(1));
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "can't allocate chip data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	priv->dev = &pdev->dev;
 	priv->reg_base = pcim_iomap_table(pdev)[0];
-- 
2.16.1
