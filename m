Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C2AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED593218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 19:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545938161;
	bh=siPBobBc8ANH4OmhcEB4D7rA7WVJff/bLBSWLKVb3hc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=HsVeDBDL2n2QOUgJllfrAAB6a4kwJEEz6N6ePLkUMszH+IR/gVvnehAt4v16WvK3Y
	 yfgh4NGWbRMnZ6yPfLTzZNKdpVNZ/mvuZwbV0GUXVeykiKePtWJuD0JaJfWJxcQfYo
	 ZVBBIB8E4WS2WL/GoGD27T/IwrubkSQmKDGEMucE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbeL0TP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Dec 2018 14:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55850 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbeL0TP5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Dec 2018 14:15:57 -0500
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F29921901;
        Thu, 27 Dec 2018 19:15:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545938156;
        bh=siPBobBc8ANH4OmhcEB4D7rA7WVJff/bLBSWLKVb3hc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VJnW4UmVJIWyha0qlm7hNlC/qOnc8ecpqxeViWR6MedA1pK2KSTYEZ5l3HcKhVMB8
         Ez3q9x8adRP/6alBn1QfOFCxYjzZrdWg27I0g4p2zZ7LOroxldwpo1pxqCuWgvQp3L
         S9eiPqxm2k4+8Hn6ZxKCCRq7WcjbXU9kTHsqZjlc=
Received: by mail-wm1-f48.google.com with SMTP id f81so18167759wmd.4;
        Thu, 27 Dec 2018 11:15:56 -0800 (PST)
X-Gm-Message-State: AA+aEWYpvSXlOcvAnSX92Kem476iWVcBbHNNed5mGKInz5OeY+Pva6lT
        2jcVUz0OQZWMS1/OALjjmx3TjdmbUUuisElPhuE=
X-Google-Smtp-Source: ALg8bN7Z0Enf3Jd1j2MB14s0qNayIYPSOCaKyOO6M9g+8FRePHkiBxXsTr97jNViED+kuQwmsr3gMQDv/6RyRgi1Kn8=
X-Received: by 2002:a1c:2e43:: with SMTP id u64mr22911478wmu.52.1545938154592;
 Thu, 27 Dec 2018 11:15:54 -0800 (PST)
MIME-Version: 1.0
References: <1545711838-20444-1-git-send-email-chuanjia.liu@mediatek.com>
In-Reply-To: <1545711838-20444-1-git-send-email-chuanjia.liu@mediatek.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Thu, 27 Dec 2018 11:16:09 -0800
X-Gmail-Original-Message-ID: <CAGp9LzpRrXzikwn91oW_qZ76MK2RePR-npQsca9_Q3g38xdUpA@mail.gmail.com>
Message-ID: <CAGp9LzpRrXzikwn91oW_qZ76MK2RePR-npQsca9_Q3g38xdUpA@mail.gmail.com>
Subject: Re: [PATCH v3] pinctrl:mediatek:add EINT support to virtual GPIOs
To:     chuanjia.liu@mediatek.com
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        youlin.pei@mediatek.com, eddie.huang@mediatek.com,
        zhiyong.tao@mediatek.com, hailong.fan@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2018 at 8:25 PM <chuanjia.liu@mediatek.com> wrote:
>
> From: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
>

there are still some nitpicks

an empty char should follow the ':' char

> Virtual gpio only used inside SOC and not being exported to outside SOC.
> Some modules use virtual gpio as eint and doesn't nedd SMT.

s/nedd/need/

> So this patch add EINT support to virtual GPIOs.
>
> Signed-off-by: Chuanjia Liu <Chuanjia.Liu@mediatek.com>
> ---
> change note:
> v3 : 1. modify subject and description
>       2. modify comments
> ---
>  drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> index 4a9e0d4c2bbc..a0db145f798d 100644
> --- a/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> +++ b/drivers/pinctrl/mediatek/pinctrl-mtk-common-v2.c
> @@ -290,7 +290,15 @@ static int mtk_xt_set_gpio_as_eint(void *data, unsigned long eint_n)
>                 return err;
>
>         err = mtk_hw_set_value(hw, desc, PINCTRL_PIN_REG_SMT, MTK_ENABLE);
> -       if (err)
> +       /*

merge the second line to be consistent with the other comment blocks

> +        *SMT is supposed to be supported by every real GPIO and doesn't

an empty char should follow '*' char to be consistent with the other
comment blocks
and also in the other lines starting with '*'

> +        *support virtual GPIOs, so the extra condition err != -ENOTSUPP
> +        *is just for adding EINT support to these virtual GPIOs. It should
> +        *add an extra flag in the pin descriptor when more pins with
> +        *distinctive characteristic come out.
> +        */
> +

remove the blank line

> +       if (err && err != -ENOTSUPP)
>                 return err;
>
>         return 0;
> --
> 2.19.1
>
