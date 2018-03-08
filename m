Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2264920-1520525225-2-5502870732486339759
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
    t=1520525224; b=Dtp3vP8TdiV/a5f1SCHK0Wqwze/LcxvGNL98qNbI81X9c+W
    iOnj7sl53xvAdMUTtDiNpNVxLySFVSpUbsATNWLN4fumcBJGpdxDgJ2WkPWVbFJX
    Cuz6OYpTRx7iZQqieef3Y95sjXaijLi/np5XFrCJqyTe++lrRRAvxNiVhpLMFoK9
    JCACvE0zGHj1Az05vRWODXR2VPg7JZROf2CdkuVCY77XcKdvW3PgSq3FgWT2PwKb
    5NtP+E/hEIFM9jcBCvIuVJ9LzTWK40wALYgPEFE+MZu6hFEVUiE1C6y+issbRLSu
    lYFEwr3EQJHxJZ0eS6QSfUKfRyK8hzWpsVdb55g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520525224; bh=5heTbaG3QVsz6FNcQkZ2RpduIl
    ZIeXhcIoWd1cSQeAk=; b=DSfvxS+p+UtvNdWycChw5y0tmzYi84WJ3qTTn/Y+hY
    AJSmuK8N/waJnm8JXuxWYZCKfIh7/VI2emkBvHAyLPlSOyAQ2jGV/BBdfcQHtMHd
    j/wBxH8Jmjl9r3ic4aN2jVVROQl9lucvFjGE0oxemHgAKLIvDscU8vhsWd2uvwkn
    KZPnz8zUnEoOe/tJTD/uq5Wf5HUE8EsFUmz2JTFHvd9wgxooy6dWGuBwpeyItbjm
    N/hxYQan1GhX4GFqhl7TNsW/VPi8osIQAPOZMjHm8aMyPceZnN5B04nDKQRCTyt1
    MAG72HpxjpEnbnw2RhDvKSerJQSiZn2y9CCtxudDukNQ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935660AbeCHQGt (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 11:06:49 -0500
Received: from muru.com ([72.249.23.125]:60062 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935582AbeCHQGs (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Thu, 8 Mar 2018 11:06:48 -0500
Date: Thu, 8 Mar 2018 08:06:44 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCHv3] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180308160644.GJ5799@atomide.com>
References: <20180307145640.93867-1-tony@atomide.com>
 <bff8014e-a0b6-8b7b-5de7-2a176e293933@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bff8014e-a0b6-8b7b-5de7-2a176e293933@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [180308 08:23]:
> On Wednesday 07 March 2018 08:26 PM, Tony Lindgren wrote:
> > +config PHY_MAPPHONE_MDM6600
> > +	tristate "Motorola Mapphone MDM6600 modem USB PHY driver"
> > +	depends on OF && USB_SUPPORT
> > +	select GENERIC_PHY
> > +	select USB_PHY
> 
> given that OTG is removed, USB_PHY won't be required anymore. Sorry for not
> stating this explicitly before.

Oh OK I did not know that.

> > +	ddata->dev = &pdev->dev;
> > +	ddata->phy.dev = ddata->dev;
> > +	ddata->phy.label = "phy_mdm6600";
> > +	ddata->phy.type = USB_PHY_TYPE_USB2;
> 
> All of this can be removed since usb_phy is not required.

> > +	usb_add_phy_dev(&ddata->phy);
> 
> This should also be removed.

OK cool, will remove and post v4 hopefully tonight at some
point.

Regards,

Tony
