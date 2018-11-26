Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C3AC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0054920855
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 07:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PvyxYv1d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0054920855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726260AbeKZSlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 13:41:17 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:48310 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbeKZSlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 13:41:17 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAQ7luHr114135;
        Mon, 26 Nov 2018 01:47:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543218476;
        bh=vLhLOTDDJ8LWZ81rYWMroSCG/ys0Ix9YMbtoG54eTIg=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=PvyxYv1d0ZMsdmVWcZPV+JQAtedvTVaKBztlIPJZfIaaSNErN59Yqfxwf9KB2a5Wk
         HWEmxrUJKMfCjl8aHYIZRXghQCAL9hwHB3lEOhqky1w4qeEiUzQ9qDNNlToE+Q36/F
         gX0gjz/gWp4CvtlyHKzQKylRVT4Vpt5mcOfP2cMM=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAQ7lusc078661
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 26 Nov 2018 01:47:56 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 26
 Nov 2018 01:47:53 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 26 Nov 2018 01:47:53 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAQ7lnie003600;
        Mon, 26 Nov 2018 01:47:50 -0600
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Tony Lindgren <tony@atomide.com>
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <20181123162417.GZ53235@atomide.com>
CC:     <robh+dt@kernel.org>, <bcousson@baylibre.com>,
        <ssantosh@kernel.org>, <ohad@wizery.com>,
        <bjorn.andersson@linaro.org>, <s-anna@ti.com>, <nsekhar@ti.com>,
        <t-kristo@ti.com>, <nsaulnier@ti.com>, <jreeder@ti.com>,
        <m-karicheri2@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5BFBA525.3060806@ti.com>
Date:   Mon, 26 Nov 2018 09:47:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181123162417.GZ53235@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/11/18 18:24, Tony Lindgren wrote:
> Hi,
> 
> * Roger Quadros <rogerq@ti.com> [181122 11:39]:
>> From: Suman Anna <s-anna@ti.com>
>> +Example:
>> +========
>> +1.	/* AM33xx PRU-ICSS */
>> +	pruss_soc_bus: pruss_soc_bus@4a326004 {
>> +		compatible = "ti,am3356-pruss-soc-bus";
>> +		ti,hwmods = "pruss";
>> +		reg = <0x4a326004 0x4>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
> 
> The top level interconnect target module driver should be just ti-sysc
> as documented in Documentation/devicetree/bindings/bus/ti-sysc.txt.
> AFAIK there is nothing PRU specific there. So let's not add yet
> another custom interconnect target module handling code to deal with.
> 
> I also posted a patch a while back for using reset-simple with
> ti-sysc as "[PATCHv2] reset: ti-rstctrl: use the reset-simple driver".
> 

Cool. I will try that out.

>> +			pruss_cfg: cfg@4a326000 {
>> +				compatible = "syscon";
>> +				reg = <0x4a326000 0x2000>;
>> +			};
>> +
>> +			pruss_iep: iep@4a32e000 {
>> +				compatible = "syscon";
>> +				reg = <0x4a32e000 0x31c>;
>> +			};
>> +
>> +			pruss_mii_rt: mii_rt@4a332000 {
>> +				compatible = "syscon";
>> +				reg = <0x4a332000 0x58>;
>> +			};
> 
> Hmm what are these syscon register actually doing? Sseems like
> they should be just handled by a phy driver nowadays?

Not the PHY driver but the Ethernet driver. The PHY driver will be
a davinci-MDIO device node (not yet in this series). I should probably
add merge that with this series.

The Ethernet device tree node will reference to these syscon nodes.
e.g.
        pruss2_eth {
                compatible = "ti,am57-prueth";
                prus = <&pru2_0>, <&pru2_1>;
                firmware-name = "ti-pruss/am57xx-pru0-prueth-fw.elf",
                                "ti-pruss/am57xx-pru1-prueth-fw.elf";
                sram = <&ocmcram1>;
                interrupt-parent = <&pruss2_intc>;
-->             mii-rt = <&pruss2_mii_rt>;
-->             iep = <&pruss2_iep>;
	}

Do you see any issues with that?

> 
> Other than that the binding looks OK to me. Good to finally
> see some activity in getting the PRU support merged :)

Thanks :)

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
