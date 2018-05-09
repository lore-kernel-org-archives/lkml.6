Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-411352-1525871412-2-448156085161499034
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525871411; b=Q7R9gACIRVmbkeAVtszux6zG3CFqwW3i99pBAJCQIjK9Z8bfqL
    3tmw0mzhtVIJ1CuY40XiS6umCqPIMyhd70asd5aYdIXQSol0FPfVPOZBfc9is0ON
    vbXXaU3qQYRUJ0JDM2dwWjnogoAj73oejNN3PX9pBHsrElzsmVjZxeh7/uxfr0UH
    ygjD4cCFvUNIEjOmuYfEXJNfdjAyKKvW39vd2rmrF28V3UZYpPneOHqdVsCF13Tm
    W0HOEMGKO9kFNg3o4LpWB2yAQfGvopHm6HrkzJyj11Bv6LUR34Z6OlJuzD769hei
    aBviDQnDboi36yjHSBHQdq+8+EmzP4ZNTYXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525871411; bh=vbodMYwcXtaiLzYMgpDP3YxcyJvMos
    H82Lcl/xaO+7M=; b=EEwscUMjAYEaTQCYrQzDeu0NLNzc6xGQvAXyAA+gsqaEqb
    TQ78bd8XBsNLjR8mpqOftrnIHsNJDrOlTM1ickJ9gfSwY3ybntszpUmNyGRjaxCY
    mPI7faiC7zslzBxCbLZK8FzOBBvrw99ShfCxm0hO6huQPjkqz15b5htxnYjErJg3
    sVjm1Pb+uNQ9rhfwBMJnp6bK30rqcXENEusjm0lKOZk0oO4vVpoa8TNJJpHFvW1N
    oDqmpLCA63G5Hyh8ZYn6TmbUBCGSnuUBZ9ilYRRNgHCwWvoybt5BuAIJ/WE4y8+m
    95lztXlR5pe9vxneHqcJk2sKmCFt65lXguY8CHMA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=o0m0feZf x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=N62v4wtO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=o0m0feZf x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=N62v4wtO;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPS0h1INglSAfSeBgdo7xHp6HWjuWU3M2AbrURSuQcKKGl1FYE46/OiVv1J3j54BoRLZUww5M9cVNxMuHsbDqwAbOxKJuUPFpgm3RFC1p4nax0I4vRyo
    7HqRfEsj/55UrW/aGXTwmUrF+kg7UbT6hLIxTX5rr9y7hl++XLKJ7JPgWwpuxMZlE2E9RgHBYMv8c4X2F8XJJnFuVXScQ2bWV8awE868Hxi0khIR9agX/LN2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=2KMo9-giAAAA:8 a=VwQbUJbxAAAA:8 a=i1kIjM29qegxjrELnt8A:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=UeCTMeHK7YUBiLmz_SX7:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934328AbeEINKI (ORCPT <rfc822;greg@kroah.com>);
        Wed, 9 May 2018 09:10:08 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46802 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934687AbeEINKF (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 9 May 2018 09:10:05 -0400
X-Google-Smtp-Source: AB8JxZoR2VDjXPene2LwQTxEbddMfXy17GrKzr5SwF0PgrL4XuhGol6cI52AeNG8raoxbbj860UD+A==
Date: Wed, 9 May 2018 15:10:03 +0200
From: Johan Hovold <johan@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Johan Hovold <johan@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Andreas Kemnade <andreas@kemnade.info>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Pavel Machek <pavel@ucw.cz>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pm@vger.kernel.org
Subject: OMAP serial runtime PM and autosuspend (was: Re: [PATCH 4/7]
 dt-bindings: gnss: add u-blox binding))
Message-ID: <20180509131003.GC2285@localhost>
References: <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180507175032.GR98604@atomide.com>
 <20180508065852.GW2285@localhost>
 <20180508152228.GV98604@atomide.com>
 <20180508154756.GW98604@atomide.com>
 <20180508155405.GX98604@atomide.com>
 <20180508164904.GZ98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508164904.GZ98604@atomide.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

[ Updating subject and adding linux-serial, linux-pm and linux-omap. ]

