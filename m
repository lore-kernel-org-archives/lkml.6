Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625397-1519999434-2-17696400468294640277
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
    t=1519999433; b=wi8+RDhdRgdP/BiMrQVuW96YGr3HR0p2k9BuykZ0ZTuCj4K
    4A/0hLvgBZRQGyrZX00Mwbxc8s7Yr8i/CgbFcYYtWfYW2lnLJ7tvltzTstmH9Dz2
    mHvVqFhSFSNmUeCzwJe3eQLrFPZj/Oq0tMC11B6cL0zBbRX5ee3JN6fH4RIJfWQa
    De6zbaC6cHAGtl9+MsZe73o2WqM0AjcwGNPIggprfGctCx8ZOdP831zyEpAVeD2p
    lOLcU9KohbMPcZyOBzC7XQ0wATEOMvOt2TFiGNNtnecYbELQIHdf4gG9Rj811vyp
    xFkFm5702ekqG/ymDv4KGcW/uUd2CafbpAJM6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519999433; bh=qjVqEoI490QExDznZ2oeEJggGf
    kO6fgLM8Ku+A4PZ54=; b=cUYEE2oB/NcJiLuZk1rAqB8pVBKx3PKtP+401Lx4QX
    drh8jFkWiS4KTkjgc+ablS5lgEFimbqhtAjkVm+HASS7M/gzMk3L2A3qlvCQq+Gn
    G3eKY47rgEvyjIFdco+Et6pS5kUx1hsG+SttmehBwdHsfs06pGy1mQ6jELd42FlQ
    r836c2l2ofow1Uc8wKyGJMZgqcdw6jW0GEi1LFqdkZ9JZgJDX/1CnmpFigBfQ6kI
    /C8zMXIaIVBEfYIUp4KXKfG8w5eTCJyzNCAUcVAfePMW+5lQhhEdTAvUelec6KZi
    lke10Jug2tKEZIWAJxATyroKIV4ZlUUKtIFHxDB+86GQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=atomide.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=atomide.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428459AbeCBODh (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Mar 2018 09:03:37 -0500
Received: from muru.com ([72.249.23.125]:59256 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1424382AbeCBODe (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 2 Mar 2018 09:03:34 -0500
Date: Fri, 2 Mar 2018 06:03:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180302140331.GK62820@atomide.com>
References: <20180301035057.37584-1-tony@atomide.com>
 <b39478ec-35ba-d288-bb03-28dda5544e80@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b39478ec-35ba-d288-bb03-28dda5544e80@ti.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

* Kishon Vijay Abraham I <kishon@ti.com> [180302 08:04]:
> Hi Tony,
> 
> On Thursday 01 March 2018 09:20 AM, Tony Lindgren wrote:
> > Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> > It is used on some Motorola Mapphone series of phones and tablets such
> > as Droid 4.
> 
> Generally PHY configuration is done for the PHYs that is connected to the USB
> controllers in the SoC. In that sense it differs from the usual case by
> programming the PHY in the device.

Yup in this case it's the MDM6600 that provides the PHY for the SoC :)

> > The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
> > is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
> > device it seems. We know this as we get L3 errors from omap-usb-host if
> > trying to use the PHY before MDM6600 is configured.
> 
> Do you know what phy is connected to the OHCI port. Previously we've seen for
> having USB devices on the board itself, phy less configurations was used.

We have MDM6600 on *HCI port 1 providing "ohci-phy-4pin-dpdm"
PHY for the SoC, so not TLL. Then there's another modem W3GLTE on
port 2 that is using "ehci-tll".

> > --- /dev/null
> > +++ b/drivers/phy/motorola/phy-mapphone-mdm6600.c
> .
> .
> <snip>
> .
> .
> > +
> > +static int phy_mdm6600_probe(struct platform_device *pdev)
> > +{
> > +	struct phy_mdm6600 *ddata;
> > +	struct usb_otg *otg;
> 
> Since it is connected to a OHCI, not sure if we really need to add usb_otg here.

OK yeah that's copy paste leftover from my earlier PHY driver I used
to start with. Will drop thanks.

Regards,

Tony
