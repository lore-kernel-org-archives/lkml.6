Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCD3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88FEE20818
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 04:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ddH38Vv6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbfBSEhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 23:37:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46024 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbfBSEhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 23:37:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id h10so13672059lfc.12
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 20:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pAlKG82ZIDfYoi+VG5UemDd2q0hSiF1x6o7DPhBW6NA=;
        b=ddH38Vv6cNlrd8aMC7sdwPS9F9pIC+8ZIjvq6IrJgsDi6oNTr+MZJ3w7FIL6C/Lrel
         EVSB19XNPt/u0IXvVfCU2TA4cSjjrJRqHrGag83T9npp5OAL87L/jx0oUoN9k6pcErwp
         H9NfcGEGjcagBNNYJkT95l2Dl88+w59uhveMoef9ESwtXrlg0z+0O3E/wEO9Tdwv45wP
         mExNDizwBtRBZqeJgr+mvCOrewGTyTGHwbPW56J7SI7W1y7g7HtD+e3n8KM2S4CPiaSl
         p50KEeZnK3ByripvhySMjp8TST4iJb61uSvRlfkm0J2yNTSg8OwiVqG6VEjrXohWn/pY
         /RGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pAlKG82ZIDfYoi+VG5UemDd2q0hSiF1x6o7DPhBW6NA=;
        b=G/iNnuzhUKn4jg8kAnlEvbiPZffC2eHujJ8SWvI4eby07/lYDXoaqdUwIdID8yfGrQ
         dtfU5fkEuV1efdj51f1ZiaOOeBbSRG53GvfIZ1qmtBBGITMepsNZ4772CYSYZDSwxZh0
         rqjsvu2dviAUhhaEhrVZkpI/1xdpipfmO+TU+OiTqx5dn4Ha3eTlSMQQuubJTlIzMixG
         oUPfrMY/BTL+zHo22/tGOAkxmCVA8Kg8gIA7VtZ7O8Sx4+13sttxgWgLgx9sbTWop3F6
         OR509exs3MdncdGeN+bT3vWhFiNyU375DDxOFBmXDUPvnyegTsIAvNbfcidd8PS4ZOfu
         TlOA==
X-Gm-Message-State: AHQUAubs3S7ptOT8nhqoYmE9A/PDtpuz+nDSx7Oa4COG75+QHxGe/3z0
        DTreX+yLHJU4nCky/QDTnzQTMyt0QRBuKliyBxYM/g==
X-Google-Smtp-Source: AHgI3IZEtppTAp6G1D3YAZx1+6LtTMCqSAn95lOaTTldlVzGjttn4KppFTPZsDe6QtvmfqWx0K+RgNV2j86UhsDzIYc=
X-Received: by 2002:a19:5205:: with SMTP id m5mr15777606lfb.61.1550551038471;
 Mon, 18 Feb 2019 20:37:18 -0800 (PST)
MIME-Version: 1.0
References: <11e55b5f9b0d83649a5b81c7e3fdb667cd3ddc5b.1550043082.git.baolin.wang@linaro.org>
 <2be9d6de92507e5886433fb2cd55117c63b63d72.1550043082.git.baolin.wang@linaro.org>
 <CAL_JsqK+x+XgxSn7ks84_JZxTkpQ-irFBmRc3tp3zsfUcHUPpg@mail.gmail.com>
In-Reply-To: <CAL_JsqK+x+XgxSn7ks84_JZxTkpQ-irFBmRc3tp3zsfUcHUPpg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 19 Feb 2019 12:37:06 +0800
Message-ID: <CAMz4ku+PqA95OJ6kVtYp=4dtD=Gi6cwGVN=0kikv2666c2ZFXw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] dt-bindings: spi: Add the DMA properties for the
 SPI dma mode
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>, lanqing.liu@unisoc.com,
        linux-spi <linux-spi@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2019 at 22:02, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Feb 13, 2019 at 1:37 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > From: Lanqing Liu <lanqing.liu@unisoc.com>
> >
> > Add the DMA properties for the SPI dma mode.
> >
> > Signed-off-by: Lanqing Liu <lanqing.liu@unisoc.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> > Changes from v1:
> >  - Remove sprd,dma-slave-ids property.
> > ---
> >  Documentation/devicetree/bindings/spi/spi-sprd.txt |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > index bad211a..3c7eacc 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > @@ -14,6 +14,11 @@ Required properties:
> >         address on the SPI bus. Should be set to 1.
> >  - #size-cells: Should be set to 0.
> >
> > +Optional properties:
> > +dma-names: Should contain names of the SPI used DMA channel.
> > +dmas: Should contain DMA channels and DMA slave ids which the SPI used
> > +       sorted in the same order as the dma-names property.
>
> These need to define the order and names.

Sure.

>
> > +
> >  Example:
> >  spi0: spi@70a00000{
> >         compatible = "sprd,sc9860-spi";
> > @@ -21,6 +26,8 @@ spi0: spi@70a00000{
> >         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> >         clock-names = "spi", "source","enable";
> >         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> > +       dma-names = "rx_chn", "tx_chn";
>
> Everyone else uses "rx" and "tx". Do you really need something different?

Okay, will change to use  "rx" and "tx". I will send incremental patch
to fix ths issues you pointed out. Thanks.

-- 
Baolin Wang
Best Regards
