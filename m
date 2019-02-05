Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CBBBC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D20BB20844
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 09:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="X6cqFFcS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfBEJko (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 04:40:44 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52968 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbfBEJko (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 04:40:44 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x159dlHo086349;
        Tue, 5 Feb 2019 03:39:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549359587;
        bh=8Wrz2vOS/AbHbtKbUZarWOdg4o6FCcrC8YxVAjfAYtU=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=X6cqFFcSN0XZ5CRQuB8cjP5hIsBGFkw/1XdFMwUROdN6AmjEm4/xdJU/iyYuKR5cz
         y1db2wjG+++0Z1zkP9vbcDQvqxxpFXs4Ox1hwDnvrqjAfBDZ+4PtvXO1N6coL2eJNb
         5ojOA+N+gTRd77WkfzV361yoszIkvGMjHvmswWWA=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x159dkWB021282
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 03:39:46 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 03:39:43 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 03:39:43 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x159dek9016901;
        Tue, 5 Feb 2019 03:39:40 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Tony Lindgren <tony@atomide.com>, <s-anna@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C5959DB.2090608@ti.com>
Date:   Tue, 5 Feb 2019 11:39:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190204163312.GI5720@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony & Suman,

On 04/02/19 18:33, Tony Lindgren wrote:
> Hi,
> 
> * Roger Quadros <rogerq@ti.com> [190204 14:23]:
>> From: Suman Anna <s-anna@ti.com>
> ...
>> +Example:
>> +========
>> +1.	/* AM33xx PRU-ICSS */
>> +
>> +	pruss: pruss@0 {
>> +		compatible = "ti,am3356-pruss";
>> +		reg = <0x0 0x2000>,
>> +		      <0x2000 0x2000>,
>> +		      <0x10000 0x3000>;
>> +		reg-names = "dram0", "dram1",
>> +			    "shrdram2";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges;
> 
> Thanks for fixing up the reg ranges for the top level node.
> 
> Ideally there would not even be a top level node here as
> AFAIK the whole PRUSS is a collection of devices on a PRU
> internal interconnect. So following that path a bit further..
> How about just get rid of the top level node and just do:
> 
> pruss: pruss@0 {
> 	dram0: memory@0 {
> 	       device_type = "memory";
> 	       reg = <0x0 0x2000>;
> 	};
> 
> 	dram1: memory@2000 {
> 	       device_type = "memory";
> 	       reg = <0x2000 0x2000>;
> 	};

Actually dram0 and dram1 are data memories for PRU0 and PRU1 respectively.
Isn't it better if they are moved to the pru node?
e.g.

	pru0: pru@34000 {
		compatible = "ti,am3356-pru";
		reg = <0x34000 0x2000>,
		      <0x22000 0x400>,
		      <0x22400 0x100>,
		      <0x0     0x2000>;
		reg-names = "iram", "control", "debug", "dram";
		...
	};

	pru1: pru@38000 {
		compatible = "ti,am3356-pru";
		reg = <0x38000 0x2000>,
		      <0x24000 0x400>,
		      <0x24400 0x100>,
		      <0x2000  0x2000>;
		reg-names = "iram", "control", "debug", "dram";
		...
	};

I think it is better to place a restriction that firmware on PRU0 cannot use data
memory of PRU1 and vice versa.

Application drivers do sometimes need to read/write to data memory. The pru_rproc
driver could provide a API for the application drivers to get virtual address of
the respective PRU's data memory.

> 
> 	shrdram2: memory@10000 {
> 		device_type = "memory";
> 		reg = <0x10000 0x3000>;
> 	};

Shared RAM is not so straight forward. Both PRU firmwares and both application drivers
might need to read/write here. The area split is decided by firmware design and there
is no hardware protection to prevent from stomping on each others toes.

We need a carveout based memory allocator at least I think that can do a
allocate(base_offset, size); into shared RAM.

This could be used by pru_rproc driver at firmware load time and by application drivers
at initialization time.

Thoughts?

> 
> 	pruss_cfg: cfg@26000 {
> 		...
> 	};
> 	...
> };
> 
> If the device_type = "memory" cannot be used here for
> being specific to the top level properties, then
> there's probably some other generic property usable
> here :)
> 
>> +		pruss_mii_rt: mii_rt@32000 {
>> +			reg = <0x32000 0x58>;
>> +		};
> 
> The node name should not have underscores so
> pruss_mii_rt: mii-rt@32000. Please check the others
> too, like app_node.
> 

OK.

>> +	app_node: app_node {
>> +		prus = <&pru0>, <&pru1>;
>> +		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
>> +		ti,pruss-gp-mux-sel = <2>, <1>;
>> +		/* setup interrupts for prus:
>> +		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
>> +		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
>> +		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
>> +	}
> 
> If the ti,pruss-gp-mux-sel and ti,pru-interrupt-map are
> firmware configuration options, maybe leave them out of
> the dts completely and make the app-node optional.

Yes the app-node is optional. I will mention it.

No, ti,pruss-gp-mux-sel and ti,pru-interrupt-map are not firmware options.
But these settings are application/firmware specific.

ti,pru-interrupt-map specifies the configuration to be used for the INTC interrupt
controller.

ti,pruss-gp-mux-sel is used to configure this register.
"Table 30-20. PRUSS_GPCFG0" in http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf
"29:26 PR1_PRU0_GP_MUX_SEL"

It configures how the pins from the PRUSS module are routed internally
to the various modules.

see "30.2.1 PRU-ICSS I/O Interface"
and "Table 30-1. PRU-ICSS1 I/O Signals"

> 
> And have a proper compatible for this node such as
> "ti,pruss-app-xyz". And this should be only set if the the
> hardware is wired up in such way that things need to be
> configured in the dts rather than by the firmware.

Yes, compatible is a required property as we need to load
the appropriate application (kernel space) driver for it.
I will fix the example.

> 
> And then you can just hide mux-sel and interrupt-map
> behind the compatible property for that hardware. And
> leave them out from the dts and have the handling driver
> would set mux-sel and interrupt-map based on the
> match->data during probe.

To summarize:

I'll mark the app node as optional. Only required if a kernel
driver is required for the application.
Compatible is mandatory for app node.
ti,pruss-gp-mux-sel and ti,pru-interrupt-map are optional
for app node.

cheers,
-roger

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
