Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF4DAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B21A1223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B21A1223D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbeKLUqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:46:34 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:52914 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeKLUqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:46:34 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 42tng654mgz1qvvt;
        Mon, 12 Nov 2018 11:53:36 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 42tng43YS5z1qtf6;
        Mon, 12 Nov 2018 11:53:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id KjC77ESDGl3l; Mon, 12 Nov 2018 11:53:34 +0100 (CET)
X-Auth-Info: bZZF1KMNtgPd/tT3wCkMy74vTuWhI+ndMlL7DNP0r/Y=
Received: from antares.denx.de (unknown [62.91.23.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Mon, 12 Nov 2018 11:53:34 +0100 (CET)
Cc:     pn@denx.de, tglx@linutronix.de, jason@lakedaemon.net,
        marc.zyngier@arm.com, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br
Subject: Re: [PATCH v2 1/3] dt-bindings: interrupt-controller: Actions
 external interrupt controller
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20180812122215.1079590-1-pn@denx.de>
 <20180812122215.1079590-2-pn@denx.de>
 <20180813043406.GA16275@Mani-XPS-13-9360>
From:   Parthiban Nallathambi <pn@denx.de>
Message-ID: <85137788-4d08-f2cb-5b50-b5e35dbff29e@denx.de>
Date:   Mon, 12 Nov 2018 11:53:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20180813043406.GA16275@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/13/18 6:34 AM, Manivannan Sadhasivam wrote:
> Hi Parthiban,
> 
> On Sun, Aug 12, 2018 at 02:22:13PM +0200, Parthiban Nallathambi wrote:
>> Actions Semi OWL family SoC's provides support for external interrupt
>> controller to be connected and controlled using SIRQ pins. S500, S700
>> and S900 provides 3 SIRQ lines and works independently for 3 external
>> interrupt controllers.
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   .../interrupt-controller/actions,owl-sirq.txt      | 46 ++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> new file mode 100644
>> index 000000000000..4b8437751331
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
>> @@ -0,0 +1,46 @@
>> +Actions Semi Owl SoCs SIRQ interrupt controller
>> +
>> +S500, S700 and S900 SoC's from Actions provides 3 SPI's from GIC,
>> +in which external interrupt controller can be connected. 3 SPI's
>> +45, 46, 47 from GIC are directly exposed as SIRQ. It has
>> +the following properties:
> 
> We should really document the driver here. What it does? and how the
> hierarchy is handled with GIC? etc...
> 
>> +
>> +- inputs three interrupt signal from external interrupt controller
>> +
>> +Required properties:
>> +
>> +- compatible: should be "actions,owl-sirq"
>> +- reg: physical base address of the controller and length of memory mapped.
> 
> ...length of memory mapped region?

Yes it is.

> 
>> +- interrupt-controller: identifies the node as an interrupt controller
>> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
>> +  source, should be 2.
>> +- actions,sirq-shared-reg: Applicable for S500 and S700 where SIRQ register
>> +  details are maintained at same offset/register.
>> +- actions,sirq-offset: register offset for SIRQ interrupts. When registers are
>> +  shared, all the three offsets will be same (S500 and S700).
>> +- actions,sirq-clk-sel: external interrupt controller can be either
>> +  connected to 32Khz or 24Mhz external/internal clock. This needs
> 
> Hertz should be specified as Hz.
> 
>> +  to be configured for per SIRQ line. Failing defaults to 32Khz clock.
> 
> What value needs to be specified for selecting 24MHz clock? You should
> mention the available options this property supports.

Ok, this property will be removed here and leave to default 24MHz for
all the SoC's.

> 
>> +
>> +Example for S900:
>> +
>> +sirq: interrupt-controller@e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0 0xe01b0000 0 0x1000>;
> 
> could be: reg = <0x0 0xe01b0000 0x0 0x1000>;

Agreed!

> 
>> +	interrupt-controller;
>> +	#interrupt-cells = <2>;
>> +	actions,sirq-clk-sel = <0 0 0>;
>> +	actions,sirq-offset = <0x200 0x528 0x52c>;
>> +};
>> +
>> +Example for S500 and S700:
>> +
>> +sirq: interrupt-controller@e01b0000 {
>> +	compatible = "actions,owl-sirq";
>> +	reg = <0 0xe01b0000 0 0x1000>;
> 
> For S500, reg base is 0xb01b0000.

Yes, agreed!

Thanks,
Parthi

> 
> Thanks
> Mani
> 
>> +	interrupt-controller;
>> +	#interrupt-cells = <2>;
>> +	actions,sirq-shared-reg;
>> +	actions,sirq-clk-sel = <0 0 0>;
>> +	actions,sirq-offset = <0x200 0x200 0x200>;
>> +};
>> -- 
>> 2.14.4
>>
>
