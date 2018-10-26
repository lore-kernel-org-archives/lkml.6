Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27615C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D85DB2084D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 06:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ERLoHuSO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85DB2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbeJZPP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 11:15:27 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:35902 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbeJZPP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 11:15:26 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9Q6dFej110669;
        Fri, 26 Oct 2018 01:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540535955;
        bh=pCkj2CpV6KyQInSURrePVpuBjqLx1TxMXat3GZqhwyE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ERLoHuSO7n+uRgepy49WibXLqkcawSfy+n0mlyLo4xQh0kLMhusSLQ4FnH72sHAEx
         mBxXlBhMTOAREVmw2KHXyGRGQco98vejhwik+iL4MtIj9ZjxqqiJIOGc3j80WIbnvc
         fEScHzvAf086dFSAs5XEFDF5O0dvA2IUhB/0bVmA=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id w9Q6dFkZ104398
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 26 Oct 2018 01:39:15 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 26
 Oct 2018 01:39:14 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 26 Oct 2018 01:39:14 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9Q6dAlv019504;
        Fri, 26 Oct 2018 01:39:11 -0500
Subject: Re: [PATCH v2 00/10] Add support for TISCI irqchip drivers
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <942981b8-7536-2b6b-ad49-dc59671cbda6@oracle.com>
 <050161aa-a257-9bf8-b3c9-35b13925b556@ti.com>
 <38811dd7-0645-0439-092d-6759ab52cb0a@oracle.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <bc7312c2-b068-ddda-b183-54e6bc3f8219@ti.com>
Date:   Fri, 26 Oct 2018 12:09:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <38811dd7-0645-0439-092d-6759ab52cb0a@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On Tuesday 23 October 2018 11:04 PM, Santosh Shilimkar wrote:
> On 10/23/2018 1:17 AM, Lokesh Vutla wrote:
>> Hi Santosh,
>>
>> On Tuesday 23 October 2018 02:09 AM, Santosh Shilimkar wrote:
>>> On 10/18/2018 8:40 AM, Lokesh Vutla wrote:
>>>> TISCI abstracts the handling of IRQ routes where interrupt sources
>>>> are not directly connected to host interrupt controller. This series
>>>> adds support for:
>>>> - TISCI commands needed for IRQ configuration
>>>> - Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers
>>>>
>>>> More information on TISCI IRQ management can be found here[1].
>>>> Complete TISCI resource management information can be found here[2].
>>>> AM65x SoC related TISCI information can be found here[3].
>>>> INTR and INTA related information can be found in TRM[4].
>>>>
>>> I didn't read the specs but from what you described in
>>> INTA and INTR bindings, does the flow of IRQs like below ?
>>>
>>> Device IRQ(e.g USB) -->INTR-->INTA--->HOST IRQ controller(GIC)
>>
>> Not all devices in SoC are connected to INTA. Only the devices that are
>> capable of generating events are connected to INTA. And INTA is
>> connected to INTR.
>>
>> So there are three ways in which IRQ can flow in AM65x SoC:
>> 1) Device directly connected to GIC
>>       - Device IRQ --> GIC
>>       - (Most legacy peripherals like MMC, UART falls in this case)
>> 2) Device connected to INTR.
>>       - Device IRQ --> INTR --> GIC
>>       - This is cases where you want to mux IRQs. Used for GPIOs and
>> Mailboxes
>>       - (This is somewhat similar to crossbar on DRA7 devices)
>> 3) Devices connected to INTA.
>>       - Device Event --> INTA --> INTR --> GIC
>>       - Used for DMA and networking devices.
>>
>> Events are messages based on a hw protocol, sent by a master over a
>> dedicated Event transport lane. Events are highly precise that no
>> under/over flow of data transfer occurs at source/destination regardless
>> of distance and latency. So this is mostly preferred in DMA and
>> networking usecases. Now Interrupt Aggregator(IA) has the logic to
>> converts these events to Interrupts.
>>
> This helps but none of the kernel doc you added, makes this clear so
> perhaps you want to add this info to make that clear for reviewers
> as well as for future reference.

Sure will add it.

> 
> Now regarding the events, no matter how they are routed/processed
> within SOC, they are essentially interrupts so I do agree with
> Marc's other comment.

Agreed. Marc suggested to use MSI in this scenario. Currently working in that 
direction. Will repost the series once it is done.

Thanks and regards,
Lokesh

> 
> Thanks for explanation again !!
> 
> regards,
> Santosh
> 
