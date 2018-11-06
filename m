Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3953EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F1E2086C
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YlGqvTkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F1E2086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389729AbeKGDCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:02:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388987AbeKGDCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:02:09 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CCE420881;
        Tue,  6 Nov 2018 17:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541525752;
        bh=i/4lk8MTWKVC4YTnXHiDzG8C54hCKbINwrrYQkIw6CA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YlGqvTkUyWlpZaF8pWGfTE1rCTfI9BKI5HugMaI6SwilNgHghCBDoR7CS2uf+yX3F
         mK73y14nuMqasLoLlsX98SzOIOV+I6zQ4mLyXg2XlCW7guYrYYDDEQR7Ei1HsZmF1H
         5OHqDWTcaiFZHZYS3l97+UwD5zqfNY0jW2ie7QAs=
Date:   Tue, 6 Nov 2018 23:05:43 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 01/17] arm64: dts: qcom: qcs404: add base dts files
Message-ID: <20181106173543.GZ12092@vkoul-mobl>
References: <20181105154529.7614-1-vkoul@kernel.org>
 <20181105154529.7614-2-vkoul@kernel.org>
 <20181105185648.GL2523@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105185648.GL2523@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review Bjorn,

On 05-11-18, 10:56, Bjorn Andersson wrote:
> On Mon 05 Nov 07:45 PST 2018, Vinod Koul wrote:
> 
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dts b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
> > new file mode 100644
> > index 000000000000..74dc09ddb0d2
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dts
> > @@ -0,0 +1,21 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2018, Linaro Limited
> > +
> > +// QCS EVB DTS
> 
> This can be read from the filename and the model a few lines down. So
> please drop.

Sure

> 
> > +
> > +/dts-v1/;
> > +
> > +#include "qcs404.dtsi"
> > +
> > +/ {
> > +	model = "Qualcomm Technologies, Inc. QCS404 EVB 1000";
> > +	compatible = "qcom,qcs404-evb";
> > +
> > +	aliases {
> > +		serial0 = &blsp1_uart2;
> > +	};
> > +
> > +	chosen {
> > +		stdout-path = "serial0";
> > +	};
> > +};
> > diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> [..]
> > +	timer {
> > +		compatible = "arm,armv8-timer";
> > +		interrupts = <GIC_PPI 2 0xff08>,
> > +			     <GIC_PPI 3 0xff08>,
> > +			     <GIC_PPI 4 0xff08>,
> > +			     <GIC_PPI 1 0xff08>;
> > +	};
> > +
> > +	clocks {
> 
> Please sort these nodes alphabetically.

Will do and also while adding subsequent nodes

> > +		xo_board: xo_board {
> > +			compatible = "fixed-clock";
> > +			#clock-cells = <0>;
> > +			clock-frequency = <19200000>;
> > +		};
> > +	};
> > +
> > +	soc: soc@0 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0 0 0 0xffffffff>;
> > +		compatible = "simple-bus";
> > +
> 
> Please pad the address in reg to 8 digits and sort these nodes by
> address.

Sure

-- 
~Vinod
