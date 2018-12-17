Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1962C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97DF22145D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 16:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XLU7MEJr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388075AbeLQQEH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 11:04:07 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55732 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbeLQQEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 11:04:06 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBHG3svk114023;
        Mon, 17 Dec 2018 10:03:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545062634;
        bh=eh0pclXDIXQe5rwrioJKs8t5pgG/2zOaRzC4OrntQ8Y=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=XLU7MEJrOeJKOWmrS+y8G+A84WE+iTU7D6uBYe5SRIOHKuEUawTEmIjMNPAIboEKy
         xCL+wV1gHS47tZn9uw2NvfYCLduDhyhetOvRhdjA8j4mZF4+yaj4y3nxNBzbO19frt
         NtBGLzVyVBxOxpeqR/BIO60gmGUnJK7HF9iozn3I=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBHG3spr106368
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 10:03:54 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 10:03:53 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 10:03:53 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBHG3oeK006246;
        Mon, 17 Dec 2018 10:03:50 -0600
Subject: Re: [PATCH 12/16] dt-bindings: remoteproc: ti-pruss: Document
 application node bindings
To:     Rob Herring <robh@kernel.org>
References: <1543218769-5507-1-git-send-email-rogerq@ti.com>
 <1543218769-5507-13-git-send-email-rogerq@ti.com>
 <20181211220637.GA32460@bogus>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <tony@atomide.com>, <bcousson@baylibre.com>, <ssantosh@kernel.org>,
        <s-anna@ti.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C17C8E5.5050301@ti.com>
Date:   Mon, 17 Dec 2018 18:03:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20181211220637.GA32460@bogus>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/18 00:06, Rob Herring wrote:
> On Mon, Nov 26, 2018 at 09:52:45AM +0200, Roger Quadros wrote:
>> From: Tero Kristo <t-kristo@ti.com>
>>
>> Add documentation for the Texas Instruments PRU application nodes.
>> These are used to configure specific user applications for PRU instances.
>>
>> Signed-off-by: Tero Kristo <t-kristo@ti.com>
>> [s-anna@ti.com: some binding updates]
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  .../devicetree/bindings/soc/ti/ti,pruss.txt        | 43 ++++++++++++++++++++++
>>  1 file changed, 43 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>> index 3e5f32f..94c91ee 100644
>> --- a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>> @@ -210,6 +210,38 @@ used in TI Davinci SoCs. Please refer to the corresponding binding document,
>>  Documentation/devicetree/bindings/net/davinci-mdio.txt for details.
>>  
>>  
>> +Application/User Nodes
>> +=======================
>> +A PRU application/user node typically uses one or more PRU device nodes to
>> +implement a PRU application/functionality. Each application/client node would
>> +need a reference to at least a PRU node, and optionally pass some configuration
>> +parameters.
>> +
>> +Required Properties:
>> +--------------------
>> +- prus                 : phandles to the PRU nodes used
>> +
>> +Optional Properties:
>> +--------------------
>> +- firmware-name        : firmwares for the PRU cores, the default firmware
>> +                         for the core from the PRU node will be used if not
>> +                         provided. The firmware names should correspond to
>> +                         the PRU cores listed in the 'prus' property
>> +- ti,pruss-gp-mux-sel  : array of values for the GP_MUX_SEL under PRUSS_GPCFG
>> +                         register for a PRU. This selects the internal muxing
>> +                         scheme for the PRU instance. If not provided, the
>> +                         default out-of-reset value (0) for the PRU core is
>> +                         used. Values should correspond to the PRU cores listed
>> +                         in the 'prus' property
>> +- ti,pru-interrupt-map : PRU interrupt mappings, containing an array of entries
>> +                         with each entry consisting of 4 cell-values. First one
>> +                         is an index towards the "prus" property to identify the
>> +                         PRU core for the interrupt map, second is the PRU
>> +                         System Event id, third is the PRU interrupt channel id
>> +                         and fourth is the PRU host interrupt id. If provided,
>> +                         this map will supercede any other configuration
>> +                         provided through firmware
> 
> Can't you use 'interrupt-map' or use more cells for the PRU intc cells. 
> Or use interrupts-extended if you need more than 1 parent.
> 

We don't need more then one parent.

Using more cells for PRU INTC sounds like doable. Although we should be able to support
2 formats (i.e. 4 cells when mapping is provided in DT and 1 cell when mapping information
comes from firmware via resource table)

I'm not sure how 'interrupt-map' can be used as we're not really translating between
2 interrupt domains.

>> +
>>  Example:
>>  ========
>>  1.	/* AM33xx PRU-ICSS */
>> @@ -397,3 +429,14 @@ Example:
>>  			...
>>  		};
>>  	};
>> +
>> +3:	/* PRU application node example */
>> +	app_node: app_node {
>> +		prus = <&pru1_0>, <&pru1_1>;
>> +		firmware-name = "pruss-app-fw", "pruss-app-fw-2";
>> +		ti,pruss-gp-mux-sel = <2>, <1>;
>> +		/* setup interrupts for prus:
>> +		   prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
>> +		   prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
>> +		ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
>> +	}

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
