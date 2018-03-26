Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3784010-1522024244-2-17641102944470599641
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
    t=1522024244; b=mVsogkTh5o+DCzVvTozNMXlsF11/vjFt9TRJSKPPVvfkwwT
    OhRRcSrLaFkVXylBlJGKWos+lw59YdTFBLoRNYZ+aunzUb9YDdAoUa1uQZPWkvEP
    wguxV/NaXw3TyQ6/nhDRBYYA5h1sBJFNvSUqJ5RKMWOgF5EqxMMdu3Wa0DqJNyV2
    wwrtBuW/sppaa+FGKKxitvnO7BDHTsPM1V6eeksE5v9PVTETencqNJcdZ9gcrmG3
    XIdI2YJzGUZtAEb7amkO07TrR1in2BU6aWdftlUDdZx2PcMvnocWBpVvxnP0B29Y
    jbxuTkgbydftuhARE5t7un2sijVmtp+oC4z0lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1522024244; bh=0um/EHz2jFXAguGVu6x5UGQvdN
    AMUnTyLIxFOdWHnAg=; b=l44b+jpMKVmegcwgBwd6p3YFeNExokse3FdpfjnsGe
    LPpWqdi4KblYjXC51gHm6E3b+BzIewYab5V8i4mJZdZBryevxXld0BA9ICWGBGR4
    o7UHVVKC5Y0JrGxfLoh5sL+jcbM/mjyJ7bzgyc2/CsCkOlmwmfaNaR3hRNhrcPtB
    dfs0KgBOLZMoSn8iCnMXI7Nit/TUa/nU10WboLbEBcNAsvRFtzioebOL1gzT1ps0
    XCTZlCVl75RtJILdtEHyWOMNkxlGt14dSMXlldqQPfrH3INE7UJWL4LioZpGXg2u
    n17THn0vH1oae4Wlq7V8gEfypnZCfvWwdhVy7pXr999g==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
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
        id S1751132AbeCZAaf (ORCPT <rfc822;greg@kroah.com>);
        Sun, 25 Mar 2018 20:30:35 -0400
Received: from muru.com ([72.249.23.125]:33914 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750832AbeCZAad (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sun, 25 Mar 2018 20:30:33 -0400
Date: Sun, 25 Mar 2018 17:30:29 -0700
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
Message-ID: <20180326003029.GF5700@atomide.com>
References: <20180323113521.45va72bhzis6ym6m@earth.universe>
 <20180323201343.GC23658@amd>
 <bd79e802944f16b844c1850572928d93f3f2c4b2.camel@redhat.com>
 <20180324142517.GA94954@atomide.com>
 <20180324200224.GA17857@amd>
 <20180325154512.GC5700@atomide.com>
 <20180325185857.GA7582@amd>
 <20180325205232.GD5700@atomide.com>
 <20180325225556.GA18141@amd>
 <20180326002259.GE5700@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180326002259.GE5700@atomide.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Tony Lindgren <tony@atomide.com> [180326 00:24]:
> Looks like on /dev/ttyUSB4 doing AT+COPS? or AT+CREG? won't work
> while on /dev/gsmtty1 they work. So /dev/ttyUSB4 seems to a subset of
> what's available over n_gsm on ch1. Anyways, good to hear that
> /dev/ttyUSB4 can be used to debug voice calls :)

Hmm and now they work on /dev/ttyUSB4. Maybe I had SIM card
poorly connected..

Tony
