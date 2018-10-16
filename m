Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA282C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD1F21470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:15:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD1F21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbeJPMDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:31 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36706 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729632AbeJPMDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:31 -0400
Received: by mail-ed1-f65.google.com with SMTP id c26-v6so19920294edt.3;
        Mon, 15 Oct 2018 21:15:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mchOHdN/gue70RugbaxUqQJWGq8zzoWIaYpYNAz3IUI=;
        b=gw51GlyOu7fptnVph6wLcbsWBVskwOecX12BcginTlN3cEsT/F4sVMm4P9Ibao4/xW
         fiKgEcwi85/cYHG1xiE+z4H0XaxS0+riO0viEkaLdaldK5diMDKaCMMqMH1CydME1R0G
         bE0ztegN44nPRbXQoNmv3rKSWXNjUpGitBslYr02dz+nAvlYCm1chte3mbBSo/z0FriN
         Utd8jxUoINvn7ZneJtlYsTsFopHTL7FhmNr3vI0iPI9i918CErB6w/3lxNb5T3fMi/Jg
         taY7BvygH9QzdH4V/bES/6P+k7Nx/5/TI+eY6hIjT5kI8i4MKCCNzlShMn9itgL5wisC
         8DhA==
X-Gm-Message-State: ABuFfohM0hLKhPMy8+J1z8/PHhz7vJI7Z+Y/s9c90IQoPflCa6krh037
        F0b56plLiTc74DEBZ/NeIs8/2wCfpNc=
X-Google-Smtp-Source: ACcGV61+M6zorMkhjGAhpVaq+TQirqsoe4OONOOcs8AVlbHiAr3XIQ1mb3PXIIFpU7XBXFsLAIH/4A==
X-Received: by 2002:a17:906:1504:: with SMTP id b4-v6mr21622672ejd.69.1539663306116;
        Mon, 15 Oct 2018 21:15:06 -0700 (PDT)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com. [209.85.221.47])
        by smtp.gmail.com with ESMTPSA id bq15-v6sm2566533ejb.52.2018.10.15.21.15.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 21:15:05 -0700 (PDT)
Received: by mail-wr1-f47.google.com with SMTP id n1-v6so23698355wrt.10;
        Mon, 15 Oct 2018 21:15:05 -0700 (PDT)
X-Received: by 2002:adf:edc2:: with SMTP id v2-v6mr15851122wro.208.1539663305208;
 Mon, 15 Oct 2018 21:15:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181013080848.29894-1-oskari@lemmela.net> <20181013080848.29894-5-oskari@lemmela.net>
In-Reply-To: <20181013080848.29894-5-oskari@lemmela.net>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Tue, 16 Oct 2018 12:14:53 +0800
X-Gmail-Original-Message-ID: <CAGb2v64HnH4UEUi2xRsAJS=EX0gTjikS+ai3M3WrG+6+A7P4JQ@mail.gmail.com>
Message-ID: <CAGb2v64HnH4UEUi2xRsAJS=EX0gTjikS+ai3M3WrG+6+A7P4JQ@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] arm64: dts: allwinner: a64: sopine: enable power supplies
To:     oskari@lemmela.net
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 4:09 PM Oskari Lemmela <oskari@lemmela.net> wrote:
>
> Sopine baseboard have ACIN and battery connectors.

The commit message should be more specific, like how the two connections
from the PMIC are routed. In this case ACIN is routed from the SOM to
the DC jack on the baseboard, while the battery pins are routed to a 3-pin
connector next to the USB connectors.

ChenYu

>
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
> Reviewed-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts    | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index c21f2331add6..335cf2263d19 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -69,6 +69,14 @@
>         };
>  };
>
> +&ac_power_supply {
> +       status = "okay";
> +};
> +
> +&battery_power_supply {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> --
> 2.17.1
>
