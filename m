Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A54C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC334215E4
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 11:59:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC334215E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbeI1SWl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 14:22:41 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48258 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbeI1SWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 14:22:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AE5CBED1;
        Fri, 28 Sep 2018 04:59:14 -0700 (PDT)
Received: from [10.4.13.85] (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4B3723F5BD;
        Fri, 28 Sep 2018 04:59:13 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: irqchip: renesas-irqc: Document R-Car E3
 support
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180928113238.17192-1-geert+renesas@glider.be>
From:   Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <accca8b5-1941-2f28-d939-647ec3b30bd9@arm.com>
Date:   Fri, 28 Sep 2018 12:59:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180928113238.17192-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/18 12:32, Geert Uytterhoeven wrote:
> Document support for the Interrupt Controller for External Devices
> (INTC-EX) in the Renesas E3 (r8a77990) SoC.
> 
> No driver update is needed.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>   .../devicetree/bindings/interrupt-controller/renesas,irqc.txt | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> index a046ed374d808d66..b8a86e30e8e67068 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/renesas,irqc.txt
> @@ -2,7 +2,8 @@ DT bindings for the R-Mobile/R-Car/RZ/G interrupt controller
>   
>   Required properties:
>   
> -- compatible: has to be "renesas,irqc-<soctype>", "renesas,irqc" as fallback.
> +- compatible: must be "renesas,irqc-<soctype>" or "renesas,intc-ex-<soctype>",
> +	      and "renesas,irqc" as fallback.
>     Examples with soctypes are:
>       - "renesas,irqc-r8a73a4" (R-Mobile APE6)
>       - "renesas,irqc-r8a7743" (RZ/G1M)
> @@ -19,6 +20,7 @@ Required properties:
>       - "renesas,intc-ex-r8a77965" (R-Car M3-N)
>       - "renesas,intc-ex-r8a77970" (R-Car V3M)
>       - "renesas,intc-ex-r8a77980" (R-Car V3H)
> +    - "renesas,intc-ex-r8a77990" (R-Car E3)
>       - "renesas,intc-ex-r8a77995" (R-Car D3)
>   - #interrupt-cells: has to be <2>: an interrupt index and flags, as defined in
>     interrupts.txt in this directory
> 

Queued for 4.20.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
