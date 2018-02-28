Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-40036-1519821579-2-452236670517215297
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519821577; b=XhaE0ouwWoaTljYgVqTXSLWIxQkDq6YiRNoFq2N7gmK+cEF
    WDPxIAl3gBqSP/4/iiA3Y/bOBx9GauIhs4DeF15fZw9qXKZA9lfUaF2mpvxnKZ2g
    bAsYIBqJTJhjbhoP4puEYpwNzGC7B4v3ZemogV++pH01PGNkcCr8RI/2UTMb78J5
    IHRsfmTU8xGrmPzGace0HnogU5MMG05upbHYOfFJCEr6lfpAyaYsFMtfI5V3MzNs
    mzFQdeU+KtcoOlGg2edOm4i24l+57cOwoZ4HRqsKZ92joqSaCHcjiRi/3BXOOri7
    kN8I4QaU0eHvoP1mmckuMXBft/4YilJhejm6giw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519821577; bh=IuPEFU85ObfpInBRdv7CXSSj0c
    rv2bi6TpOw1tuEHVo=; b=B4LRP0HP2xeUs0A1rozm718pyrdeo8acZR1UKaqMur
    cMdhnSdwb0E6wRfpEniuchatq7rEnMt9mPPDPAxHM1ho+rexkjKb+cUYCRn7xEXe
    gkSESMvsZl0WLhtc3QZ2ArZe8KujIQ5G5no1oorVGQdLV1PR59IcZiRk3sroeUz+
    W6oktvPkQ7jSQ1CUe5xycFA4Ep5bQXBj/eKQjAfftHYCWSVoaoKwcMi8O3nh3tqb
    O/LXqV3CV/ndEgY1OAlctZAedjRLK2NhKdHmKRZfF3T0wlVXIrV2mzE25FuJQQT3
    vtTCXBXmMboGylG7VZ0LrVgDJzIAgflUHUX+A8HMCbqg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeB1Mjg (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 07:39:36 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55902 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752230AbeB1Mjf (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 07:39:35 -0500
Date: Wed, 28 Feb 2018 13:39:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Greentime Hu <green.hu@gmail.com>, greentime@andestech.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        netdev <netdev@vger.kernel.org>, deanbo422@gmail.com,
        devicetree@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-serial@vger.kernel.org,
        Geert Uytterhoeven <geert.uytterhoeven@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, ren_guo@c-sky.com,
        Randy Dunlap <rdunlap@infradead.org>,
        David Miller <davem@davemloft.net>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        Peter Hurley <peter@hurleysoftware.com>,
        stable <stable@vger.kernel.org>
Subject: Re: [PATCH v7 04/37] earlycon: add reg-offset to physical address
 before mapping
Message-ID: <20180228123935.GB10114@kroah.com>
References: <cover.1518505384.git.greentime@andestech.com>
 <968497070242f849dd70ab1fa81635451f8fda7f.1518505384.git.greentime@andestech.com>
 <CAL_JsqJteT1P2GJGdesTsz=PuXU1qxiyhtKLURkGwV9sSQ7XZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJteT1P2GJGdesTsz=PuXU1qxiyhtKLURkGwV9sSQ7XZQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 09:40:49AM -0600, Rob Herring wrote:
> On Tue, Feb 13, 2018 at 3:09 AM, Greentime Hu <green.hu@gmail.com> wrote:
> > It will get the wrong virtual address because port->mapbase is not added
> > the correct reg-offset yet. We have to update it before earlycon_map()
> > is called
> >
> > Signed-off-by: Greentime Hu <greentime@andestech.com>
> > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > Cc: Peter Hurley <peter@hurleysoftware.com>
> > Cc: stable@vger.kernel.org
> > Fixes: 088da2a17619 ("of: earlycon: Initialize port fields from DT
> > properties")
> 
> This should get applied now rather than sit in numerous revisions of
> this series for nds32.
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> Greg, can you apply?

Yes, will queue it up now, thanks.

greg k-h
