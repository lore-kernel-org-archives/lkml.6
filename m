Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2F9C433F4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:45:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE8320841
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 02:45:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="soKSKrJP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE8320841
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727212AbeIAGzS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 02:55:18 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44032 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeIAGzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 02:55:18 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w812iUE7045914;
        Fri, 31 Aug 2018 21:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1535769870;
        bh=y1lIDg1TblYGZLMJp3lX4rTKycXG/xo44oMt5Y5lrrw=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=soKSKrJP7pj+/HM/1o/0RuI8l2whLGwEHFn30Q65E7uizHI6hcZ73Vtsh1Lww1Pdk
         eCeCs+4EQN8Nuq/2Va9hdt2x3y8D95euLcXzNhL2qO52wlRhyuVBV9XP80KJYTkEpU
         wg0MOjgwpAsrQWYjOSvkQW5Lfdud1Nkz8arDBKAg=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w812iUaq012437;
        Fri, 31 Aug 2018 21:44:30 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 31
 Aug 2018 21:44:30 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 31 Aug 2018 21:44:30 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w812iT9s018702;
        Fri, 31 Aug 2018 21:44:30 -0500
Date:   Fri, 31 Aug 2018 21:44:29 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, <nsekhar@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
Message-ID: <20180901024429.fwnzriuqan3v55dj@akan>
References: <20180828102642.26482-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180828102642.26482-1-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:56-20180828, Kishon Vijay Abraham I wrote:
[...]
>  		cbass_mcu: interconnect@28380000 {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> -			ranges = <0x28380000 0x28380000 0x03880000>, /* MCU NAVSS*/
> -				 <0x40200000 0x40200000 0x00900100>, /* First peripheral window */
> -				 <0x42040000 0x42040000 0x03ac2400>, /* WKUP */
> -				 <0x45100000 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
> -				 <0x46000000 0x46000000 0x00200000>, /* CPSW */
> -				 <0x47000000 0x47000000 0x00068400>; /* OSPI space 1 */
> +			ranges = <0x28380000 0x00 0x28380000 0x03880000>, /* MCU NAVSS*/
> +				 <0x40200000 0x00 0x40200000 0x00900100>, /* First peripheral window */
> +				 <0x42040000 0x00 0x42040000 0x03ac2400>, /* WKUP */
> +				 <0x45100000 0x00 0x45100000 0x00c24000>, /* MMRs, remaining NAVSS */
> +				 <0x46000000 0x00 0x46000000 0x00200000>, /* CPSW */
> +				 <0x47000000 0x00 0x47000000 0x00068400>; /* OSPI space 1 */
>  


You might need #address-cells and #size-cells as 2 in MCU as
well.. Could you refer to response from Vignesh?
https://marc.info/?l=linux-arm-kernel&m=153572924921895&w=2

-- 
Regards,
Nishanth Menon
