Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42840C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF9552133D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551273202;
	bh=ZYYQLEPb5liFOfmxZhGBOGsGIRu+PG4pQEPj4kSnLmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MrtRPb9PCBFNCrS1jGGFWCgNPG9y4Dm5GwL0w14omvYaVJW8Ie2Z81LZlhyGuuVh6
	 qf9fby1NDaYNIUgGgT21SzYdzJV/Fpg5GwoWBAxVh1D02GcOmhn0B2CCHib0H0IoWo
	 VanGJCAUtUfVpgtl040XjgvJuIZurbq+aOPv2SR8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfB0NNU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:13:20 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:40001 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729248AbfB0NNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:13:20 -0500
Received: by mail-lf1-f65.google.com with SMTP id a8so6655705lfi.7;
        Wed, 27 Feb 2019 05:13:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cDYy0M/4cSrybiJsr7HJwPfJcJrNZlZfrPqCsY0i82c=;
        b=dwHtqhl9CPdwHqcWF4HzCvJrlQLAZjPGFRTPMolLLTMIueUWUJz3aHQe0lYfHpVif8
         +FDqmlFP1fPSH4i09VdoytXSCN2shBtlw8nVA12C5ZBdKnw2O4K1BoUSqpzVI5iH6jh1
         /quejvnYb5ngnet9jrqnjV8J8Lf4l07pWohVPVaZUhP649W/egI1XzTlwN8Mr0+pmuMR
         fxuf1gO+dnvYFqFJy9cL7w7soAXFI15ldV7soZSbxq2a3bqdIc1InKsBpzmSm2k6AdIB
         Pv4+pt5vU1z8G+D+FHsq52m7elYXbeS51j6Sz1ZlvJY5OJWQ5yb2qhS3pG1AZMkpOCsH
         2bnQ==
X-Gm-Message-State: AHQUAubyrIShJfOAhVW/9aCG7uNgBVuNMxtrAqwus8Vrjr5B59xz6ZeB
        8nEhP+Zx0RLnvIWJZgqQoBE=
X-Google-Smtp-Source: AHgI3IZWHoxyaeIRPbUElr/FGl1jVRkpUNONruQnXjMaEVEmjh3QdkdAC9HX1M7UwyOv9zhz6Tuqkg==
X-Received: by 2002:a19:2812:: with SMTP id o18mr872827lfo.128.1551273196574;
        Wed, 27 Feb 2019 05:13:16 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id c2sm3921042ljj.45.2019.02.27.05.13.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 05:13:15 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gyz1P-0008MI-Cu; Wed, 27 Feb 2019 14:13:15 +0100
Date:   Wed, 27 Feb 2019 14:13:15 +0100
From:   Johan Hovold <johan@kernel.org>
To:     =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        =?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and
 compatibles
Message-ID: <20190227131315.GO4747@localhost>
References: <20190226170710.12709-1-mans@mansr.com>
 <20190227083342.GJ4747@localhost>
 <yw1xpnrdv3z7.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xpnrdv3z7.fsf@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Bjørn.

On Wed, Feb 27, 2019 at 11:57:16AM +0000, Måns Rullgård wrote:
> Johan Hovold <johan@kernel.org> writes:
> 
> > On Tue, Feb 26, 2019 at 05:07:10PM +0000, Mans Rullgard wrote:
> >> The SIMCom SIM5218 and compatible devices have 5 USB interfaces, only 4
> >> of which are serial ports.  The fifth is a network interface supported
> >> by the qmi-wwan driver.  Furthermore, the serial ports do not support
> >> modem control signals.  Add driver_info flags to reflect this.
> >> 
> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> ---
> >>  drivers/usb/serial/option.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >> 
> >> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> >> index fb544340888b..af4cbfecc3ff 100644
> >> --- a/drivers/usb/serial/option.c
> >> +++ b/drivers/usb/serial/option.c
> >> @@ -1066,7 +1066,8 @@ static const struct usb_device_id option_ids[] = {
> >>  	  .driver_info = RSVD(3) },
> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x6613)}, /* Onda H600/ZTE MF330 */
> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x0023)}, /* ONYX 3G device */
> >> -	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000)}, /* SIMCom SIM5218 */
> >> +	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000), /* SIMCom SIM5218 */
> >> +	  .driver_info = NCTRL(0) | NCTRL(1) | NCTRL(2) | NCTRL(3) | RSVD(4) },
> >>  	/* Quectel products using Qualcomm vendor ID */
> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
> >>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),
> >
> > Could you please provide the output of usb-devices (or lsusb -v) for
> > this device?
> 
> lsusb -v:
> Bus 001 Device 003: ID 05c6:9000 Qualcomm, Inc. SIMCom SIM5218 modem
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0 
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0        64
>   idVendor           0x05c6 Qualcomm, Inc.
>   idProduct          0x9000 SIMCom SIM5218 modem
>   bcdDevice            0.00
>   iManufacturer           3 SimTech, Incorporated
>   iProduct                2 SimTech SIM5360
>   iSerial                 0 
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength          138
>     bNumInterfaces          5
>     bConfigurationValue     1
>     iConfiguration          1 SimTech Configuration
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower              500mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x81  EP 1 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x01  EP 1 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        1
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x82  EP 2 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x02  EP 2 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        2
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x83  EP 3 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x03  EP 3 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        3
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x84  EP 4 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               5
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x85  EP 5 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x04  EP 4 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        4
>       bAlternateSetting       0
>       bNumEndpoints           3
>       bInterfaceClass       255 Vendor Specific Class
>       bInterfaceSubClass    255 Vendor Specific Subclass
>       bInterfaceProtocol    255 Vendor Specific Protocol
>       iInterface              0 
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x86  EP 6 IN
>         bmAttributes            3
>           Transfer Type            Interrupt
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0040  1x 64 bytes
>         bInterval               5
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x87  EP 7 IN
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
>       Endpoint Descriptor:
>         bLength                 7
>         bDescriptorType         5
>         bEndpointAddress     0x05  EP 5 OUT
>         bmAttributes            2
>           Transfer Type            Bulk
>           Synch Type               None
>           Usage Type               Data
>         wMaxPacketSize     0x0200  1x 512 bytes
>         bInterval              32
> Device Qualifier (for other device speed):
>   bLength                10
>   bDescriptorType         6
>   bcdUSB               2.00
>   bDeviceClass            0 
>   bDeviceSubClass         0 
>   bDeviceProtocol         0 
>   bMaxPacketSize0        64
>   bNumConfigurations      1
> can't get debug descriptor: Resource temporarily unavailable
> Device Status:     0x0000
>   (Bus Powered)

So the patch looks fine to me. The fifth interface is QMI, but hasn't
been available for use until now then, and this seems to have been the
vendors idea from the start:

	http://www.microchip.ua/simcom/WCDMA/APPNOTES/SIMCom_3G_Linux_driver_Application%20Note_V1.00.pdf

And you're seeing errors when opening ports 0-3 due to the DTR calls
which I guess no one noticed or cared about before?

Before you sent me the lsusb I searched for it and came across the below
thread where Bjørn's having a go at SIMCom. In it there's output from a
second device using the same id but with entirely different descriptors.

	https://forum.openwrt.org/t/lte-wireless-module-support-by-openwrt-led-on-tplink/13586?page=3

If this is a common theme with this vendor we may need to be extra
careful when making changes.

Johan