On Tue, May 08, 2018 at 09:49:04AM -0700, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180508 08:54]:
> > * Tony Lindgren <tony@atomide.com> [180508 08:47]:
> > > * Tony Lindgren <tony@atomide.com> [180508 08:22]:
> > > > * Johan Hovold <johan@kernel.org> [180508 07:00]:
> > > > > With the negative autosuspend set in both omap drivers probe functions,
> > > > > this is the expected behaviour. Which I think we must fix.
> > > > 
> > > > Yes indeed. I've been using my script for years now and have
> > > > completely missed the fact that the unused ports are not idled
> > > > at all on start-up when unused.
> > > 
> > > This might be all that's needed, care to try it and if it works
> > > I'll send out two separate proper patches?
> > > 
> > > I'm seeing this now on my bbb after temporarily disabling my
> > > UART idle init script:
> > > 
> > > # rwmem -s32 0x44e004b4           # uart 1 on l4_wkup
> > > 0x44e004b4 = 0x00000002
> > > 
> > > # rwmem -s32 0x44e0006c+0x10      # uart 2 - 5 on l4_per
> > > 0x44e0006c = 0x00030000
> > > 0x44e00070 = 0x00030000
> > > 0x44e00074 = 0x00030000
> > > 0x44e00078 = 0x00030000
> > > 
> > > # rwmem -s32 0x44e00038           # uart 6 on l4_per
> > > 0x44e00038 = 0x00030000
> > 
> > Hmm I forgot to remove status = "disabled" from the other ports,
> > still not idling the unused ports with the patch below it seems.
> 
> No need to enable/disable autosuspend except in startup and shutdown
> I think. The patch below works for me, now includes removal of the
> status = "disabled" flags too. Only tested with 8250_omap on bbb
> so far.
> 
> I wonder if other places still need fixing for autosuspend
> like console support?

While this seems to fix the idling of closed ports here too, I'm not
sure we can move use_autosuspend to startup() like this.

First, this flag should be set before registering the tty so that udev
can be used to update the attributes.

Second, this prevents setting the autosuspend delay through sysfs when
the port is closed (when autosuspend is disabled).

It seems we really should not be using the negative autosuspend to
configure the RPM behaviour the way these drivers do. Perhaps a new
mechanism is needed.

But I'm afraid I don't have time to look at this today.

Thanks,
Johan

> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -605,6 +605,7 @@ static int omap_8250_startup(struct uart_port *port)
>  			return ret;
>  	}
>  
> +	pm_runtime_use_autosuspend(port->dev);
>  	pm_runtime_get_sync(port->dev);
>  
>  	up->mcr = 0;
> @@ -685,8 +686,8 @@ static void omap_8250_shutdown(struct uart_port *port)
>  		serial_out(up, UART_LCR, up->lcr & ~UART_LCR_SBC);
>  	serial_out(up, UART_FCR, UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT);
>  
> -	pm_runtime_mark_last_busy(port->dev);
> -	pm_runtime_put_autosuspend(port->dev);
> +	pm_runtime_dont_use_autosuspend(port->dev);
> +	pm_runtime_put_sync(port->dev);
>  	free_irq(port->irq, port);
>  	dev_pm_clear_wake_irq(port->dev);
>  }
> @@ -1226,7 +1227,7 @@ static int omap8250_probe(struct platform_device *pdev)
>  	spin_lock_init(&priv->rx_dma_lock);
>  
>  	device_init_wakeup(&pdev->dev, true);
> -	pm_runtime_use_autosuspend(&pdev->dev);
> +	/* See omap_8250_startup and shutdown for autosuspend */
>  	pm_runtime_set_autosuspend_delay(&pdev->dev, -1);
>  
>  	pm_runtime_irq_safe(&pdev->dev);
> @@ -1265,8 +1266,8 @@ static int omap8250_probe(struct platform_device *pdev)
>  	}
>  	priv->line = ret;
>  	platform_set_drvdata(pdev, priv);
> -	pm_runtime_mark_last_busy(&pdev->dev);
> -	pm_runtime_put_autosuspend(&pdev->dev);
> +	pm_runtime_put_sync(&pdev->dev);
> +
>  	return 0;
>  err:
