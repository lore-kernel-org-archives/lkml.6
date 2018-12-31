Return-Path: <SRS0=w+lf=PI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2268EC43612
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E505821019
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Dec 2018 13:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbeLaN1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Dec 2018 08:27:16 -0500
Received: from mx2.suse.de ([195.135.220.15]:60882 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726689AbeLaN1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Dec 2018 08:27:13 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1E14AE62;
        Mon, 31 Dec 2018 13:27:07 +0000 (UTC)
Subject: Re: [PATCH v3 lora-next 5/5] net: lora: sx125x sx1301: allow radio to
 register as a clk provider
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
To:     Ben Whitten <ben.whitten@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>
Cc:     devicetree <devicetree@vger.kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        netdev@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-lpwan@lists.infradead.org" <linux-lpwan@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Russell King <linux@armlinux.org.uk>
References: <1539361567-3602-1-git-send-email-ben.whitten@lairdtech.com>
 <1539361567-3602-6-git-send-email-ben.whitten@lairdtech.com>
 <a89c7974-672f-e5d0-8022-d2c2f9ffeac0@suse.de>
 <d22f1f18-0c93-a537-a439-07363174a03b@suse.de>
 <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=afaerber@suse.de; prefer-encrypt=mutual; keydata=
 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
Organization: SUSE Linux GmbH
Message-ID: <a5fd0ea3-c2d1-add2-87bc-b0fd9bbc926b@suse.de>
Date:   Mon, 31 Dec 2018 14:27:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <491d1a46-c112-1106-9f25-14149f0dcbd0@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.12.18 um 11:55 schrieb Andreas Färber:
> Am 29.12.18 um 21:16 schrieb Andreas Färber:
>> `sudo ip link set lora2 up` froze my system, with both
>> lora1 and lora2 being sx1301. [...]
>>
>> Investigating...
> 
> I've bisected and confirmed that it was indeed this patch that regresses
> for one of my SX1301 concentrators.
[...]
> We never return from the sx125x_clkout_enable() performing the
> regmap_field_write() on our regmap_bus, which in turn uses a SPI regmap
> in sx1301_regmap_bus_read().
> 
> A notable difference between my two concentrators is that the working
> one is using spi-gpio driver, the regressing one spi-sun6i.
> 
> Two things stood out in spi-sun6i: It uses a completion (I do not run
> into its timeout warning!), and it uses clk_{get,set}_rate().
> 
> Given that observed symptoms were CPU stalls, workqueue [freezes] and RCU
> problems, requiring a power-cycle to recover, I wonder whether we are
> running into some atomic/locking issue with clk_enable()? Is it valid at
> all to use SPI/regmap for clk_enable()? If it is, is there a known issue
> specific to spi-sun6i (A64) in 4.20.0?

I've now hacked together a test case: delaying the regmap operation to a
work queue (violating the .enable contract of a stable clk on return!)
and having our caller poll afterwards for the operation to finish. Guess
what, below gross hack makes it work again on both cards... :/

Is this hinting at an issue with spi-sun6i clk_get_rate()'s prepare_lock
vs. our clk_enable()'s enable_lock? I grep'ed around and spi-sun6i is
not the only SPI driver using clk_get_rate() in transfer_one...

Thanks for any hints,

Andreas


diff --git a/drivers/net/lora/sx125x.c b/drivers/net/lora/sx125x.c
index 597b882379ac..095ca40e5de7 100644
--- a/drivers/net/lora/sx125x.c
+++ b/drivers/net/lora/sx125x.c
@@ -11,6 +11,7 @@

 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
@@ -49,6 +50,9 @@ struct sx125x_priv {
        struct device           *dev;
        struct regmap           *regmap;
        struct regmap_field
*regmap_fields[ARRAY_SIZE(sx125x_regmap_fields)];
+
+       struct workqueue_struct *clk_wq;
+       struct work_struct      clk_out_enable_work;
 };

 #define to_clkout(_hw) container_of(_hw, struct sx125x_priv, clkout_hw)
@@ -81,8 +85,17 @@ static int sx125x_clkout_enable(struct clk_hw *hw)
 {
        struct sx125x_priv *priv = to_clkout(hw);

+       dev_info(priv->dev, "enabling clkout...\n");
+       queue_work(priv->clk_wq, &priv->clk_out_enable_work);
+       return 0;
+}
+
+static void sx125x_clk_out_enable_work_handler(struct work_struct *ws)
+{
+       struct sx125x_priv *priv = container_of(ws, struct sx125x_priv,
clk_out_enable_work);
+
        dev_info(priv->dev, "enabling clkout\n");
-       return sx125x_field_write(priv, F_CLK_OUT, 1);
+       sx125x_field_write(priv, F_CLK_OUT, 1);
 }

 static void sx125x_clkout_disable(struct clk_hw *hw)
@@ -230,6 +243,9 @@ static int __maybe_unused sx125x_regmap_probe(struct
device *dev, struct regmap
                }
        }

+       priv->clk_wq = alloc_workqueue("sx127x_wq", WQ_FREEZABLE |
WQ_MEM_RECLAIM, 0);
+       INIT_WORK(&priv->clk_out_enable_work,
sx125x_clk_out_enable_work_handler);
+
        dev_info(dev, "SX125x module probed\n");

        return 0;
@@ -237,6 +253,10 @@ static int __maybe_unused
sx125x_regmap_probe(struct device *dev, struct regmap

 static int __maybe_unused sx125x_regmap_remove(struct device *dev)
 {
+       struct sx125x_priv *priv = dev_get_drvdata(dev);
+
+       destroy_workqueue(priv->clk_wq);
+
        dev_info(dev, "SX125x module removed\n");

        return 0;
diff --git a/drivers/net/lora/sx130x.c b/drivers/net/lora/sx130x.c
index 7ac7de9eda46..4ae6699d38ad 100644
--- a/drivers/net/lora/sx130x.c
+++ b/drivers/net/lora/sx130x.c
@@ -11,6 +11,7 @@

 #include <linux/bitops.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/lora.h>
@@ -391,6 +392,10 @@ static int sx130x_loradev_open(struct net_device
*netdev)
                goto err_clk_enable;
        }

+       do {
+               usleep_range(100, 1000);
+       } while (!__clk_is_enabled(priv->clk32m));
+
        ret = sx130x_field_write(priv, F_GLOBAL_EN, 1);
        if (ret) {
                dev_err(priv->dev, "enable global clocks failed (%d)\n",
ret);


-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
