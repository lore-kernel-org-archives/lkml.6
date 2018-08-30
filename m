Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D35AC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2C5320645
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:12:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2C5320645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeH3LNc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:13:32 -0400
Received: from mail.bootlin.com ([62.4.15.54]:46553 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727395AbeH3LNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:13:32 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 140E620828; Thu, 30 Aug 2018 09:12:47 +0200 (CEST)
Received: from dell-desktop.home (AAubervilliers-681-1-92-107.w90-88.abo.wanadoo.fr [90.88.33.107])
        by mail.bootlin.com (Postfix) with ESMTPSA id B57242072C;
        Thu, 30 Aug 2018 09:12:36 +0200 (CEST)
Date:   Thu, 30 Aug 2018 09:12:35 +0200
From:   =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?B?TXlsw6huZQ==?= Josserand 
        <mylene.josserand@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        lkml <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Subject: Re: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
Message-ID: <20180830091235.6fff7b7d@dell-desktop.home>
In-Reply-To: <CAKdAkRQQ27TNmDSSg5x4kGvhhBjRbM9G2Bv_1WBxAhYWNUkz1w@mail.gmail.com>
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
        <20180704162158.euiw2v3hyv3hzofn@penguin>
        <20180724150046.7d70786c@dell-desktop.home>
        <20180724174053.GA61165@dtor-ws>
        <20180813172358.71912d55@dell-desktop.home>
        <CAKdAkRQQ27TNmDSSg5x4kGvhhBjRbM9G2Bv_1WBxAhYWNUkz1w@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Dmitry,

On Mon, 13 Aug 2018 08:36:32 -0700
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> Hi Mylène,
> 
> On Mon, Aug 13, 2018 at 8:24 AM Mylène Josserand
> <mylene.josserand@bootlin.com> wrote:
> >
> > Hi Dmitry,
> >
> > On Tue, 24 Jul 2018 10:40:53 -0700
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> >  
> > > Hi Mylène,
> > >
> > > On Tue, Jul 24, 2018 at 03:00:46PM +0200, Mylène Josserand wrote:  
> > > > Hello Dmitry,
> > > >
> > > > On Wed, 4 Jul 2018 16:21:58 +0000
> > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > >  
> > > > > Hi Mylène,
> > > > >
> > > > > On Tue, Jul 03, 2018 at 11:43:07AM +0200, Mylène Josserand wrote:  
> > > > > > Hello,
> > > > > >
> > > > > > Here is a V6 series to add the driver of the touchscreen Cypress,
> > > > > > TrueTouch Generation 5.
> > > > > > Based on v4.18-rc3.
> > > > > >
> > > > > > This patch series has already been posted in several iterations:
> > > > > >     - v1: Sent on 2017/05/29
> > > > > >     - v2: Sent on 2017/08/18
> > > > > >     - v3: Sent on 2017/09/27
> > > > > >     - v4: Sent on 2017/12/01
> > > > > >     - v5: Sent on 2017/12/20
> > > > > >
> > > > > > I did not have any comments the last 4 versions.
> > > > > > And no reviews on my v5 during 6 months. Could I have any updates
> > > > > > or feedback on my series to know why it is not merged (to be able to
> > > > > > correct what is wrong)?  
> > > > >
> > > > > Sorry, I must have missed the v5, sorry about that.
> > > > >
> > > > > I probably asked this question before, but just to make sure - I see
> > > > > references to HID in the patch - the device is really not HID
> > > > > compatible? Is there any hope it could be made work with i2c-hid +
> > > > > hid-multitouch?
> > > > >
> > > > > Thanks.
> > > > >  
> > > >
> > > > I have checked and, for what I have seen, all the HID descriptor stuff
> > > > is HID compliant. We could definitely use i2c-hid and hid-multitouch
> > > > (there is the "hid-cypress" driver that exists also).
> > > >
> > > > The only problem is that this touchscreen has two modes: a bootloader
> > > > mode and an application mode (which is the one where we can send
> > > > HID commands). After a power-on-reset, it is always in "bootloader"
> > > > mode so we need to send some commands (called "bootloader commands") to
> > > > switch to application mode.  
> > >
> > > Is this a documented or observed behavior? In my practice devices (I am
> > > talking in general, not about Cypress) that have proper configuration
> > > loaded and that were brought up with appropriate power up sequence and
> > > timings automatically switch to application mode. They only end up in
> > > bootloader mode when proper power up sequence is not respected and they
> > > are unhappy.  
> >
> > I have checked and indeed, if everything is correctly performed, the
> > bootloader has a timeout to switch to application mode.
> > The datasheet says that this timeout can be configured and the "0" value
> > means that the bootloader will never automatically switch to application
> > unless a bootloader command is sent.
> >
> > In our case, you were right, after a timeout, the touchscreen is
> > correctly switching to Application mode. Great news!
> >  
> > >  
> > > > These commands are not HID-compliant as the
> > > > datasheet indicates:
> > > >
> > > > "Bootloader commands are not HID-over-I2C compliant."  
> > >
> > > Any chance you could share the datasheet?  
> >
> > Sorry, it is not possible, the datasheet is under NDA :(
> >  
> > >  
> > > >
> > > > I think that if the touchscreen would start directly in "application"
> > > > mode, we could directly use i2c-hid and hid-cypress drivers.
> > > > Unfortunately, this is not the case.
> > > >
> > > > In bootloader mode, the ProductID is 0xc101 and in application mode, it
> > > > is 0xc001 (already available in hid-ids.h:
> > > > USB_DEVICE_ID_CYPRESS_TRUETOUCH but not handled)
> > > >
> > > > What would be the better approach here?
> > > > Should I add a new product ID to detect the bootloader mode in
> > > > hid-cypress driver and send non-HID commands to switch to
> > > > "application" mode in this driver?
> > > > Anyway, I guess that I will drop this cyttsp5 driver and update the
> > > > existing one, right?  
> > >
> > > So it still accessible through HID, even when in bootloader mode? OK,
> > > then I guess there are 2 options:
> > >
> > > - if device is documented to always start in bootloader mode, you could
> > >   have a small stub driver that switches it into application mode in its
> > >   probe() code. The "bootloader" device will disappear and
> > >   "application" device will appear, and standard driver (hid-multitouch)
> > >   will bind to it.  
> >
> > Okay, I see. In our case, we do not have the timeout to 0 as after a
> > moment, the application mode is automatically switched.
> >  
> > >
> > > - if device supposed to come up in application mode unless configuration
> > >   is damaged: I'd recommend doing what we do on Chrome OS and have some
> > >   userspace software that runs on boot (or whenever device is
> > >   discovered) and check if it has the latest firmware/configuration, and
> > >   repair device if needed.  
> >
> > I see.
> >
> > I tried to make the i2d-hid & hid-cypress working. This is not
> > successful for the moment because I can not retrieve the correct
> > bcdVersion. While debugging, I have noticed that the HID descriptors
> > don't seem to be exactly the same:
> >
> > under i2c-hid.c:
> >
> > struct i2c_hid_desc {
> >         __le16 wHIDDescLength;
> >         __le16 bcdVersion;
> >         __le16 wReportDescLength;
> >         __le16 wReportDescRegister;
> >         __le16 wInputRegister;
> >         __le16 wMaxInputLength;
> >         __le16 wOutputRegister;
> >         __le16 wMaxOutputLength;
> >         __le16 wCommandRegister;
> >         __le16 wDataRegister;
> >         __le16 wVendorID;
> >         __le16 wProductID;
> >         __le16 wVersionID;
> >         __le32 reserved;
> > } __packed;
> >
> > whereas in my driver, I have:
> >
> > struct cyttsp5_hid_desc {
> >         __le16 hid_desc_len;
> >         u8 packet_id;       <-- Different
> >         u8 reserved_byte;   <-- Different
> >         __le16 bcd_version;
> >         __le16 report_desc_len;
> >         __le16 report_desc_register;
> >         __le16 input_register;
> >         __le16 max_input_len;
> >         __le16 output_register;
> >         __le16 max_output_len;
> >         __le16 command_register;
> >         __le16 data_register;
> >         __le16 vendor_id;
> >         __le16 product_id;
> >         __le16 version_id;
> >         u8 reserved[4];
> > } __packed;
> >
> > Have you already seen devices that are "HID compatible" with a different
> > HID descriptor's content like this?  
> 
> That seems like a violation of Microsoft I2C HID protocol:
> https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)
> How do Cypress devices work in Windows? Might they have a compatible
> firmware?

I do not know how it works on Windows, actually.
The datasheet indicates that it is based on HID specification. I guess
it is not "HID compliant" as I was thinking while reading it.

"Packet Interface Protocol (PIP) is a command and response-based
communication protocol used to communicate with the
TrueTouch device over the physical communication interface. PIP is
modeled after Microsoft’s HID over I2C protocol specification, version
1.00. However, PIP extends the functionality of HID over I2C protocol
to support both I2C and SPI physical communication interfaces, raw
data extraction, self-tests, bootloading, and configuration data
programming."

> 
> In any case, for all I2C HID things Benjamin (CCed) is your guy.

Okay, thanks.
I am not so sure it is possible to use HID's drivers, now.

Best regards,

-- 
Mylène Josserand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
