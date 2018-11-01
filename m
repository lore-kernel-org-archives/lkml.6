Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F5CBC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08EB42082E
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 09:09:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08EB42082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbeKASLn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 14:11:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:38472 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbeKASLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 14:11:42 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA1996iU095185;
        Thu, 1 Nov 2018 04:09:06 -0500
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA19961v015869
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 04:09:06 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 1 Nov
 2018 04:09:05 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 1 Nov 2018 04:09:05 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA1992cF008782;
        Thu, 1 Nov 2018 04:09:02 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>
CC:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <2369ea50-55db-c97b-5b43-99d572c97dc9@ti.com>
 <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <2a869e38-47c1-0f11-8f4e-176d0d895a45@ti.com>
Date:   Thu, 1 Nov 2018 11:09:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <da27ecc5-db32-cf3a-c194-962c44bc782f@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 10/31/18 8:21 PM, Marc Zyngier wrote:
> Well, I'm convinced that we do not want a networking driver to be tied
> to an interrupt architecture, and that the two should be completely
> independent. But that's my own opinion. I can only see two solutions
> moving forward:
> 
> 1) You make the IA a real interrupt controller that exposes real
> interrupts (one per event), and write your networking driver
> independently of the underlying interrupt architecture.
> 
> 2) you make the IA an integral part of your network driver, not exposing
> anything outside of it, and limiting the interactions with the IR
> *through the standard IRQ API*. You duplicate this knowledge throughout
> the other client drivers.
> 
> I believe that (2) would be a massive design mistake as it locks the
> driver to a single of the HW (and potentially a single revision of the
> firmware) while (1) gives you the required level of flexibility by
> hiding the whole event "concept" at a single location.
> 
> Yes, (1) makes you rewrite your existing, out of tree drivers. Oh well...

We need to have generic support for INTA within the NAVSS for Linux. The
UDMA (also part of the NAVSS) is used as system DMA and for the
DMAengine driver we need to have ability to handle the events from Rings
and from the UDMA itself.

Option 2 is not really an option as other components need to configure
INTA to get interrupts from the Events flying within NAVSS.

In the past with Keystone II we did have similar PacketDMA engine but it
was dedicated to service networking and crypto. For all other
peripherals we had EDMA as generic system DMA.

With AM654 this is no longer the case as we no longer have EDMA and the
NAVSS is tasked to service all peripherals, like networking and the ones
we used to use EDMA.

> 
> Thanks,
> 	
> 	M.
> 

- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
