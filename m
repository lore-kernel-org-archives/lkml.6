Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752501AbeBJVH1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 16:07:27 -0500
Received: from mout.web.de ([212.227.15.14]:33739 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751145AbeBJVHZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 16:07:25 -0500
Subject: [PATCH 1/2] gpio: omap: Delete an error message for a failed memory
 allocation in omap_gpio_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-gpio@vger.kernel.org, linux-omap@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Message-ID: <86570340-688b-34ec-2d99-ff728ccbe4a9@users.sourceforge.net>
Date: Sat, 10 Feb 2018 22:07:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:x912BX3jlKZbXPyyaQ3EU1+Ve5d4kFxS1YDzp8N/lgFfWMQNHhM
 qBdeGtliz9OYAsMEB0Curlk/YsDgFun3G+3lKaBhcAYGCk6H4HsxrPTjdg+wOEJLTQ3LFZy
 IjlPL73NMc6GClBHHY3iMu2p7bzva6IksQWpzxgTHvtAQlApl2ue6F2tXmvxdXeUppvUP6p
 pIaflihpFKz4jDDYYNeRg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:PHkCKHu3ZZc=:IcuwKM24hjbb2Sbh1+MTUn
 TW5zR3i5q8MtV1cl0Od5/EayGZRml7fc38JvyVA51T+mrMliMYh9oVrREsTkpj9f/gVR0Leph
 Bmgol1zrRzDHfPcsqC1hl1aL51qxl+oBK8SDbsT9YCO/mE4cson2Rwcnxii+tUNABUFratge2
 cNpArIZFfzHW6L5F1yxMGQ8pjUHAuQh9H8YdmM/npNGfJkN8tRaUADsuVxkjo6J2qVhCEnM+v
 TpZaf4WrYpXsxppTOyPpAJwuLL+bhdkd74X3lfILJDZlBmwHGwSSNKmLCh4uKbyGgS9dh68LN
 r5tNnMUNqolGMQzxYHMXd1dOZPMljaoSaTGoCYtPxoQNxe+RQR0ONSENAc4f8cUqVgy7A04R/
 A/XnMsYN8eXoPxINbP9n1bBkoCI5SadybOuoCQwYyGzv7LmRwDTQ65UB0JlZ9RgMqRqjExMWn
 yBZco3OLOc7btp15lokVAp7BtwrHKwZN5PLXUb05CqY/JIxc+RK/ft9Ig8csZ/xDq9NPCYdKt
 w6slzdMOxe3k4zBecTefoJm80Gg/nSAg/MpCKGhFxMBfS8MvTWGUNcVjkUKhlXbzBIQxyI8y9
 hgV46pTWgZzKxCDNP0Gg8z6hw5iI2wO3UuNt5TFDmaQwgqMnA4fiTR+9aUkjSg130dd3eGHb1
 gf2D9Dg/7h0blZNXcUFMxGBBwccALDt1UYTpq9IVlyuYVwaMEE9na28IAiwOkcvOktOs/eBps
 l4hudl4M/RjrJFH4a4Nchd9mcoCTg4aXTHGKoghG2kB5f8GTjNoXOctyo+OT5yOAg46yMyf/0
 U541Lcj4Zkky/J9SCUt0+drA3qKRjO+5z6UjLFh4pwWicyAEe8=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:46:30 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-omap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
index ab5035b96886..4db6f13fa133 100644
--- a/drivers/gpio/gpio-omap.c
+++ b/drivers/gpio/gpio-omap.c
@@ -1158,10 +1158,8 @@ static int omap_gpio_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	bank = devm_kzalloc(dev, sizeof(struct gpio_bank), GFP_KERNEL);
-	if (!bank) {
-		dev_err(dev, "Memory alloc failed\n");
+	if (!bank)
 		return -ENOMEM;
-	}
 
 	irqc = devm_kzalloc(dev, sizeof(*irqc), GFP_KERNEL);
 	if (!irqc)
-- 
2.16.1
