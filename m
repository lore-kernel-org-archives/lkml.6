Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FCAC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155C72081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 08:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGtliGwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155C72081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725897AbeLCIDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 03:03:04 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40942 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeLCIDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 03:03:04 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so6766887qki.7;
        Mon, 03 Dec 2018 00:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pCDnmI9ZajYzL0DVgSeswCNDMAg2Wif+qP3n60XE05c=;
        b=fGtliGwka88M1BkxI0dZoEJ38s3Zf9n/Vm4noIC0dVX5sdfJqN/xZxEGjNShgo9SYo
         ty29CdhYLrBtRB9s350zpQc+RtFJnbg0Ql3dGS8e+J7kL3P2ZcPezhFaYjuUgBuhhX+I
         WXGswe8TbUZOEZ5V58fFlWacp2nWTegZQ4P06y2u3xAVXB+BEoN7smazknym1D+VHmcb
         a5MUgc7FuRUX/MCHnyCdILw8Ln+kITI8/QMEj2IgAwrZJnNYE1SkBG/4ODBGi1HHRsns
         eyaU0lBhbYpg9qrRvoPXksX7S8FFk2nITMxXWKSLIMTzBqdRLhjAlGZBzrU5ZM61+fx3
         gtkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pCDnmI9ZajYzL0DVgSeswCNDMAg2Wif+qP3n60XE05c=;
        b=ubsWENo2U/nsL6bzjPH5jiDw3ayExOOc2unpz6G//3Oc89fyt7kQwwRrwlwHMkD+1t
         kYL3nNzayT2KQ7EpdfaYlY/5zN568B1NPjD9zzbIw5weZBkffGgqGgDqx7Av9bAQnkCW
         0w4o44Sc8ZN+Cz6WktSTY6aw8oI1ISiqt4atKXye9/WsNLqMe6GS5o3eS84i/WIU3vVs
         PpgxyY+uzNMJPy4FB3feXarjiXBqEQPsH4lkUnssJCOVUX/2D+UujG2dqFG8p03jAmU9
         2FlrYc4xMs7KH8L3E8VHVR5LxGIStv5hcGcsomwcStb1c7Eb7jMKWsru1kPicwGgLueC
         kUDA==
X-Gm-Message-State: AA+aEWYvKWWlBFQxk1nTBBbEmFVpA/L/LZ/VHE9E3HXlw08RFDS56y6L
        9hDcLTtGh5Thfc4dS2ckd2OV93N5v/OffDN7INg=
X-Google-Smtp-Source: AFSGD/XExFBoCoOC9l+GWR0q/y0I1d0dXhaRaNgjQ39qYin6G5sEG+feYBYQg8o8bSIiQArtmtwDLX1TZ4zp/ITQuF0=
X-Received: by 2002:a37:c3c3:: with SMTP id r64mr13829678qkl.70.1543824180440;
 Mon, 03 Dec 2018 00:03:00 -0800 (PST)
MIME-Version: 1.0
References: <20181203034515.91412-1-chenyu56@huawei.com> <20181203034515.91412-6-chenyu56@huawei.com>
In-Reply-To: <20181203034515.91412-6-chenyu56@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 10:02:49 +0200
Message-ID: <CAHp75VcbNumAGa8NsYp9tL-ZRP4stApuTFtY1LARHMnJjxA4dw@mail.gmail.com>
Subject: Re: [PATCH v1 05/12] usb: dwc3: Add two quirks for Hisilicon Kirin
 Soc Platform
To:     chenyu56@huawei.com
Cc:     USB <linux-usb@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        Kongfei <kongfei@hisilicon.com>, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        John Stultz <john.stultz@linaro.org>,
        Wangbinghui <wangbinghui@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 5:48 AM Yu Chen <chenyu56@huawei.com> wrote:
>
> There are tow quirks for DesignWare USB3 DRD Core of Hisilicon Kirin Soc.
> 1)SPLIT_BOUNDARY_DISABLE should be set for Host mode
> 2)A GCTL soft reset should be executed when switch mode

> +static void dwc3_gctl_core_soft_reset(struct dwc3 *dwc)
> +{

> +       int reg;

u32? int for register value looks confusing a bit.

> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> +       reg |= (DWC3_GCTL_CORESOFTRESET);
> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +
> +       reg = dwc3_readl(dwc->regs, DWC3_GCTL);
> +       reg &= ~(DWC3_GCTL_CORESOFTRESET);
> +       dwc3_writel(dwc->regs, DWC3_GCTL, reg);
> +}

> +       int reg;

Ditto.

-- 
With Best Regards,
Andy Shevchenko
