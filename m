Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932174AbeBKVEf (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 16:04:35 -0500
Received: from mout.web.de ([217.72.192.78]:45557 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932114AbeBKVEd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 16:04:33 -0500
To: linux-gpio@vger.kernel.org,
        David Cohen <david.a.cohen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] gpio-intel-mid: Delete an error message for a failed memory
 allocation in intel_gpio_probe()
Message-ID: <0ea6dba4-0c52-4c9c-ae7e-d80c2f3d50f3@users.sourceforge.net>
Date: Sun, 11 Feb 2018 22:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:b3l+XWOLFQ9wkEtcq6cXQQDmr0eCzHioTutYZM0+/sK0pvucZx7
 Oi+ofpzeY3+E9yaTbk0tDXPy8jViI9SCdhEqQaT9DzecCc0zGmHR1hHzoVQZRPIs/q/mQPf
 szPsPCELMWzhFMD1lOd/ujxE1IHE4JvPWnBuhJK7DjcXao9gXc37RFaO2RceZ5Ahe3n9oV7
 KqDdlJGTIaFztv8hMXDsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:q05SpnYTFBM=:GZPUDHN13a812BjNizs4os
 XT0414+YpJ+pCeYVn8NQDs35hOv0xyOQO4eJyHXmK0jADUZnK5AvSQ+buaxDZzdwHJRUbidFv
 34rh5hGLWCavpbJ2/6riyYXQNDtllcC0CNh8N2ODtYZbtCrQCbSNCFo23uw83l+U3BhO9tTlR
 UDqlXKEbFQ9XHhGOV8gaL3EeS1iuK3kQDAtNpOpsbGoDOWvMElfd4LsmJe5aOzR0IUG/CH1V8
 2ZmuVkiT8mp7umTtiWxavls3dOROmecOs8X5EPnT2Lmj3HrA5bntUQMflEWDRpI0/UQJkQ0yr
 18mjwbY3nEOJOIMlGl/sfpG2QJFW5Oh0pR1MgRtqINmJVYt1cHdpRmozkKhWWoP4Kz/nT91qj
 j0UfYNwptLw0ALOKAjTc5YwQW2yXLiOCWvzOK+UqFhDSc+c7K46CA/rUS9PFlhQXa00Af2TMg
 4MGXs/YJZnF9V6A3CNYd1zTn0X26RQLWbrIOo/2PFFDmNoRK5EvcwzpTLfEbetJD+F5R3kFcR
 2Y/bKxLtbXlea5CeMVjHAFcMOUzAKS9dGqFfstJozVaPKoabtd3VGnwq2jdstRUC9C3FG96Rg
 xlMolfS/arowCaOZ9eP9KQus4121has2svbhdOM93/VndPw7zQJzzzzFiqnecjv/IIgKM84vE
 Uwl1wU7DZRdrUmFUF/vYU0ad7iwsAabGR3ZKdGMhe0gJgou6ZUmbbo5cQrQR/0Nk9vEhlNPpA
 Z79hLbZUdvD07j1pxkVaqHpq26bM8JqyhUbRKj7vQ9RQZ1eP4htxnhpmByuPn59M1+3MpKHNr
 zImOXjnksMpCNSmePyH7dGkNhVJK6ed+H59WuvnsnjDRs70N5I=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 11 Feb 2018 21:56:42 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-intel-mid.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-intel-mid.c b/drivers/gpio/gpio-intel-mid.c
index 629575ea46a0..028d64c2cb1e 100644
--- a/drivers/gpio/gpio-intel-mid.c
+++ b/drivers/gpio/gpio-intel-mid.c
@@ -361,10 +361,8 @@ static int intel_gpio_probe(struct pci_dev *pdev,
 	pcim_iounmap_regions(pdev, 1 << 1);
 
 	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		dev_err(&pdev->dev, "can't allocate chip data\n");
+	if (!priv)
 		return -ENOMEM;
-	}
 
 	priv->reg_base = pcim_iomap_table(pdev)[0];
 	priv->chip.label = dev_name(&pdev->dev);
-- 
2.16.1
