Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF0AC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58A0E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544729649;
	bh=+2DwOz/MH+BB+HkI8y/EmWLob9eNm41yKPZRvzwGPgc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=amTtxLllRORAlnSSufFzf3uY8+oJjVBLh4JMLqm7YG3A0Vf9+hGV2NNIomZk2Ugcj
	 kNiw8gcZjEbT+x1nFIUsw4URN2fW302asK2440YAaQvkwsgAdQ0C4Pv65IgFQdmM3T
	 cHjqYU1n/Qn6CE397c5Y9kauk0InxI1sKuuiAv7I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58A0E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbeLMTeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:34:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:55690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbeLMTeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:34:08 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6318F20870
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 19:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544729646;
        bh=+2DwOz/MH+BB+HkI8y/EmWLob9eNm41yKPZRvzwGPgc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=183oY3MkNSyTam6gDEc+TnWQ5fXXTU7i0tMLCKRR5Fqx39ACy5YFSm4+JFDjOP1DJ
         OrHzpqsO3BgK7XW7AMHuwruRWxvGeyKONzi/VMHnXKyg7h2iyTYg6F3N71H1aS3+/c
         cFiGw2dzoW7cPKsHowDtfnczld4h73oU4WT2x2LE=
Received: by mail-wm1-f44.google.com with SMTP id y185so14615757wmd.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:34:06 -0800 (PST)
X-Gm-Message-State: AA+aEWbJvzPIr2meSA+MZsp4sp6YuJ7r/sQCNZSVmtTbej4YJ98FG/R0
        XuWtjWfS75fnOJ+2KE4M6miKrrvjhfi8Ux/HIbk=
X-Google-Smtp-Source: AFSGD/WCM5TQMRZLYmU/DT5Vcx2iAEN58rY6k1Sj9drFCxAh1iwNp4t+ljPwQ3rilA3Sz8jVW6L2sESO8zdFcXrEHZY=
X-Received: by 2002:a1c:66c5:: with SMTP id a188mr605099wmc.129.1544729641513;
 Thu, 13 Dec 2018 11:34:01 -0800 (PST)
MIME-Version: 1.0
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 13 Dec 2018 11:33:29 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
Message-ID: <CAGp9LzpcRCMWSn-u6K6+eRT=Zr8PR22Vd381miyhVYbF87N02g@mail.gmail.com>
Subject: Re: [PATCH] eint: add gpio vritual number select
To:     chuanjia.liu@mediatek.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hongkun.cao@mediatek.com, youlin.pei@mediatek.com,
        eddie.huang@mediatek.com, zhiyong.tao@mediatek.com,
        hailong.fan@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
>
> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>
> This patch add gpio vritual number select,avoid virtual gpio set SMT.

s/gpio/GPIO/
s/vritual/virtual/

Virtual GPIOs you said here that means these pins only used inside SoC
and not being exported to outside SoC, right? It seems this kind of
pins doesn't need SMT.

>
> Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> ---
>  drivers/pinctrl/mediatek/mtk-eint.h              |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mt8183.c        |    1 +
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c |    9 ++++++---
>  3 files changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pinctrl/mediatek/mtk-eint.h b/drivers/pinctrl/mediatek/mtk-eint.h
> index 48468d0..c16beaf 100644
> --- a/drivers/pinctrl/mediatek/mtk-eint.h
> +++ b/drivers/pinctrl/mediatek/mtk-eint.h
> @@ -37,6 +37,7 @@ struct mtk_eint_hw {
>         u8              ports;
>         unsigned int    ap_num;
>         unsigned int    db_cnt;
> +       unsigned int    vir_start;
>  };
>
>  struct mtk_eint;
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mt8183.c b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> index 6262fd3..bbeafd3 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mt8183.c
> @@ -497,6 +497,7 @@
>         .ports     = 6,
>         .ap_num    = 212,
>         .db_cnt    = 13,
> +       .vir_start = 180,
>  };
>
>  static const struct mtk_pin_soc mt8183_data = {
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4..ca3bae1 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -289,9 +289,12 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>         if (err)
>                 return err;
>
> -       err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> -               return err;
> +       if (gpio_n < hw->eint->hw->vir_start) {
> +               err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
> +                                      MTK_ENABLE);
> +               if (err)
> +                       return err;
> +       }

The changes will break these SoCs without a properly configured vir_start.

If SMT seems unnecessary for these kinds of virtual GPIOs pin in the
path, we can do it as

err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT,
                                        MTK_ENABLE);
/* please add comments for the exclusion condition */
if (err && err != -ENOTSUPP)
        return err;

If there is getting much special on certain pins between SoCs, and
then we can consider creating a desc->flag to split logic.

>
>         return 0;
>  }
> --
> 1.7.9.5
