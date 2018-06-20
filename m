Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FE9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:14:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57AE420693
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 19:14:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AE420693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754675AbeFTTON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 15:14:13 -0400
Received: from mail-yw0-f196.google.com ([209.85.161.196]:35589 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754463AbeFTTOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 15:14:11 -0400
Received: by mail-yw0-f196.google.com with SMTP id v131-v6so247441ywg.2;
        Wed, 20 Jun 2018 12:14:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TI551naM5Y4uDzo/GrGp2yfCeEEPUjm4pMtD9JZgHOU=;
        b=AHNMLrPZdSo95Qft3wKi/Dowtnwv5ELG9lPrd/MdVT/OWIwRaT8gz6bOAqPwJSAC0H
         tbYe5NM1tLwwLtPFh/99vtQtifRbgdZIy1aQKYLTgW6gBGueVx5HoU2uxwcHKgzZgvhd
         Xgxkhev3FaCN30/p5DUQNEbtNHKEr5fiD4CnGDkPsore6Z177IHbUGmyA6VXbmgWxqkZ
         UT7GWBEmpEMADF01LF2Wuny19VK90GOMxUCxVXbIOQjuzU4K1Al/pDVxhpF16oSXgp+p
         6lt70lwYvM6mjflEGLbKx5NptdpOn/t2R2bcjj617bm/y09d2kj0QlFXq5y0HMgun3yg
         rRnQ==
X-Gm-Message-State: APt69E2xA2H970gH2TDvaGB5rVmJBnZSTZZCSMhfY7qMjgJxyxRCtC+V
        uwLm6SXgRiwfktnKlGNwqw==
X-Google-Smtp-Source: ADUXVKJx1oQMNIc8HsS0+ND7LlL7Ig8o8r1l3ObU2VF01vMNZIT5JT3Ub+7qBOvSxwXT9t8zwhNtgQ==
X-Received: by 2002:a0d:c9c6:: with SMTP id l189-v6mr10911571ywd.164.1529522051093;
        Wed, 20 Jun 2018 12:14:11 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id p82-v6sm1126223ywe.1.2018.06.20.12.14.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Jun 2018 12:14:10 -0700 (PDT)
Date:   Wed, 20 Jun 2018 13:14:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ludovic Barre <ludovic.Barre@st.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V3 1/3] watchdog: stm32: add pclk feature for stm32mp1
Message-ID: <20180620191409.GA29934@rob-hp-laptop>
References: <1529502698-13263-1-git-send-email-ludovic.Barre@st.com>
 <1529502698-13263-2-git-send-email-ludovic.Barre@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1529502698-13263-2-git-send-email-ludovic.Barre@st.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 20, 2018 at 03:51:36PM +0200, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds config data to manage specific properties by
> compatible. Adds stm32mp1 config which requires pclk clock.
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  .../devicetree/bindings/watchdog/st,stm32-iwdg.txt |  21 +++-

Please split bindings to separate patch.

>  drivers/watchdog/stm32_iwdg.c                      | 116 +++++++++++++--------
>  2 files changed, 91 insertions(+), 46 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> index cc13b10a..f07f6d89 100644
> --- a/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> +++ b/Documentation/devicetree/bindings/watchdog/st,stm32-iwdg.txt
> @@ -2,18 +2,31 @@ STM32 Independent WatchDoG (IWDG)
>  ---------------------------------
>  
>  Required properties:
> -- compatible: "st,stm32-iwdg"
> -- reg: physical base address and length of the registers set for the device
> -- clocks: must contain a single entry describing the clock input
> +- compatible: Should be either "st,stm32-iwdg" or "st,stm32mp1-iwdg"

Please format one per line.

> +- reg: Physical base address and length of the registers set for the device
> +- clocks: Reference to the clock entry lsi. Additional pclk clock entry
> +  is required only for st,stm32mp1-iwdg.
> +- clock-names: Name of the clocks used.
> +  "lsi" for st,stm32-iwdg
> +  "pclk", "lsi" for st,stm32mp1-iwdg

Put lsi 1st so it is always index 0.

>  
>  Optional Properties:
>  - timeout-sec: Watchdog timeout value in seconds.
>  
> -Example:
> +Examples:
>  
>  iwdg: watchdog@40003000 {
>  	compatible = "st,stm32-iwdg";
>  	reg = <0x40003000 0x400>;
>  	clocks = <&clk_lsi>;
> +	clock-names = "lsi";
> +	timeout-sec = <32>;
> +};
> +
> +iwdg: iwdg@5a002000 {

watchdog@...

Do we really need 2 example just to show 2 clocks?

> +	compatible = "st,stm32mp1-iwdg";
> +	reg = <0x5a002000 0x400>;
> +	clocks = <&rcc IWDG2>, <&clk_lsi>;
> +	clock-names = "pclk", "lsi";
>  	timeout-sec = <32>;
>  };
