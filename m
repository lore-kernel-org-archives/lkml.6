Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3456C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F1F12082F
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:44:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SWxaXWCf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F1F12082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeK3Wxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:53:53 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:34735 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726473AbeK3Wxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:53:53 -0500
Received: by mail-vs1-f66.google.com with SMTP id y27so3158212vsi.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 03:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfGBLwjoprYk9UKLztyEYMY3kS/F2jQg2rNXpAjWL0c=;
        b=SWxaXWCf90RC/viOeI8KLUnANscg8zyNRAF4DNDeI2aRRhgW/bjaAVO0yYK+kPYndQ
         FwumgLU1JctR6jZayR4v38oyETvM7YcEKkYpKgBkXN9XeWP0OYf6rF9Xf/Rbt2fJHxAu
         ey/CTbzSxeUHtKVf+jJsmhuPiReBbxihRKUwz4efq+9MsxKdlsF+4Rlm0zODqNSkzp/7
         1V+DKALTN5n8cixAUIDUkWI1C8I+vSdG3jQnxynTDd48uYvKYZslkzErkRih7NoE4Hnu
         hU9EWUSEl+o5ClYlRfE2uNWxL+MeBjnVIIMYvN9JfXwHK3IYtkk4UAosl5JcFT8dFHwH
         NOAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfGBLwjoprYk9UKLztyEYMY3kS/F2jQg2rNXpAjWL0c=;
        b=TAmSdzHxeL5f+dMFrrCwFFaPv8YbwaZ3nFH9mEBvelPvOHPrz6PqU5hrjS6FyrgdeO
         mGln5fpbEqAYHbyYmAdEg8AoheZYrJ0fMOhh+cCxU+XFgLGd3GR67bp2uK1dQqUhgTZr
         DA/Ryuae3hov8QEVfXhcAPuGHuxwoq1w0G9hZaBc4qOk5by+v+5rZ3pSFVA7xPf8nlcE
         au69naHm12Fp84eL2u2grefWk3fVMicbLcOGcX7vVlSUflJBoQUU6u84tcbbwfdvfhta
         qLP4xwHH0MQfFHc21wkV8dh4HKMTG6o9D88WUhJyfqQqZ8cpmuSd/nsRAMzgzoaEfGAj
         8swA==
X-Gm-Message-State: AA+aEWb16oDigAqJ6Cy9XllfOzowiV8xWM+HpSHKRna9Aef38d3Gv2Vz
        Qp2rsnCk0g/y1paCjJBtCsNnMc64Twv4AkttrKe6YOFWpfTT
X-Google-Smtp-Source: AFSGD/UXdTJx7sh2NfJG7XBJXLmAn7HdewZ7ZKdKEcvvI9nbKaRrW4Gi0vfsyUWs2URKCtox8w4Xm2a/mSSkwIBI9HU=
X-Received: by 2002:a67:2a83:: with SMTP id q125mr2350849vsq.230.1543578292331;
 Fri, 30 Nov 2018 03:44:52 -0800 (PST)
MIME-Version: 1.0
References: <CALjTZvZzHSZ=s0W0Pd-MVd7OA0hYxu0LzsZ+GxYybXKoUQQR6Q@mail.gmail.com>
 <20181130103222.GA23393@lst.de>
In-Reply-To: <20181130103222.GA23393@lst.de>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 30 Nov 2018 11:44:41 +0000
Message-ID: <CALjTZvZsk0qA+Yxu7S+8pfa5y6rpihnThrHiAKkZMWsdyC-tVg@mail.gmail.com>
Subject: Re: use generic DMA mapping code in powerpc V4
To:     hch@lst.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 10:32, Christoph Hellwig <hch@lst.de> wrote:
>
> Hi Rui,
>
> can you check if the patch below fixes the issue for you?
>
> diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
> index 2e24fc87ed84..809797dbe169 100644
> --- a/arch/powerpc/sysdev/dart_iommu.c
> +++ b/arch/powerpc/sysdev/dart_iommu.c
> @@ -392,7 +392,9 @@ static void pci_dma_dev_setup_dart(struct pci_dev *dev)
>
>  static bool iommu_bypass_supported_dart(struct pci_dev *dev, u64 mask)
>  {
> -       return dart_is_u4 && dart_device_on_pcie(&dev->dev);
> +       return dart_is_u4 &&
> +               dart_device_on_pcie(&dev->dev) &&
> +               mask >= DMA_BIT_MASK(40);
>  }
>
>  void __init iommu_init_early_dart(struct pci_controller_ops *controller_ops)

Hi, Christoph,

Thanks for the quick response! I applied it on top of your
powerpc-dma.4 branch and retested.
I'm not seeing nouveau complaining anymore (I'm not using X11 or any
DE, though).
In any case and FWIW, this series is

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks,
Rui
