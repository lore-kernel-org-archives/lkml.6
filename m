Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54D0C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98D4E20851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 09:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARiKUZqQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98D4E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725981AbeLDJbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 04:31:35 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44518 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbeLDJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 04:31:35 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so11385457lfe.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 01:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X/+uP3K8EqS6DjUlKc3PTvxgefYHP/AxCgxfi+++j3c=;
        b=ARiKUZqQdKQ/cwek5oMlZZ2VJxpmPViqJkYf6xwyZsAOB61JCPd+jmkAugBGp692RD
         QhdMsLYJx099VKQAi8B8QXNQJUfxV36MjNuYsig7krJL8ishUsMOCdQs1+3ObrMM9oYp
         IHUi3SwGqLE5ufXg9lEeT9GQsXwJpNP9FKpUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X/+uP3K8EqS6DjUlKc3PTvxgefYHP/AxCgxfi+++j3c=;
        b=AHwBYckwtx9gKKyXy4eKgRbUtyf3aL6UtV6PXynureAE2U84Q4KDIQjKdQBpyXsczi
         tyHOoowptnAur8Y2XD+cJtU3YHvbVl80OrCBIOhWF2Np2nkKRI5Zj0X9eoSxQHUmHAuC
         8FE/iegAhGjL5GbeiV9URzIswP2CIYEs+8hAm7v1eVOtkt/ManukSbCXI2SPr7T3wzaa
         X+QFAW8nyg14fI2jKVNDZ/i29aw/ZppERnqEekitlFIfmVvh3SExhKiFPBosoIiDfGiL
         cdvt8tVD4WZoIkSDsNTTixeHK7PNntLqYMfv8oXrD8KeDfAO8zksrhYwGZGxrh1cMxpM
         KpYg==
X-Gm-Message-State: AA+aEWaNGOQHlyNNDcxmPqR4Q5FWHeST8RbdOG8E8hvefHekUX75adN7
        8aq0Bv7nagF7n8IKCmv4Ataf7UbuyXHUWRmMks8pLA==
X-Google-Smtp-Source: AFSGD/XRhXIh3Gba8hHx9zCAb8RDaZF8X1p7SN/zJtLJezE2KmMlNhhAVB8I3jaE/yEfp4rJe9p+tpeD3ztgS0UKpnI=
X-Received: by 2002:a19:5154:: with SMTP id f81mr11880370lfb.96.1543915891274;
 Tue, 04 Dec 2018 01:31:31 -0800 (PST)
MIME-Version: 1.0
References: <CGME20181201154428epcas4p3a1a5c9c576027b1c56f8dd1510b32187@epcas4p3.samsung.com>
 <20181201154151.14890-1-linus.walleij@linaro.org> <d6b5f384-51aa-0e99-7e88-a1debcf5eca3@samsung.com>
In-Reply-To: <d6b5f384-51aa-0e99-7e88-a1debcf5eca3@samsung.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 4 Dec 2018 10:31:19 +0100
Message-ID: <CACRpkdYQ5cy1-8wu--deF0kdzrRGVJ_teNh2LRF7tr9vyh+oHw@mail.gmail.com>
Subject: Re: [PATCH 00/13 v2] Regulator ena_gpiod fixups
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

first, thanks a *lot* for testing this, it is is much, much appreciated!

On Mon, Dec 3, 2018 at 3:35 PM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:

> The idea is good imho, but it looks that there are some missing cases in
> the code. Here are some logs from the boards I have access to:

OK let's fix this!

> Artik5 evaluation board (arch/arm/boot/dts/exynos3250-artik5-eval.dtb):
> s2mps11-pmic s2mps14-regulator: Failed to get control GPIO for 11/LDO12

Question: this is supposed to fail, right? It is something
like a probe deferral or nonexisting GPIO controller?

I look in the upstream tree:
arch/arm/boot/dts/exynos3250-artik5.dtsi
where s2mps14 is defined:

ldo12_reg: LDO12 {
    /* VDD72 ~ VDD73 */
    regulator-name = "VLDO12_2.8V";
    regulator-min-microvolt = <2800000>;
    regulator-max-microvolt = <2800000>;
    samsung,ext-control-gpios = <&gpk0 2 GPIO_ACTIVE_HIGH>;
};

I didn't really change anything about this, so this missing
GPIO descriptor looks worrysome.

Anyways what happens is this:

gpio[reg] = devm_gpiod_get_from_of_node(...)
if (IS_ERR(gpio[reg]))
(...)
            continue;

So this IS_ERR descriptor is left around. So we should
probably handle erronoeus or NULL descriptors in
gpiod_unhinge().

If you add this on top, does it start working?

diff --git a/drivers/gpio/gpiolib-devres.c b/drivers/gpio/gpiolib-devres.c
index 5864e758d7f2..e35751bf0ea8 100644
--- a/drivers/gpio/gpiolib-devres.c
+++ b/drivers/gpio/gpiolib-devres.c
@@ -332,6 +332,8 @@ EXPORT_SYMBOL(devm_gpiod_put);

 void devm_gpiod_unhinge(struct device *dev, struct gpio_desc *desc)
 {
+       if (IS_ERR_OR_NULL(desc))
+               return;
        WARN_ON(devres_destroy(dev, devm_gpiod_release,
                               devm_gpiod_match, desc));
 }

Yours,
Linus Walleij
