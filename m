Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84E3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E4D9214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545080736;
	bh=jxUj9siJ1/n2p0Cv6M6NsBcRve2DsY90G1yLmbo+kI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TZKqjtjHIwqq/DHrSJ/tBYiHlCYCK8l3MFyl7jSPw56qXHCXsCkROtqQQzpK0yGe1
	 zVixq+unzsjJU/I5l9faMKoUd5OzW8TCUVgHNjxxuRB0pZOGsD8UGg752dITlmEO1R
	 0Uwb+S8BcpxIMRSEHPWCF7eNTCLZHMbJB7ufHoBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbeLQVFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 16:05:35 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42632 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728204AbeLQVFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 16:05:34 -0500
Received: by mail-ot1-f65.google.com with SMTP id v23so13555875otk.9;
        Mon, 17 Dec 2018 13:05:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZnkXIT8KO/caCRKa11BR7WAzhhFgQTKndBm9a+cVhs4=;
        b=GgGNmeSIcNs64RAyeYELMyVk+IyzY69oQyIpkIsF4j53RQ+R9Z2sibwgRcrC1Gdz5K
         NDz/Z9LZwSAQ4IFUM52fAkKIIDBtIiRLz7WQ7atvGf/U2JZQKT1+tN3ZEYr7UGY5pDbg
         jrFwwNio3ZjPxuWE7bmLsM21sIWWe5ex1aQ9F9klyLqPdmUlOnEaKms7i//ANgEROw/0
         CUzv3W3UYQJV1enBBaPUPDKuS35FzPQ1O6PU0eWAFYLstbNfiJJ6smB9kMhUCUNERTlx
         kxBUlXYpTzg8KEKxI3sgM9p61pDOxVZkrF7752pfZ7rbp91OD9xVixCDozbS2b5mf8Ir
         56pw==
X-Gm-Message-State: AA+aEWYNcWLKhlFmlMJfbB8nnRhLaLRJwYH+LOhbi8VWklzj/WFYp0pK
        DYVook6ZpE8UeqlXgokGgA==
X-Google-Smtp-Source: AFSGD/UTJDwkdO8Jbv+S9FoTyKddZdE6dJuI4uGsAuvvDz2pBytJvfmEUlYnCBPivdvhffC+9NtOEQ==
X-Received: by 2002:a9d:225:: with SMTP id 34mr11210199otb.224.1545080732929;
        Mon, 17 Dec 2018 13:05:32 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id r7sm7230278oia.28.2018.12.17.13.05.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 13:05:31 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:05:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH v8 03/26] dt-bindings: Add doc for the Ingenic TCU drivers
Message-ID: <20181217210531.GA29770@bogus>
References: <20181212220922.18759-1-paul@crapouillou.net>
 <20181212220922.18759-4-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181212220922.18759-4-paul@crapouillou.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 11:08:58PM +0100, Paul Cercueil wrote:
> Add documentation about how to properly use the Ingenic TCU
> (Timer/Counter Unit) drivers from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
> 
> Notes:
>      v4: New patch in this series. Corresponds to V2 patches 3-4-5 with
>          added content.
>     
>      v5: - Edited PWM/watchdog DT bindings documentation to point to the new
>            document.
>          - Moved main document to
>            Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>          - Updated documentation to reflect the new devicetree bindings.
>     
>      v6: - Removed PWM/watchdog documentation files as asked by upstream
>          - Removed doc about properties that should be implicit
>          - Removed doc about ingenic,timer-channel /
>            ingenic,clocksource-channel as they are gone
>          - Fix WDT clock name in the binding doc
>          - Fix lengths of register areas in watchdog/pwm nodes
>     
>      v7: No change
> 
>      v8: - Fix address of the PWM node
>          - Added doc about system timer and clocksource children nodes

I thought we'd sorted this out...

