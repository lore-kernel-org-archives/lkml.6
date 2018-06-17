Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B5BC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EBED208E0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 16:51:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUz8xLvJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EBED208E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934444AbeFQQvd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 12:51:33 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:40145 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934108AbeFQQv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 12:51:29 -0400
Received: by mail-ua0-f195.google.com with SMTP id l11-v6so9309771uak.7;
        Sun, 17 Jun 2018 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2nHH+JbSV+j9JQGicjZw86DMLGhlVT65xtfs/Zktys=;
        b=XUz8xLvJEWznzfUZJtIvckvObBZOhgPCDvqAa0kFueIKdB5jyYI8BECHCxMG/bFzEj
         3FqeVgeLk2CWELVFTrI+9JmLziLQIlq0pCMaOy8DHCzz3TvTcBWtuAWELTTfc5091BFV
         yPGdzEbi+0WF/Vh+OLjwTSfXmZhRD9tXEYI+SPvdZc6q/hN9jMAzY9xhfDUCAGUkIdgq
         iDxJB3qA2Il/T0ir3ygt60yctoInGcmcDQj5Dq+BNfZaA0DTwTToTtkVhbh9E36CvJfK
         J+wIwLy93cTukUg9GXzhw0hEoT5HqEHJSUUMpCsPEghVEnNxCLUutdgxrG0jCsddu3Wo
         bqPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2nHH+JbSV+j9JQGicjZw86DMLGhlVT65xtfs/Zktys=;
        b=nAeJNJFA4AmgIkxB7VeyTs02dExGjSTl+7/xRZ8l5wkDl4gJ7PZ/h5gFOvhg401rGa
         F7Tl0WCOvB/qD5Y/l/ituWDLJRjVZjZKYwv1ZymCus/dDmGnQvJIRmcY1gjqNSiKiC2W
         YJn4aNSHvOkhxiUIhi1RIxUqt8HcoRmPH/gw497m+qaGGrXK3HVEjnlrPuB24QnUf9kh
         lCNLIRd8fhc5ED1ZU9UEeIYJAoV6kDKYDK/PqQH5egIF9YXtrA/09Et3jTUcEYXI2QpQ
         6wSAxuSbPzkX7oKGgIa0Pdc0162M4jwCpClP7D7Fpim8E3Fr/yrJkuZ+79fCU5JrFZqM
         eWBw==
X-Gm-Message-State: APt69E2Y/SPxVlILqarQ0+F2Fk0a7ik44w2gYkNTfBoNO/biMeH828kD
        HuoArj1zPh2hqwYNjM74jV3Y0VUHq+raEICo0N4=
X-Google-Smtp-Source: ADUXVKI1TSGXcLRAUmNaHILNt8ZVsLjgM4o1/Sb9JuO+3WvG4FTfeFcErComgmrLo7oecVQGK6y3ePrcX7tS+nib9o0=
X-Received: by 2002:a9f:3613:: with SMTP id r19-v6mr6236350uad.49.1529254288349;
 Sun, 17 Jun 2018 09:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180615111141.37184-1-tony@atomide.com> <20180615111141.37184-3-tony@atomide.com>
In-Reply-To: <20180615111141.37184-3-tony@atomide.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 17 Jun 2018 19:51:17 +0300
Message-ID: <CAHp75Ve4BYRbFsJRiwA2D-gJzVBj7JD2dfGhHSP3NDYwhAQyMg@mail.gmail.com>
Subject: Re: [PATCH 2/5] pinctrl: pinmux: Return selector to the pinctrl driver
To:     Tony Lindgren <tony@atomide.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Paul Cercueil <paul@crapouillou.net>, sean.wang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 2:15 PM Tony Lindgren <tony@atomide.com> wrote:
>
> We must return the selector from pinmux_generic_add_function() so
> pin controller device drivers can remove the right group if needed
> for deferred probe for example.
>
> Note that fixes are also needed for the pin controller drivers to
> use the selector value.
>
> Fixes: a76edc89b100 ("pinctrl: core: Add generic pinctrl functions for
> managing groups")
> Reported-by: H. Nikolaus Schaller <hns@goldelico.com>
> Cc: Haojian Zhuang <haojian.zhuang@linaro.org>
> Cc: Jacopo Mondi <jacopo+renesas@jmondi.org>
> Cc: Paul Cercueil <paul@crapouillou.net>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/pinctrl/pinmux.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pinctrl/pinmux.c b/drivers/pinctrl/pinmux.c
> --- a/drivers/pinctrl/pinmux.c
> +++ b/drivers/pinctrl/pinmux.c
> @@ -775,6 +775,7 @@ int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
>                                 void *data)
>  {
>         struct function_desc *function;
> +       int selector = pctldev->num_functions;
>
>         function = devm_kzalloc(pctldev->dev, sizeof(*function), GFP_KERNEL);
>         if (!function)
> @@ -785,12 +786,12 @@ int pinmux_generic_add_function(struct pinctrl_dev *pctldev,
>         function->num_group_names = num_groups;
>         function->data = data;
>
> -       radix_tree_insert(&pctldev->pin_function_tree, pctldev->num_functions,
> +       radix_tree_insert(&pctldev->pin_function_tree, selector,
>                           function);

Same nit: One line now?

>

>         pctldev->num_functions++;
>
> -       return 0;
> +       return selector;
>  }
>  EXPORT_SYMBOL_GPL(pinmux_generic_add_function);
>
> --
> 2.17.1



-- 
With Best Regards,
Andy Shevchenko
