Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4207ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB7E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 16:01:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8bxJLlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABB7E20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388603AbeGXRI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 13:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388464AbeGXRI7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 13:08:59 -0400
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE8432088E;
        Tue, 24 Jul 2018 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532448110;
        bh=lRaTDOaAEEOMshC7cwZp7kz+U0prMg2/7vx7+guroUY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j8bxJLlBU9OyebRBaGm45N44spzwLlV/uNeSmksk72ZXG6+ViGfEM+f3K/ZAtwcpT
         09Eo2mZDsMavLmCrKdCH9EiKSYWWCi0RtbFv7aRXo10tFZVt0nt54x3Jwzkb+9zN8s
         6tBG2cYmcKj95QsedrIjnTnNu5sxHti2CeZej4e0=
Date:   Tue, 24 Jul 2018 21:31:40 +0530
From:   Vinod <vkoul@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v3 07/18] dmaengine: dma-jz4780: Add support for the
 JZ4770 SoC
Message-ID: <20180724160140.GI3661@vkoul-mobl>
References: <20180721110643.19624-1-paul@crapouillou.net>
 <20180721110643.19624-8-paul@crapouillou.net>
 <20180724133229.GG3661@vkoul-mobl>
 <1532444695.2610.1@smtp.crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1532444695.2610.1@smtp.crapouillou.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-07-18, 17:04, Paul Cercueil wrote:
> Hi Vinod,
> 
> Le mar. 24 juil. 2018 à 15:32, Vinod <vkoul@kernel.org> a écrit :
> > On 21-07-18, 13:06, Paul Cercueil wrote:
> > >  +static inline void jz4780_dma_chan_enable(struct jz4780_dma_dev
> > > *jzdma,
> > >  +	unsigned int chn)
> > 
> > right justified and aligned with preceding please. While adding new
> > code to a existing driver it is a good idea to conform to existing style
> 
> OK.
> 
> > >  +{
> > >  +	if (jzdma->version == ID_JZ4770)
> > >  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKES, BIT(chn));
> > >  +}
> > >  +
> > >  +static inline void jz4780_dma_chan_disable(struct jz4780_dma_dev
> > > *jzdma,
> > >  +	unsigned int chn)
> > >  +{
> > >  +	if (jzdma->version == ID_JZ4770)
> > >  +		jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DCKEC, BIT(chn));
> > 
> > so if another version has this feature we would do:
> >         if (jzdma->version == ID_JZ4770) ||
> >                 if (jzdma->version == ID_JZXXXX))
> > 
> > and so on.. why not add a value, clk_enable in the description and use
> > that. For each controller it is set to true or false
> 
> I agree with what you said in your other answers.
> However here I still need to check the "version", because on JZ4725B and
> JZ4770+
> the way to start/stop each DMA channel's clock is different, so I can't use
> a boolean

sure describe the behavior and use that. Versions is not a very scalable
way..

-- 
~Vinod
