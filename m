Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3EBC71132
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BEB208AE
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 14:46:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BEB208AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbeJOWbu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 18:31:50 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38536 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbeJOWbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 18:31:50 -0400
Received: by mail-ot1-f68.google.com with SMTP id l1so19121570otj.5;
        Mon, 15 Oct 2018 07:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DK4TbbxttyRat7RFSZ/FwfJskfMoANy/z3qhu9r7SJQ=;
        b=oNGvHoxyKr4/JkFXUUAA3X/Yk9dUeyh2ZxeosXQzHNv40ArvBE8zd9jEH+fxFFYOxN
         vafE3eh+j3ZFra4jKIe0ELMClzcTn4Gn4VUJyyT4dFNUDlZb+Wpc6bU4ekHm3BDgl0pe
         HWmfFDrq8wAzKLATDy6CKW9E8ED/ohdSMiKGJRIQErW0uSWooALJNqYwORzs1blimLBR
         HWL98Rgl0bxiysMh94DnqixM2dKQERVhp3iQ2MYhFyUBJF67L9HwY8qEea6+nAvoDoT/
         nNOZplmXCHGgUkcJwn/eOt2sSZp/0ttkrhf7Rg5QSHrdTwvM1p74nYc98HXl2UsqdArS
         MJZQ==
X-Gm-Message-State: ABuFfogUpsEh/t/dhxTdCK0DG7Ng6tF6bDHEkIaXCu6IfVDujhhqIcb2
        sBFUz8LCgdxffMnkGUtGhw==
X-Google-Smtp-Source: ACcGV61K6inub5Ln23KJyXNVRixOe9BagZgvCuXMu2xKpQtnMWOuDONh3P9GtQR2o+3pQVA31sNGaw==
X-Received: by 2002:a9d:2fe6:: with SMTP id b35mr11307269otd.18.1539614774682;
        Mon, 15 Oct 2018 07:46:14 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id o88-v6sm3376433oik.27.2018.10.15.07.46.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 07:46:13 -0700 (PDT)
Date:   Mon, 15 Oct 2018 09:46:12 -0500
From:   Rob Herring <robh@kernel.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/9] dt-bindings: tegra186-gpio: Add wakeup parent support
Message-ID: <20181015144612.GA23929@bogus>
References: <20180921102546.12745-1-thierry.reding@gmail.com>
 <20180921102546.12745-8-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180921102546.12745-8-thierry.reding@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 12:25:44PM +0200, Thierry Reding wrote:
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
>  .../devicetree/bindings/gpio/nvidia,tegra186-gpio.txt      | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> index adff16c71d21..cbb51a8990c3 100644
> --- a/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/nvidia,tegra186-gpio.txt
> @@ -127,6 +127,11 @@ Required properties:
>              - 8: Active low level-sensitive.
>              Valid combinations are 1, 2, 3, 4, 8.
>  
> +Optional properties:
> +- wake-parent
> +    A phandle to the Power Management Controller (PMC) that contains top-
> +    level controls to enable the wake-up capabilities of some GPIOs.
> +
>  Example:
>  
>  #include <dt-bindings/interrupt-controller/irq.h>
> @@ -148,6 +153,7 @@ gpio@2200000 {
>  	#gpio-cells = <2>;
>  	interrupt-controller;
>  	#interrupt-cells = <2>;
> +	wakeup-parent = <&pmc>;
>  };
>  
>  gpio@c2f0000 {
> @@ -162,4 +168,5 @@ gpio@c2f0000 {
>  	#gpio-cells = <2>;
>  	interrupt-controller;
>  	#interrupt-cells = <2>;
> +	wakeup-parent = <&pmc>;

If all the GPIO instances point to the same PMC and have no per instance 
data, why do you need this in DT? You can just search for the compatible 
node.

Rob
