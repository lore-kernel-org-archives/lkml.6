Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD81C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0D4221737
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qOA1Psyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0D4221737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbeHMSTc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:19:32 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38979 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728894AbeHMSTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:19:31 -0400
Received: by mail-lf1-f68.google.com with SMTP id a134-v6so11561832lfe.6;
        Mon, 13 Aug 2018 08:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RV4zV7apKDTCxySVWEy4vSZClgWR6/4lNK9weUozaGE=;
        b=qOA1Psyx5wFZHF/biYbCNpE1ax48d+yJtIHc9fhUZsVv0UMQI7mhTbsl/qgOY11xCl
         aHAOsTzA8xz358TSeEgZfvy+hlGKyQPVIebN4n4bwMacjchUxnuSag1BDif66C+p0PK0
         QG3AKqXLCIw+vKzPsBiQTFosFJZ9Q/XsWRqw46I+fsqMH9kKUIgBmkFdyOWYx0BWzQ7S
         p5ufvWMlpQ/mHaokhEZmrk9R4rIQWPTfs4CyMSz/VLXyf6eq5ILWgQDYFKGFt2o9znds
         iq6k3pmLdkQvlJZSYtSyOqCqpaOco/Ojj3EpuSJofm8u8oH5vLY/QeZZWlwf58MgYDwq
         5yTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RV4zV7apKDTCxySVWEy4vSZClgWR6/4lNK9weUozaGE=;
        b=uCvh+5+Zjy8Ku8fRWnLFknE/VL+gzmbUUpY5BmpyHvOFwfEcCBS6rQPFtDoTlltOAQ
         PKSg9oIhwhSUQbOymi1vsyuugcRuCPCw7PUBZxW+T4A68x7bxtoHJneTLdcVjIta/Qc5
         bOKuwjjQ+Ju6rz1hgcLVSnn3pJpYxwHtnJ2lFnsbjv/GryF4F7NZl5fqFp7cJ5QUNa6p
         bCMBslNXoUwp3t+Ro6c9vMt7DDxFrgmn2yieTS/vXESGh1cIqiEpsulKqf0iHICm5X10
         24SwclK//eUhLLCds2EN3kD7umpny1kpXn3XEJl05J5genMEq7nzLXM0CclttYFLruD9
         Wfxg==
X-Gm-Message-State: AOUpUlF96osz0JyULgfs/Y4trgXsvJV463jbE24h8gix28uytV3ZqsOF
        N4HHMX7qAlw+Xn/+x0j+LbcfCUIRFhf3B0OtqAQ=
X-Google-Smtp-Source: AA+uWPwz67D5uEwF1jpb2MeVIU03LSBpgz5KBfO5Cxg82l1Q8Tdl2rIhiwholOA9nouCJ5njvFhuJx0lf8WvJIugWno=
X-Received: by 2002:a19:be54:: with SMTP id o81-v6mr1875181lff.31.1534174604315;
 Mon, 13 Aug 2018 08:36:44 -0700 (PDT)
MIME-Version: 1.0
References: <20180703094309.18514-1-mylene.josserand@bootlin.com>
 <20180704162158.euiw2v3hyv3hzofn@penguin> <20180724150046.7d70786c@dell-desktop.home>
 <20180724174053.GA61165@dtor-ws> <20180813172358.71912d55@dell-desktop.home>
In-Reply-To: <20180813172358.71912d55@dell-desktop.home>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 13 Aug 2018 08:36:32 -0700
Message-ID: <CAKdAkRQQ27TNmDSSg5x4kGvhhBjRbM9G2Bv_1WBxAhYWNUkz1w@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] Input: Add Cypress Gen5 Touchscreen driver
To:     =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@bootlin.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Myl=C3=A8ne_Josserand?= 
        <mylene.josserand@free-electrons.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        lkml <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Myl=C3=A8ne,

