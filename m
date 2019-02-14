Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC96DC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAA3D222DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:51:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fVcgc4iX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405547AbfBNQv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:51:58 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57446 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731118AbfBNQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:51:58 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1EGp4Cc030276;
        Thu, 14 Feb 2019 10:51:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550163064;
        bh=6u2Evk0OxMKPMaO2lLHgaUIUAifnir+OQhpYJLL/kGc=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=fVcgc4iXzZun7bqndNR4BfMjTgkBOEClR3J9kyVJ7DNh100QEAu7ooF0gsWOZEIbV
         tz7J/RkvFJkhrySYY68sRCeIpx2+Yq/EC6OULajfkm/8BpbFBxtXG7varVjzA1524g
         ez0AuUp9Qd4sewZlaXxjIxxylR78l9xVs71VIEO8=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1EGp4Wc005571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Feb 2019 10:51:04 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 14
 Feb 2019 10:51:01 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 14 Feb 2019 10:51:02 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1EGotZA004529;
        Thu, 14 Feb 2019 10:50:56 -0600
Subject: Re: [PATCH v2 01/14] dt-bindings: remoteproc: Add TI PRUSS bindings
To:     Marc Zyngier <marc.zyngier@arm.com>, Suman Anna <s-anna@ti.com>,
        "Davis, Andrew" <afd@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>
References: <1549290167-876-1-git-send-email-rogerq@ti.com>
 <1549290167-876-2-git-send-email-rogerq@ti.com>
 <CACRpkdamWQUW_O+gageB4Q6XuBg+t-h+eW1gpor7_DHvx41j=A@mail.gmail.com>
 <9c58bc48-90bf-8ac5-7fbd-0f6443e3fc5e@ti.com>
 <CACRpkdb4Q0efW5MaDmPTmewq-RFwXOTp15DCE1VpPf6g216iBw@mail.gmail.com>
 <5C65490E.6000800@ti.com> <86ef8asfap.wl-marc.zyngier@arm.com>
 <5C658CE4.5030307@ti.com> <aaff678a-820c-279e-632e-1ad25953029d@arm.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
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
        DTML <devicetree@vger.kernel.org>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <5C659C6F.5010000@ti.com>
Date:   Thu, 14 Feb 2019 18:50:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <aaff678a-820c-279e-632e-1ad25953029d@arm.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/02/19 17:51, Marc Zyngier wrote:
> On 14/02/2019 15:44, Roger Quadros wrote:
>> On 14/02/19 14:52, Marc Zyngier wrote:
>>> On Thu, 14 Feb 2019 10:55:10 +0000,
>>> Roger Quadros <rogerq@ti.com> wrote:
>>>>
>>>>
>>>> On 14/02/19 10:37, Linus Walleij wrote:
>>>>> On Thu, Feb 14, 2019 at 4:13 AM Suman Anna <s-anna@ti.com> wrote:
>>>>>> [Me]
>>>>>
>>>>>>> To be able to use hierarchical interrupt domain in the kernel, the top
>>>>>>> interrupt controller must use the hierarchical (v2) irqdomain, so
>>>>>>> if this is anything else than the ARM GIC it will be an interesting
>>>>>>> undertaking to handle this.
>>>>>>
>>>>>> These are interrupt lines coming towards the host processor running
>>>>>> Linux and are directly connected to the ARM GIC. This INTC module is
>>>>>> actually an PRUSS internal interrupt controller that can take in 64 (on
>>>>>> most SoCs) external events/interrupt sources and multiplexing them
>>>>>> through two layers of many-to-one events-to-intr channels &
>>>>>> intr-channels-to-host interrupts. Couple of the host interrupts go to
>>>>>> the PRU cores themselves while the remaining ones come out of the IP to
>>>>>> connect to other GICs in the SoC.
>>>>>
>>>>> If the muxing is static (like set up once at probe) so that while
>>>>> the system is running, there is one and one only event mapped to
>>>>> the GIC from the component below it, then it is hierarchical.
>>>>
>>>> This is how it looks.
>>>>
>>>> [GIC]<---8---[INTC]<---64---[events from peripherals]
>>>>
>>>> The 8 interrupt lines from INTC to the GIC are 1:1 mapped and fixed
>>>> per SoC.  The muxing between 64 inputs to INTC and its 8 outputs are
>>>> programmable and might not necessarily be static per boot/probe as
>>>> it depends on what firmware is loaded on the PRU.
>>>
>>> But the point is that at any given time, there are at most 8 out of 64
>>> inputs that are used, right? You *never* end-up with two (or more) of
>>> these "events" being multiplexed on a single output line.
>>>
>>
>> Since the INTC's internal logic allows assigning more than one event each outputs,
>> at most all 64 events can be assigned to one output or distributed among the 8 outputs.
> 
> OK. Do you get individual masking and status bits for each input?

Yes, we have individual enable/disable and status bits for each of the 64 events.

In addition to that it is possible to determine priority if multiple events come to the same
output by reading a register specific to that output.

--
cheers,
-roger
 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
