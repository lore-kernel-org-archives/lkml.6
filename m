Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3426895-1522011162-2-14772609431235217200
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1522011162; b=vjgEw4kj87yCWtkxBlwM2Rk5R9DWRPfg9suflRye23QnGUw
    sZeyyQ0uNkJoIl9wwjwOdcZE5Jnrsj9rdGhNDRgkH0oeqL0roPwqMoJg1fyOIu3+
    1kScG5/dO4JGzKOwtZMIpDFo4MOB7HJh2syVEGZPuFd64YqUEjodVPqkLGB/ZOoJ
    LZ2vq+uq7FuToveMKq7XN21apDrs32dRN3Uof5t7scJstuVvOy5V+rkJqQNa6opE
    O8+OG/ymexf0/q9Px3VbgW5shxeuAl1moqr38CHuds+3MqA0+Io4m4kHuC14re8I
    2VfGwp+Bc5BukATkCJHd3wAJQ/GzL9U+sg/HhTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522011162; bh=aF+alzqfjz9GmIZxv86gF3GLln
    8+KmeHSBO30XFIJ3Y=; b=GNNiQlnypnsPwUB2QMB+V2gTka9cdJVdM7DiZNafsS
    X2/Msc7QnmLzyuSTR2RBiqKM/Cc3YQaNK4x9wfk4nsHlWcvY3joo6uW+cs3GlZGP
    XzG4/J6pOnpb0AWaixmAzMCYFkT0x2zDS+0mo6+6WkfF6BJWoGcYp7g7PdOXcrPX
    cn5AzyIsdJ8/euJOpIvSdX1tH2A8kP+HrZz1ltpTDNjGmujkxvqRTeRhL3bGIRR9
    XXDrcGU58WJP/b+ILmt7Usmnz+xbZJy2bkPTO//QCXEIgmwhtZMVDzemCy33HVCY
    MEIhorjpIxkk1A7WsxVlHG4TWbjs0CxL6wgYnFmei0mw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752125AbeCYUwi (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 16:52:38 -0400
Received: from muru.com ([72.249.23.125]:33880 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751142AbeCYUwg (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Mar 2018 16:52:36 -0400
Date: Sun, 25 Mar 2018 13:52:32 -0700
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dcbw@redhat.com>, Sebastian Reichel <sre@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv4] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180325205232.GD5700@atomide.com>
References: <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180325185857.GA7582@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180325 19:00]:
> Hi!
> 
> > > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> > > to react to AT commands, and in particular reacts to ADT123; (; is
> > > important).
> > 
> > Is that to dial a voice call?
> 
> Yes. And it is ATD123; not ATD.

Strange, no semicolon is needed when using /dev/gsmtty to
dial a voice call with my current pile of pending changes,
just doing ATD123 dials..

Anyways, looks like qmi_wwan needs to be loaded before
qcserial module, otherwise we get nine ttyUSB instances
and ModemManager can't find any modems.

With qcserial module loaded after qmi_wwan, it still takes
a long time for ModemManager to find the modem.

Then unrelated to the qcserial module, also looks like I can
no longer use the GPS with ModemManager:

$ mmcli -m 0 --enable
$ mmcli -m 0 --location-enable-gps-raw

And then chmod a+r /dev/cdc-wdm0 and pointing gpsd to use
/dev/cdc-wdm0 used to work, but now it seems that gpsd
can no longer read it. Trying to start gpsd manually produces:

# gpsd -b -n -N /dev/cdc-wdm0
gpsd:ERROR: SER: /dev/cdc-wdm0 already opened by another process
gpsd:ERROR: initial GPS device /dev/cdc-wdm0 open failed
gpsd:ERROR: can't run with neither control socket nor devices open

And lsof shows /usr/libexec/qmi-proxy having it open.

Anybody know what I might be doing wrong? Sounds like something
now needs to be done with qmi-proxy to get access to GPS?

> > Anyway, "good" solution is to get ofonod running, then use ofone from
> > here: https://github.com/pavelmachek/unicsy_demo

Thanks I'll take a look.

> > I think it's the cpcap based config to route voice call audio
> > to SoC, Sebastian knows the details :)
> > 
> > The way to figure that one out is to dump the cpcap registers
> > before and during voice call on android with cpcaprw, then
> > diff the output for the audio registers. Probably some SoC
> > registers need to be diffed too with rwmem or similar tool
> > for the mcbsp instance(s) used.
> 
> That sounds like hard way to do it. There's source available, I'm now
> trying to understand it / fit it into Sebastian's driver.
> 
> https://raw.githubusercontent.com/NotKit/android_kernel_motorola_omap4-common/hybris-11.0/sound/soc/codecs/cpcap.c

Sure that hopefully helps too :)

Tony
