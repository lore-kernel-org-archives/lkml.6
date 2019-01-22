Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED15C37122
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD52A2085A
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 02:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="C4xEUz9i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbfAVCXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 21:23:13 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46229 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726756AbfAVCXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 21:23:12 -0500
Received: by mail-lj1-f193.google.com with SMTP id v15-v6so19143678ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 18:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0NdysI5CM7+I+Thbbv3VAV/KANlyL+WAtkRtmfEjoM=;
        b=C4xEUz9ip1ZeTzPv/J8he2mpt/81PA8ReTSy+PGyUHpYAla6PzsjvYQrkUPoa/V10D
         t9PWwuVdlZZR5Wht75GNWzHdPAFj3VBPKZi9wg8mcuTA6gEuaKeKvPhTmGMs0at02lip
         SIaaytviRxeg6PmBPeAwzSdKTQiw9gN6xpG9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0NdysI5CM7+I+Thbbv3VAV/KANlyL+WAtkRtmfEjoM=;
        b=mJ4Chy8l5J+/jJhpVaWFOw0J1Dgk1W6Y0+ui1btnzQHb7ik9Ad438MCL2xtQiSq3sa
         WqqSPMKgE7f8TJRJs6OjqP77P7fOwBuMxDbSfcGyowtEMhXnfi9UJseBf7K1IYJKoQon
         lkhHJB8CgLv+xk/fJCEqsGQz7nUCv4WRu7IX4CNwqUDkRKslSTXSeVBvj2ZdsemKeM2X
         mYY+5OPS8vrnDl8CBXIWsKjVT57zsDeWcUYL2uoAMk/OEa1LAzO3sBBSqS3Bbc4UYDU1
         xNIGEjAPpUR+5tPWVLt0TAx5WO0gxFYWclHnHM4EYyk5y1mIt1EMfiPYjdtGnGobebau
         sMzQ==
X-Gm-Message-State: AJcUukecyAy1K2ZUYIs/Oy6Qc2o3hPxuPh6LQD8O0VanjWT33s47ouvg
        51CXiLTQEItROxCM+BpcxOAv4BkNZ6IkNC0nvAIwTA==
X-Google-Smtp-Source: ALg8bN5PRpU6ZIfqpFwp7k/qSXB7vILzoDLcbbz3BiUTy9+yeFET6KE1wHkgvMYxrPvES0WPzhEexI1CTYw7u3cvbxk=
X-Received: by 2002:a2e:449b:: with SMTP id b27-v6mr18556784ljf.47.1548123790116;
 Mon, 21 Jan 2019 18:23:10 -0800 (PST)
MIME-Version: 1.0
References: <ab49bb74e921474aa9390f81cdf65f32c3d9d898.1547559542.git.baolin.wang@linaro.org>
 <7538d5806003b8f67e7e0d35638315974b7c2b50.1547559542.git.baolin.wang@linaro.org>
 <CAL_Jsq+VpO+pX0A27-v_U+4kQKXKD5O1EWrn708RDeLsqnU1ng@mail.gmail.com>
In-Reply-To: <CAL_Jsq+VpO+pX0A27-v_U+4kQKXKD5O1EWrn708RDeLsqnU1ng@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 22 Jan 2019 10:22:58 +0800
Message-ID: <CAMz4kuK0tvYHL1gGDXCKDzow+YmAj587UoBp=fRi0_sujLh2QQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: spi: Add the DMA properties for the SPI
 dma mode
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

On Mon, 21 Jan 2019 at 21:53, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Jan 15, 2019 at 7:47 AM Baolin Wang <baolin.wang@linaro.org> wrote:
> >
> > From: Lanqing Liu <lanqing.liu@spreadtrum.com>
>
> The email address should be updated with unisoc.com.

Sure.

>
> > Add the DMA properties for the SPI dma mode.
> >
> > Signed-off-by: Lanqing Liu <lanqing.liu@spreadtrum.com>
> > Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/spi/spi-sprd.txt |    9 +++++++++
> >  1 file changed, 9 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/spi/spi-sprd.txt b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > index bad211a..01ef53f 100644
> > --- a/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > +++ b/Documentation/devicetree/bindings/spi/spi-sprd.txt
> > @@ -14,6 +14,12 @@ Required properties:
> >         address on the SPI bus. Should be set to 1.
> >  - #size-cells: Should be set to 0.
> >
> > +Optional properties:
> > +dma-names: Should contain names of the SPI used DMA channel.
> > +dmas: Should contain DMA channels which the SPI used sorted in the
> > +       same order as the dma-names property.
> > +sprd,dma-slave-ids: Should contain the DMA number that the SPI hardware required.
> > +
> >  Example:
> >  spi0: spi@70a00000{
> >         compatible = "sprd,sc9860-spi";
> > @@ -21,6 +27,9 @@ spi0: spi@70a00000{
> >         interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
> >         clock-names = "spi", "source","enable";
> >         clocks = <&clk_spi0>, <&ext_26m>, <&clk_ap_apb_gates 5>;
> > +       dma-names = "rx_chn", "tx_chn";
> > +       dmas = <&apdma 11>, <&apdma 12>;
> > +       sprd,dma-slave-ids = <11 12>;
>
> When would this be different values from what's in 'dmas'?

Slave id is not always same with the DMA channel number in 'dmas', and
it is just coincident for SPI driver. Moreover for different SoC , the
slave ids for DMA engine consumers are not same. So we need one
property to specify the slave id for the consumers to trigger DMA
transfer.

-- 
Baolin Wang
Best Regards
