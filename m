Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F291EC43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCA3D20892
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 08:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2mD7hct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCA3D20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKIRuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 12:50:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:52828 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727962AbeKIRuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 12:50:18 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5055320855;
        Fri,  9 Nov 2018 08:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541751052;
        bh=PnTytqRUO10WrgWb54CcstnRWXcCBw/biMxfPDYyHH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I2mD7hctXKuH7dcx1DDJIBShbjFdxt3w5A7nfqW9vH5hp+bc5lnMLUfWNHuv3nMHJ
         ZBt+GvMxSKvLY9a3dCEF54S6MmfyisWN5CTeKXc/ZezSv+jAx5+wNDWYUvvxpGl126
         abRRewV/K7JFJAIcXWUpPqqrUBpykECWlz6K4qQI=
Date:   Fri, 9 Nov 2018 13:40:43 +0530
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
Message-ID: <20181109081043.GN12092@vkoul-mobl>
References: <20181108184009.18430-1-vkoul@kernel.org>
 <20181108184009.18430-2-vkoul@kernel.org>
 <CAL_JsqKsCpofdsP_TojGxeCkv59r5Ce7-4Sz1B1V_QCL1eQDVg@mail.gmail.com>
 <20181109050058.GI12092@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181109050058.GI12092@vkoul-mobl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09-11-18, 10:30, Vinod Koul wrote:

> > > +       clocks {
> > > +               xo_board: xo_board {
> > 
> > Build your dtbs with "W=12" and fix any warnings. You should get a
> > warning about '_'.
> 
> I did built it with W=1 though, so _ is not allowed?

I have fixed most of these with the exception of mmc-ddr-1_8v, as this
is documented in mmc bindings, so cant change this one. For this one I
am going to update gcc driver as well

> > > +       cpus {
> > > +               #address-cells = <1>;
> > > +               #size-cells = <0>;
> > > +
> > > +               CPU0: cpu@0 {
> > 
> > unit address is wrong.
> 
> Sorry am not sure I follow, can you please explain how..

Fixed now, thanks to Bjorn.

> > > +       memory@80000000 {
> > > +               device_type = "memory";
> > > +               /* We expect the bootloader to fill in the reg */
> > 
> > Can't you put in a default or base address at least.
> 
> Okay will try

Added now, will send update shortly

-- 
~Vinod
