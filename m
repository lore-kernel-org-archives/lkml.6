Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1410C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BED20658
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 07:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67BED20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbeH3LY6 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 07:24:58 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:46021 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbeH3LY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 07:24:57 -0400
Received: by mail-qk0-f195.google.com with SMTP id z125-v6so5102353qkb.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 00:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=trHu1C9C0i79ZYV+sDhy62d8cNI6FOH8dCtE0lALIW8=;
        b=P6V4uJvGyMAjj6ll3vXRYcI2xNr2OWCTnGz0sUg6ktrAH65gNR74eMVNGyVolcNc5I
         YOYHc/2uFtLEJ2TMMyhzmr6glCtKomLghZdJKtVlpYONw1vRuQzK0PfeUYQrSq99kQkp
         ioqgZ2NOg+u1/HrkOY3oRhEJ8PhYAO4pIqAXP76dYRcOMuzMnL5xOp8qURnxaVj6KOvY
         3XyKfpyNd8CEr2Pe2CYV+N+TVaGeBxFzA2w+IoUI8fDtu5qLJrUDQnlPDhyF409bjpYM
         57EdpVk8cWAH3Cd70SNQAj5qpIMGhGhpRUCacBsnJDr7MqVGfMXWfdb9MK4Gu5IRvw5D
         UN6Q==
X-Gm-Message-State: APzg51BLIQt3Mnln30QLRXAnirhYsU350YhbJndVeFCDGXi8rfY35pml
        fZ3XF76NT/ekuhw3EyI4E+JNOy39PqKHqNBDQSye6g==
X-Google-Smtp-Source: ANB0VdYBH3FziJwLHy6Dk6+cLctCj7nbiBFTNHPAXkvTMjrPuXO6FGtu1ZWDLoIb15fPhqDu8BMspH4dzCb0S5NO5Cg=
X-Received: by 2002:a37:132a:: with SMTP id d42-v6mr9579941qkh.343.1535613851721;
 Thu, 30 Aug 2018 00:24:11 -0700 (PDT)
MIME-Version: 1.0
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
 <20180704162158.euiw2v3hyv3hzofn@penguin> <20180724150046.7d70786c@dell-desktop.home>
 <20180724174053.GA61165@dtor-ws> <20180813172358.71912d55@dell-desktop.home>
 <CAKdAkRQQ27TNmDSSg5x4kGvhhBjRbM9G2Bv_1WBxAhYWNUkz1w@mail.gmail.com> <20180830091235.6fff7b7d@dell-desktop.home>
In-Reply-To: <20180830091235.6fff7b7d@dell-desktop.home>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Thu, 30 Aug 2018 09:24:00 +0200
Message-ID: <CAO-hwJ+heBdp4cgaeB25di1LLPAJv4BFLWMmbn4v5AXap8zpQg@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
To:     mylene.josserand@bootlin.com
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, mark.rutland@arm.com,
        mylene.josserand@free-electrons.com,
        thomas.petazzoni@free-electrons.com,
        maxime.ripard@free-electrons.com,
        lkml <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 30, 2018 at 9:12 AM Mylène Josserand
