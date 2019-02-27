Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E091C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FEB12084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ELV/TTBD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfB0Jnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:43:53 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:39998 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfB0Jnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:43:51 -0500
Received: by mail-ua1-f68.google.com with SMTP id c5so14734862uaq.7
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 01:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NuE7f8hluMKXVlyzklvAjPoVCgzdcVddjGtN9L8CxBc=;
        b=ELV/TTBDfPkzqeWiERp4ZSZ4FFxnKZSq6L9WVd2aaqXI8RkirE9LHn0sRiAkOLK57R
         f0EwM7ZIG/sGnMic32NzxuuIGA/Myw2x9MTn3vFfMNatrRN0c12In8Yr5P5Fv0JbCxg3
         D5kZrF5OB9/dyGcxGMGX5kWUwPCoBxJjPLP3Gtw9THP3/NNpvk8pmMZ0uAurLE8Fn1a3
         HcZlCo+OcPmvPxvuCRBnR2rx6+MeH7wmkBQ2LvUx5BqfuuU3tKuTtYJ37MrfhX7GiaSd
         cc9QupPtwLD3AqM0IIBsaay6/8x2kZeOCPnByxJzwLn/ubytuuGRAfw41jAiupoQzbSV
         OBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NuE7f8hluMKXVlyzklvAjPoVCgzdcVddjGtN9L8CxBc=;
        b=iUWVjlsSghpkfbLj7Ngo7h1B5X04/Z3dEFmdIOwqQezxFMBrps0aqHboSz6obh2lRl
         wceCS5bTw097ivD4ApZyC9WHzMC0mSr+IJReB5kMGE1p2VwPDjG50/p8w4wuiwDGmhae
         wz27LAzmqTP2AbYIEr+/RXHDr1ctWUeKw9G1i/80I1+jGRaMCSUUsy+fouLaYE7AbhvD
         fUIC/eVyZ+M/7hc1cBn42ijjEjnXKcCpP6ZaPQGUtjODifl2ah2JOBPxQBv5+j5cOn64
         N2a8Rs7c0Rmp8V8EVDUh6zpFX6vyh7ffhs+vq6paF7aPsmwXs+OznIcRBo3NvX/ZYVCi
         yiog==
X-Gm-Message-State: AHQUAuanfXQjyLz+Vc1tmGCSMrd6/kubMv6/xYWbTBvGsEnt04NAMF4O
        zKWwqJLKZ6A10lLHwFNA0xyJb4ZUATH3+L1knzLrLQ==
X-Google-Smtp-Source: AHgI3IbPOn9PutlZ0JrGamvyb4AU96WnDODh9jywZCbbwsCycgBOyK6bg5deb5W1RTXZFwyjGwnRXaQ6eM6nRVIk7Ss=
X-Received: by 2002:a67:768f:: with SMTP id r137mr941155vsc.35.1551260630565;
 Wed, 27 Feb 2019 01:43:50 -0800 (PST)
MIME-Version: 1.0
References: <20190226082200.4f7aa469@canb.auug.org.au>
In-Reply-To: <20190226082200.4f7aa469@canb.auug.org.au>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 Feb 2019 10:43:15 +0100
Message-ID: <CAPDyKFoXY2wx+HoVEJuPGEJnmUYYK+sCEGEDWhAKJ9bV5zytkg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the mmc-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Takeshi Saito <takeshi.saito.xv@renesas.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Simon Horman <horms+renesas@verge.net.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Feb 2019 at 22:22, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Ulf,
>
> After merging the mmc-fixes tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>
> drivers/mmc/host/tmio_mmc_core.c: In function 'tmio_mmc_start_data':
> drivers/mmc/host/tmio_mmc_core.c:706:34: error: 'SZ_64K' undeclared (first use in this function); did you mean 'EM_68K'?
>   if (host->mmc->max_blk_count >= SZ_64K)
>                                   ^~~~~~
>                                   EM_68K
> drivers/mmc/host/tmio_mmc_core.c:706:34: note: each undeclared identifier is reported only once for each function it appears in
>
> Caused by commit
>
>   063f8fee9927 ("mmc: tmio: fix access width of Block Count Register")
>
> I have reverted that commit for today.

Thanks for letting me know and sorry for the inconvenience! The
offending patch is now amended and should be fixed.

Kind regards
Uffe
