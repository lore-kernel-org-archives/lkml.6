Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5DECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC89B208E8
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 21:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC89B208E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbeGPVh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:37:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39710 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbeGPVh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:37:58 -0400
Received: by mail-oi0-f65.google.com with SMTP id d189-v6so77489348oib.6;
        Mon, 16 Jul 2018 14:08:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NPYfOFJ+fsBxXa/HGViQtPpXeQMQImJ2O/iXPR4u6XU=;
        b=ckTuKjHT0tzMJ+QetzLqrRKLKJpdqKCVLEq4P/NiTw7D7MNyct3nl0UgFHftioEhfY
         ZQqw45Kv1uJd2ElqNpTinD8u6n+WpGzRA2/dkin8s40INYvtb3H70AJ2d9C7Pc6j94UK
         3WgvfwfjkuDIWIAMWOklxVBGPdbyo80pIgvMZNfhL7iiida1R9kwCiV0DUiTKHQvaBxj
         iVA8rwGti2Gc2OYSMMulwa4vGqCpD19HRMW0RrDDf3QBEy5q8hmFbyAWBpaecENJCtHp
         X1vb0Lq3kZB//6bErKLjNhVeCLYLkmIrVUnraidZ2/U/iqP+o1SG1irrHlKTOrMcp4cH
         jkKw==
X-Gm-Message-State: AOUpUlGtI62HekoF9jkhpwTCq08Sv/NHhLEnBkB2YVnGrcuP2lI8MKzd
        1asb/TqhYdVuN4LhzfkE5w==
X-Google-Smtp-Source: AAOMgpdG0UJbkaYslM+zyfATIh+YWzkDXq2f7LTZ8ZjwmXxQNl6UkcmeU4Mer2uwZiDy0VGCiOsFcw==
X-Received: by 2002:aca:44c5:: with SMTP id r188-v6mr975793oia.280.1531775326847;
        Mon, 16 Jul 2018 14:08:46 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id m62-v6sm12258452oik.30.2018.07.16.14.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 14:08:46 -0700 (PDT)
Date:   Mon, 16 Jul 2018 15:08:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     mark.rutland@arm.com, jacek.anaszewski@gmail.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: Re: [PATCH 3/4] dt: bindings: lm3692x: Update binding for LED sync
 control
Message-ID: <20180716210845.GA26337@rob-hp-laptop>
References: <20180702181216.19660-1-dmurphy@ti.com>
 <20180702181216.19660-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180702181216.19660-3-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 02, 2018 at 01:12:15PM -0500, Dan Murphy wrote:
> Update the binding to be able to configure the LED
> sync to turn on.

s/sync/sink/ ? As in a current sink.

> 
> The LM36922 has one output but can sync current to 2 LED
> strings.  The user may only use one sync so the other
> syncs need to be disabled.
> 
> The LM36923 has 3 LED syncs.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-lm3692x.txt | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> index 6c9074f84a51..08b352840bd7 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> +++ b/Documentation/devicetree/bindings/leds/leds-lm3692x.txt
> @@ -20,7 +20,10 @@ Optional properties:
>  	- vled-supply : LED supply
>  
>  Required child properties:
> -	- reg : 0
> +	- reg : 0 - Will enable all LED sync paths
> +		1 - Will enable the LED1 sync
> +		2 - Will enable the LED2 sync
> +		3 - Will enable the LED3 sync (LM36923 only)
>  
>  Optional child properties:
>  	- label : see Documentation/devicetree/bindings/leds/common.txt
> -- 
> 2.17.0.582.gccdcbd54c
> 
