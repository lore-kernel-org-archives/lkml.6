Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 26D01C07D5C
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD75C208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 13:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ALbu+T40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD75C208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755342AbeFNNFV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 09:05:21 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:17644 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755200AbeFNNFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 09:05:05 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5ED4an5012098;
        Thu, 14 Jun 2018 08:04:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528981476;
        bh=WnOF6B5t6Uxo2Kr94e2RIKEnrGP0S/Q5JnH5EGBjmS8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=ALbu+T40jEGmCrm3dPqqv2FuG4du/oMCURGyDIsa/Zw8hCsYxmcvag91xWjHN3Z08
         598JhLpT/Sr5wnQdcuhJPDBBfh7Vj/U8oiEBIW5g/N2R1YnGgnjM8r7AJ9BUZPS/+2
         oDdo5jmrtqiM7mjfZRuH+IBozMX64AsXh0LnCDDY=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5ED4aGv010258;
        Thu, 14 Jun 2018 08:04:36 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 14
 Jun 2018 08:04:35 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 14 Jun 2018 08:04:35 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5ED4ZNC021494;
        Thu, 14 Jun 2018 08:04:35 -0500
Date:   Thu, 14 Jun 2018 08:04:35 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Vignesh R <vigneshr@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 5/6] arm64: dts: ti: Add Support for AM654 SoC
Message-ID: <20180614130435.j2bmzam6corrjylx@kahuna>
References: <20180605060510.32473-1-nm@ti.com>
 <CAL_JsqJusWTvr4A_-Bk81meYddMHBMJ4=Fch6L0MFoF7HfBW2w@mail.gmail.com>
 <20180607233853.p7iw7nlxxuyi66og@kahuna>
 <20180614123805.GF112168@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180614123805.GF112168@atomide.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12:38-20180614, Tony Lindgren wrote:
> Some comments on the ranges below.

Thanks for reviewing in detail (I understand we are in the middle of
merge window, so thanks for the extra effort).

> 
> * Nishanth Menon <nm@ti.com> [180607 16:41]:
> > +	soc0: soc0 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <2>;
> > +		#size-cells = <2>;
> > +		ranges;
> 
> I suggest you leave out the soc0, that's not real. Just make

Why is that so, on a more complex board representation with multiple
SoCs, this is a clear node indicating what the main SoC is in the final
dtb representation.

> the cbass@0 the top level interconnect. It can then provide
> ranges to mcu interconnect which can provide ranges to the wkup
> interconnect. So just model it after what's in the hardware :)

That might blow up things quite a bit - it is like the comment in:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/dra7.dtsi#n141

The trees are pretty deep with many interconnections (example main does
have direct connections to wkup as well, which is simplified off in
top level diagram) - basically it is not a direct one dimensional
relationship. But then, the same is the case for other SoCs..

we can represent NAVSS as a bus segment as well.

> 
> I found the following ranges based on a quick look at the TRM,
> they could be split further if needed for power domains for
> genpd for example.

genpd is not really an issue, since it is handled in system firmware and
OSes dont have a visibility into the permitted ranges that the OS is
allowed to use.

I think it is just how accurate a representation is it worth.

> 
> main covers
> 0x0000000000 - 0x5402000000
> 
> main provides at least the following ranges for mcu
> 0x0028380000 - 0x002bc00000
> 0x0040080000 - 0x0041c80000
> 0x0045100000 - 0x0045180000
> 0x0045600000 - 0x0045640000
> 0x0045810000 - 0x0045860000
> 0x0045950000 - 0x0045950400
> 0x0045a50000 - 0x0045a50400
> 0x0045b04000 - 0x0045b06400
> 0x0045d10000 - 0x0045d24000
> 0x0046000000 - 0x0060000000
> 0x0400000000 - 0x0800000000
> 0x4c3c020000 - 0x4c3c030000
> 0x4c3e000000 - 0x4c3e040000
> 0x5400000000 - 0x5402000000
> 
> then mcu provides the following ranges for wkup
> 0x0042000000 - 0x0044410020
> 0x0045000000 - 0x0045030000
> 0x0045080000 - 0x00450a0000
> 0x0045808000 - 0x0045808800
> 0x0045b00000 - 0x0045b02400
> 
> This based on looking at "figure 1-1. device top-level
> block diagram" and the memory map in TRM.

Thanks for researching. I did debate something like:

From A53 view, a more accurate view might be  - from an interconnect
view of the world (still simplified - i have ignored the sub bus
segments in the representations below):

msmc {
	navss_main {
		cbass_main{
			cbass_mcu {
				navss_mcu {
				};
				cbass_wkup{
				};
			};
		};
	};
};

From R5 view, the view will be very different ofcourse:
view of the world (still simplified):

cbass_mcu {
	navss_mcu {
	};
	cbass_wkup{
	};
	cbass_main{
		navss_main {
			msmc {
			};
		};
	};
};


Do we really need this level of representation, I am not sure I had seen
this detailed a representation in other aarch64 SoCs (I am sure they are
as complex as TI SoCs as well).

I am trying to understand the direction and logic why we'd want to have
such a detailed representation.

A more flatter representation of just the main segments allow for dts
reuse between r5 and a53 as well (but that is minor).


Thoughts?
-- 
Regards,
Nishanth Menon
