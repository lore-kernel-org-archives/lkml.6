Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79C1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F7AE20868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 16:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lechnology.com header.i=@lechnology.com header.b="KMyk7Cfs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7AE20868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lechnology.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729067AbeK3DY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 22:24:57 -0500
Received: from vern.gendns.com ([98.142.107.122]:52536 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728136AbeK3DY5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 22:24:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=lechnology.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=52ybRUybQRHGNfoVsCBV1aI2xJ6q7oVESBG5aiohejo=; b=KMyk7CfsbhHFhZ7Ah0PZuSWVP5
        kv+iayp1Qvu0rQvTr9U/zm0e+kmo9JLewPqBH2TaumfmI+PZSmvznTyiW6BgYft97w7bpKkHVbJ1h
        9YC8xF4WmHJcyE6veUktAtOWi/AFcSwyp1n6Sk5FsxKaHkvxtC6fhP7Kbd51ZdF6UbWaW6b1fXmXF
        OizJ776mTW5gpgziSpPH7eCzrZWW/qhDG6oEVvsN5uxm0ivmCDDmxzt1TzTUdrsEfzMlMKDyMhoX6
        a9zeDdZHZ7rYQnQvpKjbZ9CZVEFPMLfKLpR2BDUixVCjjFFj2P807S5XkTqI4Wy3yiz8wB/tz3UG4
        7nZDGH2g==;
Received: from 108-198-5-147.lightspeed.okcbok.sbcglobal.net ([108.198.5.147]:44180 helo=[192.168.0.134])
        by vern.gendns.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <david@lechnology.com>)
        id 1gSP0t-0002Xc-DF; Thu, 29 Nov 2018 11:18:03 -0500
Subject: Re: [PATCH 01/17] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Roger Quadros <rogerq@ti.com>, tony@atomide.com
Cc:     robh+dt@kernel.org, bcousson@baylibre.com, ssantosh@kernel.org,
        ohad@wizery.com, bjorn.andersson@linaro.org, s-anna@ti.com,
        nsekhar@ti.com, t-kristo@ti.com, nsaulnier@ti.com, jreeder@ti.com,
        m-karicheri2@ti.com, woods.technical@gmail.com,
        linux-omap@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1542886753-17625-1-git-send-email-rogerq@ti.com>
 <1542886753-17625-2-git-send-email-rogerq@ti.com>
 <a4fe952b-9065-d91b-4c07-984ec3f5b276@lechnology.com>
 <5BFD5F83.3070807@ti.com>
 <ee02b7d3-e7fd-2f4a-4213-d556d364194b@lechnology.com>
 <5BFFA811.3080907@ti.com>
