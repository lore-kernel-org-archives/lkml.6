Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B72BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:18:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 693AB20652
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="RmDFm/kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693AB20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727724AbeJWQlD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 12:41:03 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:38416 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727496AbeJWQlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 12:41:03 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w9N8I9jH072286;
        Tue, 23 Oct 2018 03:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1540282689;
        bh=DFC2pVDCoGXxTn+fpbStSVbGlpy8xEU47CEelm75+GE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=RmDFm/krD2QKUK7PQiXSF5HhBJYoufIzps/waoRamGIFL1M+7ZjWbYDv/I/jt3taJ
         L23nszvMK7hYwIcIdlwxOjuC8SmB0zvlI/qwtjU3NE23kM7YKCN2Lst/DxqQI3qkWm
         nXI+JXSVIZz//WBYQ8yAAwCysUgi5Edwx2ZJmT2E=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9N8I9KR012619;
        Tue, 23 Oct 2018 03:18:09 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 23
 Oct 2018 03:18:09 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 23 Oct 2018 03:18:09 -0500
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w9N8I4T1026907;
        Tue, 23 Oct 2018 03:18:05 -0500
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
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <050161aa-a257-9bf8-b3c9-35b13925b556@ti.com>
Date:   Tue, 23 Oct 2018 13:47:56 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <942981b8-7536-2b6b-ad49-dc59671cbda6@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Santosh,

On Tuesday 23 October 2018 02:09 AM, Santosh Shilimkar wrote:
> On 10/18/2018 8:40 AM, Lokesh Vutla wrote:
>> TISCI abstracts the handling of IRQ routes where interrupt sources
>> are not directly connected to host interrupt controller. This series
>> adds support for:
>> - TISCI commands needed for IRQ configuration
>> - Interrupt Router(INTR) and Interrupt Aggregator(INTA) drivers
>>
>> More information on TISCI IRQ management can be found here[1].
>> Complete TISCI resource management information can be found here[2].
>> AM65x SoC related TISCI information can be found here[3].
>> INTR and INTA related information can be found in TRM[4].
>>
> I didn't read the specs but from what you described in
> INTA and INTR bindings, does the flow of IRQs like below ?
> 
> Device IRQ(e.g USB) -->INTR-->INTA--->HOST IRQ controller(GIC)

Not all devices in SoC are connected to INTA. Only the devices that are capable 
of generating events are connected to INTA. And INTA is connected to INTR.

So there are three ways in which IRQ can flow in AM65x SoC:
1) Device directly connected to GIC
	- Device IRQ --> GIC
	- (Most legacy peripherals like MMC, UART falls in this case)
2) Device connected to INTR.
	- Device IRQ --> INTR --> GIC
	- This is cases where you want to mux IRQs. Used for GPIOs and Mailboxes
	- (This is somewhat similar to crossbar on DRA7 devices)
3) Devices connected to INTA.
	- Device Event --> INTA --> INTR --> GIC
	- Used for DMA and networking devices.

Events are messages based on a hw protocol, sent by a master over a dedicated 
Event transport lane. Events are highly precise that no under/over flow of data 
transfer occurs at source/destination regardless of distance and latency. So 
this is mostly preferred in DMA and networking usecases. Now Interrupt 
Aggregator(IA) has the logic to converts these events to Interrupts.

Thanks and regards
Lokesh
