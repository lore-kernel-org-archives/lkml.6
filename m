Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF41C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:58:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05CDE20664
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 02:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05CDE20664
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeKAL7O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 07:59:14 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:46130 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbeKAL7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 07:59:14 -0400
Received: by mail-ed1-f67.google.com with SMTP id f8-v6so3042229edt.13;
        Wed, 31 Oct 2018 19:58:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zgisRCV7WprzjyjHeJ4yDeufOhf92w0vAj4pVGcHgqo=;
        b=fLzB3cxVVRs/p3Eo/KextWOAD9W8WLSTka5xviQ6ToFtK+Iz+M1c/MK1P6uT7sXN3l
         8GOG1inf4ArVMTL0FK2VDdcJlBNdHcE2WqdASAF/HaDNQFhGZ/iGBKssNES77vQNE12v
         jAW7i/4o6mfpBDpPl7oR7TT/RUB1lpyM4QWieSof9W+jLupYhZg2yMl5V1WSAT2qXlYw
         uXY/mAKS0T+pGUFdJmh32Qv4dXCoSzZv1mP+d9Gi8hdEEJZFZTvEX2Bogkd0eyO6wZod
         anVusX4KfUaawrjksjpBvtEHjKq46kTQfFTQ+lFqBnKPEhe+ggckGwiB4rW2qGlW/ziV
         7YFA==
X-Gm-Message-State: AGRZ1gJrll1zxr2qm1og2c5HQmx1PabI/nEY/FbtlAD5+D4MCms6T4bc
        RtjZkKHsTWsOrlZSL3CA2HlBigDWmHs=
X-Google-Smtp-Source: AJdET5dIHfHU2W+yn5iJQRadJkVL0OnKFJF3yNPmVg9svHF/jEVGHv1AiE5u5P/iRxCCQ27RDZ20Hw==
X-Received: by 2002:a50:985c:: with SMTP id h28-v6mr3661856edb.36.1541041092345;
        Wed, 31 Oct 2018 19:58:12 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id p10-v6sm5111014eja.7.2018.10.31.19.58.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 19:58:12 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id x12-v6so18610183wrw.8;
        Wed, 31 Oct 2018 19:58:11 -0700 (PDT)
X-Received: by 2002:adf:f9d2:: with SMTP id w18-v6mr5045125wrr.134.1541041091521;
 Wed, 31 Oct 2018 19:58:11 -0700 (PDT)
MIME-Version: 1.0
References: <20181031183634.29640-1-jagan@amarulasolutions.com> <20181031183634.29640-6-jagan@amarulasolutions.com>
In-Reply-To: <20181031183634.29640-6-jagan@amarulasolutions.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 1 Nov 2018 10:57:58 +0800
X-Gmail-Original-Message-ID: <CAGb2v67jZvZx38Y2_k37raQ85D7aCpvmEBqgU_Dqv6qET1VZhg@mail.gmail.com>
Message-ID: <CAGb2v67jZvZx38Y2_k37raQ85D7aCpvmEBqgU_Dqv6qET1VZhg@mail.gmail.com>
Subject: Re: [PATCH 6/7] arm64: allwinner: h6: Add RTC clock to phandle 32kHz
 external oscillator
To:     Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com, Jagan Teki <jagan@openedev.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 1, 2018 at 2:37 AM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> From: Jagan Teki <jagan@openedev.com>
>
> Outside of SOC few chips need external clock source through RTC example
> Wifi chip. So H6 RTC clock node need to phandle 32kHz external oscillator
> like A64 RTC.
>
> Add support for it.

This should be part of the previous patch.

> prefix rtc- with clock-output-names defined in dt-binding to avoid
> confusion with existing osc32k name.

Unfortunately we have a not so documented requirement that the actual
LOSC be named "osc32k", which is why you see all the previous dtsi files
with RTC clock outputs having the external 32k crystal named "ext-osc32k".

ChenYu

> Signed-off-by: Jagan Teki <jagan@openedev.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> index c8d2fe76da7e..028ec286aa0a 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
> @@ -271,6 +271,9 @@
>                         reg = <0x7000000 0x400>;
>                         interrupts = <GIC_SPI 101 IRQ_TYPE_LEVEL_HIGH>,
>                                      <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> +                       clock-output-names = "rtc-osc32k", "rtc-osc32k-out";
> +                       clocks = <&osc32k>;
> +                       #clock-cells = <1>;
>                 };
>
>                 r_ccu: clock@7010000 {
> --
> 2.18.0.321.gffc6fa0e3
>
