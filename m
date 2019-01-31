Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C6D6C282D9
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:11:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BAF20823
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548969067;
	bh=M8TqggX6bJmJ42B5/Ac86mIBJxlJxaEp9Yx65IUnl8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MQ2jlZEXeOA8nrF1pBPTpZKc05LPUjAm7P+1GREkvG9FIyHyUhabRwOenVQG131er
	 kAIDNVyCYaKGlWUqGBsGkAhUMIX9BqSx9rQ+G1xzxpOp95mCYxdfX2vuin2t15EiOu
	 ydiUfRC7ElEopDnb+sVINGOVIg+EeXhW5tmfvlRg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfAaVLF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:11:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfAaVLF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:11:05 -0500
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E1C8218AF;
        Thu, 31 Jan 2019 21:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548969064;
        bh=M8TqggX6bJmJ42B5/Ac86mIBJxlJxaEp9Yx65IUnl8U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UqxItAaI7MSxj+FZVAiVCib9bu/t22fkZjQjKx1vFQUhRW1rWTZSEQRTu+Aq5iw7f
         myirTh7MSstupMu63vcL/xxG9U14xtBmbFUIAgg6MS5K7zLogRlHqNx/T+46Ael+1c
         ly+itsWHBpSuB/wcuUnAzTYYl08GrTqDb6b0wxvM=
Received: by mail-qt1-f179.google.com with SMTP id l12so5123703qtf.8;
        Thu, 31 Jan 2019 13:11:04 -0800 (PST)
X-Gm-Message-State: AJcUukdfPwAS7cC0u3+3GbSaVdK5tECu5tjOBhhGP/tCp8dASkvOEOd3
        2LEhaf6JOfDrrojn+U8wNLcIWGjmqQiQf1Zkkg==
X-Google-Smtp-Source: ALg8bN5xVlARGZqxDOmh1ggNeMx4EYwm/oRtZilP3Y7NQRPyYLJpcipt+Yc17uKzBoZxttL2JbY8dRmIzIVwt62G9Hs=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr34761543qtd.257.1548969063278;
 Thu, 31 Jan 2019 13:11:03 -0800 (PST)
MIME-Version: 1.0
References: <1548317240-44682-1-git-send-email-erin.lo@mediatek.com>
 <1548317240-44682-7-git-send-email-erin.lo@mediatek.com> <20190130162204.GA1521@bogus>
 <1548902050.23230.4.camel@mtksdaap41>
In-Reply-To: <1548902050.23230.4.camel@mtksdaap41>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 31 Jan 2019 15:10:52 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
Message-ID: <CAL_JsqL1vQCgbb2yLL2E4KTDZve1vus5bDX75HGiOu14X26q7w@mail.gmail.com>
Subject: Re: [PATCH v6 6/6] arm64: dts: Add Mediatek SoC MT8183 and evaluation
 board dts and Makefile
To:     Erin Lo <erin.lo@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Ben Ho <Ben.Ho@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Mengqi Zhang <Mengqi.Zhang@mediatek.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Seiya Wang <seiya.wang@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eddie Huang <eddie.huang@mediatek.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 8:34 PM Erin Lo <erin.lo@mediatek.com> wrote:
>
> On Wed, 2019-01-30 at 10:22 -0600, Rob Herring wrote:
> > On Thu, Jan 24, 2019 at 04:07:20PM +0800, Erin Lo wrote:
> > > From: Ben Ho <Ben.Ho@mediatek.com>
> > >
> > > Add basic chip support for Mediatek 8183, include
> > > pinctrl file, uart node with correct uart clocks, pwrap device
> > >
> > > Add clock controller nodes, include topckgen, infracfg,
> > > apmixedsys and subsystem.
> > >
> > > Signed-off-by: Ben Ho <Ben.Ho@mediatek.com>
> > > Signed-off-by: Erin Lo <erin.lo@mediatek.com>
> > > Signed-off-by: Seiya Wang <seiya.wang@mediatek.com>
> > > Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> > > Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> > > Signed-off-by: Mengqi Zhang <Mengqi.Zhang@mediatek.com>
> > > Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> > > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > > ---
> >
> >
> > > +   sysirq: intpol-controller@c530a80 {
> >
> > interrupt-controller@...
>
> I will modify it in next version.
> >
> >
> > Place all the MMIO peripherals under one or more simple-bus nodes.
> >
> > Rob
> >
>
> Do you mean need to add simple-bus like this?

Yes.

>
> +   soc: soc {
> +                #address-cells = <0x1>;
> +                #size-cells = <0x1>;
> +                ranges = <0 0 0 0xffffffff>;
> +                compatible = "simple-bus";
>
>                 soc_data: soc_data@08000000 {
>                         compatible = "mediatek,mt8183-efuse",
>                                      "mediatek,efuse";
>                         reg = <0 0x08000000 0 0x0010>;
>                         #address-cells = <1>;
>                         #size-cells = <1>;
>                         status = "disabled";
>                 };
>
>                 gic: interrupt-controller@0c000000 {
>                         compatible = "arm,gic-v3";
>                         #interrupt-cells = <4>;
>
> Best Regards,
> Erin
>
> > _______________________________________________
> > Linux-mediatek mailing list
> > Linux-mediatek@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-mediatek
>
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
