Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2145118-1523579064-2-6154061660056233622
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523579064; b=GY6SvxRHjQwWXIyMDZZxmEV8qRI6Ip4GulK37FocM4gJ0I9BuR
    zpfU+87v5ibleduOoVFEHKNkPw5P2nmFJOVUE5kqrvGoDpLWzuyARcGXxNloKZdC
    hKs2PLNQigOdVX1dhmAus2HqqsfQb50ivdYuNiCnTcAHlacEUMJkJ5bAyrvL9ovf
    mfegeTdliX05dHx2e14SY0ZE0o6ZMaHr+HYB9ntaway3HI6Y1PvNprTuByZSymhA
    UTw7qs3ZeWx3zlPdZZa+NZRmiYt2VzzNrVzvEaQd3jUVM97cKlBsrgOZLxkoVYfY
    H59+LaZ1eo5Y2D4t812DIuPE0Qwg2y8BCEIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523579064; bh=/7skul/vZGxZo8YC9xAVLTMuWdq9Ty
    ID3cu0GRI+0Y8=; b=xEdWuD5Vn3L424YwU/qDqiBaUhnCD8ImFXLwDLZsgYPmrv
    /R9y+cS1RAGVxPHP+hUNk6tXPxfcZZWHj63q8NWZQTN5C7rczt8HCvB/rH6qjuG2
    tHrtMLsypg6cPGws8W/vrUtOVwGNu50cvOcZHy/lePC53FJ/4rU/FkpYcCQ6KGQv
    2VfRvaNejKtUqZO8vRp7LbrlRi5IqRyBk4GtdqMaEUq8aUdQwzIMEMvyXwP5Is8i
    MkpfYH48VVWQfJJT6yyLa7R66PYCuKj5MV9O6M5k+7fGlSVI3pZfDzwmwPu29bpL
    ioATk5u3aNwgmEZ78EgorOeopX1dVzbTEVmyfz5w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNyjkFo9HCsLxW0yrMZL9R0nayaUeeQlslRzzCS/PjZwMhri09efiHJqA3k4gTBXL+/BZ9spEzcnobfjiJbBaQOAjXAk5SXgSotzJDReynOb+eLaISbR
    ufknUIv+yClnKh0yyh44mD+vaOOywNnH8RnWnPDeyjUGB0ZNlkr/XxKwvq0gobayXKTw1AffkLAVdt/tb3sw/INN/KJqarNGPnDHY4XlDJqBWoS80RVCJPHH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=VwQbUJbxAAAA:8 a=irXzQZJzpnCJ-jp2jSEA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752371AbeDMAYU (ORCPT <rfc822;greg@kroah.com>);
        Thu, 12 Apr 2018 20:24:20 -0400
Received: from muru.com ([72.249.23.125]:36550 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbeDMAYU (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Thu, 12 Apr 2018 20:24:20 -0400
Date: Thu, 12 Apr 2018 17:24:15 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        Alan Cox <alan@llwyncelyn.cymru>,
        Dan Williams <dcbw@redhat.com>,
        Jiri Prchal <jiri.prchal@aksignal.cz>,
        Jiri Slaby <jslaby@suse.cz>, Marcel Partap <mpartap@gmx.net>,
        Merlijn Wajer <merlijn@wizzup.org>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>,
        Michael Scott <michael.scott@linaro.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Russ Gorby <russ.gorby@intel.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH 1/2] tty: n_gsm: Fix long delays with control frame
 timeouts in ADM mode
Message-ID: <20180413002415.GC5700@atomide.com>
References: <20180407171951.122759-1-tony@atomide.com>
 <20180408090259.GA8185@amd>
 <20180408165038.GM5700@atomide.com>
 <20180408190600.GA24342@amd>
 <20180408235740.GN5700@atomide.com>
 <20180409105407.GA15315@amd>
 <20180409134259.GO5700@atomide.com>
 <20180412212412.GA29243@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412212412.GA29243@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180412 21:25]:
> sudo insmod /tmp/n_gsm.ko debug=0xff
> 
> user@devuan:/my/droid4-ngsm$ sudo ./droid4-ngsm
> Starting ngsm..
> Testing ngsm..
> Could not open /dev/gsmtty1: Level 2 halted
> Trying to start ngsm again: Level 2 halted
> Starting ngsm..
> Testing ngsm..
> Could not open /dev/gsmtty1: Level 2 halted
> Trying to start ngsm again: Level 2 halted
> Starting ngsm..
> ^CCould not set conf: Interrupted system call
> Could not start ngsm: Interrupted system call
> 
> [ 3378.381134] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> [ 3408.460937] cpcap-usb-phy cpcap-usb-phy.0: connected to USB host
> [ 3413.633239] Q>  0) R: UIH(F)
> [ 3413.639190] C3
> [ 3413.642761] gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
> ~....~
> [ 3413.653564] gsmld_output: 00000000: 7e 01 ef c3 aa 7e

OK so no response from the modem. After few of the above
packets, you should then also see something coming back:

gsm_data_kick: 00000000: 7e 01 ef c3 aa 7e
gsmld_output: 00000000: 7e 01 ef c3 aa 7e
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_receive: 00000000: f9 03 1f 01 36 f9
<-- 0) C: DM(P)
gsmld_output: 00000000: f9 03 3f 01 1c f9
--> 0) C: SABM(P)
gsmld_receive: 00000000: f9 03 1f 01 36 f9
<-- 0) C: DM(P)
DLCI 0 opening in ADM mode.

Do you have phy-mapphone-mdm6600 loaded? That is still needed to
configure all the boot mode pins for the modem so it is usable..
The UART will then work also without ohci-platform, just the
USB PHY is disabled without ohci-platform.

I have these in my .config:
CONFIG_SERIAL_8250_OMAP=y
CONFIG_SERIAL_8250_OMAP_TTYO_FIXUP=y
CONFIG_PHY_MAPPHONE_MDM6600=m
CONFIG_N_GSM=m

And then the two patches from $subject thread. I just tried
it with today's mainline kernel and it's still working for
me.

Maybe you're missing some related patch though if usingv4.16?

984c7706ff18 ("ARM: dts: omap4-droid4: Configure uart1 pins")
e5b9fd7bdeb5 ("ARM: dts: omap4-droid4: Configure MDM6600 USB PHY")
fdd192037fce ("ARM: dts: omap4-droid4: Fix USB PHY port naming")
bca809d8183c ("ARM: omap2plus_defconfig: Enable MDM6600 USB PHY")
077e1cde78c3 ("ARM: omap2plus_defconfig: Enable 8250_OMAP"

So maybe you're still using CONFIG_SERIAL_OMAP=y instead of
CONFIG_SERIAL_8250_OMAP=y?

Regards,

Tony
