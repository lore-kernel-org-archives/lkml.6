Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CAEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068AF2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="YMKzcJsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfBUKaz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:30:55 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45850 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUKaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:30:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wtrrncZ6UfFBixElIEYzM+q2ZDGzxwx8oBTS2z4o9vI=; b=YMKzcJsQjAuy2Nf4tMRiB3+c5
        SWflI/XC1Ja5GbOCLPAjinv0JAJEGrwN5QsBgjof2jZ/Hsep5BqnvmqbCYY7tTXQ1Iz0lj7ut70OZ
        LiSz2y0PhsFHGPKIcdpNACdeRc9YQwHQC62hFFBSQK+8gWVjQX/GLyOHBD10uRwV3fF2RpzNQaXkb
        5/3f1BNLGC0hhziFcqKnXtC35KlVKYQKCZZvoyE9Ezj9O35nqFTEwdcBIs4K2zE02Tv+BFBNVZtji
        OlEbaKYPOXwZteR2dSg1/T3tmUFBWTBjoxe/aHaRaYs8rw2rODQYgcrsHaUwK/f/OrHWZtFjVmVWb
        pAefTPrRA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:36974)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gwlcw-0001kv-Sm; Thu, 21 Feb 2019 10:30:51 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gwlcv-0001HR-8m; Thu, 21 Feb 2019 10:30:49 +0000
Date:   Thu, 21 Feb 2019 10:30:49 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        srinivas.kandagatla@linaro.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
Message-ID: <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
> On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> > From: Ludovic Barre <ludovic.barre@st.com>
> > 
> > This patch series introduces a bitmap of hardware quirks that require
> > some special action. This should reduce the number of boolean
> > into variant structure. 
> > And adds quirk bit to define sdmmc specific transfer modes.
> 
> Please find some other way to deal with these differences.  As far as
> I'm concerned, introducing a quirk bitmask such as what was done in
> sdhci is a complete disaster and leads to long-term maintanability
> problems.
> 
> We already have a way to deal with variants in mmci.

... to finish what I was saying ...

and I think that:

        if (variant->blksz_datactrl16)
                datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
        else if (variant->blksz_datactrl4)
                datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
        else
                datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;

ought to become a variant function call which returns the appropriate
datactrl value.  This would shrink the amount of variant testing in this
path, and also means that going forward we aren't facing an endlessly
increasing number of tests here.

> 
> > 
> > Ludovic Barre (2):
> >   mmc: mmci: introduce a quirks property into variant struct
> >   mmc: mmci: add quirk property to add stm32 transfer mode
> > 
> >  drivers/mmc/host/mmci.c | 11 +++++++++++
> >  drivers/mmc/host/mmci.h |  9 +++++++++
> >  2 files changed, 20 insertions(+)
> > 
> > -- 
> > 2.7.4
> > 
> > 
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > 
> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> According to speedtest.net: 11.9Mbps down 500kbps up
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
