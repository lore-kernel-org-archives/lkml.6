Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981003-1519072847-2-9050038897866310304
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519072846; b=ryXVHVkkeN/ODiOFlS+YEKGaA616pZAOjoxv+N46NMimE8z
    ywD0Ca1fiwra33kR6QoEbHMzO4AFsqWYpzeskFPuD8cTdpI/8GTnkjU/9cseYE0N
    JxxT8CXcfF4fOunNOvOftDLKZroA8/j9sK7A4+DENENYyndoA+qr/FREKCEfMZ+o
    tezD9PbuwJUqSuDNxWNzWk0rmfz1e2EXpgS0C+JeK0SsBd1h0zsmoRtLAwaMC/Hr
    bDn/ijp2Jy3DDW1eJ4OVLag/HCwtVAKQFmeGSRpIRJxCQTlDm5ccyHSXDBklfdzy
    e5wPdF0XvWaKFPBom9z8uWDUMPOOOwiwIMHbQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519072846; bh=r9sDBVCSnJCN6Cl2vdKOB2/BD6
    UvrwLu2xzs90FFOkQ=; b=Rr7KwuVzXzhV0PS0bL8X/CVahkK+MAJXmoCVOKMCuv
    YB6SR8Nhnf94bhNtXLLWV/XrASa8Af55RhYNIe7pB01wBJ0Th9FjvXWmn6yXKBlZ
    JmwdvJ2sIln7YI5/Yqseh79lfocVIbkkMexW1JE/KHcGAMR9gc8HKZ4kWyHW7j2E
    orRf0Lx0YieRYaItK6k1Szxi0h4GuXnvNNIO7ZvQok31kw5VhPfP2VwGje9kDIsY
    hMBtDxjiNidc+LEFyiOgWZhN9yQn8GaIUcrR/zwS4E/dBnddg5SOUs0S8hZ17Aj3
    NKE0cgPVCYxXWVlgJRqlU2J/bHpCMN57xWqf0w9WC5GA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=e8ZrbXif;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass;
    x-google-dkim=fail (body has been altered; 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=e8ZrbXif;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753715AbeBSUkc (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Feb 2018 15:40:32 -0500
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41756 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753624AbeBSUkb (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 19 Feb 2018 15:40:31 -0500
X-Google-Smtp-Source: AH8x224rgxWCIOag9NEphW24lp+kdRaQNTZHDNY9JfPE6UhBkQhTCjNKyCGUAh5C5tlMvYPxC9zwaA==
Date: Mon, 19 Feb 2018 14:40:29 -0600
From: Rob Herring <robh@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] phy: mapphone-mdm6600: Add USB PHY driver for MDM6600 on
 Droid 4
Message-ID: <20180219204029.xrftbbxvdfxlf7jh@rob-hp-laptop>
References: <20180217210723.7013-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180217210723.7013-1-tony@atomide.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 17, 2018 at 01:07:23PM -0800, Tony Lindgren wrote:
> Let's add support for the GPIO controlled USB PHY on the MDM6600 modem.
> It is used on some Motorola Mapphone series of phones and tablets such
> as Droid 4.
> 
> The MDM6600 is hardwired to the first OHCI port in the Droid 4 case, and
> is controlled by several GPIOs. The USB PHY is integrated into the MDM6600
> device it seems. We know this as we get L3 errors from omap-usb-host if
> trying to use the PHY before MDM6600 is configured.
> 
> The GPIOs controlling MDM6600 are used to power MDM660 on and off, to

MDM660 a typo?

> configure the USB start-up mode (normal mode versus USB flashing), and
> they also tell the state of the MDM6600 device.
> 
> The two start-up mode GPIOs are dual-purposed and used for out of band
> (OOB) wake-up for USB and TS 27.010 serial mux. But we need to configure
> the USB start-up mode first to get MDM6600 booted in the right mode to
> be usable in the first place.
> 
> For now, this driver just gives up the two start-up mode GPIOs after the
> modem has been configured to boot in normal mode. One of them we may
> want to configure for USB OOB wake in this driver later on, but that's a
> separate series of patches and needs more work.
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
> this USB PHY driver.
> 
> Cc: devicetree@vger.kernel.org
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  .../bindings/phy/phy-mapphone-mdm6600.txt          |  30 ++
>  drivers/phy/motorola/Kconfig                       |   9 +
>  drivers/phy/motorola/Makefile                      |   1 +
>  drivers/phy/motorola/phy-mapphone-mdm6600.c        | 490 +++++++++++++++++++++
>  4 files changed, 530 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
>  create mode 100644 drivers/phy/motorola/phy-mapphone-mdm6600.c
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
> new file mode 100644
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-mapphone-mdm6600.txt
> @@ -0,0 +1,30 @@
> +Device tree binding documentation for Motorola Mapphone MDM6600 USB PHY
> +
> +Required properties:
> +- compatible	Must be "motorola,mapphone-mdm6600"
> +- enable-gpios	GPIO to enable the USB PHY
> +- power-gpios	GPIO to power on the device
> +- reset-gpios	GPIO to reset the device

The are pretty standard, but...

> +- mode-gpios	Two GPIOs to configure MDM6600 USB start-up mode for
> +		normal mode versus USB flashing mode
> +- status-gpios	Three GPIOs to read the power state of the MDM6600
> +- cmd-gpios	Three GPIOs to control the power state of the MDM6600

These 3 should have vendor a prefix.

> +
> +Example:
> +
> +fsusb1_phy: fsusb1_phy {

usb-phy {

> +	compatible = "motorola,mapphone-mdm6600";
> +	enable-gpios = <&gpio3 31 GPIO_ACTIVE_LOW>;     /* gpio_95 */
> +	power-gpios = <&gpio2 22 GPIO_ACTIVE_HIGH>;	/* gpio_54 */
> +	reset-gpios = <&gpio2 17 GPIO_ACTIVE_HIGH>;	/* gpio_49 */
> +	mode-gpios = <&gpio5 20 GPIO_ACTIVE_HIGH>,	/* gpio_148 */
> +		     <&gpio5 21 GPIO_ACTIVE_HIGH>;	/* gpio_149 */
> +	status-gpios = <&gpio2 23 GPIO_ACTIVE_HIGH>,	/* gpio_55 */
> +		       <&gpio2 21 GPIO_ACTIVE_HIGH>,	/* gpio_53 */
> +		       <&gpio2 20 GPIO_ACTIVE_HIGH>;	/* gpio_52 */
> +	cmd-gpios = <&gpio4 7 GPIO_ACTIVE_HIGH>,	/* gpio_103 */
> +		    <&gpio4 8 GPIO_ACTIVE_HIGH>,	/* gpio_104 */
> +		    <&gpio5 14 GPIO_ACTIVE_HIGH>;	/* gpio_142 */
> +	#phy-cells = <0>;
> +};
> +
