Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A32DC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E258C217D6
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 15:42:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="MivrLwRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729910AbfBEPm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 10:42:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45412 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfBEPm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 10:42:26 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x15FfSSt032537;
        Tue, 5 Feb 2019 09:41:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549381288;
        bh=LVmiQJqVUsbCq2CDpeZcR5gAo4KGKhn9z/Hsj7ma+6E=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=MivrLwRup8Jbh7zHg7jpD1zP9kPhQee8RVtuqKTj1aS3RWH7bwaz+f46wvhNd/SZg
         l2nZc/JXs7HOqbyRalv/RJQRfckOx75PaGJxCbcbX9aErgBLWQNeI168kL1lt2MJgR
         BDHyc1oDPVNCf/lbVcKv0HW8tFjyAOTJzn1pz004=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x15FfS1q050078
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 09:41:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 09:41:27 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 09:41:27 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x15FfN8e021659;
        Tue, 5 Feb 2019 09:41:24 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Murali Karicheri <m-karicheri2@ti.com>,
        Tony Lindgren <tony@atomide.com>, <s-anna@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <20190204163312.GI5720@atomide.com> <5C5959DB.2090608@ti.com>
 <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>,
        <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <woods.technical@gmail.com>,
        <linux-omap@vger.kernel.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C59AEA3.1080400@ti.com>
Date:   Tue, 5 Feb 2019 17:41:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <f1b689cc-5d1b-0333-7a1c-cb6d58169e12@ti.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Murali,

