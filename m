Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3784010-1522023801-5-18020765513413403513
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
    t=1522023800; b=owfa+RYLWf5vKz3JLUSUDvoQwchpyJ9lHMtcwgZz37UmmDW
    CU/J838MAJsqjiuZV1vJDnv7iF90GUA20WvxxhZIToXd6hnU4/DMKlJkfQmHrap0
    cC03dJRSrRW5jEONT9K84fiXurzm+mUjrMCqIkOWFMtF4WxYrNa9h75vI1f0do9Y
    iRXWZF4HIFC78LmjoRKdiLoyz3w59Iay0juTG5HIi7w47+/kUMeJ7Q2hCf90cPfl
    9Au6evaNe9zhfAEfnMfhRFVx2VErAcLR6d2m7ifXN4vd9dTAS0lAQo7MIsjgT2j2
    ciHPWOk9TCxHBJ5GsgZL6BC0hfT3SE4sto8JFeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1522023800; bh=naw6Dx3
    jQrYCdLD2HCiSnvkiTFKXerEpEpkB1naDtL8=; b=gIq+FR28IncL1ZvW3iWZ6Sc
    W1EFDmUXVK4uifENwQ5maGCz/o/hx2NS+5hG/0WoI09cjnWu1q6tWZ3rzh3VWnTi
    VR4k4ERLJJdrpJZil9tj3EqDSAqxhS5SO2UI+AkfVX0Vul93+RV995kpAbqfKMuY
    nPOYkf55j8/HfR4DANYeliJ8fKmLC8H1XsdXBHjU6/1XKBTHpFYZ+cA7h7zKX0B7
    FDGeSk6OEPs3r25QfKjcZFU5thI7qd+mh5exd1ye3bhw/V4vI+pBW1vG/3apCFS7
    Qqd5Jf21fnhXxbF6CSIkIeqgVmFN+FLmpsL5IWT0H+uDhwPe39loE+OGHEbD8ng=
    =
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
        id S1750975AbeCZAXE convert rfc822-to-8bit (ORCPT
        <rfc822;greg@kroah.com>); Sun, 25 Mar 2018 20:23:04 -0400
Received: from muru.com ([72.249.23.125]:33898 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750771AbeCZAXD (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Mar 2018 20:23:03 -0400
Date: Sun, 25 Mar 2018 17:22:59 -0700
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
Message-ID: <20180326002259.GE5700@atomide.com>
References: <20180323105455.GB21644@amd>
 <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
 <20180325205232.GD5700@atomide.com>
 <20180325225556.GA18141@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180325225556.GA18141@amd>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Pavel Machek <pavel@ucw.cz> [180325 22:57]:
> Hi!
> 
> > > > > Hmm. Interesting. Anyway, for me ttyUSB4 is interesting, as it seems
> > > > > to react to AT commands, and in particular reacts to ADT123; (; is
> > > > > important).
> > > > 
> > > > Is that to dial a voice call?
> > > 
> > > Yes. And it is ATD123; not ATD.
> > 
> > Strange, no semicolon is needed when using /dev/gsmtty to
> > dial a voice call with my current pile of pending changes,
> > just doing ATD123 dials..
> 
> Interesting. Maybe I made some mistake in experiment.

Looks like on /dev/ttyUSB4 doing AT+COPS? or AT+CREG? won't work
while on /dev/gsmtty1 they work. So /dev/ttyUSB4 seems to a subset of
what's available over n_gsm on ch1. Anyways, good to hear that
/dev/ttyUSB4 can be used to debug voice calls :)

> Thanks for hints, it would not be bad to get gps working. But .. voice
> calls. Those are important :-).

Yup, please keep us posted :) Meanwhile, I'll slowly continue
getting the n_gsm stuff working.

Tony
