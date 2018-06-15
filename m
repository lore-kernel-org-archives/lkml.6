Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF57C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4901F208B2
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="IJuSbhIJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4901F208B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936382AbeFORSb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 13:18:31 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:37800 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934312AbeFORS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 13:18:29 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5FHI1JA007609;
        Fri, 15 Jun 2018 12:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529083081;
        bh=87/lMDZ4STPvHSeGh//+BsWrrQTaJA3u8kEj7y2UDxk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=IJuSbhIJ5F1x8QPoS6dBZeN5xc8FTGBLs17sND5YAYTii9TMMChK1r0B7tCmdlHh3
         qvioOyGRm3n+WPCkifBF1+6NLBkCoUh6mv7Jr+6nCzLO/yS+QldphNgW+ULje0voTS
         J+N+B8C73+9gD1h3N17gKjoH93s1ZbnGF+Funx1o=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5FHI1Va020209;
        Fri, 15 Jun 2018 12:18:01 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 15
 Jun 2018 12:18:00 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 15 Jun 2018 12:18:00 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5FHHrMo013097;
        Fri, 15 Jun 2018 12:17:54 -0500
Subject: Re: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART
 controller
To:     Rob Herring <robh@kernel.org>, Nishanth Menon <nm@ti.com>
CC:     Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>
References: <20180605060125.9518-1-nm@ti.com>
 <20180605060125.9518-4-nm@ti.com> <20180612210640.GA20728@rob-hp-laptop>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <8c553dcc-e352-6e69-e08c-4e6237555ea7@ti.com>
Date:   Fri, 15 Jun 2018 22:47:53 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180612210640.GA20728@rob-hp-laptop>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Wednesday 13 June 2018 02:36 AM, Rob Herring wrote:
> On Tue, Jun 05, 2018 at 01:01:22AM -0500, Nishanth Menon wrote:
>> AM654 uses a UART controller that is compatible (partially) with
>> existing 8250 UART, however, has a few differences with respect to DMA
>> support and control paths. Introduce a base definition that allows us
>> to build up the differences in follow on patches.
>>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Vignesh R <vigneshr@ti.com>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>>  drivers/tty/serial/8250/8250_omap.c                      | 1 +
>>  2 files changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> index 4b0f05adb228..c35d5ece1156 100644
>> --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
>> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
>> @@ -1,6 +1,7 @@
>>  OMAP UART controller
>>  
>>  Required properties:
>> +- compatible : should be "ti,am654-uart" for AM654 controllers
> 
> Not compatible with any existing TI 8250 UARTs?

Curious on why you asked about this. Are you suggesting why not:

"ti,<new-soc>-uart", "ti,<old-soc>-uart"

or you are asking why introduce "ti,<new-soc>-uart" unless there is
clear demonstrable need for using it in driver code.

In general, I think "ti,<new-soc>-uart", "ti,<old-soc>-uart" in
device-tree (and by extension in binding document) is better even in
there are no _known_ incompatibilities at the time of initial driver
submission. The reason is silicon integration and process differences
many times spill over into driver.

Of course, the idea is not to go postal and create a new compatible for
every pin-compatible part number that gets created, but probably a new
compatible should be created for a new silicon die.

We have just started introducing support for this SoC, and since it
reuses many IPs, this question is likely to come up again.

In this particular case though, Nishanth is perfectly right in not saying

compatible : should be "ti,am654-uart", "ti,omap4-uart"

Because we *know* UART DMA integration is different and a match against
omap4 would result in non-working UART once DMA is enabled by default.

Thanks,
Sekhar