> 
>  .../devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt |  25 ---
>  .../devicetree/bindings/timer/ingenic,tcu.txt      | 176 +++++++++++++++++++++
>  .../bindings/watchdog/ingenic,jz4740-wdt.txt       |  17 --
>  3 files changed, 176 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/ingenic,tcu.txt
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/ingenic,jz4740-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt b/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> deleted file mode 100644
> index 7d9d3f90641b..000000000000
> --- a/Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt
> +++ /dev/null
> @@ -1,25 +0,0 @@
> -Ingenic JZ47xx PWM Controller
> -=============================
> -
> -Required properties:
> -- compatible: One of:
> -  * "ingenic,jz4740-pwm"
> -  * "ingenic,jz4770-pwm"
> -  * "ingenic,jz4780-pwm"
> -- #pwm-cells: Should be 3. See pwm.txt in this directory for a description
> -  of the cells format.
> -- clocks : phandle to the external clock.
> -- clock-names : Should be "ext".
> -
> -
> -Example:
> -
> -	pwm: pwm@10002000 {
> -		compatible = "ingenic,jz4740-pwm";
> -		reg = <0x10002000 0x1000>;
> -
> -		#pwm-cells = <3>;
> -
> -		clocks = <&ext>;
> -		clock-names = "ext";
> -	};
> diff --git a/Documentation/devicetree/bindings/timer/ingenic,tcu.txt b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> new file mode 100644
> index 000000000000..8a4ce7edf50f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/timer/ingenic,tcu.txt
> @@ -0,0 +1,176 @@
> +Ingenic JZ47xx SoCs Timer/Counter Unit devicetree bindings
> +==========================================================
> +
> +For a description of the TCU hardware and drivers, have a look at
> +Documentation/mips/ingenic-tcu.txt.
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4740-tcu
> +  * ingenic,jz4725b-tcu
> +  * ingenic,jz4770-tcu
> +- reg: Should be the offset/length value corresponding to the TCU registers
> +- clocks: List of phandle & clock specifiers for clocks external to the TCU.
> +  The "pclk", "rtc", "ext" and "tcu" clocks should be provided.
> +- clock-names: List of name strings for the external clocks.
> +- #clock-cells: Should be <1>;
> +  Clock consumers specify this argument to identify a clock. The valid values
> +  may be found in <dt-bindings/clock/ingenic,tcu.h>.
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value should be 1.
> +- interrupt-parent : phandle of the interrupt controller.
> +- interrupts : Specifies the interrupt the controller is connected to.
> +
> +
> +Children nodes
> +==========================================================
> +
> +
> +PWM node:
> +---------
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4740-pwm
> +  * ingenic,jz4725b-pwm
> +- #pwm-cells: Should be 3. See ../pwm/pwm.txt for a description of the cell
> +  format.
> +- clocks: List of phandle & clock specifiers for the TCU clocks.
> +- clock-names: List of name strings for the TCU clocks.
> +
> +
> +Watchdog node:
> +--------------
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4740-watchdog
> +  * ingenic,jz4780-watchdog
> +- clocks: phandle to the WDT clock
> +- clock-names: should be "wdt"
> +
> +
> +OST node:
> +---------
> +
> +Required properties:
> +
> +- compatible: Must be one of:
> +  * ingenic,jz4725b-ost
> +  * ingenic,jz4770-ost
> +- clocks: phandle to the OST clock
> +- clock-names: should be "ost"
> +- interrupts : Specifies the interrupt the OST is connected to.
> +
> +
> +System timer node:
> +------------------
> +
> +Required properties:
> +
> +- compatible: Must be "ingenic,jz4740-tcu-timer"

Is this an actual sub-block? Or just a way to assign a timer to a 
clockevent?

> +- clocks: phandle to the clock of the TCU channel used
> +- clock-names: Should be "timer"
> +- interrupts : Specifies the interrupt line of the TCU channel used.
> +
> +
> +System clocksource node:
> +------------------------
> +
> +Required properties:
> +
> +- compatible: Must be "ingenic,jz4740-tcu-clocksource"

The h/w has a block called 'clocksource'?

If there's a difference in the timer channels, then that difference 
should be described in DT, not just 'use timer X for clocksource'.

> +- clocks: phandle to the clock of the TCU channel used
> +- clock-names: Should be "timer"
