Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4F6C282CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A01020873
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:22:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="jdAsyQ90"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbfBKIWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:22:51 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:36487 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbfBKIWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:22:51 -0500
Received: by mail-it1-f196.google.com with SMTP id c9so24106475itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fvY2/yBGMwbngNDLa66cM3Z3OvAxuwsm6ud86Xu01mE=;
        b=jdAsyQ90mli/1X4feqFov2FjxbYBaMp8oZXHDFKZAWdO1k84n+XBqCwxjtSJ8VoJM9
         lFJCACs/k+wKAao0f9jIyuZozeIDbrBMETX3xuOOUCzseOUdxq3r8S3hsyqwQpGUgtNl
         ern03whpopTdNC/7JyKsxVGGZJZy2bZm6hI00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fvY2/yBGMwbngNDLa66cM3Z3OvAxuwsm6ud86Xu01mE=;
        b=S0C4RMbQeU4wtPtceVnw5YU72ZEEixaWoEn8cjwKG0UsDSqqRur8AS2EbcSiwBZbfR
         mFn3g75CTNc15uGB/UoHz0D/o/pNIAqjucyBP3h74t6U0iVUX3jKqvMIutvQF61xTkrI
         Rq6ZEBywdqGOqrKO8OtPD/TvADKirHN/8/maQSWsNs+aLLbFvycdcsihWInmZNXjofml
         TpuIkYp7AutNZkp1tQlLODRQeeb3PGQisNz9k33cidUgqugTX/yZBu8tECleJSb1nCnU
         RpGtUj1gal3BCV+vRXq0GT3oHo1k5WK3/0udka+912xBjkZalgfS30v5qyEmSv4xet1U
         lkJw==
X-Gm-Message-State: AHQUAuZjxPsGhPkVkjG+qIM2f/5xVPTsjDKXAq7zoHwcqsWRkqEyDfi5
        PEOiJuya/kBPALIsJfeoudCIGOzUeidyobFB5Rfm9w==
X-Google-Smtp-Source: AHgI3IaFcZZL/2rH9QTpGunyScGyRTXN776wXOAZSs3378quUqLuNmzuocgC1Zo1SMOQDR5v96EwagPe0Xwc0kqbyPg=
X-Received: by 2002:a6b:b790:: with SMTP id h138mr14110911iof.114.1549873370645;
 Mon, 11 Feb 2019 00:22:50 -0800 (PST)
MIME-Version: 1.0
References: <20190128085847.7217-1-jagan@amarulasolutions.com>
In-Reply-To: <20190128085847.7217-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Mon, 11 Feb 2019 13:52:39 +0530
Message-ID: <CAMty3ZCdm_RoVxoHy9u2-Xhg4_tf7Mr0Gedcrz-jVhc5ceL0CQ@mail.gmail.com>
Subject: Re: [PATCH v8 0/5] media/sun6i: Allwinner A64 CSI support
To:     Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-media <linux-media@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        linux-amarula@amarulasolutions.com,
        devicetree <devicetree@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro and Maxime,

On Mon, Jan 28, 2019 at 2:29 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> Add CSI support for Allwinner A64. Here is previous series[1]
>
> Changes for v8:
> - update proper enable and disable sequnce for clk_mod
> - fix warning for patch "media: sun6i: Add A64 CSI block support"
> - collect Maxime Acked-by
> Changes for v7:
> - Drop quirk change, and add as suggusted by Maxime
> - Use csi instead csi0 in pinctrl function
> Changes for v6:
> - set the mod rate in seett_power instead of probe
> Changes for v5:
> - Add mod_rate quirk for better handling clk_set code
> Changes for v4:
> - update the compatible string order
> - add proper commit message
> - included BPI-M64 patch
> - skipped amarula-a64 patch
> Changes for v3:
> - update dt-bindings for A64
> - set mod clock via csi driver
> - remove assign clocks from dtsi
> - remove i2c-gpio opendrian
> - fix avdd and dovdd supplies
> - remove vcc-csi pin group supply
>
> [1] https://patchwork.kernel.org/cover/10779831/
>
> Jagan Teki (5):
>   dt-bindings: media: sun6i: Add A64 CSI compatible
>   media: sun6i: Add A64 CSI block support
>   arm64: dts: allwinner: a64: Add A64 CSI controller
>   arm64: dts: allwinner: a64: Add pinmux setting for CSI MCLK on PE1

Any chance to apply this patches? dtsi patch is already been merged
and all been Acked as well.
