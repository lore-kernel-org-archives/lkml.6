Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF9F3C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C02420881
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7OfdOc1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C02420881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389814AbeKGDD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:03:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:48462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389275AbeKGDDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:03:55 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 410632081D;
        Tue,  6 Nov 2018 17:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541525857;
        bh=NME4ZgMfdG71uUOIZl1Wjbcmrju6WXrTc79Zn5MQT9s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z7OfdOc1qkaK6FvtJJZCdqHcab9LQcnmDYvDRvDZALjgwfyOakiG3akWYHnbtHQHB
         elunNB1kL7g0Xwoa62TQUDlPka6BMC2DIB6Zj/zTNtNTJJgUstfGNnHaeapf2niAu8
         XY8EsMZhT1dZB0N588bQFiT1SNCv2mBdqwwWG+2Y=
Date:   Tue, 6 Nov 2018 23:07:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/17] arm64: dts: qcom: pms405: add gpios
Message-ID: <20181106173729.GA12092@vkoul-mobl>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-12-vkoul@kernel.org>
 <20181105190802.GQ2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105190802.GQ2523@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-11-18, 11:08, Bjorn Andersson wrote:
> On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:
> 
> > Add the GPIOs present on PMS405 chip.
> > 
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pms405.dtsi | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> > index cdb4547c998b..18410d9f0f8f 100644
> > --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> > @@ -17,5 +17,21 @@
> >  			reg-names = "rtc", "alarm";
> >  			interrupts = <0x0 0x61 0x1 IRQ_TYPE_NONE>;
> >  		};
> > +
> > +		pms405_gpios: gpios@c000 {
> > +			compatible = "qcom,pms405-gpio";
> > +			reg = <0xc000>;
> > +			gpio-controller;
> > +			#gpio-cells = <2>;
> > +			interrupts = <0 0xc1 0 IRQ_TYPE_NONE>,
> > +				<0 0xc2 0 IRQ_TYPE_NONE>,
> > +				<0 0xc3 0 IRQ_TYPE_NONE>,
> > +				<0 0xc4 0 IRQ_TYPE_NONE>,
> > +				<0 0xc5 0 IRQ_TYPE_NONE>,
> > +				<0 0xc6 0 IRQ_TYPE_NONE>,
> > +				<0 0xc7 0 IRQ_TYPE_NONE>,
> > +				<0 0xca 0 IRQ_TYPE_NONE>,
> > +				<0 0xcb 0 IRQ_TYPE_NONE>;
> 
> Is there a reason why gpio 1, 8 and 9 are omitted from this list?

I think I saw something in downstream code / documentation for this, I
will check again to be sure

-- 
~Vinod