From:   David Lechner <david@lechnology.com>
Message-ID: <e9c26880-66df-120f-842c-f86ae8745f46@lechnology.com>
Date:   Thu, 29 Nov 2018 10:18:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <5BFFA811.3080907@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/29/18 2:49 AM, Roger Quadros wrote:
> David,
> 
> On 28/11/18 17:42, David Lechner wrote:
>> On 11/27/18 9:15 AM, Roger Quadros wrote:
>>>
>>> On 26/11/18 23:14, David Lechner wrote:
>>>> On 11/22/18 5:38 AM, Roger Quadros wrote:
>>>>> From: Suman Anna <s-anna@ti.com>
>>>>>
>>>>> This patch adds the bindings for the Programmable Real-Time Unit
>>>>> and Industrial Communication Subsystem (PRU-ICSS) present on various
>>>>> TI SoCs. The IP is present on multiple TI SoC architecture families
>>>>> including the OMAP architecture SoCs such as AM33xx, AM437x and
>>>>> AM57xx; and on a Keystone 2 architecture based 66AK2G SoC. It is
>>>>> also present on the Davinci based OMAPL138 SoCs and K3 architecture
>>>>> based AM65x SoCs as well (not covered for now). Details have been
>>>>> added to include bindings for various core sub-modules like the PRU
>>>>> Cores, the PRUSS Interrupt Controller, and other sub-modules used
>>>>> for Industrial Communication purposes, covering the MDIO, MII_RT
>>>>> and the IEP sub-modules. The binding mostly uses standard DT
>>>>> properties.
>>>>>
>>>>> Signed-off-by: Suman Anna <s-anna@ti.com>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> ---
>>>>>     .../devicetree/bindings/soc/ti/ti,pruss.txt        | 360 +++++++++++++++++++++
>>>>>     1 file changed, 360 insertions(+)
>>>>>     create mode 100644 Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>>>> new file mode 100644
>>>>> index 0000000..24fedad
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/soc/ti/ti,pruss.txt
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +PRU-ICSS SoC Bus Parent Node
>>>>> +=============================
>>>>> +This node represents the integration of the PRU-ICSS IP into a SoC, and is
>>>>> +required for all SoCs. The PRU-ICSS parent nodes need to be defined as child
>>>>> +nodes of this node.
>>>>> +
>>>>> +Required Properties:
>>>>> +--------------------
>>>>> +- compatible     : should be one of,
>>>>> +                       "ti,am3356-pruss-soc-bus" for AM335x family of SoCs
>>>>> +                       "ti,am4376-pruss-soc-bus" for AM437x family of SoCs
>>>>> +                       "ti,am5728-pruss-soc-bus" for AM57xx family of SoCs
>>>>> +                       "ti,k2g-pruss-soc-bus" for 66AK2G family of SoCs
>>>>> +- reg            : address and size of the PRUSS CFG sub-module registers
>>>>> +                   dictating the interconnect configuration
>>>>
>>>> I haven't looked into Tony's suggestion of using ti-sysc yet, so this may be a
>>>> moot point, but how will this work with AM18xx that does not have a PRUSS CFG
>>>> register? It seems to me that reg here should be the address and size of the
>>>> entire PRUSS IP block and the CFG register should be a syscon node or something
>>>> like that.
>>>
>>> The reg property description is incorrect in the patch. It should have been
>>>
>>> reg        : address of SYSCFG register.
>>>
>>> The SYSCFG register is used to enable and reset the module.
>>>
>>> But based on Tony's suggestion this wrapper driver will change to ti,sysc for
>>> OMAP like SoCs.
>>>
>>> For AM18xx it could be a simple wrapper driver that just populates the children?
>>
>> I suppose that could work. I will look into it (perhaps after seeing what you
>> come up with in v2).
>>
>>>
>>>>
>>>>> +- #address-cells : should be 1
>>>>> +- #size-cells    : should be 1
>>>>> +- ranges         : standard ranges definition
>>>>> +
>>>>
>>>> ...
>>>>
>>>>> +
>>>>> +PRUSS INTC Child Node
>>>>> +======================
>>>>> +Each PRUSS has a single interrupt controller instance that is common to both
>>>>> +the PRU cores. Each interrupt controller can detect 64 input events which are
>>>>> +then mapped to 10 possible output interrupts through two levels of mapping. The
>>>>> +input events can be triggered by either the PRUs and/or various other PRUSS
>>>>> +internal and external peripherals. The first 2 output interrupts are fed
>>>>> +exclusively to the internal PRU cores, with the remaining 8 connected to
>>>>> +external interrupt controllers including the MPU.
>>>>
>>>> FYI, on AM18xx, there is a PRUSSEVTSEL bit in CFGCHIP3[3] (already a syscon node
>>>> in the device tree) that allows selecting one of two groups of 32 input events
>>>> out of this group of 64. This is perhaps getting out of the scope of this patch
>>>> series, but I just want to make sure we end up with something that can be easily
>>>> extended for this case. For example, I was thinking that this binding could be
>>>> modified so that #interrupt-cells could be 1 or 2. If it is 2, then the first
>>>> cell specifies the PRUSSEVTSEL value and the second value is the event number.
>>>>
>>>
>>> this is da850.dtsi correct?
>>
>> Yes.
>>
>>>
>>> As PRUSSEVTSEL is not SYSEVENT specific but applies to all the SYSEVENTs at a time.
>>> I don't think interrupt-cells is the right place to specify this.
>>>
>>> Can it be set in DT in the board file? But this can't change once booted so maybe restrictive.
>>
>> I guess the way I see this is that it is like specifying the bank and index for
>> a GPIO. If you only specify the system event number, then it is not clear which
>> event you mean - it could be one of two events. You have to also specify the
>> PRUSSEVTSEL value (one could call this the bank or group, I suppose) to fully
>> describe the system event.
> 
> But this PRUSSEVTSEL is not present on most SoCs. I think it is only on the AM18xx and OMAP-L13x SoCs.
> 
> How about modelling this as a linear map of 64 events and decode this internally in INTC driver.
> i.e. 0 to 31 set PRUSSEVTSEL to 0 and 32 to 63 set PRUSSEVTSEL to 1.
> 
> If any interrupt map provides sysevents from both groups simultaneously then we complain and error out.
> 
> This should keep the dt-binding and resource table format identical across all SoCs.


This sounds reasonable to me.


> 
>>
>>>
>>> If runtime change is required it can only be done before a PRU boots.
>>>
>>> How about providing this info in the resource table and/or application DT node?
>>
>> This seems like this would make it easy to end up with a broken interrupts
>> if you accidentally try to use interrupts from both groups. Instead this
>> could be implemented in the irqchip driver such that the first interrupt
>> (system event) requested gets to select the group. If any interrupts from
>> the other group are requested later, they can just return an error. Any
>> interrupts in the same group as the first can be requested successfully.
> 
> cheers,
> -roger
> 

