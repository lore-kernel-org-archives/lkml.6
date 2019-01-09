Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0437BC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C367520665
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 18:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0suuRRY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfAIS2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 13:28:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46661 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726471AbfAIS2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 13:28:03 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so7322588ljh.13
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 10:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8RJuycZFVnX/932+Qivq9pRyV9V81OMvCpk9Z/FH5yk=;
        b=e0suuRRYxRZfYJ0095LKqRW5UyRompvFzbKYpIO+ErTQMD5I0Zq0s2uU1PCr/oJ3ke
         +3lEGx6+Ea6HFOd363en13nx/v4X/1bOagcFbTKvsATwVdp66/Enge++G82yrfepjXQP
         camKmoPs5YpUWQ3A2sePy/CBMczdOqopSsnNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8RJuycZFVnX/932+Qivq9pRyV9V81OMvCpk9Z/FH5yk=;
        b=j1P66Zk+RXNLkS1WFxDVpoUfeTmW1PnvZOMLezMVYODHOIGGzE/kadBl14k8UiwhxK
         tRsbXE3OraNoD8nrlkX7yfHco6ABgx/fbHCZGmyvNF7qA59Z7qLzfdnA4LaWd0akuUCU
         AaQUn6f2ktcp6LkWSui8GtPk66X2kxhK2E3ReAYKOIDT83KJLze7jjXARYGHwJtRvPVI
         MIYn3aAFd//kt++sdV8cf8738e34+Dg/udnJspRHmaX2NtPnnRPa9Ok6lVOqWIduy4nj
         TJHV13dmJdQuUGc9wmDCFNzIwQQEP6OSMX4qlUu4oLPcB/kOHhZHyl9ujwg33Bt4XBnd
         +vdQ==
X-Gm-Message-State: AJcUukfKt6vr76yIeTI8zFPAW2L9DPd0cb7y2ZErmMBBmaSy3yfjKQXW
        AH1PXI8jzZ3objGHO56G1XusG4FsDxg81D5dKZIqdw==
X-Google-Smtp-Source: ALg8bN4EuzDZSDDC3fZTwgwqZYW1ZaHKTlfwBCyaACJ7fNnndSMSPKqNxMN4OpMtlZShpdi92D66Pz15wznCrYfwOak=
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr4120473ljg.23.1547058481240;
 Wed, 09 Jan 2019 10:28:01 -0800 (PST)
MIME-Version: 1.0
References: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org>
In-Reply-To: <1547056892-16527-1-git-send-email-vincent.guittot@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 9 Jan 2019 19:27:48 +0100
Message-ID: <CACRpkdbA8cvoaG_5=JCrpQd2k1HYRxUjqGsoGJLLvroGGQukkA@mail.gmail.com>
Subject: Re: [PATCH] arm64/hisilicon: fix SDcard detection
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Xu Wei <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent!

On Wed, Jan 9, 2019 at 7:01 PM Vincent Guittot
<vincent.guittot@linaro.org> wrote:

> commit 89a5e15bcba8 ("gpio/mmc/of: Respect polarity in the device tree")
> has changed how cd_gpios phandle and cd-inverted are used to set gpio's flags.
>
> Since this change, hikey960 SDcard is not detected anymore because flags
> are not set correctly. Updating cd-gpios to set GPIO_ACTIVE_LOW instead
> of high, fixes the problem.
>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

Please check if this patch fixes your problem:
https://marc.info/?l=linux-mmc&m=154637189021211&w=2

> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -582,7 +582,7 @@
>         sd-uhs-sdr104;
>         disable-wp;
>         cd-inverted;
> -       cd-gpios = <&gpio25 3 0>;
> +       cd-gpios = <&gpio25 3 GPIO_ACTIVE_LOW>;

This is also a good change, but the old device tree should
continue to work so we need to fix the real bug.

If you also remove "cd-inverted" above, this patch should
hopefully still work and be fine to apply as well.

Yours,
Linus Walleij
