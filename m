Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC21C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C92208DD
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 21:56:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnZrYzHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30C92208DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756638AbeFOV4c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 17:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:47538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756434AbeFOV4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 17:56:30 -0400
Received: from mail-it0-f50.google.com (mail-it0-f50.google.com [209.85.214.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7495220896;
        Fri, 15 Jun 2018 21:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529099789;
        bh=0swY2uwf7VPyfAK2qghJx8fY/SnuzZHZRMXpAufV4F4=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=nnZrYzHAggqgQR+PoDeaotj6Esga3w8GslW1TXQmWwgDvcEYu+SiGmdkGob5pEbdq
         eNu+1Vll8uhG3svrJjR2o/ctwx3JM+F2PA2HPMmz6s8iENQki7IZWPp8zDhaApUAJD
         nKY9vIu9tMOOHP01HCYrkV3aacepJv811DVz+VaI=
Received: by mail-it0-f50.google.com with SMTP id a3-v6so4740157itd.0;
        Fri, 15 Jun 2018 14:56:29 -0700 (PDT)
X-Gm-Message-State: APt69E1vsiT2Z98PbJOA6N7dunu+rPtGqTWYuyYBy22cNF3qffw85D1n
        SMiRfLkxQ9R1TORX9vrISPG1MTehl69aD6IkhQ==
X-Google-Smtp-Source: ADUXVKLw1LS4MVI8mbCO3EDgtzZrIwbSa63r0C+yu7YnFXlyqAvwLimsleo338sCu3G3Crpde5R+JlQ5Bsir9VnnafU=
X-Received: by 2002:a24:f04e:: with SMTP id p14-v6mr2784712iti.106.1529099788881;
 Fri, 15 Jun 2018 14:56:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:6403:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 14:56:08
 -0700 (PDT)
In-Reply-To: <8c553dcc-e352-6e69-e08c-4e6237555ea7@ti.com>
References: <20180605060125.9518-1-nm@ti.com> <20180605060125.9518-4-nm@ti.com>
 <20180612210640.GA20728@rob-hp-laptop> <8c553dcc-e352-6e69-e08c-4e6237555ea7@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 15 Jun 2018 15:56:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLvygcUSqJpAF_xTt3QRq9=xgu7nF3UDchgPYk+QDj1JA@mail.gmail.com>
Message-ID: <CAL_JsqLvygcUSqJpAF_xTt3QRq9=xgu7nF3UDchgPYk+QDj1JA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART controller
To:     Sekhar Nori <nsekhar@ti.com>
Cc:     Nishanth Menon <nm@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 11:17 AM, Sekhar Nori <nsekhar@ti.com> wrote:
> Hi Rob,
>
> On Wednesday 13 June 2018 02:36 AM, Rob Herring wrote:
>> On Tue, Jun 05, 2018 at 01:01:22AM -0500, Nishanth Menon wrote:
>>> AM654 uses a UART controller that is compatible (partially) with
>>> existing 8250 UART, however, has a few differences with respect to DMA
>>> support and control paths. Introduce a base definition that allows us
>>> to build up the differences in follow on patches.
>>>
>>> Cc: Sekhar Nori <nsekhar@ti.com>
>>> Cc: Vignesh R <vigneshr@ti.com>
>>> Signed-off-by: Nishanth Menon <nm@ti.com>
>>> ---
>>>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>>>  drivers/tty/serial/8250/8250_omap.c                      | 1 +
>>>  2 files changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
>>> index 4b0f05adb228..c35d5ece1156 100644
>>> --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
>>> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
>>> @@ -1,6 +1,7 @@
>>>  OMAP UART controller
>>>
>>>  Required properties:
>>> +- compatible : should be "ti,am654-uart" for AM654 controllers
>>
>> Not compatible with any existing TI 8250 UARTs?
>
> Curious on why you asked about this. Are you suggesting why not:
>
> "ti,<new-soc>-uart", "ti,<old-soc>-uart"

Correct.

> or you are asking why introduce "ti,<new-soc>-uart" unless there is
> clear demonstrable need for using it in driver code.
>
> In general, I think "ti,<new-soc>-uart", "ti,<old-soc>-uart" in
> device-tree (and by extension in binding document) is better even in
> there are no _known_ incompatibilities at the time of initial driver
> submission. The reason is silicon integration and process differences
> many times spill over into driver.

Yes, and chip designers can't be trusted. ;)

> Of course, the idea is not to go postal and create a new compatible for
> every pin-compatible part number that gets created, but probably a new
> compatible should be created for a new silicon die.

Yes, that's the criteria I would use too. That's sometimes hard if
it's not the chip vendor doing the DT bindings.

> We have just started introducing support for this SoC, and since it
> reuses many IPs, this question is likely to come up again.
>
> In this particular case though, Nishanth is perfectly right in not saying
>
> compatible : should be "ti,am654-uart", "ti,omap4-uart"
>
> Because we *know* UART DMA integration is different and a match against
> omap4 would result in non-working UART once DMA is enabled by default.

Okay, makes sense. I'd suggest rewording the commit message to include
this. The "compatible to 8250 except for DMA" part I would have
applied to all TI UARTs rather than DMA differences with other TI
UARTs.

Rob
