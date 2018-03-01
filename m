Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1794019-1519875990-2-7621175695738803469
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519875989; b=QtKfCy0eV7Gra/FbwSZNwz5JHV9EWhOzsEMV/N0K8iW/SiO
    fAek/Iwjme8H8sfqDxy8NClU8YrZYffPpIPbFiroKGpZHe73/XRLUb4FC0hENMtK
    Ulub4DOwPfGVHiRd8wYCegMGTXQkwap1AzPtjEkuiyOnoVAwPZypUwQ8YDqSPBSo
    8TVi5Sg9kM89/XADNXYRoyU0tWjjKKGGjCw8ZdXJtAAV73ukCgCZ3hhUK5wDXaSD
    n6wZ2adgOfD7ISKCay05/F6dYAu9XalfX/wOiA0avXQHCYJWVoRCT2b7j65b2qvH
    7iasr0u344U+muQTCYaOEvcajjnAMlM4v6rTHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519875989; bh=HZ0UjIRzqvcy0e94raNqroUK8V
    o+jdFgYCqnBDHMDy0=; b=MYawU8Tb95q4bKfpgrbO2jhjh3hR0tqQqyG3yNuTsE
    G+S+sKxVGdEIDr4C/nj5V9slJYNo6zpoX9laFSg9ETnT6VWgMe0v5ufiun6DrB4v
    RxtEFBH+rLhi2oy6cG8qGCAU41EFnPA/JP2fPDBqO8ddiCpmpKXxFcPyYe1fK6kK
    3TLCT0a0fm+316XW35dR1MF2LWvz7YwrFKa76Q+pNbArzzUz3xVQf7y/R5uz+fu0
    nieHU0Cq5kNaROcrgZ+4TcT5XGmI6sLkMddSEkk4E/z5+tU9AtBmfBAkmyGHQ2/o
    o1hDYmo2RO+7Vd+zf/EI25Vzsyc8qg+ncmo9MLcglMew==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965741AbeCADqQ (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 22:46:16 -0500
Received: from muru.com ([72.249.23.125]:58924 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965663AbeCADqN (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Wed, 28 Feb 2018 22:46:13 -0500
Date: Wed, 28 Feb 2018 19:46:10 -0800
From: Tony Lindgren <tony@atomide.com>
To: Rob Herring <robh@kernel.org>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
 Droid 4
Message-ID: <20180301034610.GC62820@atomide.com>
References: <20180217210723.7013-1-tony@atomide.com>
 <20180219204029.xrftbbxvdfxlf7jh@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180219204029.xrftbbxvdfxlf7jh@rob-hp-laptop>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Rob Herring <robh@kernel.org> [180219 20:41]:
> On Sat, Feb 17, 2018 at 01:07:23PM -0800, Tony Lindgren wrote:
> > The GPIOs controlling MDM6600 are used to power MDM660 on and off, to
> 
> MDM660 a typo?

Thanks fixing.

> > +Required properties:
> > +- compatible	Must be "motorola,mapphone-mdm6600"
> > +- enable-gpios	GPIO to enable the USB PHY
> > +- power-gpios	GPIO to power on the device
> > +- reset-gpios	GPIO to reset the device
> 
> The are pretty standard, but...
> 
> > +- mode-gpios	Two GPIOs to configure MDM6600 USB start-up mode for
> > +		normal mode versus USB flashing mode
> > +- status-gpios	Three GPIOs to read the power state of the MDM6600
> > +- cmd-gpios	Three GPIOs to control the power state of the MDM6600
> 
> These 3 should have vendor a prefix.

OK

> > +
> > +Example:
> > +
> > +fsusb1_phy: fsusb1_phy {
> 
> usb-phy {

Thanks will send out an updated version shortly.

Regards,

Tony
