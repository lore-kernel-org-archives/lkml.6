Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BCFC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:16:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AB2D23CA8
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 23:16:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AB2D23CA8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeGCXQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 19:16:54 -0400
Received: from mail-yb0-f193.google.com ([209.85.213.193]:33075 "EHLO
        mail-yb0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbeGCXQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 19:16:52 -0400
Received: by mail-yb0-f193.google.com with SMTP id e84-v6so1383264ybb.0;
        Tue, 03 Jul 2018 16:16:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZQKyOMAIsixw0cpN/IjDZx9tuqfJT0i3YxHsxAlJLBA=;
        b=VWHL86KucC9Sg58rMoCkF704egG/bWVJhuobSG2bqy26LhN1YV3EUEURdKt4J74TOK
         CF4TFOwx89B4XMmEHJh0p6RWE5/OpSP4EpH4Fjv2q1oI7ZlJVIpw1WppinvldsTCwh/V
         HXU4RqAiGFIHf2BZTUk46KQI6tR0dRkjl1UOKK3McBroTjXXblj/O2y5+ns/DRf+0NVx
         1r9XwGk9p7J1vHtKWznSYyvsx960cRoeWcpe8gJ0vobPJNSXIVZU4Abs+yyixQIIFPGZ
         hcucvToW4PDYd02KiH8izJMbza8HrfRVd0NJ8fGIfaX7IEdLygCGJPb7YsLTNFxl7Xmt
         50iw==
X-Gm-Message-State: APt69E2+zYw0joNjjCXOEclWMCqwjpg8BXuEPCHTuCwiAm3N5VUuj//S
        WQoGOQWqGF2ohhgevikTSDSipR2AWA==
X-Google-Smtp-Source: ADUXVKJ4e1+XZYEhw7QD4aF6lD2hMraK/UhC3iFTM2wLLbDwrot5sE1FUuHYn+qxgdxHFEPE4Yduag==
X-Received: by 2002:a25:830f:: with SMTP id s15-v6mr16414444ybk.526.1530659812195;
        Tue, 03 Jul 2018 16:16:52 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id q131-v6sm1947761ywq.8.2018.07.03.16.16.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 16:16:51 -0700 (PDT)
Date:   Tue, 3 Jul 2018 17:16:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
Subject: Re: [PATCH v2 1/4] dt-bindings: w1: document sub-node bindings for
 DS2760
Message-ID: <20180703231650.GA9201@rob-hp-laptop>
References: <20180628075540.1757-1-daniel@zonque.org>
 <20180628075540.1757-2-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180628075540.1757-2-daniel@zonque.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 09:55:37AM +0200, Daniel Mack wrote:
> This patch add a generic w1 bindings document that merely describes how
> slave deviceses are grouped under master nodes. It also adds a specific
> binding for the ds2760 battery monitor.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../devicetree/bindings/w1/maxim,ds2760.txt    | 15 +++++++++++++++
>  .../devicetree/bindings/w1/w1-gpio.txt         |  6 ++++++
>  Documentation/devicetree/bindings/w1/w1.txt    | 18 ++++++++++++++++++
>  3 files changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/w1/maxim,ds2760.txt
>  create mode 100644 Documentation/devicetree/bindings/w1/w1.txt
> 
> diff --git a/Documentation/devicetree/bindings/w1/maxim,ds2760.txt b/Documentation/devicetree/bindings/w1/maxim,ds2760.txt
> new file mode 100644
> index 000000000000..d916fdd213f7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/maxim,ds2760.txt
> @@ -0,0 +1,15 @@
> +Devicetree bindings for Maxim DS2760
> +====================================
> +
> +The ds2760 is a w1 slave device and must hence have its sub-node in DT
> +under a w1 bus master node.
> +
> +The device exposes a power supply, so the details described in
> +Documentation/devicetree/bindings/power/supply/power_supply.txt apply.
> +
> +Required properties:
> +- compatible: must be "maxim,ds2760"
> +
> +Optional properties:
> +- power-supplies:	Refers to one or more power supplies connected to
> +			this battery.
> diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> index 6e09c35d9f1a..6694317bcbed 100644
> --- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
> +++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> @@ -13,10 +13,16 @@ Optional properties:
>   - linux,open-drain: if specified, the data pin is considered in
>  		     open-drain mode.
>  
> +Also refer to the generic w1.txt document.
> +
>  Examples:
>  
>  	onewire@0 {
>  		compatible = "w1-gpio";
>  		gpios = <&gpio 126 0>, <&gpio 105 0>;
> +
> +		battery {
> +			compatible = "maxim,ds2760";

Perhaps show the power-supplies property as that's the whole point to 
have in DT.

> +		};
>  	};
>  
> diff --git a/Documentation/devicetree/bindings/w1/w1.txt b/Documentation/devicetree/bindings/w1/w1.txt
> new file mode 100644
> index 000000000000..6ac103f972a0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/w1.txt
> @@ -0,0 +1,18 @@
> +Generic devicetree bindings for onewire (w1) busses
> +===================================================
> +
> +Onewire busses are described through nodes of their master bus controller.
> +Slave devices are listed as sub-nodes of such master devices. For now, one
> +one slave is allowed per bus master.

s/one one/only one/

> +
> +
> +Example:
> +
> +	onewire {
> +		compatible = "w1-gpio";
> +		gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
> +
> +		battery {
> +			compatible = "maxim,ds2760";
> +		};
> +	};
> -- 
> 2.17.1
> 