On Mon, Aug 13, 2018 at 8:24 AM Myl=C3=A8ne Josserand
<mylene.josserand@bootlin.com> wrote:
>
> Hi Dmitry,
>
> On Tue, 24 Jul 2018 10:40:53 -0700
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
>
> > Hi Myl=C3=A8ne,
> >
> > On Tue, Jul 24, 2018 at 03:00:46PM +0200, Myl=C3=A8ne Josserand wrote:
> > > Hello Dmitry,
> > >
> > > On Wed, 4 Jul 2018 16:21:58 +0000
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > >
> > > > Hi Myl=C3=A8ne,
> > > >
> > > > On Tue, Jul 03, 2018 at 11:43:07AM +0200, Myl=C3=A8ne Josserand wro=
te:
> > > > > Hello,
> > > > >
> > > > > Here is a V6 series to add the driver of the touchscreen Cypress,
> > > > > TrueTouch Generation 5.
> > > > > Based on v4.18-rc3.
> > > > >
> > > > > This patch series has already been posted in several iterations:
> > > > >     - v1: Sent on 2017/05/29
> > > > >     - v2: Sent on 2017/08/18
> > > > >     - v3: Sent on 2017/09/27
> > > > >     - v4: Sent on 2017/12/01
> > > > >     - v5: Sent on 2017/12/20
> > > > >
> > > > > I did not have any comments the last 4 versions.
> > > > > And no reviews on my v5 during 6 months. Could I have any updates
> > > > > or feedback on my series to know why it is not merged (to be able=
 to
> > > > > correct what is wrong)?
> > > >
> > > > Sorry, I must have missed the v5, sorry about that.
> > > >
> > > > I probably asked this question before, but just to make sure - I se=
e
> > > > references to HID in the patch - the device is really not HID
> > > > compatible? Is there any hope it could be made work with i2c-hid +
> > > > hid-multitouch?
> > > >
> > > > Thanks.
> > > >
> > >
> > > I have checked and, for what I have seen, all the HID descriptor stuf=
f
> > > is HID compliant. We could definitely use i2c-hid and hid-multitouch
> > > (there is the "hid-cypress" driver that exists also).
> > >
> > > The only problem is that this touchscreen has two modes: a bootloader
> > > mode and an application mode (which is the one where we can send
> > > HID commands). After a power-on-reset, it is always in "bootloader"
> > > mode so we need to send some commands (called "bootloader commands") =
to
> > > switch to application mode.
> >
> > Is this a documented or observed behavior? In my practice devices (I am
> > talking in general, not about Cypress) that have proper configuration
> > loaded and that were brought up with appropriate power up sequence and
> > timings automatically switch to application mode. They only end up in
> > bootloader mode when proper power up sequence is not respected and they
> > are unhappy.
>
> I have checked and indeed, if everything is correctly performed, the
> bootloader has a timeout to switch to application mode.
> The datasheet says that this timeout can be configured and the "0" value
> means that the bootloader will never automatically switch to application
> unless a bootloader command is sent.
>
> In our case, you were right, after a timeout, the touchscreen is
> correctly switching to Application mode. Great news!
>
> >
> > > These commands are not HID-compliant as the
> > > datasheet indicates:
> > >
> > > "Bootloader commands are not HID-over-I2C compliant."
> >
> > Any chance you could share the datasheet?
>
> Sorry, it is not possible, the datasheet is under NDA :(
>
> >
> > >
> > > I think that if the touchscreen would start directly in "application"
> > > mode, we could directly use i2c-hid and hid-cypress drivers.
> > > Unfortunately, this is not the case.
> > >
> > > In bootloader mode, the ProductID is 0xc101 and in application mode, =
it
> > > is 0xc001 (already available in hid-ids.h:
> > > USB_DEVICE_ID_CYPRESS_TRUETOUCH but not handled)
> > >
> > > What would be the better approach here?
> > > Should I add a new product ID to detect the bootloader mode in
> > > hid-cypress driver and send non-HID commands to switch to
> > > "application" mode in this driver?
> > > Anyway, I guess that I will drop this cyttsp5 driver and update the
> > > existing one, right?
> >
> > So it still accessible through HID, even when in bootloader mode? OK,
> > then I guess there are 2 options:
> >
> > - if device is documented to always start in bootloader mode, you could
> >   have a small stub driver that switches it into application mode in it=
s
> >   probe() code. The "bootloader" device will disappear and
> >   "application" device will appear, and standard driver (hid-multitouch=
)
> >   will bind to it.
>
> Okay, I see. In our case, we do not have the timeout to 0 as after a
> moment, the application mode is automatically switched.
>
> >
> > - if device supposed to come up in application mode unless configuratio=
n
> >   is damaged: I'd recommend doing what we do on Chrome OS and have some
> >   userspace software that runs on boot (or whenever device is
> >   discovered) and check if it has the latest firmware/configuration, an=
d
> >   repair device if needed.
>
> I see.
>
> I tried to make the i2d-hid & hid-cypress working. This is not
> successful for the moment because I can not retrieve the correct
> bcdVersion. While debugging, I have noticed that the HID descriptors
> don't seem to be exactly the same:
>
> under i2c-hid.c:
>
> struct i2c_hid_desc {
>         __le16 wHIDDescLength;
>         __le16 bcdVersion;
>         __le16 wReportDescLength;
>         __le16 wReportDescRegister;
>         __le16 wInputRegister;
>         __le16 wMaxInputLength;
>         __le16 wOutputRegister;
>         __le16 wMaxOutputLength;
>         __le16 wCommandRegister;
>         __le16 wDataRegister;
>         __le16 wVendorID;
>         __le16 wProductID;
>         __le16 wVersionID;
>         __le32 reserved;
> } __packed;
>
> whereas in my driver, I have:
>
> struct cyttsp5_hid_desc {
>         __le16 hid_desc_len;
>         u8 packet_id;       <-- Different
>         u8 reserved_byte;   <-- Different
>         __le16 bcd_version;
>         __le16 report_desc_len;
>         __le16 report_desc_register;
>         __le16 input_register;
>         __le16 max_input_len;
>         __le16 output_register;
>         __le16 max_output_len;
>         __le16 command_register;
>         __le16 data_register;
>         __le16 vendor_id;
>         __le16 product_id;
>         __le16 version_id;
>         u8 reserved[4];
> } __packed;
>
> Have you already seen devices that are "HID compatible" with a different
> HID descriptor's content like this?

That seems like a violation of Microsoft I2C HID protocol:
https://docs.microsoft.com/en-us/previous-versions/windows/hardware/design/=
dn642101(v=3Dvs.85)
How do Cypress devices work in Windows? Might they have a compatible
firmware?

In any case, for all I2C HID things Benjamin (CCed) is your guy.

Thanks.

--=20
Dmitry
