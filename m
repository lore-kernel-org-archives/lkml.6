Return-Path: <SRS0=GJTC=JQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B418AC6778A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:18:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64243243E5
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jun 2018 00:18:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="flrhcEam"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64243243E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937034AbeF3ASs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 20:18:48 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44120 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935547AbeF3ASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 20:18:46 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w5U0Hbuf109512;
        Fri, 29 Jun 2018 19:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530317857;
        bh=xdH+P4kEwI6JAeDvciXJH+YC0MhTp1aKPIw0mwOW3jE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=flrhcEamilsWEeEheHMXxswpqmJrrEos3p7odpyIdYjxv3K5MvKUOlWTipIMB0hnc
         PuumADuBOcnkfaZIewVwpLM30CoJM6eKSYxkuoKReWNuQR4PZB9vJpNfn39/Q6acuF
         vVie6CH8aapNFgxU526UOYKmFfTa6jgMiNX8W5CE=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5U0Hbj7028823;
        Fri, 29 Jun 2018 19:17:37 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 29
 Jun 2018 19:17:37 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 29 Jun 2018 19:17:37 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5U0HavE003152;
        Fri, 29 Jun 2018 19:17:36 -0500
Subject: Re: New remoteproc driver for TI PRU
To:     David Lechner <david@lechnology.com>,
        Roger Quadros <rogerq@ti.com>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Beno=c3=aet_Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>
References: <20180623210810.21232-1-david@lechnology.com>
 <e0a883af-8228-5b06-3186-f57d8f898aaa@ti.com>
 <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <536d28bd-bcdd-1665-e1c8-828572051cfb@ti.com>
Date:   Fri, 29 Jun 2018 19:17:36 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <8fc18d40-72f5-9215-26f0-1492e3a6c0e7@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 06/29/2018 12:44 PM, David Lechner wrote:
> On 06/29/2018 04:58 AM, Roger Quadros wrote:
>> +Suman & Tero
>>
>> Hi David,
>>
>> On 24/06/18 00:08, David Lechner wrote:
>>>
>>> Date: Sat, 23 Jun 2018 15:43:59 -0500
>>> Subject: [PATCH 0/8] New remoteproc driver for TI PRU
>>>
>>> This series adds a new remoteproc driver for the TI Programmable
>>> Runtime Unit
>>> (PRU) that is present in some TI Sitara processors. This code has
>>> been tested
>>> working on AM1808 (LEGO MINDSTORMS EV3) and AM3358 (BeagleBone Green).
>>
>> This is great. We have been working on something similar and I think
>> it would
>> be great if we can collaborate to get all our needs addressed.
> 
> Yes, I have used the PRU with the TI kernel on BeagleBone so I've seen
> the TI
> implementation. My primary interest is in the AM1808, which has a far
> simpler
> PRU than other SoCs. So, I was hoping I could get away with just
> implementing
> the basic stuff that I need and let TI add the more complex stuff later.

Thanks for the series. PRUSS is present on many SoCs now, and each with
their own integration quirks, both in terms of SoC connections as well
as internal sub-modules within the subsystem. We currently support
AM335x, AM437x, AM57xx, Keystone 2 based 66AK2G and a newer generation
AM65x as well. It should be relatively straight-forward to scale this
for AM1808/OMAP-L138 as well. The move to the standard Common Clock and
Reset frameworks for clocks with the Davinci chips should make it
relatively straight-forward for the architecture pieces.

I will take a look at your series in detail sometime next week, and
mostly post our series to the upstream lists as well within the next
couple of weeks so that it is easier for discussion on the upstream lists.

> 
>>
>> Our primary requirement is that it should be possible for a user (e.g.
>> kernel driver) to
>> - request a specific PRU core load a specific firmware blob and
>> boot/stop the PRU.
> 
> For this, I was thinking of suggesting a generic remoteproc
> provider/consumer
> binding that is similar to other subsystems. For example:
> 
> Provider node has:
> 
>     #remoteproc-cells = <1>;
> 
> And consumer has:
> 
>     remoteprocs = <&pruss 0>, <&pruss 1>;
>     remoteproc-names = "pru0", "pru1";

We do have an existing API in remoteproc core today,
rproc_get_by_phandle() for this, though it is not as sophisticated or
designed in a standard way that we see on some other sub-systems. One
thing that's currently missing from this is a sense of exclusive access,
as we do want to restrict access to a PRU to a single client at a time.
> 
> The consumer device would be responsible for determining the firmware file
> and for calling the rproc boot function.
> 
> 
>> - configure INTC interrupt mapping based on either resource table or DT
>> - use request_irq to request and use an interrupt.
> 
> I didn't consider creating a new interrupt controller in device tree, but
> that makes sense. I will have to look into it some more.
> 

Couple of iterations on our vendor tree all but resulted in representing
various sub-modules as child nodes - this allows to reuse different
drivers to deal with specific functionality like MDIO, UART etc. The
number of registers across all PRUSS sub-modules and SoCs are too huge
to support through a single driver.

> 
>> - request access to DRAM/SRAM
> 
> Can the existing device tree bindings for reserved-memory be used for this?

Typically, reserved-memory is used for reserving regions in DDR, not
mmio spaces. There is the SRAM driver in general to deal with on-chip
memories.

> I would expect the consumer nodes to use this and not the PRUSS provider
> node.

We will need access from both, as the remoteproc core does the loading
in general leveraging specific rproc ops from a remoteproc
implementation driver.

> 
> 
>> - configure gpimode/miirt/xfr (CFG space)
> 
> I have no idea what this stuff is. :-)

There are all the different sub-modules/register spaces dealing
specifically with internal pinmuxes, some serial/parallel GPIO pin
operations etc.

regards
Suman

> 
> (This is what I was referring to when I said I was hoping that someone
> else could add more later).
> 
