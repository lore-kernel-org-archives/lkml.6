Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619FCC6787C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A3D321470
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 19:07:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9iDldZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A3D321470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJMCll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 22:41:41 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41379 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbeJMCll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 22:41:41 -0400
Received: by mail-lj1-f195.google.com with SMTP id u21-v6so12243673lja.8;
        Fri, 12 Oct 2018 12:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GaRB0w55q1HTP3osbZnN3wKaaRwWOUx826TTBAkNzwU=;
        b=I9iDldZetEfJHGROPZ+tW9BimkrelJAhW2cHPlZw0ObA9z6+EqaL/3Z/W5MtVixpmv
         QLeREBzalrBiJ/ocb3exNtHtxFLh5BKC3nXuU5y8z/h8li3yqE6aAoEmRVBvjjTDQZwi
         UkQNC/FbFiSAqbWQwiSrEybQVtfAIXHbpqNC9NZyVnITv6o2iWredhlNQl4sK6/C+fxD
         xtsH0hTldnipI37f/H0OXYqd34KQwuljizQ4d/rkvKpEpM/dWCYnDhYkk1h62X9llNZN
         0w127upK8b4WiGidTl/RNvoSnvCk+d76D3jVQOEH4AbtlGh8S6z9KHxJr/oK/2NKg0lm
         CQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GaRB0w55q1HTP3osbZnN3wKaaRwWOUx826TTBAkNzwU=;
        b=HN94NIK5WAJnUDNhnvl7lj2D661melW/iucN/xL0cLu9CmnH7Ggo7E545rajJqdPiy
         HALn0t7fdobo+W2DTj5GanzCw7NfW+rIg1jtcHdE8oLKNDyWaHdl32mMBAzB3ohjNCmu
         5+WBHQQvR3NgR3YrIi/HemCFOOD8P/iar8ivZKrlCeeldc0ZeHVE3wX2XMZ0TuuRnFlT
         PRqlIdI5fIrvMlwpndtIfQ5LhXQSFwvRi21hy8Rf+aHOsMs9/pVkkGH8SP+mLqRgcgiu
         uPBTxZHeieixhcZjPh2vTeX7Ns7MQFCB02YfN6qvTzJsyeDlR5owThKqP6AH5HGUtZ4B
         tdjQ==
X-Gm-Message-State: ABuFfogtaJROEfqX9TvHVffqzN+70RlDO/cm3LDe703sDAtgnEdzaLLW
        x9UI1luTvZEWtwXYT4NzSrk=
X-Google-Smtp-Source: ACcGV61Hia86VhFYxKDts9k6Wnmv04yPnPWiJN9xlB54jc33RbO5iV0TJwty2as6vtMuljhJpMTixQ==
X-Received: by 2002:a2e:9f17:: with SMTP id u23-v6mr4729689ljk.53.1539371263199;
        Fri, 12 Oct 2018 12:07:43 -0700 (PDT)
Received: from localhost.localdomain ([31.0.86.150])
        by smtp.gmail.com with ESMTPSA id h8-v6sm412359lfc.47.2018.10.12.12.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 12:07:42 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org,
        Kukjin Kim <kgene@kernel.org>,
        =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Enric Balletbo i Serra <eballetbo@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        linux-omap@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [RFT PATCH] mmc: pwrseq_simple: Fix incorrect handling of GPIO bitmap
Date:   Fri, 12 Oct 2018 21:09:01 +0200
Message-Id: <20181012190901.1243-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180925192433.1377-1-jmkrzyszt@gmail.com>
References: <20180925192433.1377-1-jmkrzyszt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b9762bebc633 ("gpiolib: Pass bitmaps, not integer arrays, to
get/set array") changed the way GPIO values are passed to
gpiod_get/set_array_value() and friends.  The new code introduced into
mmc_pwrseq_simple_set_gpios_value() incorrectly interpretes the 'value'
argument as a bitmap of GPIO values and assigns it directly to the
'values' bitmap variable passed to gpiod_set_array_value_cansleep()
instead of filling that bitmap with bits equal to the 'value' argument.
As a result, only member 0 of the array is handled correctly.

Moreover, wrong assumption is taken about the 'values' bitmap size not
exceding the number of bits of the 'value' argument type.

Fix it.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
---
Hi,

I think that patch has been missed while we were resolving issues 
related to GPIO fast bitmap processing.  Since all issues other than the 
one addreessed by this patch have been been hopefully identified and 
fixed, GPIO tree seems now to be in good shape in regard to that. 
However, I believe pwrseq_simple is still broken.  Hence, I'm 
resubmitting this patch to Ulf for inclusion in MMC tree, Cc: many other 
people who are kindly requested to test it if possible.

I've identified the following DT files representing devices which may be 
affected (have more than one GPIO assigned to pwrseq_simple):
- arch/arm/boot/dts/imx6qdl-sr-som-brcm.dtsi
- arch/arm/boot/dts/exynos5250-snow-common.dtsi
- arch/arm/boot/dts/imx6sl-warp.dts
- arch/arm/boot/dts/omap3-igep0030.dts
- arch/arm/boot/dts/omap3-igep0020.dts
- arch/arm/boot/dts/rk3036-kylin.dts
- arch/arm64/boot/dts/rockchip/rk3368-r88.dts
- arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi

Please start with checking if pwrseq_simple from linux-next works for 
you and if not, please test if this patch fixes the issue.

Thanks,
Janusz


 drivers/mmc/core/pwrseq_simple.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 7f882a2bb872..ece34c734693 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -40,13 +40,22 @@ static void mmc_pwrseq_simple_set_gpios_value(struct mmc_pwrseq_simple *pwrseq,
 	struct gpio_descs *reset_gpios = pwrseq->reset_gpios;
 
 	if (!IS_ERR(reset_gpios)) {
-		DECLARE_BITMAP(values, BITS_PER_TYPE(value));
+		unsigned long *values;
 		int nvalues = reset_gpios->ndescs;
 
-		values[0] = value;
+		values = bitmap_alloc(nvalues, GFP_KERNEL);
+		if (!values)
+			return;
+
+		if (value)
+			bitmap_fill(values, nvalues);
+		else
+			bitmap_zero(values, nvalues);
 
 		gpiod_set_array_value_cansleep(nvalues, reset_gpios->desc,
 					       reset_gpios->info, values);
+
+		kfree(values);
 	}
 }
 
-- 
2.16.4

