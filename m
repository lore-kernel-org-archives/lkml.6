Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE2C5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C785420873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 15:02:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C785420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388783AbeGKPGp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:06:45 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:44235 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732752AbeGKPGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:06:44 -0400
Received: by mail-oi0-f68.google.com with SMTP id s198-v6so49801658oih.11;
        Wed, 11 Jul 2018 08:02:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Jc6Qckq0piQWHb1bxPBwU7+Y3qMHPySbJAIjJTvKTu4=;
        b=QCAossxCffx4EtffX8IpFo1Z8VJk4inKGK0umWotAn3xdYoJavC/G6BesIT8++oZlK
         7cVIKZCIznCVuBjF5veQRmH3tDkslqrD+0wRzXIG8NGHe/bvoAtRVPlTwRB66ueSi1RZ
         5oNOI5Wm0T0Ny+UKijms4fi0L3jea+OONMKglSLmjeIzcAw6pYOQVH04/DJvtGKOuTQV
         fIKmX/cwa0Lmk7OtIx2r3EvYIZSTXABSZSTAXsdILDMlmB7e82ZOzGnEyd0Jr2t7Un/b
         w6RA4FXtBnVvZDLkhgNPhriSU6vhqNTTFgP8Au/RPmcniN0sB3kRiO63B9AsQ75ggjka
         hEqw==
X-Gm-Message-State: APt69E3W0OAQ9FbPBUdKujt+NPNH3VBSQA0GiJ17K4raxBfFC1oAmeuP
        8P9G8wD5RYBzn2kDS7TFjA==
X-Google-Smtp-Source: AAOMgpfK0f1LOl4u8tImPgZPrUiWigG+tpd6DdBDPA1Rz/EBVHT8eym/I6hzRwIS8BxG2bkxUHt3Gw==
X-Received: by 2002:aca:a8c7:: with SMTP id r190-v6mr30393659oie.357.1531321319658;
        Wed, 11 Jul 2018 08:01:59 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id r133-v6sm17355830oia.33.2018.07.11.08.01.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 08:01:58 -0700 (PDT)
Date:   Wed, 11 Jul 2018 09:01:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Daniel Mack <daniel@zonque.org>
Cc:     zbr@ioremap.net, mark.rutland@arm.com, szabolcs.gyurko@tlt.hu,
        sre@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        robert.jarzmik@free.fr
Subject: Re: [PATCH v4 1/5] dt-bindings: w1: document generic onewire bindings
Message-ID: <20180711150157.GA18150@rob-hp-laptop>
References: <20180706053552.11438-1-daniel@zonque.org>
 <20180706053552.11438-2-daniel@zonque.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180706053552.11438-2-daniel@zonque.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2018 at 07:35:48AM +0200, Daniel Mack wrote:
> This patch adds a generic w1 bindings document that describes how w1
> slave deviceses are grouped under master nodes. It also augments the
> existing w1-gpio.txt document a bit.
> 
> Signed-off-by: Daniel Mack <daniel@zonque.org>
> ---
>  .../devicetree/bindings/w1/w1-gpio.txt        | 11 +++++---
>  Documentation/devicetree/bindings/w1/w1.txt   | 25 +++++++++++++++++++
>  2 files changed, 33 insertions(+), 3 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/w1/w1.txt

Reviewed-by: Rob Herring <robh@kernel.org>

Note that this will conflict with a unit-address fix that I have queued 
up for 4.18 (will send this week).

> 
> diff --git a/Documentation/devicetree/bindings/w1/w1-gpio.txt b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> index 6e09c35d9f1a..3d6554eac240 100644
> --- a/Documentation/devicetree/bindings/w1/w1-gpio.txt
> +++ b/Documentation/devicetree/bindings/w1/w1-gpio.txt
> @@ -13,10 +13,15 @@ Optional properties:
>   - linux,open-drain: if specified, the data pin is considered in
>  		     open-drain mode.
>  
> +Also refer to the generic w1.txt document.
> +
>  Examples:
>  
> -	onewire@0 {
> +	onewire {
>  		compatible = "w1-gpio";
> -		gpios = <&gpio 126 0>, <&gpio 105 0>;
> -	};
> +		gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
>  
> +		battery {
> +			// ...
> +		};
> +	};
> diff --git a/Documentation/devicetree/bindings/w1/w1.txt b/Documentation/devicetree/bindings/w1/w1.txt
> new file mode 100644
> index 000000000000..05f26b27d898
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/w1/w1.txt
> @@ -0,0 +1,25 @@
> +Generic devicetree bindings for onewire (w1) busses
> +===================================================
> +
> +Onewire busses are described through nodes of their master bus controller.
> +Slave devices are listed as sub-nodes of such master devices. For now, only
> +one slave is allowed per bus master.
> +
> +
> +Example:
> +
> +	charger: charger {
> +		compatible = "gpio-charger";
> +		charger-type = "mains";
> +		gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
> +	};
> +
> +	onewire {
> +		compatible = "w1-gpio";
> +		gpios = <&gpio 100 0>, <&gpio 101 0>;
> +
> +		battery {
> +			compatible = "maxim,ds2760";
> +			power-supplies = <&charger>;
> +		};
> +	};
> -- 
> 2.17.1
> 
