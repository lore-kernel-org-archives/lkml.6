Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E05AC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5282241C1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 12:26:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5282241C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932965AbeFVM0C (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 08:26:02 -0400
Received: from foss.arm.com ([217.140.101.70]:34074 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753275AbeFVM0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 08:26:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B4D914;
        Fri, 22 Jun 2018 05:26:00 -0700 (PDT)
Received: from [10.1.206.75] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDD053F819;
        Fri, 22 Jun 2018 05:25:57 -0700 (PDT)
Subject: Re: [PATCH v9 3/5] ARM: dts: Renesas R9A06G032 base device tree file
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>
Cc:     Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Phil Edworthy <phil.edworthy@renesas.com>,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1528973829-25493-1-git-send-email-michel.pollet@bp.renesas.com>
 <1528973829-25493-4-git-send-email-michel.pollet@bp.renesas.com>
 <CAMuHMdXamhn2GZs41i=wHXSRn0HgeHg4=7=g7pg7uni3LizK9w@mail.gmail.com>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <e90e0670-3cf5-4430-3b4a-8f7ad520938d@arm.com>
Date:   Fri, 22 Jun 2018 13:25:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXamhn2GZs41i=wHXSRn0HgeHg4=7=g7pg7uni3LizK9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/18 13:14, Geert Uytterhoeven wrote:
> Hi Michel,
> 
> CC MarcZ
> 
> On Thu, Jun 14, 2018 at 1:02 PM Michel Pollet
> <michel.pollet@bp.renesas.com> wrote:
>> This adds the Renesas R9A06G032 bare bone support.
>>
>> This currently only handles the SYSCTRL block note,
>> generic parts (gic, architected timer) and a UART.
>>
>> Signed-off-by: Michel Pollet <michel.pollet@bp.renesas.com>
> 
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/r9a06g032.dtsi
> 
>> +       timer {
>> +               compatible = "arm,cortex-a7-timer",
> 
> Checkpatch says:
> WARNING: DT compatible string "arm,cortex-a7-timer" appears
> un-documented -- check ./Documentation/devicetree/bindings/
> 
>> +                            "arm,armv7-timer";
> 
> Documentation/devicetree/bindings/arm/arch_timer.txt says:
> 
>     compatible should at least contain "arm,armv7-timer"
> 
> but fails to list other possible values?

The idea is that you could add something useful that matches your CPU.
Adding new CPU types in the binding seems to be a never ending battle...

> 
>> +               interrupt-parent = <&gic>;
>> +               arm,cpu-registers-not-fw-configured;

Really? :-(

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