On 05/02/19 17:08, Murali Karicheri wrote:
> Hi Roger,
> 
> On 02/05/2019 04:39 AM, Roger Quadros wrote:
>> Hi Tony & Suman,
>>
>> On 04/02/19 18:33, Tony Lindgren wrote:
>>> Hi,
>>>
>>> * Roger Quadros <rogerq@ti.com> [190204 14:23]:
>>>> From: Suman Anna <s-anna@ti.com>
>>> ...
>>>> +Example:
>>>> +========
>>>> +1.    /* AM33xx PRU-ICSS */
>>>> +
>>>> +    pruss: pruss@0 {
>>>> +        compatible = "ti,am3356-pruss";
>>>> +        reg = <0x0 0x2000>,
>>>> +              <0x2000 0x2000>,
>>>> +              <0x10000 0x3000>;
>>>> +        reg-names = "dram0", "dram1",
>>>> +                "shrdram2";
>>>> +        #address-cells = <1>;
>>>> +        #size-cells = <1>;
>>>> +        ranges;
>>>
>>> Thanks for fixing up the reg ranges for the top level node.
>>>
>>> Ideally there would not even be a top level node here as
>>> AFAIK the whole PRUSS is a collection of devices on a PRU
>>> internal interconnect. So following that path a bit further..
>>> How about just get rid of the top level node and just do:
>>>
>>> pruss: pruss@0 {
>>>     dram0: memory@0 {
>>>            device_type = "memory";
>>>            reg = <0x0 0x2000>;
>>>     };
>>>
>>>     dram1: memory@2000 {
>>>            device_type = "memory";
>>>            reg = <0x2000 0x2000>;
>>>     };
>>
>> Actually dram0 and dram1 are data memories for PRU0 and PRU1 respectively.
>> Isn't it better if they are moved to the pru node?
>> e.g.
>>
>>     pru0: pru@34000 {
>>         compatible = "ti,am3356-pru";
>>         reg = <0x34000 0x2000>,
>>               <0x22000 0x400>,
>>               <0x22400 0x100>,
>>               <0x0     0x2000>;
>>         reg-names = "iram", "control", "debug", "dram";
>>         ...
>>     };
>>
>>     pru1: pru@38000 {
>>         compatible = "ti,am3356-pru";
>>         reg = <0x38000 0x2000>,
>>               <0x24000 0x400>,
>>               <0x24400 0x100>,
>>               <0x2000  0x2000>;
>>         reg-names = "iram", "control", "debug", "dram";
>>         ...
>>     };
>>
>> I think it is better to place a restriction that firmware on PRU0 cannot use data
>> memory of PRU1 and vice versa.
>>
> That will not work as there are switch firmware cases where PRU access
> DRAM of other PRU and is a valid case to support in the future. So let
> us not do that.

PRU firmware accessing DRAM of other PRU is a design contract and that use case
requires both PRUs to be loaded with matching firmware. That should continue to work.

What I'm suggesting here is that kernel remoteproc driver should have nothing to do
with the other PRU's data RAM.

The application driver if needs both PRUs then it can obviously access both DRAMs
as it has a phandle to both PRUs.

cheers,
-roger

> 
> Murali
>> Application drivers do sometimes need to read/write to data memory. The pru_rproc
>> driver could provide a API for the application drivers to get virtual address of
>> the respective PRU's data memory.
>>
>>>
>>>     shrdram2: memory@10000 {
>>>         device_type = "memory";
>>>         reg = <0x10000 0x3000>;
>>>     };
>>
>> Shared RAM is not so straight forward. Both PRU firmwares and both application drivers
>> might need to read/write here. The area split is decided by firmware design and there
>> is no hardware protection to prevent from stomping on each others toes.
>>
>> We need a carveout based memory allocator at least I think that can do a
>> allocate(base_offset, size); into shared RAM.
>>
>> This could be used by pru_rproc driver at firmware load time and by application drivers
>> at initialization time.
>>
>> Thoughts?
>>
>>>
>>>     pruss_cfg: cfg@26000 {
>>>         ...
>>>     };
>>>     ...
>>> };
>>>
>>> If the device_type = "memory" cannot be used here for
>>> being specific to the top level properties, then
>>> there's probably some other generic property usable
>>> here :)
>>>
>>>> +        pruss_mii_rt: mii_rt@32000 {
>>>> +            reg = <0x32000 0x58>;
>>>> +        };
>>>
>>> The node name should not have underscores so
>>> pruss_mii_rt: mii-rt@32000. Please check the others
>>> too, like app_node.
>>>
>>
>> OK.
>>
>>>> +    app_node: app_node {
>>>> +        prus = <&pru0>, <&pru1>;
>>>> +        firmware-name = "pruss-app-fw", "pruss-app-fw-2";
>>>> +        ti,pruss-gp-mux-sel = <2>, <1>;
>>>> +        /* setup interrupts for prus:
>>>> +           prus[0] => pru1_0: ev=16, chnl=2, host-irq=7,
>>>> +           prus[1] => pru1_1: ev=19, chnl=1, host-irq=3 */
>>>> +        ti,pru-interrupt-map = <0 16 2 7 >, <1 19 1 3>;
>>>> +    }
>>>
>>> If the ti,pruss-gp-mux-sel and ti,pru-interrupt-map are
>>> firmware configuration options, maybe leave them out of
>>> the dts completely and make the app-node optional.
>>
>> Yes the app-node is optional. I will mention it.
>>
>> No, ti,pruss-gp-mux-sel and ti,pru-interrupt-map are not firmware options.
>> But these settings are application/firmware specific.
>>
>> ti,pru-interrupt-map specifies the configuration to be used for the INTC interrupt
>> controller.
>>
>> ti,pruss-gp-mux-sel is used to configure this register.
>> "Table 30-20. PRUSS_GPCFG0" in http://www.tij.co.jp/jp/lit/ug/spruhz7h/spruhz7h.pdf
>> "29:26 PR1_PRU0_GP_MUX_SEL"
>>
>> It configures how the pins from the PRUSS module are routed internally
>> to the various modules.
>>
>> see "30.2.1 PRU-ICSS I/O Interface"
>> and "Table 30-1. PRU-ICSS1 I/O Signals"
>>
>>>
>>> And have a proper compatible for this node such as
>>> "ti,pruss-app-xyz". And this should be only set if the the
>>> hardware is wired up in such way that things need to be
>>> configured in the dts rather than by the firmware.
>>
>> Yes, compatible is a required property as we need to load
>> the appropriate application (kernel space) driver for it.
>> I will fix the example.
>>
>>>
>>> And then you can just hide mux-sel and interrupt-map
>>> behind the compatible property for that hardware. And
>>> leave them out from the dts and have the handling driver
>>> would set mux-sel and interrupt-map based on the
>>> match->data during probe.
>>
>> To summarize:
>>
>> I'll mark the app node as optional. Only required if a kernel
>> driver is required for the application.
>> Compatible is mandatory for app node.
>> ti,pruss-gp-mux-sel and ti,pru-interrupt-map are optional
>> for app node.
>>
>> cheers,
>> -roger
>>

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
