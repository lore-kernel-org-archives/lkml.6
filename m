Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2359611-1518086737-2-68155324511802036
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518086736; b=OWUd93CijBggkSYjsfmxCFoPUBYtD8wqXox/1ljdgZWkKb7
    QXisQkpR/IQZf8JsF9VCJC4+hPYV/pLsBVvn/1M1vghtGoeBZrDDrM/2/Z544uP2
    MKE2WV1mwwbSJYTCHqCx/4nc5pCFUHwrsIgkNUMAIQAvdjhpxqNJFhIaJllGjiGn
    iFFCv04S5Rs5rwG8Rln/lHWjkXeiyJbWSbJsiwIzdNjqF24tau+UUwPG9moXaw6j
    oYw9it+Z0mrIv5PvvAqzi8EYKcgbnYdXSQDaDn9kc0BTnrBgi5t8k0eIMf87kpPz
    s6nT802s/PiZSX14frJxKTa5PRA3h53I5Z57EPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518086736; bh=wR7X0qPL/5vaFVctnizEOWVz/l
    3DAoGy+e5lVPrMPcI=; b=wLR4zgkihSiFhsyH0KhwKc84xSXcoXYR+O26ZxUJ0L
    +wqiNFUaV6J4KF8AREOLPlzLHh+JeII6GFYnXiQb5cNkM0Qfqw7ro0gAYL7KQG+/
    a3K4VcrIGFs6SWCexeGYhWipxD1dxD3m9CeVxNy0N+1xzP71d1G5ykHMi6Pwwglo
    HFjjUtVhP6FzBquX9BhxKMw4/rW7eAyk0JUUPNqNgalW2feZuIquumCN5SwzawZh
    j+Vv6nUSghQQm8yDraQFDa8FpyiXlwLsyMCHE4O+f3KcwcBBntPkAZHHWgEcUlIk
    ITSXGfNOHD8AnF4CgnaumjpxBBjTm+H1C0QtJHY1RYlw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linux.intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linux.intel.com header.result=pass header_org.domain=intel.com header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750882AbeBHKpX (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Feb 2018 05:45:23 -0500
Received: from mga11.intel.com ([192.55.52.93]:15959 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750749AbeBHKpW (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Feb 2018 05:45:22 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,478,1511856000";
   d="scan'208";a="29139785"
Date: Thu, 8 Feb 2018 12:45:17 +0200
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc: Sebastian Reichel <sre@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Yueyao Zhu <yueyao.zhu@gmail.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH v4 6/7] typec: tcpm: Represent source supply through
 power_supply class
Message-ID: <20180208104517.GA7655@kuha.fi.intel.com>
References: <cover.1514904982.git.Adam.Thomson.Opensource@diasemi.com>
 <e2cb104f53e20a01f3b44442068c549e5d0e1ac3.1514904983.git.Adam.Thomson.Opensource@diasemi.com>
 <20180130131131.GF14922@kuha.fi.intel.com>
 <2E89032DDAA8B9408CB92943514A0337014C1C1595@SW-EX-MBX01.diasemi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337014C1C1595@SW-EX-MBX01.diasemi.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Adam,

On Tue, Feb 06, 2018 at 03:51:26PM +0000, Adam Thomson wrote:
> Right now there is no documentation for the generic psy class. The stuff in
> sysfs-class-power is device specific property information, and the same goes for
> sysfs-class-power-twl4030. The property usage can vary depending on driver
> implementation, an example being the 'online' property which can differ between
> drivers, so the usage I have here is very much tcpm related. Also, the ability
> to write to certain properties varies depending on the driver and HW, so here
> where we configure 'voltage_now' and 'current_now', the likelihood is that most
> other psy driver implementations won't allow for this.

The power supply class is missing documentation, YES! That is what I
have been saying! The fact that even an attribute like "online" can
mean different things depending on the driver is absolutely horrible.
The ABI documentation FOR THE POWER SUPPLY CLASS needs to provide
clear meaning for the attributes. It needs to also point out which
attributes can be hidden, and it should also give some hints for
things like which attributes can be expected to be visible for example
in case of USB type of psy and so on.

We are talking about user space ABI for power supplies here. The user
space does not know that its dealing with tcpm in this case, or some
other driver in an other case, AND, the user space _must_ not be
expected to know that kind of details. The behaviour and meaning of an
individual attribute file quite simply has to be the same, always,
regardless of the platform, HW, driver or whatever. Otherwise this
whole ABI is completely useless.

Working around the issue of missing guidelines and documentation for
subsystem ABI by providing it for the device drivers instead is not
acceptable. If you don't want to propose documentation for the class,
don't propose any documentation at all is better answer then that. And
using arguments like "well, twl4030 did it" is really starting to
annoy me. We are not lemmings here. We can make this right instead of
following others blindly over the cliff edge.

To summarize: We can't just accept chaos. Instead we should organize
the places without structure, in this case the user space ABI for
power supplies.

On top of ABI documentation, we will need driver API documentation as
well. I'm not expecting that you would also propose something for the
API too, but I just wanted to bring that up here. I would like to have
some guidelines on how the power supplies should be used also in
kernel.

Right now it is possible for one driver to create the power supply and
an other to take over the control of it. It is super easy to gain
access to a power supply. You can request it with just the name
without any control, and after gaining access, you have full control
over it. That makes it really easy to have race condition where both
the psy device driver and some other driver try to control the same
things of the same psy.

I guess the whole design of the psy class could use a little bit of
re-designing. So IMO, access to the psy should be more strict then it
is now, and also, even after gaining access to a psy handle, drivers
that are not the actual psy device drivers should have more controlled
access to it. So possibly separate API for them... OK, this is
definitely a separate topic. Sorry, I'll stop here.


Thanks,

-- 
heikki
