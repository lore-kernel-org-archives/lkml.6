Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1913496-1526552721-5-14753711549520681723
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
    1526552721; b=VIIdV9mRWG+V4mmirY6Ry8TC2baVUeGG3DkbiCmGIZL5KlNLAC
    pRhdKtTwZAqeMqkUkt8f1Uhq5y7o+HPf9QogfvVpvlu4GUDKebnEDEB6FZkOa3CA
    5JJ2m6jqemvtJGB+Sx4HsaiiArfMmGBpTQWKCOvvGZpqArojo1oGSpXZOaUJyISn
    2QKg4GC9O+E/5Svo+cJeac9feMhwBbByHVNIza27beYW7IRcpeScBUzh9aWQtJhE
    GqfinGIfjsLjq/WQMaDcyeuUgLxvVWycBKahCNMYnGtZCCgrIh0wn310VSmYp484
    VUVTj/+lWg5liY17mlKoS1NsJl+rMss6AZEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1526552721; bh=u8oe6in3ZTQgx+UeNvbJ6IwfyB0inh
    TObGd4yJRwU7Q=; b=BR2btZ+ChAzkO+fadvNeFPuY0xJJYar1xv61MTaKz15agk
    P/kcNgwZq/ZNE2toK3AVoSOh0hsPJPT5BwLjQNxgn5AZSQPtzsEg4fcVOTPF9fhL
    cFq4lBMTwFkCP5ViwFV+HvjFh6RP9yhVXRSFA3b85859f6O7mhKNDd/F1FEZrDHb
    DsVPTA8iGPCV1l6nGOC9715A07hFeHkxv53QVLIlzXVBpmE5kDuascqgERp+9pdo
    LFFfU3zMe3sXQKZcAFMsZkFLU4vWqhs8PozPUUiLffNnPfpJ5t2zcctxMdcC4U9U
    uE23fN023ZZkmSZqw8Xz4Bs7t28AEg67gnO8Zr2w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=IvS7m8QM x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=P7l+L07k;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=IvS7m8QM x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=P7l+L07k;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfHmAig82wHddeGNR67nN0/BUmnrKrXk7gM53uWzKimd/+hNXFDdwmXRXyk6zaE4em9WoOJPa70KaDYANh+mZOHHvwezoQMtjKjlMg6ZBBtcl0wEDxsM2
    ZL4m4xzDQ4DW3Lcxyhf7K7r59D1UWXDFLRd5yPzwSgtt9OjvfVLqFSxdQUuMSe4+F4EmbxzIPfxHMGFicaJCNMC9wbj8/QBqwXkvWoGzqhBvaUPkjh8AswgL
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=gu6fZOg2AAAA:8 a=5w-2jPEAoLC1aQIRKXEA:9 a=CjuIK1q_8ugA:10
    a=x8gzFH9gYPwA:10 a=-FEs8UIgK8oA:10 a=NWVoK91CQyQA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752106AbeEQKZF (ORCPT <rfc822;greg@kroah.com>);
        Thu, 17 May 2018 06:25:05 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35470 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752083AbeEQKZD (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 17 May 2018 06:25:03 -0400
X-Google-Smtp-Source: AB8JxZrtIlYiMS5/sLJtG8xV7JnKVWGQ6j8XP+YQI9gk8WJhqL7Wi6DoCznZKCoLf25HY9vDEyiXdQ==
Date: Thu, 17 May 2018 12:25:02 +0200
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
        linux-pm@vger.kernel.org
Subject: Re: Serdev runtime PM (was: Re: [PATCH 4/7] dt-bindings: gnss: add
 u-blox binding)
Message-ID: <20180517102502.GJ30172@localhost>
References: <5242FCAD-3139-4A9C-B9FA-7BBAA0E6AE57@goldelico.com>
 <20180503205037.7be552c1@aktux>
 <44A0BC7C-67C7-4116-849F-90FF7CF2B1F0@goldelico.com>
 <20180504114213.3xlzqxe74n55tk5s@earth.universe>
 <20180507100135.GS2285@localhost>
 <20180507154515.GP98604@atomide.com>
 <20180507163439.GV2285@localhost>
 <20180508155608.3bzcbepsmoskhlox@earth.universe>
 <20180509091831.GA2285@localhost>
 <20180509140550.GC98604@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180509140550.GC98604@atomide.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, May 09, 2018 at 07:05:50AM -0700, Tony Lindgren wrote:
> * Johan Hovold <johan@kernel.org> [180509 09:20]:
> > On Tue, May 08, 2018 at 05:56:08PM +0200, Sebastian Reichel wrote:
> > > I think using open/close for runtime pm is good enough for GPS,
> > > since it regularly sends data and draws lots of power anyways.
> > > But devices, that have an out-of-band wakeup signal can do proper
> > > runtime PM of the serial port without loosing characters.
> > 
> > Yeah, there may be some applications where this is possible. And this is
> > not the case for GPS, but not just because of a generally higher power
> > consumption, but due to the fact that we cannot afford having the first
> > message in every report burst be dropped.
> 
> Well most of the phone implementations use one or two out of band
> GPIOs to first wake the UART before any data is sent. For serdev
> this can be called from the serdev consumer write function for TX.
> For RX, the serdev consumer needs to implement an interrupt handler
> and wake up the parent UART before serdev RX.

Right, but the client driver would then wake the parent controller when
expecting RX, while waking its own (serial-attached) device when wanting
to do TX.

Just for the record, we also cleared this up here:

	https://marc.info/?l=linux-kernel&m=152604434504868&w=2

> > > Note, that OMAP does not reach deep idle states with active
> > > serial port. This is not acceptable for low power devices.
> > 
> > Sure, but note that OMAP is the only serial driver which currently
> > implements this kind of aggressive runtime PM (besides a couple of
> > usb-serial drivers). This means that a serdev driver can never rely on
> > this being the case, and therefore needs to be restrictive about how
> > long the port is kept open if it cares about power at all.
> 
> Well by default we don't allow lossy UART. It needs to be manually
> configured via /sys for the timeout. With serdev, this can all be
> done with no /sys configuration needed for the cases with GPIO
> wake irqs :)

Indeed, but serdev client drivers must also work with serial drivers
which do not implement this kind of aggressive runtime PM, and then the
only way to save power is to close the port when not in use.

Thanks,
Johan
