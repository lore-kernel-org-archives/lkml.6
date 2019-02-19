Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0235C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EDD2147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 08:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kjbeoIwl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfBSIv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 03:51:58 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:58362 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbfBSIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 03:51:56 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1J8pVUF086856;
        Tue, 19 Feb 2019 02:51:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550566291;
        bh=s4HYJPqyPJn3r1uSudtaaH3WEZvuI8niOjTupXXcvSM=;
        h=From:Subject:To:CC:References:Date:In-Reply-To;
        b=kjbeoIwlJ2ouADzwUbz07nm5+csBCIJ73GcH7O1D5/mFwWYnkZ2Rx6Zf/Lp1vw2dX
         LOqvi0IG5Ul/8XPcymnEg/m9gnYS2HKAMO9La/30CG6OBKMXGvkt3o3QtDDyduP+yd
         68kAXw0O5YuibZV+zxgk0fQWYmJ2ibTyQuaxRcCE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1J8pVLs037891
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 19 Feb 2019 02:51:31 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 19
 Feb 2019 02:51:31 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 19 Feb 2019 02:51:31 -0600
Received: from [172.24.190.117] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1J8pQD9017838;
        Tue, 19 Feb 2019 02:51:27 -0600
From:   Lokesh Vutla <lokeshvutla@ti.com>
Subject: Re: [PATCH v5 05/10] dt-bindings: irqchip: Introduce TISCI Interrupt
 router bindings
To:     Tony Lindgren <tony@atomide.com>
CC:     <marc.zyngier@arm.com>, Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
References: <20190212162247.GK5720@atomide.com>
 <6a274588-0fb6-2ddf-3bcc-f9e4d849ac07@ti.com>
 <20190213152620.GS5720@atomide.com>
 <4791de04-63af-4c5e-db9c-47634fcb8dc9@ti.com>
 <20190214154100.GB5720@atomide.com>
 <b4e821b3-f2fb-41d8-eb8c-8f4e8a19f77c@ti.com>
 <20190214174612.GF5720@atomide.com>
 <171e8597-2156-747d-d024-7b4bfc6f9186@ti.com>
 <20190215161629.GK5720@atomide.com>
 <2369739e-3bc8-257a-99e0-db2951c6777d@ti.com>
 <20190218143245.GC15711@atomide.com>
Message-ID: <84b3ec21-9ce9-b9a8-80a9-75001db43a90@ti.com>
Date:   Tue, 19 Feb 2019 14:21:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190218143245.GC15711@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 18/02/19 8:02 PM, Tony Lindgren wrote:
> * Lokesh Vutla <lokeshvutla@ti.com> [190216 03:30]:
>> On 2/15/2019 9:46 PM, Tony Lindgren wrote:
>>> The dts node for the interrupt controller should describe a
>>> proper Linux device, that is with reg entries and so on.
>>
>> You are asking to just keep the compatible property :)
> 
> Right, and then I realized this node is missing the standard
> reg entry too. And you're saying the registers are not even
> accissible from Linux.
> 
> So based on that IMO you should not even have a device tree
> node for it at all. You should just have the interrupt

Practically lets look at what all I am adding in the DT node. Below is one such
example:

main_intr: interrupt-controller0 {
	compatible = "ti,sci-intr";
	interrupt-controller;
	interrupt-parent = <&gic500>;
	#interrupt-cells = <4>;
	ti,sci = <&dmsc>;
	ti,sci-dst-id = <56>;
	ti,sci-rm-range-girq = <0x1>;
};

The following 4 properties are required at least for probing, to represent the
hierarchy and for  interrupt definition:
	compatible = "ti,sci-intr";
	interrupt-controller;
	interrupt-parent = <&gic500>;
	#interrupt-cells = <4>;

The remaining 3 properties represents the TISCI interface. Let's go step by step:
* ti,sci = <&dmsc> :This is the phandle to the firmware protocol driver using
which the messages are sent
* ti,sci-dst-id = <56> : This is the TISCI device ID for the parent controller
for which your irqs needs to be connected. As I said this cannot be queried from
sysfw and this is the input to the messages that are send to sysfw.
*  ti,sci-rm-range-girq = <0x1>: This define the ids using which the parent-irq
ranges that are allocated to this interrupt router instance can be queried from
sysfw.
If the above 2 properties are to be added as driver phandle then for every
instance of interrupt router in the SoC, a new compatible needs to be created. I
don't think this is a desirable solution.

With this can you tell me how can we not have a device-tree and still support
irq allocation?

Also, this is not the first time a driver based on a firmware is being added.
K2g clock, power and reset drivers are based on this where device ids are being
passed from consumers. Similarly arm scpi based drivers are also available.

Thanks and regards,
Lokesh



