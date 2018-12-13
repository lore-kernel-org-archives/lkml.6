Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B2D1C65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 372E32086D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCQGdrmy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372E32086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbeLMWbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:31:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37467 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeLMWbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:31:01 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so1729729plr.4;
        Thu, 13 Dec 2018 14:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:reply-to:to:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wvTCZ5GcXBQDXVByr8N3kAHD6K+rCc1BpSV4CYqHkcs=;
        b=LCQGdrmyCjsSw5KtGWt0A68ZQJHpdpRcTIjHB9Xu+LnkxChdrUWhZboglDdDWj92II
         hXkT7iCEC+D0HwIsbbxdYoXf+I2dVQfI8q8vGq5YRrL8jKtDXhqd7j0INGaBsLDC2e/N
         hYJrZaQDh+cZ9pmLGt3sEe4BHiIGG4GSVfBp0lfJkKMB88dSCGYjFAdZeTWHdKTG1cKm
         J4CE8RG8BJYyf1mb3r7KfOv521NJMnJQL2EQOxSTiLeSequh5JXEkp2jaSaXrh6P7Dpl
         ecZ4CCnSEPZOI0db8CE57Iep4EPNT8g+WQfZ9dHgjJx3zf78xq3gxZWWNhwjbGd4c9PU
         lC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:date
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=wvTCZ5GcXBQDXVByr8N3kAHD6K+rCc1BpSV4CYqHkcs=;
        b=or/CvhsF80X/HLbzFLWj07E4Km3sRygWtLTgW74t2vuufeb06e+Wo5nipERhARpBGb
         +T6OybFTwfQsBLlIe3yXvoDrxD2bv5w9Ibw3sDBiqilmaAwo0r/cKfQ7xLFh6lMlmwJv
         izRatKRUQ5ufW6A9GBXWN2ou/dDLyl3+8RlETWCepBNFTjWECyYk5iVA2j7dgdDwJr/c
         lttPvW76lmXzUTreAmBhuNQaWrt4ID0REbVmjYnfEllmLS4HMd4OXQsl8B6Oodhdt/Jh
         h1MLCe7/YtqIPgu7ojP8iCgMydPRSPtn7FMsqkteBm3MjHzXoqU5CUjhkGTLIdZIBnEV
         eQ+A==
X-Gm-Message-State: AA+aEWYOIGX3Op+6dISUex5yfyTJiPuNAk8troMuoOnaBmJviMoZlSaU
        3KtieRcrKygL1r3NobWBCUdK5InQbZk=
X-Google-Smtp-Source: AFSGD/UxuWcy+GV1dkh/XDE9lJd7ppXWhy7QzxcPrf1hn8omePxd7fHummN/YOt18qEU8gEdH0Ghkg==
X-Received: by 2002:a17:902:3f81:: with SMTP id a1mr573424pld.258.1544740260388;
        Thu, 13 Dec 2018 14:31:00 -0800 (PST)
Received: from dwesterg-mobl.amr.corp.intel.com (wsip-174-78-176-194.sd.sd.cox.net. [174.78.176.194])
        by smtp.gmail.com with ESMTPSA id w3sm3673808pge.8.2018.12.13.14.30.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Dec 2018 14:30:59 -0800 (PST)
Message-ID: <cab060d31b36a6a8d2618ac8a65ddf193d338c5e.camel@gmail.com>
Subject: Re: [PATCH] arch: arm: socfpga: arria10: Add stmmac ptp_ref clock
 to socdk devicetree
From:   Dalon Westergreen <dwesterg@gmail.com>
Reply-To: dwesterg@gmail.com
To:     Dinh Nguyen <dinguyen@kernel.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thor.thayer@intel.com
Date:   Thu, 13 Dec 2018 14:30:58 -0800
In-Reply-To: <c703c4d4-4442-19b1-8645-aa906b08f7e6@kernel.org>
References: <20181213205910.26359-1-dalon.westergreen@linux.intel.com>
         <c703c4d4-4442-19b1-8645-aa906b08f7e6@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-12-13 at 15:56 -0600, Dinh Nguyen wrote:
> 
> On 12/13/18 2:59 PM, dwesterg@gmail.com wrote:
> > From: Dalon Westergreen <dalon.westergreen@linux.intel.com>
> > 
> > Add the stmmac ptp_ref clock as it is configured in the arria10 socdk.
> > The stmmac driver defaults the ptp_ref clock to the main stmmac clock
> > if the ptp_ref clock is not set in the devicetree.  This is inapprotiate
> 
> s/inapprotiate/inappropriate
> 
> > for the arria10 socdk.
> > 
> > Signed-off-by: Dalon Westergreen <dalon.westergreen@linux.intel.com>
> > ---
> >  arch/arm/boot/dts/socfpga_arria10_socdk.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> > b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> > index 2a7466891d0e..58bfa84dcdb3 100644
> > --- a/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> > +++ b/arch/arm/boot/dts/socfpga_arria10_socdk.dtsi
> > @@ -74,7 +74,8 @@
> >  &gmac0 {
> >  	phy-mode = "rgmii";
> >  	phy-addr = <0xffffffff>; /* probe for phy addr */
> > -
> > +	clocks = <&l4_mp_clk>, <&peri_emac_ptp_clk>;
> > +	clock-names = "stmmaceth", "ptp_ref";
> >  	
> These should go into the base arria10 dtsi at socfpga_arria10.dtsi?
> Should the other gmacs get the same updates?

Agreed, I will send a new patch set that addresses cv/av, a10, and s10.

> 
> Also the patch header should be "ARM: dts: arria10:"
> 
> Dinh

