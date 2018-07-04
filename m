Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CDBC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4C923E4E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 20:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/Wsuczf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF4C923E4E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752962AbeGDU0q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 16:26:46 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:38652 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbeGDU0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 16:26:44 -0400
Received: by mail-vk0-f65.google.com with SMTP id b77-v6so3688451vkb.5;
        Wed, 04 Jul 2018 13:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=h/K8m9dPDZ9HmMQbYndiCweqUN5DLtMdSmKYQ7bedjg=;
        b=j/WsuczfXsc/gGpJVJS/dRD+yZkdUkdO1aJgIQI2LB5x/DFjCxZiAX+5jvviZ5/MU1
         9vi4TsZw3E5j/ycc/XpKs4eD6Q+aqy1Uav4TmAFRkhZJTFFV0WpGQapYnqzy1zzQNpO6
         GdjYnbjtkOGGr/Lxx1TLJnNs4YVOgrEHN8T3DCSZESkXjgCQPhv1fB5iMR9pMSzQ52Sj
         Plqei2W7/3dDAavB1DmDInln3aBfOPrBgxruYT6zTSl0v+guPnL9kvht6QqTJWZTCmlP
         YLED5iyaNBACCBtmGU+07GX9qwT6RtwE5Yi3OJ5NwdfEmPhjtDO09AkGaUM22YCYIbl3
         kXpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=h/K8m9dPDZ9HmMQbYndiCweqUN5DLtMdSmKYQ7bedjg=;
        b=Jwo9cOOxFvyV72H56kpTcrsWqSzIuqzYxqoqo/yxc2Ou4yGTw1E78gfE3kbR84OmPG
         YsidDzMnPKYy81r8gUz2gk3sG/NF4sUKtaxHnG1ZjWLpV5vcz2nO78qvc4+b6Ll04dW6
         WFTac5rtjyFj3X2xiQl+HRysxpVYCVgx2EmvJR7v1rpu4TDrjXR0JPoKfJ6lDgWlTeLU
         N195ocMRll5Hbg9CXRlgsj5qK0RWC+KEvz0siBEb7cMLb16Gao/SzhMAr0Gl1nLhLhfe
         UjWQSMUX+MSpnIaJPgXUSfWKAzPKZsI24U808rClKNiHGkrkht3rb+poVuKSsRRKoeuU
         CAqQ==
X-Gm-Message-State: APt69E2PuNZtYhurMPOde3K+6kJTCPaZlaUcb/XMFSh5WjlO2uvCzL4X
        7jQQhuAYfTdrgwaHo12rr0iBx0u7q6IghdSm9IE=
X-Google-Smtp-Source: AAOMgpffK85CeV6BBX8NDmwOiV6SVxMo0kYFKvzRs3YX/p0sG41JlRc3/akN5b1ZAK1JYdZmcNCWLiGTv0Si8MBRZjY=
X-Received: by 2002:a1f:820e:: with SMTP id e14-v6mr1833312vkd.187.1530736003811;
 Wed, 04 Jul 2018 13:26:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Wed, 4 Jul 2018 13:26:43 -0700 (PDT)
In-Reply-To: <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
References: <1530494867-15015-1-git-send-email-Anson.Huang@nxp.com> <CACRpkdZOCJXHxcYv0CU76J0r2OpxdtDuOiJ9cenrvJCHVsBeAA@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 4 Jul 2018 23:26:43 +0300
Message-ID: <CAHp75VeQdfoo8Q4EHqAJZ49kXwsgCWGyxgVPB187swKsB=XFTg@mail.gmail.com>
Subject: Re: [PATCH V2] mmc: core: cd_label must be last entry of mmc_gpio struct
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Evan Green <evgreen@chromium.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 2:42 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Jul 2, 2018 at 3:32 AM Anson Huang <Anson.Huang@nxp.com> wrote:

>> -       char cd_label[0];
>> +       char cd_label[];
>
> Not that I am the smartest in the world when it comes to how the
> C compilers work this out.
>
> But isn't that equivalent to:
> char *cd_label;
> ?

No.

sizeof(foo) == bar in the original code and with your change it would be
sizeof(foo) == bar + sizeof(void *)

On top of that, the actual memory is going in one chunk and requires
only one allocation.

But, I like your below stuff, though comments

> From facb3799f479bfd4dad99c25c9c5d4c77b14c9b0 Mon Sep 17 00:00:00 2001
> From: Linus Walleij <linus.walleij@linaro.org>
> Date: Mon, 2 Jul 2018 13:35:01 +0200
> Subject: [PATCH] mmc: slot-gpio: Allocate GPIO labels dynamically
>
> The use of string pointers in the MMC slot GPIO context is
> pretty dubious, allocating some 2*len extra bytes for each
> label of the ro and wp pins.
>
> Tidy this up using kasprintf() with dynamic allocation of
> labels for these strings.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  drivers/mmc/core/slot-gpio.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
> index ef05e0039378..c417801b366e 100644
> --- a/drivers/mmc/core/slot-gpio.c
> +++ b/drivers/mmc/core/slot-gpio.c
> @@ -27,7 +27,7 @@ struct mmc_gpio {
>      bool override_cd_active_level;
>      irqreturn_t (*cd_gpio_isr)(int irq, void *dev_id);
>      char *ro_label;
> -    char cd_label[0];
> +    char *cd_label;
>      u32 cd_debounce_delay_ms;
>  };
>
> @@ -47,13 +47,18 @@ int mmc_gpio_alloc(struct mmc_host *host)
>  {

>      size_t len = strlen(dev_name(host->parent)) + 4;

Do you need this still?

>      struct mmc_gpio *ctx = devm_kzalloc(host->parent,
> -                sizeof(*ctx) + 2 * len,    GFP_KERNEL);
> +                        sizeof(*ctx), GFP_KERNEL);
>
>      if (ctx) {
> -        ctx->ro_label = ctx->cd_label + len;
>          ctx->cd_debounce_delay_ms = 200;
> -        snprintf(ctx->cd_label, len, "%s cd", dev_name(host->parent));
> -        snprintf(ctx->ro_label, len, "%s ro", dev_name(host->parent));
> +        ctx->cd_label = devm_kasprintf(host->parent, GFP_KERNEL,
> +                "%s cd", dev_name(host->parent));
> +        if (!ctx->cd_label)
> +            return -ENOMEM;
> +        ctx->ro_label = devm_kasprintf(host->parent, GFP_KERNEL,
> +                "%s ro", dev_name(host->parent));
> +        if (!ctx->ro_label)
> +            return -ENOMEM;
>          host->slot.handler_priv = ctx;
>          host->slot.cd_irq = -EINVAL;
>      }

-- 
With Best Regards,
Andy Shevchenko
