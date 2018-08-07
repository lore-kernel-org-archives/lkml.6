Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 964C5C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5819D21547
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 17:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5819D21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390330AbeHGT5u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 15:57:50 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40927 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727198AbeHGT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 15:57:49 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so24084231ita.5;
        Tue, 07 Aug 2018 10:42:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KeKJnzQOffQOfRtAMyjQsTpNA5n7hdyzcdzP6bVZfls=;
        b=oOeRkdmnnyVYbVEa6A0h1fiYYKwQ3e9DimmTEzrQehdfiJ40XUdqmBeKSfeAE/XvTs
         8wLYkIOO9v1lx+IeWuZF4nrtBwEHIDdhTvID1ny8u7xh+9d9VYplMAVOzDz1MYc/oLkR
         UQO+VcmubYy6QeNHmP9h2FiBc4mdQHiyGTbyhjAjXHJyjOZD48ma0HYKpv1QqidzW5pi
         I7+in/miA1vBzs9eM6u8jIl8jy6bEMYJk4EfIeAFRsLx02tvRZUCBFezoCMlkyoZu0ML
         P8iTPGbyZQpfgEBM6Eb1vYFxA1OMdfn9qyy5XUPRBPThHbjuxAeDwpBkhsVwiHMm+1CA
         8N5A==
X-Gm-Message-State: AOUpUlHASD1H4ZsZRqUsU0vj0OC22T8T5N5kyb1gHJeakDIy5Q8Fpph9
        67WugAWivWue2+9SZ6VorQ==
X-Google-Smtp-Source: AA+uWPySPENDMX6MHA4PVFFsHcyOjIXrwPOgxWyDwSHWjEa1qLYLRzL6sFUjx8v7/2qBeJ7rAR7r8Q==
X-Received: by 2002:a24:534c:: with SMTP id n73-v6mr2818748itb.25.1533663744257;
        Tue, 07 Aug 2018 10:42:24 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id c71-v6sm727703ioe.69.2018.08.07.10.42.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Aug 2018 10:42:23 -0700 (PDT)
Date:   Tue, 7 Aug 2018 11:42:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Subject: Re: [PATCH v3 4/6] i2c: designware: add MSCC Ocelot support
Message-ID: <20180807174222.GA5720@rob-hp-laptop>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
 <20180806185412.7210-5-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180806185412.7210-5-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 06, 2018 at 08:54:10PM +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../bindings/i2c/i2c-designware.txt           |  9 ++++-

Please split binding patches.

>  drivers/i2c/busses/i2c-designware-core.h      |  3 ++
>  drivers/i2c/busses/i2c-designware-platdrv.c   | 40 +++++++++++++++++++
>  3 files changed, 50 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fbb0a6d8b964..7886f2dc6675 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -2,7 +2,8 @@
>  
>  Required properties :
>  
> - - compatible : should be "snps,designware-i2c"
> + - compatible : should be "snps,designware-i2c" or "mscc,ocelot-i2c" followed by
> +   "snps,designware-i2c" for fallback

Please reformat to one valid combination per line.

>   - reg : Offset and length of the register set for the device
>   - interrupts : <IRQ> where IRQ is the interrupt number.
>  
> @@ -11,8 +12,12 @@ Recommended properties :
>   - clock-frequency : desired I2C bus clock frequency in Hz.
>  
>  Optional properties :
> + - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
> +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> +
>   - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
> -   This option is only supported in hardware blocks version 1.11a or newer.
> +   This option is only supported in hardware blocks version 1.11a or newer and
> +   on Microsemi SoCs ("mscc,ocelot-i2c" compatible).
>  
>   - i2c-scl-falling-time-ns : should contain the SCL falling time in nanoseconds.
>     This value which is by default 300ns is used to compute the tLOW period.
