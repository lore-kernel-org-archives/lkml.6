Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03752C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:13:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B874921908
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 03:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fWwreEwq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393727AbfBNDN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 22:13:26 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60760 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfBNDN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 22:13:26 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1E3CUGp094411;
        Wed, 13 Feb 2019 21:12:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550113950;
        bh=JidtS8YhFYqggZ+ZfE5Diy4Gcd3eu7bNsEci/OtpQRY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fWwreEwqjGsR7vshhU5BbkS/+cTKLHJxaEVsjtFFk3CzWhPhgPS7MjlPFutj/Gz6o
         eLJVkX30fGigxPufkPmEQmdXmPhjcYq/6ldcDqWKvcmtuplXJXgGH0RKma+F77NJYu
         jj/LLbdcncRAOqZHj4h9+jq1yNtSS7DVirHiH7Vs=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1E3CUBA020326
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Feb 2019 21:12:30 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 21:12:29 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 21:12:29 -0600
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1E3CTxW027796;
        Wed, 13 Feb 2019 21:12:29 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Linus Walleij <linus.walleij@linaro.org>,
        Roger Quadros <rogerq@ti.com>,
        Marc Zyngier <marc.zyngier@arm.com>
CC:     ext Tony Lindgren <tony@atomide.com>,
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
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
Date:   Wed, 13 Feb 2019 21:12:29 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/8/19 7:51 AM, Linus Walleij wrote:
> On Mon, Feb 4, 2019 at 3:24 PM Roger Quadros <rogerq@ti.com> wrote:
> 
>> From: Suman Anna <s-anna@ti.com>
>>
>> This patch adds the bindings for the Programmable Real-Time Unit
>> and Industrial Communication Subsystem (PRU-ICSS) present on various
>> SoCs such as AM33xx, AM437x, AM57xx, Keystone 66AK2G SoC, etc. It is
>> present on the Davinci based OMAPL138 SoCs and K3 architecture
>> based AM65x SoCs as well (not covered for now).
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> (...)
>> +               pruss_intc: intc@20000 {
>> +                       compatible = "ti,am3356-pruss-intc";
>> +                       reg = <0x20000 0x2000>;
>> +                       reg-names = "intc";
>> +                       interrupt-controller;
>> +                       #interrupt-cells = <1>;
>> +                       interrupts = <20 21 22 23 24 25 26 27>;
>> +                       interrupt-names = "host2", "host3", "host4",
>> +                                         "host5", "host6", "host7",
>> +                                         "host8", "host9";
> 
> If thsese interrupts are mapped 1-to-1 to a parent interrupt controller
> then this is a hierarchical interrupt domain and then these should
> be handled locally in the driver as offset from child to parent
> statically encoded in the driver.
> 
> Several old drivers and old device tree bindings make this kind
> of maps, but it is not how we do it anymore, if we can avoid it.
> 
> To be able to use hierarchical interrupt domain in the kernel, the top
> interrupt controller must use the hierarchical (v2) irqdomain, so
> if this is anything else than the ARM GIC it will be an interesting
> undertaking to handle this.

These are interrupt lines coming towards the host processor running
Linux and are directly connected to the ARM GIC. This INTC module is
actually an PRUSS internal interrupt controller that can take in 64 (on
most SoCs) external events/interrupt sources and multiplexing them
through two layers of many-to-one events-to-intr channels &
intr-channels-to-host interrupts. Couple of the host interrupts go to
the PRU cores themselves while the remaining ones come out of the IP to
connect to other GICs in the SoC.

We have implemented this as an irqchip using chained interrupt handlers
with the consumers using the event numbers on the Linux-side. The PRUs
also access some of the associated registers for clearing an event source.

regards
Suman

> 
> The more I understand of hierarchical irqdomains, the more of
> workarounds where we should be using it I see, we really need
> to spread this knowledge. Using it requires a lot of upfront work
> sometimes, sorry about that but the end result is so much better.
> 
> Yours,
> Linus Walleij
> 

