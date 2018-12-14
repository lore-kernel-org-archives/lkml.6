Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB09C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7872E20892
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544749995;
	bh=kWN4p+VyR38OOySBnD3pOw0g5JOZk1nwfMiBgOWd6w4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I16GvFTGHAzuj3826tDTsszkkJARyuRyBZkOZKK1OvR8PJj6h0Ics8RigvFjRgPLa
	 QcZzGQtCEzJTNf94AEPgao6gqci1WII9C3O5YS4Gp4asgjn8jDFHQcZNVu0meUin6B
	 OnaYfSe4vSFloW1/5qWops2ur9hWMy0isE+a9tbo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7872E20892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbeLNBNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:13:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:53008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727654AbeLNBNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:13:12 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B876A2086D;
        Fri, 14 Dec 2018 01:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544749992;
        bh=kWN4p+VyR38OOySBnD3pOw0g5JOZk1nwfMiBgOWd6w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=syBJRFhf29yt6g88NnAumeFUqsGsJpnxduVywB5JZr7K92Qrs5Hj/rsyejPEQrY8F
         66FC8ToVka+Ye9G3gyRySmqgFtWEiRidiRYPxbeqv2DXX2Z5A4DUH/IB+xBCg//EG3
         RqhWy99glvoyXlCWPtgebjH8s3UDeTmhtkCqCbaA=
Date:   Fri, 14 Dec 2018 09:12:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>, Lucas Stach <l.stach@pengutronix.de>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Olof Johansson <olof@lixom.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Rob Herring <robh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH 1/3] arm64: Remove CONFIG_SOC_IMX8MQ and use ARCH_MXC
 instead
Message-ID: <20181214011207.GB13243@dragon>
References: <1544707047-4417-1-git-send-email-abel.vesa@nxp.com>
 <1544707047-4417-2-git-send-email-abel.vesa@nxp.com>
 <1544711727.3137.32.camel@pengutronix.de>
 <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181213145149.6hyyhi6hxdzvikl4@fsr-ub1664-175>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 02:51:50PM +0000, Abel Vesa wrote:
...
> > > diff --git a/arch/arm64/Kconfig.platforms
> > > b/arch/arm64/Kconfig.platforms
> > > index 7e1545a..318dbb9 100644
> > > --- a/arch/arm64/Kconfig.platforms
> > > +++ b/arch/arm64/Kconfig.platforms
> > > @@ -148,14 +148,6 @@ config ARCH_MXC
> > >  	  This enables support for the ARMv8 based SoCs in the
> > >  	  NXP i.MX family.
> > >  
> > > -config SOC_IMX8MQ
> > > -	bool "i.MX8MQ support"
> > > -	depends on ARCH_MXC
> > > -	select ARM64_ERRATUM_843419
> > > -	select ARM64_ERRATUM_845719
> > > -	help
> > > -	  This enables support for the i.MX8MQ SoC.
> > > -
> > 
> > NACK on this one. Having a single place where stuff that is absolutely
> > critical for proper SoC operation can be selected is very useful and
> > avoids hard to debug issues due to slightly wrong configs in the long
> > run.
> 
> As mentioned in the cover letter, please ignore this patch set entirely.
> The ARCH_MXC is actually used on arm32 too, so it won't work.
> 
> I'm working on a patchset that will add the Kconfig into 
> drivers/clk/imx/ and in it will add CLK_IMX8MQ. That will
> fix the clock dependency since the CLK_IMX8MQ will depend on
> ARCH_MXC and ARM64. I believe the CLK_IMX8QXP will follow
> the same pattern.
> 
> As for the SOC_IMX8MQ, all the other vendors have one single
> config for all the arm64 platforms. TBH, to control every SoC
> independently it's a little bit of an overkill.

Lucas,

We are still waiting for further comments from Olof [1].  But it sounds
like SoC specific option is not welcomed on ARM64.

Shawn

[1] https://patchwork.kernel.org/patch/10727453/#22378669
