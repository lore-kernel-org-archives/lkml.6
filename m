Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB07FC43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:34:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA72520868
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 04:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8GTCkj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAEEeY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 23:34:24 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40972 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfAEEeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 23:34:24 -0500
Received: by mail-wr1-f67.google.com with SMTP id x10so38219812wrs.8
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jan 2019 20:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GQBlCadZCOotC7WcWUZWM/qHn03LQdG+fqIY9Ks3MnU=;
        b=K8GTCkj75/GqtULaOsxpp+gENtKPSfr/Y/tfM9cobdIs/fZlwWGQydpeyE3fRcYqhR
         P5PNy/OjWenoLv+Lria3qNVncmHLQwuh7oLRdk0IjTuaqtzqPtvBLUoxvAbNhH0aOZyd
         7RHu76+IqsRdbeNWL3p9bm9SiGr7Nq6PqurAU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GQBlCadZCOotC7WcWUZWM/qHn03LQdG+fqIY9Ks3MnU=;
        b=o8VRTPoK+7LF8NMEcGeSaB7MHel9x2PfHF66kJT56FqiQxGPUmXNRk8UYvdZSV4+nr
         wMYHQeJZwZR4Az+JTOQtqqF8kdZsSxHpkYrm4KoV7ZxqvXuDGp/p7OQAYmVnciTIax9v
         B5Bb4KfwbANr6WAL4YHIYexatlfVSiq74cg1B7TAXV4O4zudpHMvqG1Ay0LhELW8fcqd
         RNj08/0ucWnwYU5tcxl1CWOPk3piQjnZ9CP2aPjvdkoMbFsHp3KrZuFmnXvQjqEQJ++Z
         dJOqv72aPHKiimqmTJcIHpiIyEAY1n5yolLbhs9AZ4JusUKeY/f3xQXUwxVXr4IU5a+7
         VA4g==
X-Gm-Message-State: AJcUukeaD9ypkDTqPVnbikv9G3jX3545/cpfbtXt7a4rYLCX371FBJ/6
        mxLStOYDPgzAfJoPncucMkfs5l+8eoLzHKOKlMCsWg==
X-Google-Smtp-Source: ALg8bN5uj/KAjavJwr/gTLPWp3pYg7X5NMl4VgeSAD26OrEIEX+1Yw9SC74EOHKzblMNyp6Gef4Lwfh/T8wE3QN7+rk=
X-Received: by 2002:adf:c108:: with SMTP id r8mr47951498wre.233.1546662862430;
 Fri, 04 Jan 2019 20:34:22 -0800 (PST)
MIME-Version: 1.0
References: <1546635388-13795-1-git-send-email-john.stultz@linaro.org>
 <1546635388-13795-7-git-send-email-john.stultz@linaro.org> <20190105034904.GD2477@Mani-XPS-13-9360>
In-Reply-To: <20190105034904.GD2477@Mani-XPS-13-9360>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 4 Jan 2019 20:34:09 -0800
Message-ID: <CALAqxLVGznbM8+rHHn8j_+m1P-E9+_jJNfRZKPVqF+pTQWG_Mg@mail.gmail.com>
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

On Fri, Jan 4, 2019 at 7:49 PM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> Hi John,
>
> On Fri, Jan 04, 2019 at 12:56:26PM -0800, John Stultz wrote:
> > Try to add DMA support to the uart nodes following
> > the assignments made in the dts from the victoria vendor kernel
> > here:
> > https://consumer.huawei.com/en/opensource/detail/?siteCode=worldwide&keywords=p10&fileType=openSourceSoftware&pageSize=10&curPage=1
> >
> > Cc: Tanglei Han <hantanglei@huawei.com>
> > Cc: Zhuangluan Su <suzhuangluan@hisilicon.com>
> > Cc: Ryan Grachek <ryan@edited.us>
> > Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > Cc: Wei Xu <xuwei5@hisilicon.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: devicetree@vger.kernel.org
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > ---
> >  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > index 20ae40d..aaa2b04 100644
> > --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> > @@ -466,6 +466,8 @@
> >                       compatible = "arm,pl011", "arm,primecell";
> >                       reg = <0x0 0xfdf02000 0x0 0x1000>;
> >                       interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
> > +                     dma-names = "rx", "tx";
> > +                     dmas =  <&dma0 0 &dma0 1>;
>
> Usage of DMA channel 0 contradicts with the description provided in
> patch, "dma: k3dma: Add support to dma_avail_chan".

Hrm. Good point.  I'll double check w/ Dr Su on this, I'm not sure if
that inconsistency is due to the the vendor kernel (where these came
from) having different reserved channels or just something overlooked
if the uart0 is not actually being used (as we find on hikey960 as
well).

thanks
-john
