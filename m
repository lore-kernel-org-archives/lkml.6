Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756DBC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FBEE20838
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 08:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FM3Gp/iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FBEE20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeJaRxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 13:53:51 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46091 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJaRxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 13:53:51 -0400
Received: by mail-lj1-f194.google.com with SMTP id x3-v6so14055751lji.13
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 01:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u+Via9G3ufkUJQtolb2E/zuM9tSHunQvVk8bkIv2FL4=;
        b=FM3Gp/iPFI1rb3mWkfwsIb5kph0VuyH6s8f6rOnRnTShCsU8Mg9P1cpoITeofslFjq
         e7654JrRLulxNgGL8+lM3Lia9SZovB960JHca/pnBh/4tTb5jbtEOZmlWuGKL8LEBk+H
         P7AriW+Wzin/EVSFLoCfYboT9NzEuacubDKsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u+Via9G3ufkUJQtolb2E/zuM9tSHunQvVk8bkIv2FL4=;
        b=q+shS+0ECvOJGl3Ry1O55mlDJUG7NkJZgRmkgLheAvQ6F4FiYf6i7abkxHyXiKVaVH
         BIQyUSWr80t4kkfv9cZBSS6Enj3Lf+Hu4khqTPWhzdkYYkKo5MBj/euHPhmIZfwqlmqK
         v0oU3KHCE1NsaOKEtaepBlm3ftTxqS7cUBPzv5jC5HRHuYbUj3ZFIUu0n86AidzY6Tij
         luBSqZaAsYcSTtZqJe+2bGwDZ1DXQVtmQC9NvTol9fiRMQAwybbogdYEq8MKifqh6+zE
         qjzK9n4s6l0WGLqueZPgUe77XbdZU0Z8Ld+Q6qMIojIgwl2CxmXS8td89BDrr2vpdkgy
         2Uog==
X-Gm-Message-State: AGRZ1gLaEZxw1kF35OjB3pdZ7jUPINszIjgRAIKXg8LdWUw92DMIuvhN
        9Q1ItUsZJVY4Vs/dtdFunOgZcfolCLUjQMaU75Xgsw==
X-Google-Smtp-Source: AJdET5fd3S35BRyBBpXtZ6FARTxw23l2z13RwZhwA4sDo4uwrVIzjfXN+HeLRlFeiTnBqE4NTy9VOP/2HLx6DW5JIYg=
X-Received: by 2002:a2e:1510:: with SMTP id s16-v6mr1395987ljd.4.1540976197210;
 Wed, 31 Oct 2018 01:56:37 -0700 (PDT)
MIME-Version: 1.0
References: <e7c061535f2dcca54d6498405fdd5ed7098b19f9.1540189330.git.baolin.wang@linaro.org>
 <6a4c15368e0bf34f8e6aad4d788bc899cfb9d61e.1540189330.git.baolin.wang@linaro.org>
In-Reply-To: <6a4c15368e0bf34f8e6aad4d788bc899cfb9d61e.1540189330.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Oct 2018 09:56:24 +0100
Message-ID: <CACRpkdaDB2f5FTY-sk6Ak49GMtqFzV_5Jkway49zSLA6XJkq0A@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 9:44 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
> which is used to calculate the battery capacity.
>
> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes from v5:
>  - Save the OCV values in micro volts for OCV capacity table.
>  - Use devm_kmemdup() instead of devm_kzalloc() in sc27xx_fgu_hw_init()

Hi Baolin, you can keep my ACK, just adding some nitpicking:

> +struct sc27xx_fgu_data {
> +       struct regmap *regmap;
> +       struct device *dev;
> +       struct power_supply *battery;
> +       u32 base;
> +       struct mutex lock;
> +       struct gpio_desc *gpiod;
> +       struct iio_channel *channel;
> +       bool bat_present;
> +       int internal_resist;
> +       int total_cap;
> +       int init_cap;
> +       int init_clbcnt;
> +       int max_volt;
> +       int table_len;

Can  the above really be negative or should these int:s really
be unsigned int?

> +static int sc27xx_fgu_adc_to_current(int adc)
> +{
> +       return (adc * 1000) / SC27XX_FGU_1000MA_ADC;
> +}
> +
> +static int sc27xx_fgu_adc_to_voltage(int adc)
> +{
> +       return (adc * 1000) / SC27XX_FGU_1000MV_ADC;
> +}

Would you maybe use
DIV_ROUND_CLOSEST(adc*1000, SC27XX_FGU_1000MV_ADC)
on these?

Overall this is a very fine driver and really pretty compared to some
other stuff we have in drivers/power.

Yours,
Linus Walleij
