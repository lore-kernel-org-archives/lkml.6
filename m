Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6903AC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238FE2186A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 02:07:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nHNVU8Xp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBLCHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 21:07:40 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44767 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726170AbfBLCHj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 21:07:39 -0500
Received: by mail-lj1-f196.google.com with SMTP id q128so609477ljb.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 18:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hz95+UTTLfhdNcxxpem9gB906nUvod0afeKnD4XzDEs=;
        b=nHNVU8XpAhLnEzA8ETHyIcLrdzEYYpcvgsc1Mui492tSCHYn+nNZCgdpCL9zOdfRYj
         KZMd+7yw6i2vI2oTU3nlUfhZnIWikugCCfdww06gK1vmAn1MmHOTHBoUJbwdGylZHf8g
         55OlWauX8iEA42L5cB35O4yv4x+HeLYbuGpz9XaT3NcI9VJBc5rCkEPTFYphJjXloFT8
         bRLJ3mI2tf10o2K/vd/bx5gUn6B18DVfXXXoeTnIgAErI4qsAaTtlT6c9QtbuTzspcV3
         GsMxSChPl9wvP6g1P43uhMleSNIheO3nDaJ9ymnxYSduSTNmPM5Fn+hz3G9xL/0zhnyJ
         JW7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hz95+UTTLfhdNcxxpem9gB906nUvod0afeKnD4XzDEs=;
        b=MYEs80gdqYWr3vDBm7OGn6iyNu7X2lAhJnOPJy4CHITNdafkO97tvq4cGRulCaxyJ3
         1Xh2XAgEhqHp0lF0hv11oW+pCqcn649Hc7kDSBxqvdkkf1IX5A6/kbzm/aUI06C1Cz73
         bEX6xt/t8kjWKBj9++8UYoMQpa8myFYfPOsNK6oYs7wT6VVdwDSgMgmR4cjE32yPhoeH
         o39eAzWXRBVe64pNl9TIaDtsKjyHAPPmnWq8q8064RoYzcQK4QJAM9rouIaLcwAq+5Yj
         P+7notDk0E6SC56p0akppTimUg1gkS+NaCQBiXsAVHE1NGCH+cHSWtRBk5jNF3pFAg+t
         OmNQ==
X-Gm-Message-State: AHQUAubaetriR/rWDYC8aJHmWWKkUkH8G+CBWMg/kc5gB7FeZbTZ3NyQ
        oeXfbx4DtshHA3dk3ZpEpFvUPq5Zfl54QtW685HgIg==
X-Google-Smtp-Source: AHgI3IYK7LsHkl4uDejXJC8R2QNW/mOC3DxBvy+ySqDm/Ejsf4pg2JAu3fZnDEz2rWeX/yYpu3uiF7MHt9g991vWb8g=
X-Received: by 2002:a2e:9497:: with SMTP id c23-v6mr662882ljh.181.1549937257722;
 Mon, 11 Feb 2019 18:07:37 -0800 (PST)
MIME-Version: 1.0
References: <20190211185001.GA19472@embeddedor>
In-Reply-To: <20190211185001.GA19472@embeddedor>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 12 Feb 2019 10:07:26 +0800
Message-ID: <CAMz4kuLm66+h_Mo45sTZ1et_wGqDBEv2RRLMU_c+Xip1TEVM-w@mail.gmail.com>
Subject: Re: [PATCH] gpio: sprd: Add missing break in switch statement
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Tue, 12 Feb 2019 at 02:50, Gustavo A. R. Silva
<gustavo@embeddedor.com> wrote:
>
> Fix the following warning by adding a missing break:
>
> drivers/gpio/gpio-eic-sprd.c: In function =E2=80=98sprd_eic_irq_set_type=
=E2=80=99:
> drivers/gpio/gpio-eic-sprd.c:403:3: warning: this statement may fall thro=
ugh [-Wimplicit-fallthrough=3D]
>    switch (flow_type) {
>    ^~~~~~
> drivers/gpio/gpio-eic-sprd.c:435:2: note: here
>   default:
>   ^~~~~~~
>
> This patch is part of the ongoing efforts to enable
> -Wimplicit-fallthrough.
>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks for fixing my mistake.
Reviewed-by: Baolin Wang <baolin.wang@linaro.org>

> ---
>  drivers/gpio/gpio-eic-sprd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpio/gpio-eic-sprd.c b/drivers/gpio/gpio-eic-sprd.c
> index e41223c05f6e..f0223cee9774 100644
> --- a/drivers/gpio/gpio-eic-sprd.c
> +++ b/drivers/gpio/gpio-eic-sprd.c
> @@ -432,6 +432,7 @@ static int sprd_eic_irq_set_type(struct irq_data *dat=
a, unsigned int flow_type)
>                 default:
>                         return -ENOTSUPP;
>                 }
> +               break;
>         default:
>                 dev_err(chip->parent, "Unsupported EIC type.\n");
>                 return -ENOTSUPP;
> --
> 2.20.1
>


--=20
Baolin Wang
Best Regards
