Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2604421-1521992725-2-197953479440342077
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
    t=1521992724; b=BABDY4SFSkpFJZYDMzT3zOGlvj6b8uYqyvqv7m/tEwvPz4u
    2Rj1LAe4lcFXjp2VZy8RFkKc7HAxWOPyVqvb1X28NQp249PF0xdfE2JjZOzOmgku
    zKgQhSfqRXll4WUKzyKkqkZwyWkSkd0seZgAfd5CrkzTqEyse91qQq/a/5SnGShp
    LSTVzQ/8UeeBIbUkU9Qf2GnUGEnKNGhM9yhZs5TdI5e++DOU5mPNJ2GJctp+zRv+
    X9DM6sRVJwGY/STbLdAXPMnWe6zCdN+cY6iQaQywKPKHwYKMPBf1mKrir8zBzSm+
    BCgqaPB64V+2NHo9LW0Zami9cdpAyyMi7B7g+Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1521992724; bh=wmS/rJAnO5nACKlP4vmcihEWnX
    8PtCdpMAWXsuoR0DE=; b=LnI9EGFp3RYsJJfpt57EgKDIqquN8qej9Fr0Z+Aeqs
    GC9/GgQSBVr2DYbTepFzpUDRSEaKEpKn5r/ibhJXNgTDHT4UUNIdyl2vUZM9fn1X
    JqbNElnRPKrhSmfOD4npLWc8C6LDIpyGNfUvOBm92fnu7Rt26mdjM8PIUbr2B6BF
    Nq9g2TSGTxjYI22Jteoft21ZxTkkOToseMQEowXcktkZZ4fsoywdVVSR1C0LfNZR
    4xDoUcb3PFUKhicoaP+WbvgKOB3z25hQcbK5w2GJY/5Jbfb/5A2g7A19z6Bp0igt
    iQdKniLTbd3VUxvObC9arvtpycauWUQ6YHAxr27LS+9A==
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
        id S1753439AbeCYPpT (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 11:45:19 -0400
Received: from muru.com ([72.249.23.125]:33796 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753408AbeCYPpR (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Mar 2018 11:45:17 -0400
Date: Sun, 25 Mar 2018 08:45:12 -0700
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
Message-ID: <20180325154512.GC5700@atomide.com>
References: <20180322135553.GA27648@amd>
 <20180322164633.GF5799@atomide.com>
 <20180322192843.GA17189@amd>
 <a88b0c0c06a6977d8f0c329690f5335b5fb5ab36.camel@redhat.com>
 <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180324200224.GA17857@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180324 20:03]:
> On Sat 2018-03-24 07:25:17, Tony Lindgren wrote:
> > * Dan Williams <dcbw@redhat.com> [180324 14:00]:
> > > On Fri, 2018-03-23 at 21:13 +0100, Pavel Machek wrote:
> > > > Does ofonod work for you? I could not get that one to work...
> > > 
> > > Because it's looking for a Gobi modem but the MDM6600 isn't one and
> > > doesn't expose that layout (and doesn't really need to anyway).  I
> > > don't think ofono has a generic QMI driver, so you'd either need to for
> > > ce it to use the telitqmi or quectelqmi drivers, or write your own
> > > generic QMI one.
> > 
> > We also get five USB uarts if we add the device id with something
> > like the patch below. I don't quite get why we get five UARTS?
> 
> Not sure, either. Often more than one uart is useful, you get AT
> commands on one, while GPRS data flow on some other. 
> 
> > Also not sure if we should be using drivers/usb/serial/qcaux.c
> > instead of qcserial.c?
> > 
> > And from what I recall trying it out, adding the USB UARTs
> > somehow confused ModemManager I think, that needs to be retested
> > though :)
> > 
> > And the USB UARTs added do not offer the same set of AT commands
> > as the n_gsm serial mux.
> 
> Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> to react to AT commands, and in particular reacts to ADT123; (; is
> important).

Is that to dial a voice call?

> AT+CMGF=1
> AT+CMGS="123"
> foo^Z
> 
> Works for SMS sending. Good.

So what do you use for reading notifying and reading sms?

> Now, if someone knows what needs to be done to get GSM audio working,
> let me know. That's something I'd really like.

I think it's the cpcap based config to route voice call audio
to SoC, Sebastian knows the details :)

The way to figure that one out is to dump the cpcap registers
before and during voice call on android with cpcaprw, then
diff the output for the audio registers. Probably some SoC
registers need to be diffed too with rwmem or similar tool
for the mcbsp instance(s) used.

Regards,

Tony

