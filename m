Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E9DC43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0456021872
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 10:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546597557;
	bh=CH83fWi6aXHDbkfbQ8crdcBsK6AL/E+/iMFA7cyrKRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HUaz3K2RkpOP4QCmT6WfFf/HtYtM27TG5iC0IZr4Asg1+xCgMbt9gH/yokbvdTrY8
	 Vi7RPrqrkdqsiBqKBf+JsVhsISlwGIHtVjr/YV6+Uv9e/5PDqSoKRg9S6ZYNuTaJQs
	 GV/wD/bMjY+qIjQjVdBHacsEnozJHyMqLTdWNerc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfADKZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 05:25:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:47060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfADKZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 05:25:55 -0500
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD738218D2;
        Fri,  4 Jan 2019 10:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546597555;
        bh=CH83fWi6aXHDbkfbQ8crdcBsK6AL/E+/iMFA7cyrKRE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=sqPo3VE7/IZbGludqm+qgwK+/tLkcDUXJtpd3ObAaKoeKe7qD06IdKueO0MmuoM8/
         qUwwh5k8QBq63jfWrnRI0GgKqqnjiUpMYr8Pt9wnFFCf2DVKJWC5XQvtDG2jPYi4UG
         km4+FAanW8gn9W8SMe8NoaMkc96sI9LaQHRhZ9JI=
Received: by mail-wm1-f54.google.com with SMTP id y185so790551wmd.1;
        Fri, 04 Jan 2019 02:25:54 -0800 (PST)
X-Gm-Message-State: AJcUukfvDRc/6f4pmwoBn0SuBTGeBe/GFWPKyew3QJSQk/6q1gptMWBY
        Xw3qVjbdYuuZU8K0648xOoVqtR9ok60EdTty9zg=
X-Google-Smtp-Source: ALg8bN58ntAz8LOaWcaQRSeGseKr3DsG3+PZJM9xMfaJzSiqys5fg8KNo62LnHp26TeEc+p2WgMmSgQ6DDJfzfS3sEM=
X-Received: by 2002:a1c:6607:: with SMTP id a7mr859765wmc.129.1546597553112;
 Fri, 04 Jan 2019 02:25:53 -0800 (PST)
MIME-Version: 1.0
References: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1546486635-16829-1-git-send-email-chuanjia.liu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Fri, 4 Jan 2019 02:26:46 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzop3UaUt8Kx4LsPxkoo_4uZF-7bv2BOqHgwmurmEA9CLA@mail.gmail.com>
Message-ID: <CAGp9Lzop3UaUt8Kx4LsPxkoo_4uZF-7bv2BOqHgwmurmEA9CLA@mail.gmail.com>
Subject: Re: [PATCH v5] pinctrl: mediatek: add EINT support to virtual GPIOs
To:     =?UTF-8?B?Q2h1YW5qaWEgTGl1ICjmn7PkvKDlmIkp?= 
        <chuanjia.liu@mediatek.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        youlin.pei@mediatek.com,
        =?UTF-8?B?RWRkaWUgSHVhbmcgKOm7g+aZuuWCkSk=?= 
        <eddie.huang@mediatek.com>, Zhiyong Tao <zhiyong.tao@mediatek.com>,
        hailong.fan@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 7:38 PM <chuanjia.liu@mediatek.com> wrote:
>
> From: "chuanjia.liu" <Chuanjia.Liu@mediatek.com>
>
> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't need SMT.
> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: chuanjia.liu <Chuanjia.Liu@mediatek.com>

Acked-by: Sean Wang <sean.wang@kernel.org>

BTW, if you were worried about a patch is lost, you could use RESEND
in the tag is fine.

> ---
> change note:
> v5: This patch is the same as v4,re-upload due to
>       mail permissions issues
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4c2bbc..b1c368455d30 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -290,7 +290,13 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>                 return err;
>
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> +       /* SMT is supposed to be supported by every real GPIO and doesn't
> +        * support virtual GPIOs, so the extra condition err != -ENOTSUPP
> +        * is just for adding EINT support to these virtual GPIOs. It should
> +        * add an extra flag in the pin descriptor when more pins with
> +        * distinctive characteristic come out.
> +        */
> +       if (err && err != -ENOTSUPP)
>                 return err;
>
>         return 0;
> --
> 2.19.1
>
