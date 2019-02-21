Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBE9C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:27:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B1120880
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rW/GpLyy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726663AbfBUK1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:27:50 -0500
Received: from pandora.armlinux.org.uk ([78.32.30.218]:45800 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfBUK1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:27:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=2JaQ1PlJuxYqC6O7MhBRM+XSftOK69SiRyCGOTj0M3M=; b=rW/GpLyy1CzueMsETvh0Zm0qE
        svcRP8s79ytpYQXpymfIgjMs6hW22joHJAxIoTHo6ESMiIOhnV7CB9a/6w2TdpqoPlWWE+TJf+E5P
        n1glSG2c5INVDgEdKYAm9nrVfSl3+zA4gvtfMHPkDK+MU5MjAHMidIoWtsNdA2rkedCWvHN3MAxH8
        1bXqdxmtXEVN1rLp9v+lqFsQ4/y2VBiagkbsHKzNQcnmeuJiNANs/6JBTW3MFrwy6WC+39IXiRhKL
        lVA+6hWjxnO2J3W/ElOsVQqQEKI7i+Dvv1rVB9Ys+3GI3dg8qLFARZ3SSobAelGRbJNcyhaTwwTw6
        tIbwZJ/pw==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:54670)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gwlZv-0001jk-NA; Thu, 21 Feb 2019 10:27:43 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.89)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1gwlZs-0001HJ-37; Thu, 21 Feb 2019 10:27:40 +0000
Date:   Thu, 21 Feb 2019 10:27:39 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/2] mmc: mmci: add quirk property to add stm32 transfer
 mode
Message-ID: <20190221102739.cc37au6elqu6gvfe@shell.armlinux.org.uk>
References: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550743851-13588-1-git-send-email-ludovic.Barre@st.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 11:10:49AM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch series introduces a bitmap of hardware quirks that require
> some special action. This should reduce the number of boolean
> into variant structure. 
> And adds quirk bit to define sdmmc specific transfer modes.

Please find some other way to deal with these differences.  As far as
I'm concerned, introducing a quirk bitmask such as what was done in
sdhci is a complete disaster and leads to long-term maintanability
problems.

We already have a way to deal with variants in mmci.

> 
> Ludovic Barre (2):
>   mmc: mmci: introduce a quirks property into variant struct
>   mmc: mmci: add quirk property to add stm32 transfer mode
> 
>  drivers/mmc/host/mmci.c | 11 +++++++++++
>  drivers/mmc/host/mmci.h |  9 +++++++++
>  2 files changed, 20 insertions(+)
> 
> -- 
> 2.7.4
> 
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
