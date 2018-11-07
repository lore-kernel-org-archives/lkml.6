Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 712ACC32789
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 212A52086A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 02:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DOt2+2N4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 212A52086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389296AbeKGMYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 07:24:52 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44345 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388451AbeKGMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 07:24:52 -0500
Received: by mail-ed1-f66.google.com with SMTP id n19-v6so12210727edq.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 18:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V2wcfhy5y0AiMf7u809T/U+/OgtsEImPqt6IotOeUW8=;
        b=DOt2+2N4aUMpcYKov6owcCWtNoxhexX+9sA/BMu35HGsVJ3zhjn555f2n2Z4IUWxW0
         t61GhmaIA528S01Uk1uk5lgt4dh4KG2Fcm0zRxN1dhnDjjOUimuLjiBxp1QQ/3MPbXL/
         CvjMnxJhBMtF/ncAJvu++GMwvwtFmv3hB9p8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V2wcfhy5y0AiMf7u809T/U+/OgtsEImPqt6IotOeUW8=;
        b=ka3MP1KKLriX5LxRQ3nxDxmzzekt9sDSOvDcvxG9YP3Zhhc4JP2atZVgG+QufW2urL
         2tjIQAUsBCZlxTfRFdPKrltopF8czYc93nGCbZdRn6lTMmbI66phb6bCrf40r6LHPysz
         0H16V8EysRPb5GXSWbXWqmmyZgvAsmamuOTREjelXfLR7F1GP2Oh8vSNz90Bk5BmUnyu
         f4tx1MOtopaMVRjbSgYOqKbbAfCjDG9OcGev5T3duaj7kNODIsKnOwRWY24zyoIrKdCx
         89QB55OVHM3Ear+/kCvPpoMcewH4shkucXD8jqlu+iXUUR5Iy9I0L9yUFXJEf8YzNfm0
         eZdQ==
X-Gm-Message-State: AGRZ1gJsQT8GdBsHPHrzVnRB4pRBfDW6gYev9oLJLgWzWlBmG9coX4mR
        EGXfdYXbTkrSokDtqx/SZRpgA5TQgD7guo/xuyIbZw==
X-Google-Smtp-Source: AJdET5fMhhf8wTiWnIow32dHHiZ1Jx/8m7P+KK57eD095QDLcMKF92ps31Nd1J6jlg/2P4907phmqm3eBKqlerfuAK8=
X-Received: by 2002:a17:906:f6cc:: with SMTP id jo12-v6mr350157ejb.66.1541559387543;
 Tue, 06 Nov 2018 18:56:27 -0800 (PST)
MIME-Version: 1.0
References: <1541387810-24867-1-git-send-email-zhang.chunyan@linaro.org>
 <1541387810-24867-2-git-send-email-zhang.chunyan@linaro.org> <CAK8P3a2aUjLsP70zSjkavR4-mkV9iEVCw96Vces4N15Dno8SHw@mail.gmail.com>
In-Reply-To: <CAK8P3a2aUjLsP70zSjkavR4-mkV9iEVCw96Vces4N15Dno8SHw@mail.gmail.com>
From:   Chunyan Zhang <zhang.chunyan@linaro.org>
Date:   Wed, 7 Nov 2018 10:56:16 +0800
Message-ID: <CAG2=9p8ELyjbOx1Ez2LExpYA4bDh_2RcD68e0EV0DHpaPwjXPg@mail.gmail.com>
Subject: Re: [PATCH RFC 1/3] mmc: sdhci: add support for using external DMA devices
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Lyra Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Nov 2018 at 19:16, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On 11/5/18, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> > Some standard SD host controller can support both external dma
> > controllers as well as ADMA in which the controller acts as
> > DMA master.
> >
> > Currently the generic SDHCI code supports ADMA/SDMA integrated into
> > the host controller but does not have any support for external DMA
> > controllers implemented using dmaengine meaning that custom code is
> > needed for any systems that use a generic DMA controller with SDHCI.
> >
> > Signed-off-by: Chunyan Zhang <zhang.chunyan@linaro.org>
>
> Looks good to me overall, but I think I found one small bug:
>
>
> > +     dma->rx_chan = dma_request_chan(mmc->parent, "rx");
> > +     if (IS_ERR(dma->rx_chan)) {
> > +             ret = PTR_ERR(dma->rx_chan);
> > +             if (ret == -EPROBE_DEFER && dma->tx_chan)
> > +                     dma_release_channel(dma->tx_chan);
> > +
> > +             dma->rx_chan = NULL;
> > +             pr_warn("Failed to request RX DMA channel.\n");
> > +     }
>
> The error handling looks wrong here: if you get EPROBE_DEFER,
> you want to skip the warning message. If you get any other error code,

Right, will address.

> you want the warning message and also the dma_release_channel()
> which should be unconditional here.

Will address.

Thanks for the review,
Chunyan

>
>         Arnd
