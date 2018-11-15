Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BBEC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C681121582
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 16:40:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C681121582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388546AbeKPCsq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 21:48:46 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:43954 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387839AbeKPCsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 21:48:45 -0500
Received: by mail-ed1-f65.google.com with SMTP id f4so4543568edq.10;
        Thu, 15 Nov 2018 08:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkpqcAIjuBI4c6Oduh0eObAbYXeEMEvLNtXtBrid8IU=;
        b=jEVHpXlg4hGgr0sBphBGuWpvRZCmF7rjSZY9ipkqP/NCyrYwoDObbTrQlruMB2pZb0
         Xv1qBSXuNnWKRBN3O9Fs1oyQcVN3oqwTh18izOdgV1oFPY0+L8quNgUGvCeHbId5VUmA
         kslziTNVERVBZbIMWR2+GTwFk0aPpLsgxNVI+XzPyAY+ejpS8DKR1UaPDQFQeyngahiR
         z1KFAja/6xfJTA6rJH1a+VxFAfvZBN/yHyv9AN/Rwd9n79aCxRuBW8Mrz+ILqf1BmeFJ
         OcCsdJzeXtPI4Aa1hiRsQWW8zW08NEHAcGV3vvxK8UygAD0YkcLi/NlOLW/6+Omkd+Y7
         +v3A==
X-Gm-Message-State: AGRZ1gIZ543ImfnhUDmrOBAUX9ix6AcQ0ksSdKieXdsmp4FnPbrF7U8+
        LKZ16WH+w3YVveq0HuZvXOX0Q3h3E2o=
X-Google-Smtp-Source: AJdET5d2ApXR5Wzz7q64Fb6rNHwQMl9MO7VBK7hIxw0AlyUbXNeeUO6ytG18wJ+Who8QKIEAkyiBng==
X-Received: by 2002:a17:906:1654:: with SMTP id n20-v6mr5919146ejd.167.1542300011055;
        Thu, 15 Nov 2018 08:40:11 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id l19-v6sm8312935edc.3.2018.11.15.08.40.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 08:40:10 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id r11-v6so19413319wmb.2;
        Thu, 15 Nov 2018 08:40:10 -0800 (PST)
X-Received: by 2002:a1c:860b:: with SMTP id i11mr1059712wmd.5.1542300009894;
 Thu, 15 Nov 2018 08:40:09 -0800 (PST)
MIME-Version: 1.0
References: <20181115145013.3378-1-paul.kocialkowski@bootlin.com> <20181115145013.3378-11-paul.kocialkowski@bootlin.com>
In-Reply-To: <20181115145013.3378-11-paul.kocialkowski@bootlin.com>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Fri, 16 Nov 2018 00:39:59 +0800
X-Gmail-Original-Message-ID: <CAGb2v66twfxzMzO-E1WH78N6O9N1J_AcPQcKp3FApE1gTKmn3Q@mail.gmail.com>
Message-ID: <CAGb2v66twfxzMzO-E1WH78N6O9N1J_AcPQcKp3FApE1gTKmn3Q@mail.gmail.com>
Subject: Re: [PATCH 10/15] arm64: dts: allwinner: a64: Add support for the
 SRAM C1 section
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devel@driverdev.osuosl.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-sunxi@googlegroups.com, Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 10:50 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
>
> Add the description for the SRAM C1 section to the A64 device-tree.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> index f3a66f888205..88b3e9110833 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> @@ -277,6 +277,20 @@
>                                         reg = <0x0000 0x28000>;
>                                 };
>                         };
> +
> +                       sram_c1: sram@1d00000 {
> +                               compatible = "mmio-sram";
> +                               reg = <0x01d00000 0x80000>;

I can confirm that this SRAM region is indeed at this address. However the
size is only 0x40000, not 0x80000. The address ranges should be fixed.

One hiccup is that the VE reset has to be de-asserted and the VE bus clock
has to be ungated for the CPU to access this region when it's mapped to the
CPU.

One other thing I find interesting is that in the previous SoCs, the bits
that control this mapping says 50K, but in reality it is 512K for the older
SoCs, and 256K for this one.

ChenYu

> +                               #address-cells = <1>;
> +                               #size-cells = <1>;
> +                               ranges = <0 0x01d00000 0x80000>;
> +
> +                               ve_sram: sram-section@0 {
> +                                       compatible = "allwinner,sun50i-a64-sram-c1",
> +                                                    "allwinner,sun4i-a10-sram-c1";
> +                                       reg = <0x000000 0x80000>;
> +                               };
> +                       };
>                 };
>
>                 dma: dma-controller@1c02000 {
> --
> 2.19.1
>
