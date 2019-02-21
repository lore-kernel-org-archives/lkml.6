Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD39BC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F6522084D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="aSdt3F/n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbfBUODN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:03:13 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:48498 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbfBUODN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:03:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=CrGMWF+zQA+eCZ/zcHrnOfnNSdCwEtuP0uRYXLfWpNI=; b=aSdt3F/nc+5fLJc/TPJkOBWNV
        hah8Jq1IRkWy9rXCsToywhVmS9X5VFqFJ+Ah8KwVDfY816d4C6MMT7yyNfyZYvZrtvTW/kJGTNQCR
        DtMGNGlQrninPv7U6WcDAZTg4Z4SIyjm86RlFJheHSht+O5OB+vqqjA9y7nSc7xHq9zdR+gH5yKEK
        jxMI8WAFY6moXZ/dspBCaMGMAdnd01hlyYQOcic31t9UBnRAR4ece9XLOuUnHnse2IgOFTd2foMq6
        wyqNqMgXL0WVRb73Wf3ATVUesU0RIBCufP2Qnnnlp/U36k3CHAtX15aq2/RqhFOul/eHqx8RQUSfc
        VcHePXa3w==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54676)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gwowM-00032A-Mu; Thu, 21 Feb 2019 14:03:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gwowH-0001OI-21; Thu, 21 Feb 2019 14:03:01 +0000
Date:   Thu, 21 Feb 2019 14:03:00 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ludovic BARRE <ludovic.barre@st.com>
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
Message-ID: <20190221140300.y3tunrvsh3gyig5f@shell.armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
 <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
 <20190221103049.tspc5igoe6wmt3jd@shell.armlinux.org.uk>
 <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a736b773-d6e6-eb81-90d6-ebeab7b401cb@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 02:38:36PM +0100, Ludovic BARRE wrote:
> hi Russell & Ulf
> 
> On 2/21/19 11:30 AM, Russell King - ARM Linux admin wrote:
> > On Thu, Feb 21, 2019 at 10:27:39AM +0000, Russell King - ARM Linux admin wrote:
> > > On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> > > > From: Ludovic Barre <ludovic.barre@st.com>
> > > > 
> > > > This patch series introduces a bitmap of hardware quirks that require
> > > > some special action. This should reduce the number of boolean
> > > > into variant structure.
> > > > And adds quirk bit to define sdmmc specific transfer modes.
> > > 
> > > Please find some other way to deal with these differences.  As far as
> > > I'm concerned, introducing a quirk bitmask such as what was done in
> > > sdhci is a complete disaster and leads to long-term maintanability
> > > problems.
> > > 
> > > We already have a way to deal with variants in mmci.
> > 
> > ... to finish what I was saying ...
> > 
> > and I think that:
> > 
> >          if (variant->blksz_datactrl16)
> >                  datactrl = variant->datactrl_dpsm_enable | (data->blksz << 16);
> >          else if (variant->blksz_datactrl4)
> >                  datactrl = variant->datactrl_dpsm_enable | (data->blksz << 4);
> >          else
> >                  datactrl = variant->datactrl_dpsm_enable | blksz_bits << 4;
> > 
> > ought to become a variant function call which returns the appropriate
> > datactrl value.  This would shrink the amount of variant testing in this
> > path, and also means that going forward we aren't facing an endlessly
> > increasing number of tests here.
> 
> For blksz_datactrl case:
> We could create an inline function for datactrl16 and blksz_datactrl4
> which returns the appropriate datactrl value (specific for ux500v2 and
> qcom). This function could be register in mmci_host_ops structure.

Yes, this is what I'm proposing (except for the "inline" bit which
seems meaningless if it's called via the mmci_host_ops structure.)
I'm also proposing that it shouldn't just be the blksz that's
returned but anything that the variant needs to take account of,
including the stm transfer mode.

> in mmci_start_data function we could call a common function which call a
> hook if defined.
> 
> int mmci_dblksz(struct mmci_host *host)

As this is returning a register value, "u32" would be more appropriate
than "int".

> {
> 	if (host->ops && host->ops->dblksz)
> 		return host->ops->dblk(host);
> 
> 	/* default data block size definition */
> 	blksz_bits = ffs(data->blksz) - 1;
> 	return blksz_bits << 4;
> }
> 
> what do you think about it?

I don't see any reason not to make the call unconditional and have every
variant supply an appropriate function pointer.  IMHO that keeps stuff
cleaner.

> After, I'm afraid to multiply callback function in mmci_host_ops.
> 
> For stm32 transfer mode:
> ditto, a callback function or I keep a boolean?
> 
> BR
> Ludo
> 
> > 
> > > 
> > > > 
> > > > Ludovic Barre (2):
> > > >    mmc: mmci: introduce a quirks property into variant struct
> > > >    mmc: mmci: add quirk property to add stm32 transfer mode
> > > > 
> > > >   drivers/mmc/host/mmci.c | 11 +++++++++++
> > > >   drivers/mmc/host/mmci.h |  9 +++++++++
> > > >   2 files changed, 20 insertions(+)
> > > > 
> > > > -- 
> > > > 2.7.4
> > > > 
> > > > 
> > > > _______________________________________________
> > > > linux-arm-kernel mailing list
> > > > linux-arm-kernel@lists.infradead.org
> > > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > > 
> > > 
> > > -- 
> > > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > > FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
> > > According to speedtest.net: 11.9Mbps down 500kbps up
> > > 
> > > _______________________________________________
> > > linux-arm-kernel mailing list
> > > linux-arm-kernel@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> > > 
> > 
> 

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
