Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65793C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30B8720811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 19:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544730737;
	bh=2i/AYWkFpEOlg+61T3YaTh6wAxl5PxRc41maMyWJSdI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WfuNBd9xzR45eKLxsR4nlZN7Ji4Q0mrHjJBIIysmQBdm80d0HM35XpD/twtmz0oqk
	 bmYLFghBUl9mXksp20y4E8V2GnIrvSJmkuKsiVmIVSGE8LOuTz6PWMdrlcJcYTASWI
	 Qr6ArL6qBNJ/V+jS3qjJRXE918tHFj7xL88zvKcA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30B8720811
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbeLMTwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 14:52:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:38028 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727707AbeLMTwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 14:52:15 -0500
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 023EB20880
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 19:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544730734;
        bh=2i/AYWkFpEOlg+61T3YaTh6wAxl5PxRc41maMyWJSdI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Xbp270yxIQfjK7fnpEcEFLXY3rrvmtoYlTjrFPOI5D38VqBBTcmFIfNne21rQ63nf
         R4CuDV1mPLjeEDgGM0kb6o05XcWIwee42ropA9edH0NXFSCRJFYe0AtJKO1UpsMNRD
         ChbWegpQtOd7VMCL9bTg/zcSfY6YaU5x/HGq/4e0=
Received: by mail-wm1-f53.google.com with SMTP id y139so3541999wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 11:52:13 -0800 (PST)
X-Gm-Message-State: AA+aEWYvQc35tEuDoLpWpCT820UxjOFSHdz5jb8sRukQD6wbpcqGwZ34
        317A1u2mB7nCHHjgwR73kHaJgPOipT0yYi2V+oI=
X-Google-Smtp-Source: AFSGD/VdKzErsmhgheAe4tPdHiaMdYZY63egoG/6rkOg2ATjLgHZOTebqJcMUFJM/049zlGxv5/3vDvS+xebT+lOLbU=
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr749046wmh.92.1544730732499;
 Thu, 13 Dec 2018 11:52:12 -0800 (PST)
MIME-Version: 1.0
References: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1544693783-25079-1-git-send-email-chuanjia.liu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 13 Dec 2018 11:51:40 -0800
X-Gmail-Original-Message-ID: <CAGp9LzrTZjEPLKEB+OwSVbLx=KBQRFVmN41KDqj_xTJ5oyU0KQ@mail.gmail.com>
Message-ID: <CAGp9LzrTZjEPLKEB+OwSVbLx=KBQRFVmN41KDqj_xTJ5oyU0KQ@mail.gmail.com>
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

And the subject should be also corrected with prefix starting with
"pinctrl: mediatek:", typo fixup, and having a better subject close to
the content.

On Thu, Dec 13, 2018 at 1:36 AM <chuanjia.liu@mediatek.com> wrote:
>
> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>
> This patch add gpio vritual number select,avoid virtual gpio set SMT.
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
>
>         return 0;
>  }
> --
> 1.7.9.5
