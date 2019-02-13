Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4913C0044B
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85AEC21872
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550092615;
	bh=s0F7blGKMTafEwuJhtQmbSQjtlJFq9O25DHwKCvQPCA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s9kyGahzI7fwnK2AZsLIYY7iRlto4oBONfcPlYTburvNh5/b6AVAoeFJEparx7nD7
	 +51NCR5g1C2SHJbAGRSy0VHR8DQof/wVESC1/7w/XGT/gSUcJXyZVzT4PJ7QdXXmpg
	 KjTbt/A+V7wuk+D/syjvV5LIUaEZXqkPJb9Q412Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391092AbfBMVQy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:16:54 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:33262 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbfBMVQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:16:54 -0500
Received: by mail-ot1-f68.google.com with SMTP id i20so6904698otl.0;
        Wed, 13 Feb 2019 13:16:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2DZkzOaCdmECHd9/Tro5kM6BhxtTzXxaZeY3lv9NQYs=;
        b=XzLY5p/9qXCz+hIctvdlrUqZeU9NWU1iQ+GOACpwqPm6Hxjiwr/IqoigIKNbKxKDqW
         EKRQrRs9aKbezLc1fU0lG/jaiLaLiY5OE/Gpbm4a7WKSxF3d/5C0h0XdIxsOUAUW4rVl
         blTBYHscTzFhRxaJj3B5o5HgSDLuUUk5vijRMCJ8Ro54/tUTL8yuWe1tzDn8CQ3MwiQw
         JiwfJchr6W16MHLRmgFFQXQAipQA5oOjzQIlk0kK/o4npXkkq3vDBCI9OLYAVSf1ZQTQ
         MPh2v8ovoo7cDABoj0kFWdAuegMgfaC8jJZZcMFQh4udqObVZ2O+lrTvIlyVNlunG++E
         S23A==
X-Gm-Message-State: AHQUAubAzxxNDfJSumTtXZRK6xEX+Q5zUmQlegpGfuauNtgRhOD+uOJj
        oa+jwzLER6O6dOXBiKHpMg==
X-Google-Smtp-Source: AHgI3IagL6J8fXhfkzCCUwWODGWh3Kadto7gY+Q0Rc41xW5RbbKrex+ntI2EloJyTTEA+VHNFbNNRA==
X-Received: by 2002:a9d:6205:: with SMTP id g5mr105690otj.277.1550092613121;
        Wed, 13 Feb 2019 13:16:53 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v3sm190172oib.57.2019.02.13.13.16.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:16:52 -0800 (PST)
Date:   Wed, 13 Feb 2019 15:16:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ray Jui <ray.jui@broadcom.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Mark Rutland <mark.rutland@arm.com>, linux-i2c@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
Subject: Re: [PATCH v4 3/8] dt-bindings: i2c: iproc: make 'interrupts'
 optional
Message-ID: <20190213211651.GA10705@bogus>
References: <20190204231554.87666-1-ray.jui@broadcom.com>
 <20190204231554.87666-4-ray.jui@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204231554.87666-4-ray.jui@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 04, 2019 at 03:15:49PM -0800, Ray Jui wrote:
> In prep for the introduction of polling mode into the driver, update the
> binding document to make the 'interrupts' property optional
> 
> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>  .../devicetree/bindings/i2c/brcm,iproc-i2c.txt         | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> index 81f982ccca31..d3a3620b1f06 100644
> --- a/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> +++ b/Documentation/devicetree/bindings/i2c/brcm,iproc-i2c.txt
> @@ -9,9 +9,6 @@ Required properties:
>      Define the base and range of the I/O address space that contain the iProc
>      I2C controller registers
>  
> -- interrupts:
> -    Should contain the I2C interrupt
> -
>  - clock-frequency:
>      This is the I2C bus clock. Need to be either 100000 or 400000
>  
> @@ -21,6 +18,13 @@ Required properties:
>  - #size-cells:
>      Always 0
>  
> +Optional properties:
> +
> +- interrupts:
> +    Should contain the I2C interrupt. If unspecified, driver will fall back to
> +    polling mode

What determines when you want to use polling mode? I'm not sure DT 
is the best way to control this unless it's really a property of 
the h/w. Driver behavior is really outside the scope of the DT. u-boot 
would use polling even if an interrupt is specified, for example.

Rob
