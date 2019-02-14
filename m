Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70366C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3751C222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 10:56:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Oiw4Yl8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406844AbfBNK4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 05:56:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49882 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBNK4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 05:56:16 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EAtJM3013968;
        Thu, 14 Feb 2019 04:55:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550141719;
        bh=Huyhs7T7CF7eyF3JkYiDE936MmdyMW+UTXJ1jca27C0=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Oiw4Yl8fnViQR0xO2ebtSJmNCerjnfOWX+LwwlfVw4xA7JieSpRoDKV9F1wPBQdZy
         nB8fSdjxEwWAX1h+HHaUVRKPGwTlp/p6LpRK/Af9dRIXutvS/JUlOHBk53dl/HRD72
         8/3B7iXYiNlb1DhST+GxDDOBphb4ycT76NpyySdY=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EAtJN2119424
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 04:55:19 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 04:55:17 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 04:55:17 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EAtCdg012787;
        Thu, 14 Feb 2019 04:55:12 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Linus Walleij <linus.walleij@linaro.org>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
 <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
 <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
CC:     Marc Zyngier <marc.zyngier@arm.com>,
        ext Tony Lindgren <tony@atomide.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Lechner <david@lechnology.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <nsaulnier@ti.com>, <jreeder@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        <woods.technical@gmail.com>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C65490E.6000800@ti.com>
Date:   Thu, 14 Feb 2019 12:55:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/02/19 10:37, Linus Walleij wrote:
> On Thu, Feb 14, 2019 at 4:13 AM Suman Anna <s-anna@ti.com> wrote:
>> [Me]
> 
>>> To be able to use hierarchical interrupt domain in the kernel, the top
>>> interrupt controller must use the hierarchical (v2) irqdomain, so
>>> if this is anything else than the ARM GIC it will be an interesting
>>> undertaking to handle this.
>>
>> These are interrupt lines coming towards the host processor running
>> Linux and are directly connected to the ARM GIC. This INTC module is
>> actually an PRUSS internal interrupt controller that can take in 64 (on
>> most SoCs) external events/interrupt sources and multiplexing them
>> through two layers of many-to-one events-to-intr channels &
>> intr-channels-to-host interrupts. Couple of the host interrupts go to
>> the PRU cores themselves while the remaining ones come out of the IP to
>> connect to other GICs in the SoC.
> 
> If the muxing is static (like set up once at probe) so that while the system is
> running, there is one and one only event mapped to the GIC from
> the component below it, then it is hierarchical.

This is how it looks.

[GIC]<---8---[INTC]<---64---[events from peripherals]

The 8 interrupt lines from INTC to the GIC are 1:1 mapped and fixed per SoC.
The muxing between 64 inputs to INTC and its 8 outputs are programmable
and might not necessarily be static per boot/probe as it depends on what firmware
is loaded on the PRU.

A typical PRUSS use case will usually use just one firmware per boot but if required it
can switch at runtime and the muxing might change.

> 
>> We have implemented this as an irqchip using chained interrupt handlers
>> with the consumers using the event numbers on the Linux-side. The PRUs
>> also access some of the associated registers for clearing an event source.
> 
> Chaining with cascading is when two or more interrupts fire the
> same upper level (say GIC) IRQ. If there is a 1:1 mapping,
> it is not chained/cascaded but hierarchical.
> 
> I understand you used old irqdomain/chip frameworks in the past,
> because everyone was working around the fact that they didn't have
> an abstraction for hierarchical IRQs. Using chained interrupts
> and custom 1:1 maps and assigning a long list of IRQs like this
> patch does was the most common workaround. But we should
> step out of that habit now.
> 
> Different levels of the IRQ handling having to do different stuff is
> what hierarchical irqdomains do best, so it sounds like a good fit.
> 
> We handle some stuff at our level of the hierarchy and then fall
> up to the next higher level using calls such as
> irq_chip_ack_parent(), irq_chip_mask_parent() and friends.
> 
> Yours,
> Linus Walleij
> 

--
cheers,
-roger
 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
