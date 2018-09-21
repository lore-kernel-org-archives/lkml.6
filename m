Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD33ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6498921531
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kapsi.fi header.i=@kapsi.fi header.b="ldr9uh8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6498921531
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kapsi.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389852AbeIUQZb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:25:31 -0400
Received: from mail.kapsi.fi ([91.232.154.25]:49141 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727554AbeIUQZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:25:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wyQBogFP49CCQKKhyzhdwQJOr+cSn7csR62Zhc8easA=; b=ldr9uh8wH4NsmaPnxj+TzK4hQp
        o/gPZRB8Sm3ABzK3aZ8C4gKbKsmTWHeBlLZUDVBZ7rjWp0+keR2xYFbZdXExYQKQZlmbjkuFug0BY
        0FA63+r1d6FwGKCkyebgXX7TLnOqb0tSHvZYe79TY9NnCIZ+BTX/t3KENZ8AsYbAKP+aW2exwS0b1
        3UoISFOPgR/MPYc7gUl5aCqhCtGZm9DD9BKEC+pzeyGlCGfygW7/euOQk3vEteYNttU0fp+8V/5Kh
        KBDe5rL9bbB8AOZTBQyTc4/v5T5CKS9xijm7HfAojMfiiJqqeZrXLttsxz1ttywzph7KhEVJWBzCN
        6T2Vy1YA==;
Received: from [39.110.237.146] (helo=[10.19.62.132])
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1g3IoC-0006BF-PX; Fri, 21 Sep 2018 13:37:13 +0300
Subject: Re: [PATCH 7/9] dt-bindings: tegra186-gpio: Add wakeup parent support
To:     Thierry Reding <thierry.reding@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-8-thierry.reding@gmail.com>
From:   Mikko Perttunen <cyndis@kapsi.fi>
Message-ID: <e6477bcb-4a1e-be60-d92e-a9d64accf687@kapsi.fi>
Date:   Fri, 21 Sep 2018 19:37:06 +0900
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180921102546.12745-8-thierry.reding@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 39.110.237.146
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/09/2018 19.25, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Tegra186 and later have some top-level controls for wake events in the
> power management controller (PMC). In order to enable the system to wake
> up from low power states, additional registers in the PMC need to be
> programmed. Add a wakeup-parent property to establish this relationship
> between the GPIO controller and the PMC.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>   .../devicetree/bindings/gpio/nvidia,tegra186-gpio.txt      | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> index adff16c71d21..cbb51a8990c3 100644
> --- a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> @@ -127,6 +127,11 @@ Required properties:
>               - 8: Active low level-sensitive.
>               Valid combinations are 1, 2, 3, 4, 8.
>   
> +Optional properties:
> +- wake-parent

wakeup-parent

Cheers,
Mikko

> +    A phandle to the Power Management Controller (PMC) that contains top-
> +    level controls to enable the wake-up capabilities of some GPIOs.
> +
>   Example:
>   
>   #include <dt-bindings/interrupt-controller/irq.h>
> @@ -148,6 +153,7 @@ gpio@2200000 {
>   	#gpio-cells = <2>;
>   	interrupt-controller;
>   	#interrupt-cells = <2>;
> +	wakeup-parent = <&pmc>;
>   };
>   
>   gpio@c2f0000 {
> @@ -162,4 +168,5 @@ gpio@c2f0000 {
>   	#gpio-cells = <2>;
>   	interrupt-controller;
>   	#interrupt-cells = <2>;
> +	wakeup-parent = <&pmc>;
>   };
> 
