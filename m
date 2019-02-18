Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E430C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7F621773
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:21:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M21+OBWi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730222AbfBRMVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 07:21:47 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36861 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729016AbfBRMVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 07:21:47 -0500
Received: by mail-pf1-f193.google.com with SMTP id n22so8491273pfa.3;
        Mon, 18 Feb 2019 04:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2j/oBaZCiq+xOkeLNGc1ekqebREDWrcHBnEk9AWy/4=;
        b=M21+OBWiiaq/yIq6GU5CA2hU7a9P30ovwq2pJn7i4FmDSxjOZoJijXiirn0JS+wiFR
         cX8WJ0gvHvdMly/xHE/NkxxdCyjccbHcrTyjCJl/S9tm9nH28ES8+oGbUhhV/lpYJ2x+
         Ev7vWawlViCjeH5sez63ewRTOUH1ff8iA5a9bbACaOd3WSB1WpSr5oM2RTyQUtJyZN+R
         Bf7sLteOiSnQUOgxm8Rvg9TEV5UZZT9DJH7nrhkPMw19qd7AsKv74sDs9pOR5mAUeoXa
         rwujaP2YtlniYmc0wqNbPRAsN+FnKU13NSrTgsGJFH/tFRt/nuFbGGndiXjMENiVp1JW
         nlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2j/oBaZCiq+xOkeLNGc1ekqebREDWrcHBnEk9AWy/4=;
        b=WhyO8/XxCSrcaKAcbNj93s14k43rdcEuorWmsl/0+CMr0MAk+RThcSTI2kAIj/Gj3z
         mC9N2t5pw9dQ3k88K65bum0LKBEVCSygtPdyrIJ70jvUlSDfhnXo191ODZjR80rlIGOB
         IE9tmPVynxveROYdyeGia0EjcS4bBiuDdVdGIYeLPAMqHhhIMgtbU0Wb9WHCfLnX65eP
         6aJvpLIWM6QL/T7MeoGgRshoknN8D16U8z2IRMmZp3S+X/WUlnoRJ69vzBGzKs4yGa5Q
         SpygU+7scXEYXIjAbgrQWS6f+S5nbWvTKcQgLGxNxm6buo9bU9fMt+rehgQncS4GHxNy
         xVfQ==
X-Gm-Message-State: AHQUAuYFoUAh1e+emLkfCqwyu2rfBzGO+3pya/mq72v7DAAXNWOg2BCr
        q7hU/voqLT5OB1fP1WZO410nvX58UMUYdYWnyBs=
X-Google-Smtp-Source: AHgI3IZY+7QI8ksBc7C7eNGhNdFi2t2AYkeqNgE4u7+Mmr6llJ3bJkNKdlp5k0WWosuKBGUk5uiy/io3iU4hazIw7fg=
X-Received: by 2002:a63:1a25:: with SMTP id a37mr4358197pga.428.1550492505854;
 Mon, 18 Feb 2019 04:21:45 -0800 (PST)
MIME-Version: 1.0
References: <20190218112310.17860-1-chenyu56@huawei.com> <20190218112310.17860-5-chenyu56@huawei.com>
In-Reply-To: <20190218112310.17860-5-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Feb 2019 14:21:34 +0200
Message-ID: <CAHp75VdrSyORjd0OXS11poCL-3PofgsiejzgZ=m56sZegfGyMw@mail.gmail.com>
Subject: Re: [PATCH v2 04/10] usb: dwc3: Add two quirks for Hisilicon Kirin
 Soc Platform
To:     Yu Chen <chenyu56@huawei.com>
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, liuyu712@hisilicon.com,
        wanghu17@hisilicon.com, butao@hisilicon.com,
        Yao Chen <chenyao11@huawei.com>, fangshengzhou@hisilicon.com,
        lipengcheng8@huawei.com, songxiaowei <songxiaowei@hisilicon.com>,
        xu yiping <xuyiping@hisilicon.com>, xuyoujun4@huawei.com,
        yudongbin@hisilicon.com, zangleigang@hisilicon.com,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Binghui Wang <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 1:23 PM Yu Chen <chenyu56@huawei.com> wrote:
>
> There are tow quirks for DesignWare USB3 DRD Core of Hisilicon Kirin Soc.
> 1)SPLIT_BOUNDARY_DISABLE should be set for Host mode
> 2)A GCTL soft reset should be executed when switch mode

Thus, it must be two patches, no?

> +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
> +{
> +       u32 reg;
> +
> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);

> +       reg |= (DWC3_GCTL_CORESOFTRESET);

Redundant parens.

> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +
> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);

> +       reg &= ~(DWC3_GCTL_CORESOFTRESET);

Ditto.

> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +}

> +static void dwc3_complete(struct device *dev)
> +{

> +       struct dwc3     *dwc = dev_get_drvdata(dev);
> +       u32             reg;

Indentation style is different to the other functions in the same patch.
Use simple space here.

> +       if (dwc->current_dr_role == DWC3_GCTL_PRTCAP_HOST &&
> +                       dwc->dis_split_quirk) {
> +               dev_dbg(dwc->dev, "set DWC3_GUCTL3_SPLITDISABLE\n");
> +               reg = dwc3_readl(dwc->regs, DWC3_GUCTL3);
> +               reg |= DWC3_GUCTL3_SPLITDISABLE;
> +               dwc3_writel(dwc->regs, DWC3_GUCTL3, reg);
> +       }
> +}

> --- a/drivers/usb/dwc3/gadget.c
> +++ b/drivers/usb/dwc3/gadget.c
> @@ -269,7 +269,7 @@ int dwc3_send_gadget_ep_cmd(struct dwc3_ep *dep, unsigned cmd,
>  {
>         const struct usb_endpoint_descriptor *desc = dep->endpoint.desc;
>         struct dwc3             *dwc = dep->dwc;

> -       u32                     timeout = 1000;
> +       u32                     timeout = 5000;

I don't see anything about this change in commit message. Moreoever,
it looks like it must be a separate logical change with its own
description.

>         u32                     saved_config = 0;
>         u32                     reg;


-- 
With Best Regards,
Andy Shevchenko
