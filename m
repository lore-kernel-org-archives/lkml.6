Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B12CC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5F82080A
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 10:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gDZovFs/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbfBEKg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:36:56 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:42478 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbfBEKg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 05:36:56 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x15AZn8q020296;
        Tue, 5 Feb 2019 04:35:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549362949;
        bh=xHd3aAysE71cNI4HFCRp8yXLnNiwAqggbaNDtPPUS/4=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=gDZovFs/xF0HOSSWzospM1SHYWsMmT1uL5srVeYy8/XF1BFBTfYc9zEWPgkCy6sVM
         u3PfBWhreukYxP8FXeD4jtdjHSYYM0o5tYclXI2wr9s2I54hzSD6r+8l69FbLJEQMf
         BitH8+77vg+NMssSk7R1Ew6ElBmoUrLIHWdVkxCE=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x15AZn9Y079902
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Feb 2019 04:35:49 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 5
 Feb 2019 04:35:49 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 5 Feb 2019 04:35:49 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x15AZiKr029287;
        Tue, 5 Feb 2019 04:35:45 -0600
Subject: Re: [PATCH v2 04/14] irqchip: pruss: Add a PRUSS irqchip driver for
 PRUSS interrupts
To:     Tony Lindgren <tony@atomide.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-5-git-send-email-rogerq@ti.com>
 <20190204181518.GN5720@atomide.com>
CC:     <ohad@wizery.com>, <bjorn.andersson@linaro.org>, <s-anna@ti.com>,
        <david@lechnology.com>, <nsekhar@ti.com>, <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>, <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>, <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, "Andrew F. Davis" <afd@ti.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C596700.1010000@ti.com>
Date:   Tue, 5 Feb 2019 12:35:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20190204181518.GN5720@atomide.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/02/19 20:15, Tony Lindgren wrote:
> * Roger Quadros <rogerq@ti.com> [190204 14:23]:
>> From: "Andrew F. Davis" <afd@ti.com>
>>
>> The Programmable Real-Time Unit Subsystem (PRUSS) contains an
>> interrupt controller (INTC) that can handle various system input
>> events and post interrupts back to the device-level initiators.
>> The INTC can support upto 64 input events with individual control
>> configuration and hardware prioritization. These events are mapped
>> onto 10 interrupt signals through two levels of many-to-one mapping
>> support. Different interrupt signals are routed to the individual
>> PRU cores or to the host CPU.
>>
>> The PRUSS INTC platform driver manages this PRUSS interrupt
>> controller and implements an irqchip driver to provide a Linux
>> standard way for the PRU client users to enable/disable/ack/
>> re-trigger a PRUSS system event. The system events to interrupt
>> channels and host interrupts relies on the mapping configuration
>> provided through a firmware resource table for now. This will be
>> revisited and enhanced in the future for a better interface. The
>> mappings will currently be programmed during the boot/shutdown
>> of the PRU.
>>
>> The PRUSS INTC module is reference counted during the interrupt
>> setup phase through the irqchip's irq_request_resources() and
>> irq_release_resources() ops. This restricts the module from being
>> removed as long as there are active interrupt users.
>>
>> The PRUSS INTC can generate an interrupt to various processor
>> subsystems on the SoC through a set of 64 possible PRU system
>> events. These system events can be used by PRU client drivers
>> or applications for event notifications/signalling between PRUs
>> and MPU or other processors. An API, pruss_intc_trigger() is
>> provided to MPU-side PRU client drivers/applications to be able
>> to trigger an event/interrupt using IRQ numbers provided by the
>> PRUSS-INTC irqdomain chip.
> 
> I suggest you send the binding patch and the interrupt
> controller driver separately to the irqchip guys. Maybe
> put the trigger function in to a separate patch that can
> be reviewed and applied separately.

Good idea. I will send irqchip related patches separately.

cheers,
-roger
> 
> Regards,
> 
> Tony
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
