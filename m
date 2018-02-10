Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeBJUcl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 15:32:41 -0500
Received: from mout.web.de ([212.227.15.4]:46279 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752314AbeBJUcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 15:32:39 -0500
Subject: [PATCH 1/2] gpio: timberdale: Delete an error message for a failed
 memory allocation in timbgpio_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <da77f86c-a366-0a0f-10fd-9b7cfd879391@users.sourceforge.net>
Message-ID: <758bf4e7-5beb-dbf6-54ed-6c691a56bbee@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:32:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <da77f86c-a366-0a0f-10fd-9b7cfd879391@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:J32BJOGAxpdrsF8bdm+zr3uXFb3szUQRUF9NukBoc8smELBLHB0
 c5u0kYvh7LlAw6L2UcDim1ajstwa56xl2/EtwDuZ3m6Mf35AkcU9B5MROU8XmFfBJyabGzG
 2u3LqFqtjI1U8OTNR2scWsLeSFgJKsu8yyRue3c3as4K68IuxgakAMgb4dofedeflxo9wCw
 ssuHlZHiVHoRB90+mpk/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ShSGQ1+Kuno=:4HDu+hfK7HI2uSH5h6WaP8
 PH6gqI6YdgUz+vgF9vUO00voRSbYVkrVt9g6jQpDu0vUrL4zveTldD4bQRKsGCpNp6zeyGYJA
 +nAJQ4Vt9QvbkIetdf8AhNml0tPSJolAA3dWoD0OcaidQLqmR6z63zoRgSIuXsx9LK46S0whA
 HfYJ/ti2VJH1zGmpevjzMqYrpovLniDlVb0isNNxdPjN6LeBwi/kgvP+e2nYSkaEBjSrWzWoW
 kmYj7sCjkN3hnKhhUAzx+bCHVYLtFrRfw8qhFbIMniLRbGTFLPcrt2NdWdSNc4CYruNMCuPSh
 94KTWYXKO83wGjo5zaZFwtpkxd7OO/JuQVZlDxvShEtWMhH29FEHaDSJBMXyOHzySGL7LlsHL
 ZrduWEvoHT5TiNxdEX5DwrUALTct6MdDrDKWm0S4wsQhrBiiOeO6T3N53p7JZ3VmrYpDr6CfZ
 L6Pp28v77zxIyOmuB4nS94nIuE6ZIvb+2H0TgLFm/HcJXuK0CvHvReKjc+wE0lEHeVCRMw0hX
 t47SRQfma9ni0sUUgYhF8yu6ws2aKiDcwm+jb/nwBte6myGAJeQVLnz9wcNjUw7Aw0yn28QNF
 1+jWQKwmNmAdFXUmeHyhu9oX6sDKk8uXXmpRy/4AGzAUrHOY6ndLtveb7sufTrtt24XmqkuFZ
 EW1lpSl0jW2Pve4OoSOYxBY+QMZDlDN4lL64iRk4iJxbrk4aln0x5YfCtxHAr7O/kV6gM07tt
 hknX5qTNIdvrZXFmW1U7NC9pf8LKYWzf8A7fWqK0eRXsHMo2KNWY9J42zPPV2GtoG7zt8dbiL
 o86j6VgrcCHKCIVFYt3O/neMm7ExgNtOVfDgBaxOJz1kBtvo6c=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Feb 2018 21:09:08 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/gpio/gpio-timberdale.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-timberdale.c b/drivers/gpio/gpio-timberdale.c
index 181f86ce00cd..ff155e437210 100644
--- a/drivers/gpio/gpio-timberdale.c
+++ b/drivers/gpio/gpio-timberdale.c
@@ -239,10 +239,9 @@ static int timbgpio_probe(struct platform_device *pdev)
 	}
 
 	tgpio = devm_kzalloc(dev, sizeof(struct timbgpio), GFP_KERNEL);
-	if (!tgpio) {
-		dev_err(dev, "Memory alloc failed\n");
+	if (!tgpio)
 		return -EINVAL;
-	}
+
 	tgpio->irq_base = pdata->irq_base;
 
 	spin_lock_init(&tgpio->lock);
-- 
2.16.1
