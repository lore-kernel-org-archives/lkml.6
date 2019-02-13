Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447ECC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08D4F222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:35:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S+mAqM0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731418AbfBMMfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:35:21 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33060 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbfBMMfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:35:20 -0500
Received: by mail-lf1-f68.google.com with SMTP id q12so1671897lfm.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aj4FwLyMuUozNVbO9F2S0UM6EjpblZStbiitkn8Ar2M=;
        b=S+mAqM0FKb+y8IczZrrGArOxZP8MOZqvJv+V2Xz8GQdxplQDDlZJKvfGeNOAjS0EWy
         OAkLqPh+2k6HMycpP9jspkcmZyY0fXau2U+3qaqJosc5wTBJs1QaV6bZBaGBB47nSctt
         oPKlGJKscapm7Qz1MxyE6eI1CqLuXIN6wR7K70TfpOhIx1WZFsDboGEl/oeHCCY3eE3E
         6igRg/aDVBrNSkHY5oQp+lt5JrtAVX5UDIcCo0oRbDrh0IRfwNgTAZYwGuyZG8DsqcoS
         iqYyC8+yF7zdkGa8H7DNb9qyBimd/6JIU/m6JzOWQ2RPtmlrjlXZCIb4qPZ8aflUY2G5
         QZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aj4FwLyMuUozNVbO9F2S0UM6EjpblZStbiitkn8Ar2M=;
        b=Uks2SjVcwVgK3NQ7TmKYAd9Gob8kBB+4QDdlwqrX2x8sEBlNMcGVeRCSy2T/01jmgS
         MGq3Q1h5XZ6D5EVDrhpiF64zqfYETjTnMyGYfYzg4AFw7AoiNQpCB0xuVk+q+N7wAIox
         FcksS/Nok9IOQYfefJh9Mom9egYZnHLiavY9O6N4dEJBxrFUtAsvewGrzMeWaRUhraFY
         aw8BfSFRmnV+dfC74NAvWhOsi1ZeH/2mGXita6oQbJ9zpIUdbipEd013UIt+ogt1KayI
         99g+xHTjUidMnRjsMTSYS4z1zpRlVTxdZLoZBkT1srQpPG9wu/Pb1uz1fGPA+1VLTtZs
         4ZZQ==
X-Gm-Message-State: AHQUAubzI2jQ3D+JOBFv7iQJ2Xc0mJZOllgmyQDB1z7rC5dvIeHtgffb
        1IIr4cmZ85Sl7As3d6OSm0ezZ4oPRCWR5Tjs5zd8Ag==
X-Google-Smtp-Source: AHgI3IbPtFLZT9mNhKd6IQP71cXun87GeXwst/WAQzOdNceW3KRc3OxGQYSfVfShiV/6O+ey1N9bZhdVizcjTzYC/TE=
X-Received: by 2002:a19:5205:: with SMTP id m5mr173188lfb.61.1550061318196;
 Wed, 13 Feb 2019 04:35:18 -0800 (PST)
MIME-Version: 1.0
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
 <3f9d23d4b250c5046f8c3411606aa9ffe807edd8.1550043082.git.baolin.wang@linaro.org>
 <20190213122012.GE7540@sirena.org.uk>
In-Reply-To: <20190213122012.GE7540@sirena.org.uk>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 13 Feb 2019 20:35:06 +0800
Message-ID: <CAMz4kuJL2OTkeik5gR1NnxzSAxY6QcQp9wRTcft-DX8oknY+eg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] spi: sprd: spi: sprd: Add DMA mode support
To:     Mark Brown <broonie@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 at 20:20, Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 03:36:11PM +0800, Baolin Wang wrote:
>
> > +enum sprd_spi_dma_channel {
> > +     SPI_RX,
> > +     SPI_TX,
> > +     SPI_MAX,
> > +};
>
> It'd have been better to namespace these (SPRD_SPI_ or something) in
> case of conflicts.  That's really minor though and everything else looks
> good so I'll go ahead and apply, thanks!

Yes, I'll send one incremental patch ASAP. Thanks for your reviewing.

-- 
Baolin Wang
Best Regards