<mylene.josserand@bootlin.com> wrote:
>
> Hello Dmitry,
>
> On Mon, 13 Aug 2018 08:36:32 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> > Hi Mylène,
> >
> > On Mon, Aug 13, 2018 at 8:24 AM Mylène Josserand
> > <mylene.josserand@bootlin.com> wrote:
> > >
> > > Hi Dmitry,
> > >
> > > On Tue, 24 Jul 2018 10:40:53 -0700
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > > > Hi Mylène,
> > > >
> > > > On Tue, Jul 24, 2018 at 03:00:46PM +0200, Mylène Josserand wrote:
> > > > > Hello Dmitry,
> > > > >
> > > > > On Wed, 4 Jul 2018 16:21:58 +0000
> > > > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > > Hi Mylène,
> > > > > >
> > > > > > On Tue, Jul 03, 2018 at 11:43:07AM +0200, Mylène Josserand wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > Here is a V6 series to add the driver of the touchscreen Cypress,
> > > > > > > TrueTouch Generation 5.
> > > > > > > Based on v4.18-rc3.
> > > > > > >
> > > > > > > This patch series has already been posted in several iterations:
> > > > > > >     - v1: Sent on 2017/05/29
> > > > > > >     - v2: Sent on 2017/08/18
> > > > > > >     - v3: Sent on 2017/09/27
> > > > > > >     - v4: Sent on 2017/12/01
> > > > > > >     - v5: Sent on 2017/12/20
> > > > > > >
> > > > > > > I did not have any comments the last 4 versions.
> > > > > > > And no reviews on my v5 during 6 months. Could I have any updates
> > > > > > > or feedback on my series to know why it is not merged (to be able to
> > > > > > > correct what is wrong)?
> > > > > >
> > > > > > Sorry, I must have missed the v5, sorry about that.
> > > > > >
> > > > > > I probably asked this question before, but just to make sure - I see
> > > > > > references to HID in the patch - the device is really not HID
> > > > > > compatible? Is there any hope it could be made work with i2c-hid +
> > > > > > hid-multitouch?
> > > > > >
> > > > > > Thanks.
> > > > > >
> > > > >
> > > > > I have checked and, for what I have seen, all the HID descriptor stuff
> > > > > is HID compliant. We could definitely use i2c-hid and hid-multitouch
> > > > > (there is the "hid-cypress" driver that exists also).
> > > > >
> > > > > The only problem is that this touchscreen has two modes: a bootloader
> > > > > mode and an application mode (which is the one where we can send
> > > > > HID commands). After a power-on-reset, it is always in "bootloader"
> > > > > mode so we need to send some commands (called "bootloader commands") to
> > > > > switch to application mode.
> > > >
> > > > Is this a documented or observed behavior? In my practice devices (I am
> > > > talking in general, not about Cypress) that have proper configuration
> > > > loaded and that were brought up with appropriate power up sequence and
> > > > timings automatically switch to application mode. They only end up in
> > > > bootloader mode when proper power up sequence is not respected and they
> > > > are unhappy.
> > >
> > > I have checked and indeed, if everything is correctly performed, the
> > > bootloader has a timeout to switch to application mode.
> > > The datasheet says that this timeout can be configured and the "0" value
> > > means that the bootloader will never automatically switch to application
> > > unless a bootloader command is sent.
> > >
> > > In our case, you were right, after a timeout, the touchscreen is
> > > correctly switching to Application mode. Great news!
> > >
> > > >
> > > > > These commands are not HID-compliant as the
> > > > > datasheet indicates:
> > > > >
> > > > > "Bootloader commands are not HID-over-I2C compliant."
> > > >
> > > > Any chance you could share the datasheet?
> > >
> > > Sorry, it is not possible, the datasheet is under NDA :(
> > >
> > > >
> > > > >
> > > > > I think that if the touchscreen would start directly in "application"
> > > > > mode, we could directly use i2c-hid and hid-cypress drivers.
> > > > > Unfortunately, this is not the case.
> > > > >
> > > > > In bootloader mode, the ProductID is 0xc101 and in application mode, it
> > > > > is 0xc001 (already available in hid-ids.h:
> > > > > USB_DEVICE_ID_CYPRESS_TRUETOUCH but not handled)
> > > > >
> > > > > What would be the better approach here?
> > > > > Should I add a new product ID to detect the bootloader mode in
> > > > > hid-cypress driver and send non-HID commands to switch to
> > > > > "application" mode in this driver?
> > > > > Anyway, I guess that I will drop this cyttsp5 driver and update the
> > > > > existing one, right?
> > > >
> > > > So it still accessible through HID, even when in bootloader mode? OK,
> > > > then I guess there are 2 options:
> > > >
> > > > - if device is documented to always start in bootloader mode, you could
> > > >   have a small stub driver that switches it into application mode in its
> > > >   probe() code. The "bootloader" device will disappear and
> > > >   "application" device will appear, and standard driver (hid-multitouch)
> > > >   will bind to it.
> > >
> > > Okay, I see. In our case, we do not have the timeout to 0 as after a
> > > moment, the application mode is automatically switched.
> > >
> > > >
> > > > - if device supposed to come up in application mode unless configuration
> > > >   is damaged: I'd recommend doing what we do on Chrome OS and have some
> > > >   userspace software that runs on boot (or whenever device is
> > > >   discovered) and check if it has the latest firmware/configuration, and
> > > >   repair device if needed.
> > >
> > > I see.
> > >
> > > I tried to make the i2d-hid & hid-cypress working. This is not
> > > successful for the moment because I can not retrieve the correct
> > > bcdVersion. While debugging, I have noticed that the HID descriptors
> > > don't seem to be exactly the same:
> > >
> > > under i2c-hid.c:
> > >
> > > struct i2c_hid_desc {
> > >         __le16 wHIDDescLength;
> > >         __le16 bcdVersion;
> > >         __le16 wReportDescLength;
> > >         __le16 wReportDescRegister;
> > >         __le16 wInputRegister;
> > >         __le16 wMaxInputLength;
> > >         __le16 wOutputRegister;
> > >         __le16 wMaxOutputLength;
> > >         __le16 wCommandRegister;
> > >         __le16 wDataRegister;
> > >         __le16 wVendorID;
> > >         __le16 wProductID;
> > >         __le16 wVersionID;
> > >         __le32 reserved;
> > > } __packed;
> > >
> > > whereas in my driver, I have:
> > >
> > > struct cyttsp5_hid_desc {
> > >         __le16 hid_desc_len;
> > >         u8 packet_id;       <-- Different
> > >         u8 reserved_byte;   <-- Different
> > >         __le16 bcd_version;
> > >         __le16 report_desc_len;
> > >         __le16 report_desc_register;
> > >         __le16 input_register;
> > >         __le16 max_input_len;
> > >         __le16 output_register;
> > >         __le16 max_output_len;
> > >         __le16 command_register;
> > >         __le16 data_register;
> > >         __le16 vendor_id;
> > >         __le16 product_id;
> > >         __le16 version_id;
> > >         u8 reserved[4];
> > > } __packed;
> > >
> > > Have you already seen devices that are "HID compatible" with a different
> > > HID descriptor's content like this?
> >
> > That seems like a violation of Microsoft I2C HID protocol:
> > https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/dn642101(v=vs.85)
> > How do Cypress devices work in Windows? Might they have a compatible
> > firmware?
>
> I do not know how it works on Windows, actually.
> The datasheet indicates that it is based on HID specification. I guess
> it is not "HID compliant" as I was thinking while reading it.
>
> "Packet Interface Protocol (PIP) is a command and response-based
> communication protocol used to communicate with the
> TrueTouch device over the physical communication interface. PIP is
> modeled after Microsoft’s HID over I2C protocol specification, version
> 1.00. However, PIP extends the functionality of HID over I2C protocol
> to support both I2C and SPI physical communication interfaces, raw
> data extraction, self-tests, bootloading, and configuration data
> programming."
>
> >
> > In any case, for all I2C HID things Benjamin (CCed) is your guy.
>
> Okay, thanks.
> I am not so sure it is possible to use HID's drivers, now.

Well, we *could* detect this particular model if the `packet_id` and
the `reserved_byte` fields in place of the `bcd_version` differ from
what we normally expect on a HID descriptor.

I can imagine that we check on the bcd_version, if it's not 0x0100, we
can add a special case for this Cypress device by shifting the
descriptor, making sure we are dealing with this particular device,
and hopefully getting something we can handle now.

Cheers,
Benjamin
