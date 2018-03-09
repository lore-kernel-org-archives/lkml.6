Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932211AbeCIQEA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:04:00 -0500
Received: from mout.web.de ([212.227.17.11]:50589 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeCIQD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:03:58 -0500
Subject: [PATCH v2 03/17 3/3] mfd: abx500-core: Adjust 14 checks for null
 pointers
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <c5d9751e-3ae8-0b66-821a-0e7f45bb8e1c@users.sourceforge.net>
 <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Message-ID: <2f3c512b-cd17-beb3-152a-23513f13279f@users.sourceforge.net>
Date: Fri, 9 Mar 2018 17:03:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <6c8ff539-9e9d-635b-22a8-df8100ac8156@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:Hr6F67uXIBXwIAQv7g2CB6wtTi1MwwtvZPpOI5pgpdrCykDLn67
 TUOkfquQ3rGn+jJKiao3gkMWi28QJyiP1DBXTgOo7iCw6b+KYlzUe/24X/1fD3HGdaT7fit
 /xP6CkgRrOXEk6SeYJiITCAqDRa46GSm3dWoyHzPmtjm8dC1SQV4a2MV1SeZgPr9MpKRS0O
 KE0ChXmHDZqKd85rOCGQw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j/EC0m6b4Cg=:LQNMp5T1ne6mx7FrwvzDHH
 M1SVaTMVgjoF4rXU9t43r0DeBygvldaqu/5GukOkI/FLckojP2jG57QK5D1PDrFUR+odlt/MC
 RkZMWO4kos5ZEs4wet01+rUf9qVwEdmOGJuF6HGVutPk67XOyj9ie7dcuVEh7gtpRyF8Yf26E
 usCFu7Kwu4tSnWcU1T1OFYtly4uY0hbg4UQbINQq9NmIwlpyjJkkLQ6y/ELxZ8VrA9SCbnQqm
 D20ME9f2x7Q/J6QKBh+lyn5D4ZhMkZ9RKiaE/N4/v2S4KOrbUcxt+LSNpLDgbKFMzGFWKG2ae
 xWJfUxiMisa12wObja+d0GOlMqZMwrJTPXbBdDTzZDmCGMi8fSqZ6cwyqCMfBDGh2+QghXBeG
 1xfKtoRocNrukssODKRtv/POyf0uUoUNFkUthjvdKMiYPWaJ7IWZ/Q7WmZd6A9mKiOV7h9UuS
 Wb0bmcgHcGuNwZogqKUaLa4lm7OZVYduTuzgjJNuZzquvEDrqp0dMeFv9ovttG5NuIei+9nmH
 oMU7yUoPWk0tRcoCa3OCEx6vWILkD7LRtlPuq7Pe60aCCNq1iIoPfME4h3EEhXd9s1aE005bz
 ZPWATNaOwccc/YE1JuiH6K25QrZPfysBGnSZcimPr4Gb7hkc5ZjBjrGdaMTDTZqXuvUXoyeOz
 DV+BNjYYMn+5r+DwU6zy7vWnL/JoiHb7hjlFbmGiO65YnUpTpEfZ9wT5pBt8wVTN/ABLwSXmj
 IKJrmHOQat8SwS8LAjEQgWoWEi73J6gg8+jNmUVJ9xRd7XPL7Ry3oE8tMeja6jKpSmtglp0oB
 fI6B7ZQjPIdBvJ86awzWFfT/H4jN43sNIVfNxZ2NI7zeIUG9+M=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 8 Mar 2018 12:50:12 +0100

The script “checkpatch.pl” pointed information out like the following.

Comparison to NULL could be written …

Thus fix the affected source code places.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---

v2:
Lee Jones requested a resend for this patch. The change was rebased
on source files from Linux next-20180308.

 drivers/mfd/abx500-core.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mfd/abx500-core.c b/drivers/mfd/abx500-core.c
index 17176e91cbd0..f282d39a5917 100644
--- a/drivers/mfd/abx500-core.c
+++ b/drivers/mfd/abx500-core.c
@@ -65,7 +65,7 @@ int abx500_set_register_interruptible(struct device *dev, u8 bank, u8 reg,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->set_register != NULL))
+	if (ops && ops->set_register)
 		return ops->set_register(dev, bank, reg, value);
 	else
 		return -ENOTSUPP;
@@ -78,7 +78,7 @@ int abx500_get_register_interruptible(struct device *dev, u8 bank, u8 reg,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->get_register != NULL))
+	if (ops && ops->get_register)
 		return ops->get_register(dev, bank, reg, value);
 	else
 		return -ENOTSUPP;
@@ -91,7 +91,7 @@ int abx500_get_register_page_interruptible(struct device *dev, u8 bank,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->get_register_page != NULL))
+	if (ops && ops->get_register_page)
 		return ops->get_register_page(dev, bank,
 			first_reg, regvals, numregs);
 	else
@@ -105,7 +105,7 @@ int abx500_mask_and_set_register_interruptible(struct device *dev, u8 bank,
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->mask_and_set_register != NULL))
+	if (ops && ops->mask_and_set_register)
 		return ops->mask_and_set_register(dev, bank,
 			reg, bitmask, bitvalues);
 	else
@@ -118,7 +118,7 @@ int abx500_get_chip_id(struct device *dev)
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->get_chip_id != NULL))
+	if (ops && ops->get_chip_id)
 		return ops->get_chip_id(dev);
 	else
 		return -ENOTSUPP;
@@ -130,7 +130,7 @@ int abx500_event_registers_startup_state_get(struct device *dev, u8 *event)
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->event_registers_startup_state_get != NULL))
+	if (ops && ops->event_registers_startup_state_get)
 		return ops->event_registers_startup_state_get(dev, event);
 	else
 		return -ENOTSUPP;
@@ -142,7 +142,7 @@ int abx500_startup_irq_enabled(struct device *dev, unsigned int irq)
 	struct abx500_ops *ops;
 
 	lookup_ops(dev->parent, &ops);
-	if ((ops != NULL) && (ops->startup_irq_enabled != NULL))
+	if (ops && ops->startup_irq_enabled)
 		return ops->startup_irq_enabled(dev, irq);
 	else
 		return -ENOTSUPP;
-- 
2.16.2
