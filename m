Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EF0C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:55:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F41E205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 07:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="I+pH013F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F41E205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbeKAQ51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 12:57:27 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:55188 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeKAQ51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 12:57:27 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA17ss1W074055;
        Thu, 1 Nov 2018 02:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1541058894;
        bh=VAkII7CKLsgoe3uTdzWtbgF0XnBT2Tex9f7gYXtFUW8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=I+pH013FXjri/kM3wzCQ2qL3+18DCl8ZzVKsr3qiSq762VDPYKTgUB1/wqJEB4tLY
         odCElDQt3lzSgag35N4Z7LaC1StXn8qWnKR6kFoLgXfwHps6StUOn+CPrJGK+9Ivos
         iQTSpG6PHnzbShtD//LV+H3RoWmHWXV0aBVMnGsU=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA17ssXA011053
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 1 Nov 2018 02:54:54 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 1 Nov
 2018 02:54:53 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 1 Nov 2018 02:54:53 -0500
Received: from [192.168.2.10] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA17soik022460;
        Thu, 1 Nov 2018 02:54:51 -0500
Subject: Re: [PATCH v2 09/10] irqchip: ti-sci-inta: Add support for Interrupt
 Aggregator driver
To:     Lokesh Vutla <lokeshvutla@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     Nishanth Menon <nm@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        <jason@lakedaemon.net>, Sekhar Nori <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, <tglx@linutronix.de>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20181018154017.7112-1-lokeshvutla@ti.com>
 <20181018154017.7112-10-lokeshvutla@ti.com>
 <b20127dc-be43-3b00-9960-663738df0069@arm.com>
 <9969f24c-cdb0-1f5c-d0f4-b1c1f587325c@ti.com>
 <86va5ssrfm.wl-marc.zyngier@arm.com>
 <b3a71622-7734-04be-0b0c-38e9dc6542d4@ti.com>
 <63ba5353-8470-b4c1-64a8-a1df5bf48614@ti.com>
 <86va5myz7t.wl-marc.zyngier@arm.com>
 <81136b74-4b45-f44b-0168-23d191a4fb5e@ti.com>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <49029695-79a0-141b-a9da-9764cb0ed60f@ti.com>
Date:   Thu, 1 Nov 2018 09:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <81136b74-4b45-f44b-0168-23d191a4fb5e@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lokesh,

On 10/29/18 3:04 PM, Lokesh Vutla wrote:
>>> With the above information, linux should send a message to
>>> system-controller using TISCI protocol. After policing the given
>>> information, system-controller does the following:
>>> - Attaches the interrupt(INTA input) to the device resource index
>>> - Muxes the interrupt(INTA input) to corresponding vint(INTA output)
>>> - Muxes the vint(INTR input) to GIC irq(INTR output).
>>
>> Isn't there a 1:1 mapping between *used* INTR inputs and outputs?
>> Since INTR is a router, there is no real muxing. I assume that the
>> third point above is just a copy-paste error.
> 
> Right, my bad. INTR is just a router and no read muxing.

INTR can mux M interrupt inputs to N interrupt outputs.
One selects which interrupt input is outputted on the given interrupt
output.
It is perfectly valid (but not sane) to select the same interrupt input
to be routed to _all_ interrupt output for example.

Not sure if we are going to use this for anything but 1:1 mapping, but
might worth keeping in mind...


- Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
