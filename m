Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753628AbeBBReb (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 12:34:31 -0500
Received: from mout.web.de ([212.227.15.14]:62550 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753682AbeBBRVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:21:45 -0500
Subject: [PATCH 1/2] i2c-davinci: Delete an error message for a failed memory
 allocation in davinci_i2c_probe()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Kevin Hilman <khilman@kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Wolfram Sang <wsa@the-dreams.de>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Message-ID: <f890924b-ca68-253b-a7c8-fce269393867@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:21:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <4e668c87-65f5-8a00-132a-0184779faa08@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:X9mWGY9IK56enbtcYUi3D8vm7ggftfmFfsNXOSLqo3CD6Zu/zAe
 SE7CeuKtafriI17fU5Iw+EoNc7fpfc/FFzNx66XuofIWBQlcOhLkG+0o+iqTKP8tSM+BuaI
 itE5+Wf/jf6h1934GF0yJVTmNVXJoY6+0V9FcrhrGHEQR+bmErpa2T/IIQ9hb3VoaLYfzhi
 U0BhE8evTJaR1CHAV2KBg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:91IHUphB/SA=:Eco1uGG+04Wm5NtY0s/8kB
 c9ls6fF7ib8sTySvDzDwOOpqw0Y9UNqwh/vFFk7qsPV7ynPP1x5kpJH0iY6il4sh15yKu9KoB
 KU8D8gRj4BM6z4585TrFmzD4L9FCEyYiSG0KkYMePphIVcEXTxTEioyN8CXwbahZ5ids0IeX9
 IJEMBNXkVl/IP0oBbVjrBCCzqWqNzfg6928/ugHmphkqs/mLjjeGUQJMbIM99Qnmxx5Pju0o2
 gV6hbUyaOzT/ewGUSPc8Tq/yuuG8TxmkhrAUvarx0JY1dNnFhPx5W7Ee0foGS5yemBHkGQfg+
 mdh5ntpcocjsS0RXJku8j5xIH1UMqFa60krhMsNl+kRsxHUu2JhTJNJYXbOpZg/Nx0FJ/hpY8
 oNkbTIZ1I9r/MrZ5zNyswRF9x15ULdZkCIGyW80T0SLewjqC+dX4+dHLoJqZXG8ltPaFjvN2Z
 9gZKE9Of0CNKvm+waGT9QpR4ap3fIxg2J02FJNn9lm40z6/oxP+2HHwjeB6bu93hhbs0ebg7N
 veCng4MeNSf9OT9zAmURuqUEt5LWeLzPArgz9du/ZwnrAkgfRbUdVAC5RzylCCQdFzT6w+3U2
 mVBhy3ypx/NnwxesKEy8eRYJyhz3CS5UBOEsQLXufaa4HIw6BQ8creu9cMBe21Z+BfeOgZxKL
 TlAQbMcqDdAvDwghUxBIK6mWso61zOLULFC5msmpTe3en8aKAsjadlaDblv7OC/cSOaeRiJRh
 t89AuhECtyil8QIb+LpE+slcvcC9yZwKNyaAFL1guMNvEzmHJUXtONxHL1ynItQN8hkug584H
 VTxAsBIRHJELGDHDTo8YIeW5SufVd278DaTNVD0F06GTR98+Ys=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 2 Feb 2018 18:00:20 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/i2c/busses/i2c-davinci.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-davinci.c b/drivers/i2c/busses/i2c-davinci.c
index cb24a3ffdfa2..71a9c29b3981 100644
--- a/drivers/i2c/busses/i2c-davinci.c
+++ b/drivers/i2c/busses/i2c-davinci.c
@@ -784,10 +784,8 @@ static int davinci_i2c_probe(struct platform_device *pdev)
 
 	dev = devm_kzalloc(&pdev->dev, sizeof(struct davinci_i2c_dev),
 			GFP_KERNEL);
-	if (!dev) {
-		dev_err(&pdev->dev, "Memory allocation failed\n");
+	if (!dev)
 		return -ENOMEM;
-	}
 
 	init_completion(&dev->cmd_complete);
 #ifdef CONFIG_CPU_FREQ
-- 
2.16.1
