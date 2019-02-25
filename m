Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8716E20663
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 14:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551105812;
	bh=vr1ZhFcRIDV1sAgXUX1CBJeWEOj2ljHDMls8abpMhGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GNP7jp3VCShbGC1DLGtqMHHyks0bZVEmFy1FhIuS76ydr+vQwIOMs+fY+YE/9g7o7
	 OHy7PmbO95E63krCZfNRQD98Ndf+fkYP7u5W27TshldYLv8pA2xFRyIi/lCETyIRKg
	 kI6mTpVQWbfQgBRgk8g4vFWMpiit8ttq4Hcb6Boc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfBYOnb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 09:43:31 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:38614 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfBYOna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 09:43:30 -0500
Received: by mail-oi1-f195.google.com with SMTP id q81so7420437oic.5;
        Mon, 25 Feb 2019 06:43:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MvHMrby5ch/aP9AvTPdkfCdicB/G7XIAKtD3Ix+7XQg=;
        b=miGrEx4qqmjC3r7aaA4wtNfGd0hAv/D9fXqJG+JoMVfjfv2yglbafcOQum3nPfGbmC
         qtku7qAaGTax8ahqXgDuqErIH88knxwx/gKwCPb3FHBeqKMYcBs+HEnF47PRCmiTeubp
         QqiqO+8SNjX7Xd3Z6+b6ZIr/WhK1hS3lqkdyb/sS0LsHmh4as3u2ZmGeQEWXnwWhCGAc
         QHSAKbpoREkZuHAhR1TSAFMuTzDCF+/RJ1NO4oSXtUr339rPGuLtuURAL95DopvjFN2M
         8RZM/xobDsjTFT0c9cGTddhXGta6HyX85ffK9UWg6VtKqTse67zxmGMXEkfFLTJhjJQs
         jewQ==
X-Gm-Message-State: AHQUAuaASwZL8a1T5Mt1GG9B2Ixw47DB8AQLvaUOuA+R9MbTyK9YpoJP
        7iXqqHkYWLV0lBrjwV5p/w==
X-Google-Smtp-Source: AHgI3Ia1wh8fpvxMYYgNI7+CVfvRSuu4aqpym0VigaEdjGEFcblLeNlA/8q6ywgbva3A+6Vn68vnCA==
X-Received: by 2002:aca:c40c:: with SMTP id u12mr11726378oif.138.1551105809851;
        Mon, 25 Feb 2019 06:43:29 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id k11sm258630oia.16.2019.02.25.06.43.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 06:43:29 -0800 (PST)
Date:   Mon, 25 Feb 2019 08:43:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Martin Kepplinger <martink@posteo.de>
Cc:     devicetree@vger.kernel.org, linux-input@vger.kernel.org,
        dmitry.torokhov@gmail.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: Re: [PATCH 1/2] dt-bindings: input: sitronix-st1232: document
 optional reset-gpios property
Message-ID: <20190225144328.GA13518@bogus>
References: <20190129102347.27754-1-martink@posteo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129102347.27754-1-martink@posteo.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:23:46AM +0100, Martin Kepplinger wrote:
> From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> 
> The st1232 driver reads this via gpiod.

What a driver does is not relevant to the binding. This breaks 
compatibility so you need to mention that and why this is okay.

Either you need to keep 'gpios' as deprecated or you can drop it if 
there aren't any dts files using it.

> 
> Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
> ---
>  .../devicetree/bindings/input/touchscreen/sitronix-st1232.txt | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> index e73e826e0f2a..365b32d30d4b 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> +++ b/Documentation/devicetree/bindings/input/touchscreen/sitronix-st1232.txt
> @@ -8,7 +8,7 @@ Required properties:
>  - interrupts: interrupt to which the chip is connected
>  
>  Optional properties:
> -- gpios: a phandle to the reset GPIO
> +- reset-gpios: a phandle to the reset GPIO
>  
>  Example:
>  
> @@ -19,7 +19,7 @@ Example:
>  			compatible = "sitronix,st1232";
>  			reg = <0x55>;
>  			interrupts = <2 0>;
> -			gpios = <&gpio1 166 0>;
> +			reset-gpios = <&gpio1 166 0>;
>  		};
>  
>  		/* ... */
> -- 
> 2.20.1
> 
