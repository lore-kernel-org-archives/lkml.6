Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F4A1C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28673218DE
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 05:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4Wz0WHy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726202AbfAEFhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 00:37:38 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55199 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfAEFhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 00:37:37 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2815132wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 21:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tcixzltADjssKiWqoqYobPa1vyHbdsw3OxwbfCgPu3M=;
        b=h4Wz0WHykaKwJNLvADVeZ4OYwHnpxtd1NyN79BJ8q4RilkASoWHpaGIBMfZr1DpCnc
         eCRIiEsrdhlromC5O+4d6cbqImYQx/UtliHyteZW18mRRZBGjoIrOB2gN+9pQOndlVIk
         ekCsQH0Lm9jmlvsoAWFbUTQlZtzJ7OIfpw2dA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tcixzltADjssKiWqoqYobPa1vyHbdsw3OxwbfCgPu3M=;
        b=SbQzyk1NPTzQemnhjhCa/IblZfk/ubnKdCie6fdU4fzuwEnOJ3LgzajTAJ3/dQfuJ8
         JbyDkDYk1l9AdMldBN0p2lb2jhVzA/2bieFHHPlMn6JxtXtBXoEH0WCCqZy3Fnw4REAn
         As9mY4ca864B1KHs2aNdlN4qV5NNwDtLui/bZf6U94fB2r4a6doCSOKNYqdsdIuQIlLj
         1T7iWagqoCnKorXr3smfjaGAidlHyP60bGO87BBvoNK3Wrnl8nZmh+M/xHyBKb8UNI/u
         lwfHePbZ2W1Q+WhYbFbunnenBih6KTDK0fblUsIAUrOw9nbHo/ZNS1WoqMtz9O3itBX+
         gnxw==
X-Gm-Message-State: AJcUukdpoGHP2OGFCHriwfsgQkfWC6FZjGQyE7/GnFnI/jehoeHsxRc1
        s/zfG7SCSU3xngReC9A2qGSmOnsRG1PFTmKdGgTNFPRT0lF/cQ==
X-Google-Smtp-Source: ALg8bN5BKSchTBYUATMxJhIqATdi2OwkbolG2AhmChMtnqCv71kIiiC0yvKIDK55hzFYVdilhqIn5+V5b86BVY6/4No=
X-Received: by 2002:a1c:a68f:: with SMTP id p137mr1482830wme.64.1546666655915;
 Fri, 04 Jan 2019 21:37:35 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-7-git-send-email-john.stultz@linaro.org>
 <20190105034904.GD2477@Mani-XPS-13-9360> <CALAqxLVGznbM8+rHHn8j_+m1P-E9+_jJNfRZKPVqF+pTQWG_Mg@mail.gmail.com>
In-Reply-To: <CALAqxLVGznbM8+rHHn8j_+m1P-E9+_jJNfRZKPVqF+pTQWG_Mg@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 21:37:23 -0800
Message-ID: <CALAqxLUtCtEF1bck5WcfHFugrjS5b73MOMVz+9CiML0oG9ZzGA@mail.gmail.com>
Subject: Re: [PATCH 6/8 v2] arm64: dts: hi3660: Add dma to uart nodes
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Tanglei Han <hantanglei@huawei.com>,
        Zhuangluan Su <suzhuangluan@hisilicon.com>,
        Ryan Grachek <ryan@edited.us>, Wei Xu <xuwei5@hisilicon.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 4, 2019 at 8:34 PM John Stultz <john.stultz@linaro.org> wrote:
>
> On Fri, Jan 4, 2019 at 7:49 PM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > Hi John,
> >
> > On Fri, Jan 04, 2019 at 12:56:26PM -0800, John Stultz wrote:
> > > Try to add DMA support to the uart nodes following
> > > the assignments made in the dts from the victoria vendor kernel
> > > here:
> > > https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1
> > >
> > > Cc: Tanglei Han <hantanglei@huawei.com>
> > > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > > Cc: Ryan Grachek <ryan@edited.us>
> > > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > Cc: Wei Xu <xuwei5@hisilicon.com>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > Cc: linux-arm-kernel@lists.infradead.org
> > > Cc: devicetree@vger.kernel.org
> > > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > index 20ae40d..aaa2b04 100644
> > > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > > @@ -466,6 +466,8 @@
> > >                       compatible = "arm,pl011", "arm,primecell";
> > >                       reg = <0x0 0xfdf02000 0x0 0x1000>;
> > >                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> > > +                     dma-names = "rx", "tx";
> > > +                     dmas =  <&dma0 0 &dma0 1>;
> >
> > Usage of DMA channel 0 contradicts with the description provided in
> > patch, "dma: k3dma: Add support to dma_avail_chan".
>
> Hrm. Good point.  I'll double check w/ Dr Su on this, I'm not sure if
> that inconsistency is due to the the vendor kernel (where these came
> from) having different reserved channels or just something overlooked
> if the uart0 is not actually being used (as we find on hikey960 as
> well).

Hrm. So it seems like uart0 is mapped to the dma0 chan0, but the
device specific files in the vendor tree overwite the dma values:
                serial0: uart@fdf02000 {
                        pinctrl-names = "default", "idle";
                        pinctrl-0 = <&gpio053_pmx_func
&gpio054_pmx_func &gpio053_cfg_func &gpio054_cfg_func>;
                        pinctrl-1 = <&gpio053_pmx_idle
&gpio054_pmx_idle &gpio053_cfg_idle &gpio054_cfg_idle>;
                        dma-names = "", "";
                        dmas = <>;
                        clock-rate = <0 19200000>;
                        status = "ok";
                };

But I went ahead and pulled the dma values on uart0.

thaks
-john
