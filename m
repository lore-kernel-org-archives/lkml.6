Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4284DC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091452081B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544547916;
	bh=avd+dtzQl41dld8XFGWOC3fNEzUjx2h5h/WpLXi8A2s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Y6mZA5P6yoaJ058ML+b2aBrH5wNfu9nNDicFYNTqEUbddjs+JxQqA+IdJEZ2cF0Ij
	 wQpFlMRnI3eQBA4+1Sy3uQMV1oYDrILj/cbBSxkkhUXNb6gKNnhG0bgjqk+5Rfb/0O
	 e4gw6DiCeXPb5P6DlUt6qj1dZvPCg3ERKMiLc6Hc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 091452081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbeLKRFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50152 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727216AbeLKRFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:05:12 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E3C8720989;
        Tue, 11 Dec 2018 17:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544547911;
        bh=avd+dtzQl41dld8XFGWOC3fNEzUjx2h5h/WpLXi8A2s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CpPo0r4WLehhLcU3qIbpQP35e/HVrdBcPiW+zjR0y9a+Xk3/VFOcFavybYbV7F78m
         aJfLDxZfLAcAak7+a0TGiySqf/Ygvyy7vw6XBAOONehZNa357gq0t1girs0/0X4Ud/
         q9NRJeg+YsudwcWi2NxNbZnERB8auc2bIrP2SqJc=
Received: by mail-qt1-f172.google.com with SMTP id n21so17209187qtl.6;
        Tue, 11 Dec 2018 09:05:10 -0800 (PST)
X-Gm-Message-State: AA+aEWYdLkq+7vCdg72CDCYWKb1rYGUNODEflbIAREGNstgWeSabb/tC
        Fo33zGRSB3dK5nOjBIm13UPhmQvBlQklr0Vcng==
X-Google-Smtp-Source: AFSGD/VISdxP3SHC2gYOEApLYL1M6xt1l/QReUm6SysqGD4Uv3x1xWXQuPKlS5IRGX6DKaBTfnSpwEPmkpg88RCvK9o=
X-Received: by 2002:ac8:6b18:: with SMTP id w24mr17102010qts.144.1544547910109;
 Tue, 11 Dec 2018 09:05:10 -0800 (PST)
MIME-Version: 1.0
References: <20181127074249.15204-1-icenowy@aosc.io> <20181127074249.15204-2-icenowy@aosc.io>
 <11894938.HOUtrQJeEF@phil>
In-Reply-To: <11894938.HOUtrQJeEF@phil>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 11 Dec 2018 11:04:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+FjW3WEEPkefN_d3K7z=vrz3GfYdWQCY0PHs_+gtAigw@mail.gmail.com>
Message-ID: <CAL_Jsq+FjW3WEEPkefN_d3K7z=vrz3GfYdWQCY0PHs_+gtAigw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: gpu: add Allwinner H6 Mali Midgard binding
To:     "heiko@sntech.de" <heiko@sntech.de>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 6:25 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Dienstag, 27. November 2018, 08:42:49 CET schrieb Icenowy Zheng:
> > Allwinner H6 SoC uses a Mali T720 GPU, which is one of the GPUs in the
> > Midgard GPU product line.
> >
> > Add binding for the H6 Mali Midgard GPU.
> >
> > Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> > ---
> >  .../devicetree/bindings/gpu/arm,mali-midgard.txt    | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > index 02f870cd60e6..c897dd7be48f 100644
> > --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> > @@ -18,6 +18,7 @@ Required properties:
> >      + "amlogic,meson-gxm-mali"
> >      + "rockchip,rk3288-mali"
> >      + "rockchip,rk3399-mali"
> > +    + "allwinner,sun50i-h6-mali"
>
> I'd think you might want to keep an alphabetical sorting here, aka
> above amlogic, otherwise the list will probably become hard to read
> at some later point.
>
>
> >  - reg : Physical base address of the device and length of the register area.
> >
> > @@ -44,6 +45,18 @@ Optional properties:
> >    for details.
> >
> >
> > +Vendor-specific bindings
> > +------------------------
> > +
> > +The Mali GPU is integrated very differently from one SoC to
> > +another. In order to accomodate those differences, you have the option
> > +to specify one more vendor-specific compatible, among:
> > +
> > +  - allwinner,sun50i-h6-mali
> > +    Required properties:
> > +      * resets: phandle to the reset line for the GPU
>
> While this paragraph is similar to how it is done in Utgard, I'm
> wondering why we cannot just describe the "resets" as regular
> optional property above that.

Optional is fine, but I don't want to see every vendor doing their own
definition (there's a similar patch for meson[1]). Please first figure
out how many resets the IP block has. ARM should help as they were
eager for me to accept this binding in the first place. Then we can
see if vendors have extra resets.

Rob

[1] https://patchwork.ozlabs.org/patch/1010406/
