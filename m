Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0B155C07D5F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBB5C20660
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 18:09:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB5C20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933836AbeFKSJe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 14:09:34 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:46195 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932740AbeFKSJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 14:09:32 -0400
Received: by mail-yw0-f193.google.com with SMTP id v197-v6so6617328ywc.13;
        Mon, 11 Jun 2018 11:09:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=C5Ukkivr4449uW1buuloCdNzxCLEtAN5nABvxV5Vkqc=;
        b=X3h6gsjWxYJaTIBx8VT92halSSq9xjRI3G9Loc5F/PLr53rdso/F6G+PT/cgOrA+ha
         wotsdyFETvq5NVb9bn9SeZXH/Y5pAkWasAWA0VhpSudc8mtKiGrjYSo4FlISAc2f1kYD
         G0RNSbDM3QmAdU9nlZOTaTFLsslQFfCgGEcp1207pU3BzHWYMKUg0EW3n2hgCJliF+ln
         DKVAVlKCZeJA5SzrM+/k2tQrbuKT2d78bQL6f/SIVXeCBt5rYVwla1RNZfhJev7wYl9l
         BtXs02VsoRqm49s4KrYoBs+8qFbvsptOrPWnxWLERUSa2NEweibi5VMW8h0JsswViz/S
         KZbw==
X-Gm-Message-State: APt69E0vOD5oodiELEVDobG17I7MyATuF9TaUrKm8ytayjh6l86a+raT
        SprrlnoaeZJJGJurqc5r3Q==
X-Google-Smtp-Source: ADUXVKJgX228hisiYNhaBTyVbRH9MhxmqfNnFagnTm3wf/TlGHs8QQZfpDCo7V/X/b9pUfBrsZdiNA==
X-Received: by 2002:a0d:cf41:: with SMTP id r62-v6mr111926ywd.473.1528740571315;
        Mon, 11 Jun 2018 11:09:31 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id l197-v6sm15461250ywe.61.2018.06.11.11.09.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 11:09:30 -0700 (PDT)
Date:   Mon, 11 Jun 2018 12:09:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc:     davem@davemloft.net, tobin@apporbit.com,
        Andrea Greco <a.greco@4sigma.it>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] arcnet: com20020: bindings for smsc com20020
Message-ID: <20180611180929.GA28695@rob-hp-laptop>
References: <20180611142705.20849-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180611142705.20849-1-andrea.greco.gapmilano@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 11, 2018 at 04:27:01PM +0200, Andrea Greco wrote:
> From: Andrea Greco <a.greco@4sigma.it>
> 
> Add devicetree bindings for smsc com20020
> 
> Signed-off-by: Andrea Greco <a.greco@4sigma.it>
> ---
>  .../devicetree/bindings/net/smsc-com20020.txt       | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/smsc-com20020.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/smsc-com20020.txt b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> new file mode 100644
> index 000000000000..660a4a751f29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> @@ -0,0 +1,21 @@
> +SMSC com20020 Arcnet network controller
> +
> +Required property:
> +- timeout-ns: Arcnet bus timeout, Idle Time (328000 - 20500)
> +- bus-speed-bps: Arcnet bus speed (10000000 - 156250)
> +- smsc,xtal-mhz: External oscillator frequency
> +- smsc,backplane-enabled: Controller use backplane mode
> +- reset-gpios: Chip reset pin
> +- interrupts: Should contain controller interrupt
> +
> +arcnet@28000000 {
> +	compatible = "smsc,com20020";
> +
> +	timeout-ns = <20500>;
> +	bus-speed-hz = <10000000>;

You have hz here and bps above.

> +	smsc,xtal-mhz = <20>;
> +	smsc,backplane-enabled;
> +
> +	reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
> +	interrupts = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +};
> -- 
> 2.14.4
> 
