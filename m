Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7190DC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:55:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CA932799D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 02:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=roeck-us.net header.i=@roeck-us.net header.b="BnWW0xwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CA932799D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967641AbeF2CzG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 22:55:06 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:50856 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966362AbeF2CzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 22:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VXtzo4vNwmeuyHqsFLQOdivO78T7gcJ+B2lQauLvF7E=; b=BnWW0xwko7YQpNar/kVDZ+BFR9
        koEc7+isFeW5cENPQLbpNDF5fs/WTyTbwsU0N7xFx6P6qVrvufC3ztsNCEDU/Aa45NnjCvkG7BNJu
        kJWxISAnwHRMCzmcf6awRj+C9H87MrKw1ibiWLBA8BxWluzsEt80/tpphMFCjxQhKzXnrZwYoeGZa
        TmdyxgoN5MDWXX01XsaJn5TeUIeBQmMBuKVh1Zh9WFoSLkW06p6RCxwkPlTvu2GF3KIiVkWk9kfgF
        XugWzHcvbqPX+DP6VK38moBYEYCA4dSk2LgiLXKPaG76b62wmdWHlu0xRUNgV6PYquNhbGa2rWsBu
        ouIRFGcA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:49384 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fYjYt-007sJd-0Y; Fri, 29 Jun 2018 02:55:03 +0000
Date:   Thu, 28 Jun 2018 19:55:01 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [v4,1/6] Documentation: DT: Consolidate SP805 binding docs
Message-ID: <20180629025501.GA28536@roeck-us.net>
References: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527530497-10392-2-git-send-email-ray.jui@broadcom.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 11:01:32AM -0700, Ray Jui wrote:
> Consolidate two SP805 binding documents "arm,sp805.txt" and
> "sp805-wdt.txt" into "arm,sp805.txt" that matches the naming of the
> desired compatible string to be used
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

For the record:

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  .../devicetree/bindings/watchdog/arm,sp805.txt     | 27 ++++++++++++++-----
>  .../devicetree/bindings/watchdog/sp805-wdt.txt     | 31 ----------------------
>  2 files changed, 20 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> index ca99d64..0fa3629 100644
> --- a/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> +++ b/Documentation/devicetree/bindings/watchdog/arm,sp805.txt
> @@ -1,17 +1,30 @@
>  ARM AMBA Primecell SP805 Watchdog
>  
> +SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
> +can be used to identify the peripheral type, vendor, and revision.
> +This value can be used for driver matching.
> +
> +As SP805 WDT is a primecell IP, it follows the base bindings specified in
> +'arm/primecell.txt'
> +
>  Required properties:
> -- compatible: Should be "arm,sp805" & "arm,primecell"
> -- reg: Should contain location and length for watchdog timer register.
> -- interrupts: Should contain the list of watchdog timer interrupts.
> -- clocks: clocks driving the watchdog timer hardware. This list should be 2
> -	clocks. With 2 clocks, the order is wdogclk clock, apb_pclk.
> +- compatible:  Should be "arm,sp805" & "arm,primecell"
> +- reg:         Should contain location and length for watchdog timer register
> +- clocks:      Clocks driving the watchdog timer hardware. This list should be
> +               2 clocks. With 2 clocks, the order is wdog_clk, apb_pclk
> +               wdog_clk can be equal to or be a sub-multiple of the apb_pclk
> +               frequency
> +- clock-names: Shall be "wdog_clk" for first clock and "apb_pclk" for the
> +               second one
> +
> +Optional properties:
> +- interrupts:  Should specify WDT interrupt number
>  
>  Example:
>  	watchdog@66090000 {
>  		compatible = "arm,sp805", "arm,primecell";
>  		reg = <0x66090000 0x1000>;
>  		interrupts = <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>;
> -		clocks = <&apb_pclk>,<&apb_pclk>;
> -		clock-names = "wdogclk", "apb_pclk";
> +		clocks = <&wdt_clk>, <&apb_pclk>;
> +		clock-names = "wdog_clk", "apb_pclk";
>  	};
> diff --git a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt b/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> deleted file mode 100644
> index edc4f0e..0000000
> --- a/Documentation/devicetree/bindings/watchdog/sp805-wdt.txt
> +++ /dev/null
> @@ -1,31 +0,0 @@
> -* ARM SP805 Watchdog Timer (WDT) Controller
> -
> -SP805 WDT is a ARM Primecell Peripheral and has a standard-id register that
> -can be used to identify the peripheral type, vendor, and revision.
> -This value can be used for driver matching.
> -
> -As SP805 WDT is a primecell IP, it follows the base bindings specified in
> -'arm/primecell.txt'
> -
> -Required properties:
> -- compatible : Should be "arm,sp805-wdt", "arm,primecell"
> -- reg : Base address and size of the watchdog timer registers.
> -- clocks : From common clock binding.
> -           First clock is PCLK and the second is WDOGCLK.
> -           WDOGCLK can be equal to or be a sub-multiple of the PCLK frequency.
> -- clock-names : From common clock binding.
> -                Shall be "apb_pclk" for first clock and "wdog_clk" for the
> -                second one.
> -
> -Optional properties:
> -- interrupts : Should specify WDT interrupt number.
> -
> -Examples:
> -
> -		cluster1_core0_watchdog: wdt@c000000 {
> -			compatible = "arm,sp805-wdt", "arm,primecell";
> -			reg = <0x0 0xc000000 0x0 0x1000>;
> -			clocks = <&clockgen 4 3>, <&clockgen 4 3>;
> -			clock-names = "apb_pclk", "wdog_clk";
> -		};
> -
