Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF38ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B68820661
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 17:57:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B68820661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388322AbeGTSqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:46:21 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54704 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387950AbeGTSqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:46:21 -0400
Received: by mail-it0-f67.google.com with SMTP id s7-v6so15780322itb.4;
        Fri, 20 Jul 2018 10:56:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hASqk2pPzUMAl0o1TChs0N9JdyAkF9e6O9TkEJq0Lkk=;
        b=LGq3VlLpzAca8N4ABmC1UDk/PDYVnGdsWE7qB6vyoSsL9v3y2OtSiKi+WZEpPBYIOm
         VQl12CitqV5HMC4yZ6puFtoE53r8Pb7DMj6VoY0pXe9+cv+csYx4pYRW67eMqHNqPFsG
         Nfy49rlLz/ZMyWXdy4w+Sc9p947ZkFGvQs35f9GO+DLfdqHKQADgAxzW7bJ7IFOXwcLs
         IOgRZklsJr9a8HECRDRpyK/oU4a9zt6mjMc8Y/roOKG5X1trvwv6jse7+tSkL2vbRZdf
         lbbPQ84Cvk2LkIUZNrYa+FQRZPZQB40zk5N5JCdQIeG14eR8/k8nxfi7HtBTWFejK1eG
         wrqw==
X-Gm-Message-State: AOUpUlGRIygdEDHX0MyGc9FSMBuzhpHYQRQMQ+FlXLJ4uxr3P6kG9wgA
        VNwssDRkgDox7+uHw4QIdQ==
X-Google-Smtp-Source: AAOMgpeqNhRiqrMuEYu6TiERWpgWlXdCQqTElRigOz7TBLjuB6TZduD+vw7Tso+dns5t/yo/92I2cA==
X-Received: by 2002:a24:6b0d:: with SMTP id v13-v6mr2653930itc.16.1532109419583;
        Fri, 20 Jul 2018 10:56:59 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b129-v6sm1543763ioa.75.2018.07.20.10.56.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 10:56:58 -0700 (PDT)
Date:   Fri, 20 Jul 2018 11:56:58 -0600
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
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
Message-ID: <20180720175658.GA2930@rob-hp-laptop>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
 <20180717114837.21839-4-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717114837.21839-4-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2018 at 01:48:35PM +0200, Alexandre Belloni wrote:
> The Microsemi Ocelot I2C controller is a designware IP. It also has a
> second set of registers to allow tweaking SDA hold time and spike
> filtering.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  .../bindings/i2c/i2c-designware.txt           |  5 ++++-
>  drivers/i2c/busses/i2c-designware-core.h      |  1 +
>  drivers/i2c/busses/i2c-designware-platdrv.c   | 20 +++++++++++++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/i2c/i2c-designware.txt b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> index fbb0a6d8b964..7af4176da4af 100644
> --- a/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> +++ b/Documentation/devicetree/bindings/i2c/i2c-designware.txt
> @@ -2,7 +2,7 @@
>  
>  Required properties :
>  
> - - compatible : should be "snps,designware-i2c"
> + - compatible : should be "snps,designware-i2c" or "mscc,ocelot-i2c"

Sounds like the registers are optional (or could be initialized by 
firmware), so shouldn't 'snps,designware-i2c' be a fallback compatible?

>   - reg : Offset and length of the register set for the device
>   - interrupts : <IRQ> where IRQ is the interrupt number.
>  
> @@ -11,6 +11,9 @@ Recommended properties :
>   - clock-frequency : desired I2C bus clock frequency in Hz.
>  
>  Optional properties :
> + - reg : for "mscc,ocelot-i2c", a second register set to configure the SDA hold
> +   time, named ICPU_CFG:TWI_DELAY in the datasheet.
> +
>   - i2c-sda-hold-time-ns : should contain the SDA hold time in nanoseconds.
>     This option is only supported in hardware blocks version 1.11a or newer.

Perhaps this needs an update too? It sounds like Microsemi fixed this 
problem on their own before version 1.11a of the IP block.

Rob
