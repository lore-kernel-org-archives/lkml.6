Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30615C43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC6F720840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ryKvcm0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC6F720840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeKIOkA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:40:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53334 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbeKIOj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:39:57 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF67620840;
        Fri,  9 Nov 2018 05:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541739666;
        bh=mK8ePfPDblAqctIrkH/QDPZpxC9nurMBIyfKTD15g4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ryKvcm0F023V9CqLhRlGGscPvuxfBv1vaXJfSfX2Jdb7XxeoxV76YH8dnG1CX4Fsr
         LsIJstwNIQyZnkD89bBpwa88mmmsr2llRz2Hy+RbNCq0AJDinJU0l3BQRcwcVSzh92
         JlPfvgi1nJR3JG+e29LEfVfarXOEyGNNsEiKdrP8=
Date:   Fri, 9 Nov 2018 10:30:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 01/18] arm64: dts: qcom: qcs404: add base dts files
Message-ID: <20181109050058.GI12092@vkoul-mobl>
References: <20181108184009.18430-1-vkoul@kernel.org>
 <20181108184009.18430-2-vkoul@kernel.org>
 <CAL_JsqKsCpofdsP_TojGxeCkv59r5Ce7-4Sz1B1V_QCL1eQDVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqKsCpofdsP_TojGxeCkv59r5Ce7-4Sz1B1V_QCL1eQDVg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-18, 15:45, Rob Herring wrote:
> > +/ {
> > +       interrupt-parent = <&intc>;
> > +
> > +       #address-cells = <2>;
> > +       #size-cells = <2>;
> > +
> > +       chosen { };
> > +
> > +       clocks {
> > +               xo_board: xo_board {
> 
> Build your dtbs with "W=12" and fix any warnings. You should get a
> warning about '_'.

I did built it with W=1 though, so _ is not allowed?

> > +                       compatible = "fixed-clock";
> > +                       #clock-cells = <0>;
> > +                       clock-frequency = <19200000>;
> > +               };
> > +       };
> > +
> > +       cpus {
> > +               #address-cells = <1>;
> > +               #size-cells = <0>;
> > +
> > +               CPU0: cpu@0 {
> 
> unit address is wrong.

Sorry am not sure I follow, can you please explain how..

> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x100>;
> > +                       enable-method = "psci";
> > +                       next-level-cache = <&L2_0>;
> > +               };
> > +
> > +               CPU1: cpu@1 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x101>;
> > +                       enable-method = "psci";
> > +                       next-level-cache = <&L2_0>;
> > +               };
> > +
> > +               CPU2: cpu@2 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x102>;
> > +                       enable-method = "psci";
> > +                       next-level-cache = <&L2_0>;
> > +               };
> > +
> > +               CPU3: cpu@3 {
> > +                       device_type = "cpu";
> > +                       compatible = "arm,cortex-a53";
> > +                       reg = <0x103>;
> > +                       enable-method = "psci";
> > +                       next-level-cache = <&L2_0>;
> > +               };
> > +
> > +               L2_0: l2-cache {
> > +                       compatible = "cache";
> > +                       cache-level = <2>;
> > +               };
> > +       };
> > +
> > +       memory@80000000 {
> > +               device_type = "memory";
> > +               /* We expect the bootloader to fill in the reg */
> 
> Can't you put in a default or base address at least.

Okay will try

-- 
~Vinod
