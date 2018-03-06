Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3123819-1520301255-2-9411073119918331604
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520301254; b=JLS7Pq7ojHCOnR+thW2Nti/oeu2juMydVmmCU4Qn0w6vEHJ
    MG6CDarqB9U7nxTSQy2hXaFvUrL1rwC7Daia3Hse0iBK3vN5bMoOJ803G1RWxfUj
    eVMjhftIEiWJ+rPyRBgYyNmigp9bZ0UGdzQyijTquVa3v9fjHf3+q0/p1GgX+gLW
    ZWqB1RG12x4kqQ+aMflDAxFrsCfgEALZuq6sprDUGpO2T0hrFzN6NdK9LvFcRtTs
    MqO1T1cxyf5eKkLHQT1dnJ0tCVY3ZJnGCg4TlgfUMlWCbzIK3TSEY2Exc5yKPu6d
    zZniEBQDKoF3wfhddvqfUENCG4+qNoU0TvMJiLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520301254; bh=0O6CU4bYBRwzzl6NpU31b3Go3f
    tUN9l+1NCM8Hu93E8=; b=lwnVh6zgeBnr432Rru1ODhzAYLFXfDaJFWNiPibyuy
    q74PTlAGAp5KBB1nX8kSUTz9NBz/KCu/IEHpeld/wKlYon8b5d4etXoyFQv/ti0D
    uaT8gpc7oXz/MbZYyCb/wAa9EEqz7OundmL5oF3I4NeZAd5xibYGIpkhFv2jnfia
    rRwvPSJ4+NBGZLWDRbQwGPlso6PfyuD9nhWc1HRF2ZEW03c5b+taAA/YXyRZi/nu
    5FjEL6Cxql2xhzGC7dt19Fc/1DlEheTC3eE6htOozE2hPMTA1waqKpRzf6eDY9Tv
    Mwj1RdwCHGH6ZC5+pejqaMUGc2lX4joQQJ6O/D3Fv6lQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dcwNup/K;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-category=clean score=-100 state=0;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=dcwNup/K;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752586AbeCFBx6 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 20:53:58 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:32904 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752017AbeCFBx4 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 5 Mar 2018 20:53:56 -0500
X-Google-Smtp-Source: AG47ELskGMiXXsacXR3tJeTgJTFywOmTGTP4eajyxSoOseAe1MQ07HXCS6cZBJEfUZ6jBuiL5UEOWA==
Date: Mon, 5 Mar 2018 19:53:54 -0600
From: Rob Herring <robh@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv2] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600
 on Droid 4
Message-ID: <20180306015354.wegugxvz25tkptxk@rob-hp-laptop>
References: <20180301035057.37584-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301035057.37584-1-tony@atomide.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 28, 2018 at 07:50:57PM -0800, Tony Lindgren wrote:
> Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> It is used on some Motorola Mapphone series of phones and tablets such
> as Droid 4.
> 
> The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
> is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
> device it seems. We know this as we get L3 errors from omap-usb-host if
> trying to use the PHY before MDM6600 is configured.
> 
> The GPIOs controlling MDM6600 are used to power device on and off, to
> configure the USB start-up mode (normal mode versus USB flashing), and
> they also tell the state of the MDM6600 device.
> 
> The two start-up mode GPIOs are dual-purposed and used for out of band
> (OOB) wake-up for USB and TS 27.010 serial mux. But we need to configure
> the USB start-up mode first to get MDM6600 booted in the right mode to
> be usable in the first place.
> 
> Note that the Motorola Mapphone Linux kernel tree has a "radio-ctrl"
> driver for modems. But it really does not control the radio at all, it
> just controls the modem power and start-up mode for USB. So I came to
> the conclusion that we're better off having this done in the USB PHY
> driver. For adding support for USB flashing mode, we can later on add
> a kernel module option for flash_mode=1 or something similar.
> 
> Also note that currently there is no PM runtime support for the OHCI
> on omap variant SoCs. So for low(er) power idle states, currenty both
> ohci-platform and phy-mapphone-mdm6600 must be unloaded or unbound.
> 
> For reference here is what I measured for total power consumption on
> an idle Droid 4 with and without USB related MDM6600 modules:
> 
> idle lcd off	phy-mapphone-mdm6600	ohci-platform
> 153mW		284mW			344mW
> 
> So it seems that MDM6600 is currently not yet idling even with it's
> radio turned off, but that's something that is beyond the control of
> this USB PHY driver. This patch does get us to the point where modem
> data and GPS are usable with libqmi and ModemManager for example.
> Voice calls need more audio driver work.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> 
> Changes since v1:
> - Fixed up issues noticed by Rob and Sebastian
> - Implemented wake irq handler (for debug use only for now)
> - Improved error handling based on more testing
> 
> ---
>  .../bindings/phy/phy-mapphone-mdm6600.txt          |  30 ++

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/phy/motorola/Kconfig                       |   9 +
>  drivers/phy/motorola/Makefile                      |   1 +
>  drivers/phy/motorola/phy-mapphone-mdm6600.c        | 556 +++++++++++++++++++++
>  4 files changed, 596 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
>  create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c
