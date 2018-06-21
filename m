Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B03C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B941E208A1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 11:37:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="olByLN9p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B941E208A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933202AbeFULhQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 07:37:16 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:42972 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933039AbeFULhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 07:37:14 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5LBaisT011291;
        Thu, 21 Jun 2018 06:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529581004;
        bh=3Kn5BfHjsDF323fZOL+MokawdwcNHwxcS/4dqVsBvEI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=olByLN9pQl8u1Is7rH8i3tfBaSDB/iWxxyAmS5wkLGnYmXPX6C4NOnRDaNwMsBpBg
         9yOx3qp1GkOCxHlAQXW+vs/Xpomt7B6UcB4U6kfnoXCAKns4qBIZOesub2basVYfyk
         nhuJ8ePOCgk5HDTlvShtsspgYR4Sh3sDs8rJRE3A=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5LBai6r017883;
        Thu, 21 Jun 2018 06:36:44 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 06:36:44 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 06:36:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5LBaioB016593;
        Thu, 21 Jun 2018 06:36:44 -0500
Date:   Thu, 21 Jun 2018 06:36:44 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Tony Lindgren <tony@atomide.com>
CC:     Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <t-kristo@ti.com>, Sekhar Nori <nsekhar@ti.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH 3/5] arm64: dts: ti: Add Support for AM654 SoC
Message-ID: <20180621113644.g24yzcixzeegsiks@kahuna>
References: <20180619194253.27288-1-nm@ti.com>
 <20180619194253.27288-4-nm@ti.com>
 <20180621053754.GD112168@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180621053754.GD112168@atomide.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05:37-20180621, Tony Lindgren wrote:
> * Nishanth Menon <nm@ti.com> [180619 19:46]:
> > +	cbass_main: cbass@100000 {
> > +		compatible = "simple-bus";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		ranges = <0x00100000 0x00 0x00100000 0x00020000>, /* ctrl mmr */
> > +			 <0x00600000 0x00 0x00600000 0x00001100>, /* GPIO */
> > +			 <0x00900000 0x00 0x00900000 0x00012000>, /* serdes */
> > +			 <0x01000000 0x00 0x01000000 0x0af02400>, /* Most peripherals */
> > +			 <0x30800000 0x00 0x30800000 0x0bc00000>, /* MAIN NAVSS */
> > +			 /* MCUSS Range */
> > +			 <0x28380000 0x00 0x28380000 0x03880000>,
> > +			 <0x40200000 0x00 0x40200000 0x00900100>,
> > +			 <0x42040000 0x00 0x42040000 0x03ac2400>,
> > +			 <0x45100000 0x00 0x45100000 0x00c24000>,
> > +			 <0x46000000 0x00 0x46000000 0x00200000>,
> > +			 <0x47000000 0x00 0x47000000 0x00068400>;
> > +
> > +		cbass_mcu: cbass@28380000 {
> > +			compatible = "simple-bus";
> > +			#address-cells = <1>;
> > +			#size-cells = <1>;
> > +			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
> > +				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
> > +				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
> > +				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
> > +				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
> > +				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
> > +
> > +			cbass_wakeup: cbass@42040000 {
> > +				compatible = "simple-bus";
> > +				#address-cells = <1>;
> > +				#size-cells = <1>;
> > +				/* WKUP  Basic peripherals */
> > +				ranges = <0x42040000 0x42040000 0x03ac2400>;
> > +			};
> > +		};
> > +	};
> > +};
> 
> You should use cbass_main: interconnect@1000000 and so on here.
> Other than that looks good to me, thanks for updating it.

Thanks, will wait till Monday to see if there are any further comments,
else will post a V2.

-- 
Regards,
Nishanth Menon
