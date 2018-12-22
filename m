Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3385C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:50:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93AB52195D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 18:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545504612;
	bh=EXOANm6tkF2VD+tusHpxMKU/XXyEeaq1YvVk9+PsR00=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lljyTfo7gAyWUzbzENZ1+75CxAm3N9fDFrnbZbMWz0slvGMVvJdbxNHVRmHiqDLU5
	 icOPl2r1XJnFZrIdYYBkdNplY5lbt6ADy3WZ/zVDWwgmKkzvN3wTvYEfYyfjCIVHS7
	 YWWYhwfbLGWZ0Kp3dfmykQsWc+IYkE56cZPgc28Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388138AbeLVSuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 13:50:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:35164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728086AbeLVSuL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 13:50:11 -0500
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E6DE2196E;
        Sat, 22 Dec 2018 18:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545504610;
        bh=EXOANm6tkF2VD+tusHpxMKU/XXyEeaq1YvVk9+PsR00=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IjnT/BUShlBgikHhMQLg+sH3RlMO7frzPfTSNuVzGbVipnr7dpDk/V10vH0qch2PQ
         MOiDwz3V2GQRoVnvrsAiKuxC4hT4V+2wKxKtWg+qe+zWNE+FeizauxJAeD5jaxQurk
         yZz70wuj6FQKifDcloWEGLkGXzWmLz1lgO9n+Qhw=
Received: by mail-wr1-f45.google.com with SMTP id t27so8307543wra.6;
        Sat, 22 Dec 2018 10:50:10 -0800 (PST)
X-Gm-Message-State: AJcUukcfrR2bOjqBnQPQVJ1+s/juQ8fa8VnKUglGmH/Z3fNu+7A8Dk4F
        EP0AxltONd3InDV5c3jlMn0KtTOgiY0dWlTDxS8=
X-Google-Smtp-Source: ALg8bN5lX4dZDF6anLCJlQsv8WTedtCVif7l7EUPUCJupBT0ZhY6oI2B03/yp2mobzDw6+eDiDQOys68duHtxfjBaZ0=
X-Received: by 2002:a5d:66c1:: with SMTP id k1mr6691953wrw.132.1545504608825;
 Sat, 22 Dec 2018 10:50:08 -0800 (PST)
MIME-Version: 1.0
References: <1545100282-15756-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1545100282-15756-1-git-send-email-chuanjia.liu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Sat, 22 Dec 2018 10:50:01 -0800
X-Gmail-Original-Message-ID: <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
Message-ID: <CAGp9Lzoo6bw-3Hr56rgbL6EhrRvXX2y5pajaOo13c5MV9FsO7Q@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl:mediatek:add judgment conditions
To:     chuanjia.liu@mediatek.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zhiyong.tao@mediatek.com, eddie.huang@mediatek.com,
        hailong.fan@mediatek.com, youlin.pei@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 6:32 PM <chuanjia.liu@mediatek.com> wrote:
>

I thought the subject still is much general, it should be further
improved with something like "add EINT support to virtual GPIOs" and
should say more about what virtual GPIOs means by MTKers in the patch
description because "virtual" is a usual term used throughout the
kernel and that would easily cause others to fail to interpret
correctly.

> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>
> This patch avoid return err when virtual gpio set SMT.
>
> Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v2 : 1. delete virtual gpio number
>      2. add judgment conditions
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4c2bbc..a576e417744a 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -290,7 +290,11 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>                 return err;
>
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> +
> +       /* SMT doesn't support virtual GPIO, add err != -ENOTSUPP is used for
> +        * avoid return err when virtual gpio set SMT.
> +        */

I'd prefer to the comments as the below

/*
SMT is supposed to be supported by every real GPIO and doesn't support
virtual GPIOs, so the extra condition err != -ENOTSUPP is just for
adding EINT support to these virtual GPIOs. It should add an extra
flag in the pin descriptor when more pins with distinctive
characteristic come out.
*/

> +       if (err && err != -ENOTSUPP)
>                 return err;
>
>         return 0;
> --
> 2.19.1
>
