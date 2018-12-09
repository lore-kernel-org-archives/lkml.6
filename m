Return-Path: <SRS0=cWqk=OS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B4EC65BAF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E82F20645
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Dec 2018 19:27:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E82F20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726248AbeLIT0u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 14:26:50 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41970 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeLIT0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 14:26:50 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 43Cbmg5N2Mz1qxQ3;
        Sun,  9 Dec 2018 20:26:43 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 43Cbmg0Xdrz1qqlD;
        Sun,  9 Dec 2018 20:26:43 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id DjQLjNZUqY5r; Sun,  9 Dec 2018 20:26:41 +0100 (CET)
X-Auth-Info: T6YN9DrHuuQFQW/vowv1WxvtZzEtMlXeVytu7eFMubI=
Received: from [192.168.178.26] (unknown [62.91.37.152])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Sun,  9 Dec 2018 20:26:41 +0100 (CET)
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: Actions
 external interrupt controller
To:     Rob Herring <robh@kernel.org>
Cc:     marc.zyngier@arm.com, tglx@linutronix.de, jason@lakedaemon.net,
        mark.rutland@arm.com, afaerber@suse.de, catalin.marinas@arm.com,
        will.deacon@arm.com, manivannan.sadhasivam@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, thomas.liau@actions-semi.com,
        mp-cs@actions-semi.com, linux@cubietech.com,
        edgar.righi@lsitec.org.br, laisa.costa@lsitec.org.br,
        guilherme.simoes@lsitec.org.br, mkzuffo@lsi.usp.br,
        Saravanan Sekar <sravanhome@gmail.com>, pn@denx.de
References: <20181126100356.2840578-1-pn@denx.de>
 <20181126100356.2840578-2-pn@denx.de> <20181207232934.GA28201@bogus>
From:   Parthiban Nallathambi <pn@denx.de>
Organization: DENX Software Engineering GmbH
Message-ID: <49bb60b8-a51b-a4e8-da29-52f0a951c37b@denx.de>
Date:   Sun, 9 Dec 2018 20:26:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <20181207232934.GA28201@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

On 12/8/18 12:29 AM, Rob Herring wrote:
> On Mon, Nov 26, 2018 at 11:03:53AM +0100, Parthiban Nallathambi wrote:
>> Actions Semi OWL family SoC's provides support for external interrupt
>> controller to be connected and controlled using SIRQ pins. S500, S700
>> and S900 provides 3 SIRQ lines and works independently for 3 external
>> interrupt controllers.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>  .../interrupt-controller/actions,owl-sirq.txt | 57 +++++++++++++++++++
>>  1 file changed, 57 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> new file mode 100644
>> index 000000000000..b3adc4bddf40
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> @@ -0,0 +1,57 @@
>> +Actions Semi Owl SoCs SIRQ interrupt controller
>> +
>> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
> 
> Listing SoCs here means you have to update this line for every new SoC.

Ok, I will mark it as OWL SoC's here.

> 
>> +in which external interrupt controller can be connected. 3 SPI's
>> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
>> +the following properties:
>> +
>> +- inputs three interrupt signal from external interrupt controller
>> +
>> +Required properties:
>> +
>> +- compatible: should be "actions,owl-sirq"
> 
> SoC specific compatibles needed.

Ok, I will change this into "actions,s700-sirq"

> 
>> +- reg: physical base address of the controller and length of memory mapped
>> +  region.
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
>> +  source, should be 2.
>> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
>> +  details are maintained at same offset/register.
>> +- actions,sirq-reg-offset: register offset for SIRQ interrupts. When registers are
>> +  shared, all the three offsets will be same (S500 and S700).
> 
> These properties should be implied by the compatible string.

Agreed for sirq-shared-reg.

But for s900 sirq-reg-offset, the register offset will have different values.
So this shall not be removed.

> 
>> +- actions,ext-irq-range: Identifies external irq number range in different SoCs.
> 
> Why is this needed? It appears to always be the same.

Yes, I agree for all the existing Owl SoC's this remains same.

In the previous version we defined this as constant in the code. But based on Marc's
feedback I understood that this value should come from Device Tree instead on hard
coding in the code.

> 
>> +
>> +Example for S900:
>> +
>> +sirq: interrupt-controller@e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
>> +	interrupt-controller;
>> +	#interrupt-cells = <3>;
>> +	actions,sirq-offset = <0x200 0x528 0x52c>;
>> +	actions,ext-irq-range = <13 15>;
>> +};
>> +
>> +Example for S700:
> 
> Examples are examples, not an enumeration of all possible dts entries. 
> So 1 should be sufficient.

Sure, I will maintain only s700 here.

> 
>> +
>> +sirq: interrupt-controller@e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0x0 0xe01b0000 0x0 0x1000>;
>> +	interrupt-controller;
>> +	#interrupt-cells = <3>;
>> +	actions,sirq-shared-reg;
>> +	actions,sirq-reg-offset = <0x200 0x200 0x200>;
>> +	actions,ext-irq-range = <13 15>;
>> +};
>> +
>> +Example for S500:
>> +
>> +sirq: interrupt-controller@b01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0x0 0xb01b0000 0x0 0x1000>;
>> +	interrupt-controller;
>> +	#interrupt-cells = <3>;
>> +	actions,sirq-shared-reg;
>> +	actions,sirq-offset = <0x200 0x200 0x200>;
>> +	actions,ext-irq-range = <13 15>;
>> +};
>> -- 
>> 2.17.2
>>
> 

-- 
Thanks,
Parthiban N

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-22 Fax: (+49)-8142-66989-80 Email: pn@denx.de
