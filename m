Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA62C31680
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FC3C2085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 18:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="d2hFYPrc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728232AbfAUSwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 13:52:09 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:32957 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfAUSwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 13:52:08 -0500
Received: by mail-oi1-f196.google.com with SMTP id c206so15398845oib.0;
        Mon, 21 Jan 2019 10:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c4Qdvbhq4FregzhLmXioDiDeKpvujIGWY0sPKBoE3Lk=;
        b=d2hFYPrc2IB00e8YF7EyEKFWVOlsD7Fbz5IMTlcmDI2KG4SwMqTv94EFKFedDMoJFc
         WxFT+gTHOAIqUzkaSFJGdwx2oFLbLiyldFKgcSVvvisFwHbFFwux3RUx78rQ1a50O1VW
         J1UElIPx7CizNvwPpBnZAYUHDkB5hcCtibzArU5sPd94LNEXHBzTbB5xc28jWnOjMKIC
         Vrgkt7yvRTNr1RwS4oUEUaUC1u5Z7fFuoLUCXJTsz5pv5k07jOAgX18eNgMPkEflgwCR
         Dc6RfyuIfc1rI/58mrA66fLrquBhUewQdDlPYxZwzt8ECZOllG3lWa/pZJOcBiajdTHI
         7O7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c4Qdvbhq4FregzhLmXioDiDeKpvujIGWY0sPKBoE3Lk=;
        b=bG3dnvlbUsHtbFUxszliITld0Rb8d8nhMklb7LIMSR9/8fChEq+BQoPxjdFXliQZ/0
         +awmCi24rvciZ1gFQl+6L2DmxiTQwD3YY9CXlcv7c3hufQSpiYGldahbxUgEMADiiN5H
         WhHRvgt57WiYJ8nmR9QvI80aoNOl7QPg0XvniofWUSoO8rw/Aro9vcnf83u4XPGkSTli
         zsiT70mWSzY/PbjGgslNHuiBMhEMXqoRjRbpBZQ1xzFiQgBBqGeIV+Y981+CtNAebK3H
         hsSPaWSR89gmLB4eJZWlS0fdiQyzh8xlO6ZkG6dgQv4y9GRIEc6Pe3qpU1fUD4JXkIix
         ga2Q==
X-Gm-Message-State: AJcUukeCsNnjhGNbEEEHqgQC/4JZ7v/Zbb3bpV4cKUZ9FpgQXGzztuq1
        bvAFRNej3nj5L1XF1F7uTrDHDcnoAcgZ1nOcKD8=
X-Google-Smtp-Source: ALg8bN4k9BXEadxn7DLc1DZdhi1nqWJiDBPQ7PhFkcCZjtZaQEmndYXHxqc+n5xhQi0yOigBhQE0LuCGpHxIjFvcvik=
X-Received: by 2002:aca:4b48:: with SMTP id y69mr4958436oia.200.1548096727085;
 Mon, 21 Jan 2019 10:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com> <CAFBinCCD4o0cXEht_7bgV6moCK2WfVRvZq8UUZD3gDo-TaRKbQ@mail.gmail.com>
 <CANAwSgQNNRqr3rZRgr71iy7+0zuuYykd+4-1W3LB+Voux6KioQ@mail.gmail.com>
 <CAFBinCCXufowepJaHgkPwhhNrogXDP-0x0ZS09OGCM=ua-=5MQ@mail.gmail.com> <CANAwSgR6gGGx6RgAszwHp+FYeJTdBvMAzc4p4TNpWnFXdxDf4w@mail.gmail.com>
In-Reply-To: <CANAwSgR6gGGx6RgAszwHp+FYeJTdBvMAzc4p4TNpWnFXdxDf4w@mail.gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 21 Jan 2019 19:51:56 +0100
Message-ID: <CAFBinCBuQx+JVXzs4=+Ko++1CsEc5GqUX6+xUym=c25ZtLz3BA@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
To:     Anand Moon <linux.amoon@gmail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anand,

On Mon, Jan 21, 2019 at 7:37 AM Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Martin,
>
> Thanks for you comments.
>
> On Mon, 21 Jan 2019 at 03:21, Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> >
> > Hi Anand,
> >
> > On Sun, Jan 20, 2019 at 7:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > >
> > > Hi Martin,
> > >
> > > Thanks for your review comments.
> > >
> > > On Sat, 19 Jan 2019 at 03:59, Martin Blumenstingl
> > > <martin.blumenstingl@googlemail.com> wrote:
> > > >
> > > > Hi Anand,
> > > >
> > > > thank you for this patch!
> > > >
> > > > On Sun, Jan 13, 2019 at 7:18 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > > >
> > > > > Add missing vbus-supply link to phy controller for usb_phy0
> > > > > and usb_phy1 nodes, this changes fixed the power issue
> > > > > on usb ports usb, changes help fix usb reset warning.
> > > > I trust you on the fact that GPIOAO_5 controls VBUS of USB0 and USB1
> > > >
> > > > to me the schematics are not 100% clear or I'm bad at interpreting them:
> > > > - I'll refer to odroid-c1+_rev0.4_20150615.pdf
> > > > - page 1 lists GPIOAO.BIT5 as input for the PWREN signal of the
> > > > USB_OTG controller (usb0)
> > > > - page 1 also shows a PWREN signal in the USB_HOST controller (usb1)
> > > > but not it's input
> > > > - based on your patch I assume that PWREN is the same signal for both
> > > > USB controllers
> > > >
> > > As per the schematics odroid-c1+_rev0.4_20150615.pdf
> > >
> > > It seem that their  vbus setting for *OTG* port. *Bus 01.Port 1* using
> > > *GPIOAO.BIT5* gpio
> > that matches my interpretation of the schematics
>
> Yep, I feel that GPIOAO.BIT5 enable the PWREN power on  Bus 02.Port (usb1)
> But I could not get this to enable on Bus 01.Port (usb0).
>
> usb hot-plug of devices is working fine on *usb1* but not on *usb0*.
> I have tried different combination but it's not working for me.
>
> I am attaching small changes to phy which enables the Bus 01.Port
> (usb0) on Odroid C1+/Odroidc2.
> we need to set dr_mode="otg" to enable this bus in dts.
I need to get my multimeter out and measure on my own Odroid-C1
I *believe* to have observed that toggling GPIOAO.BIT5 changes the
voltage at at the OTG port, but it's been a few weeks since then...
let me know if you want me to do the measurements on my Odroid-C1+ again

> > > But we also need set power supply for *USB_B* port. *Bus 02.Port 1* ?
> > > I don't know but I will try to find solution.
> > I assume we also have to enable VBUS for the host only port, but I
> > don't know how
> >
> > > We need to enable some bit in phy driver ?
> > I'm not aware of any bit in the PHY driver which can toggle VBUS
> >
> > (trying to be creative here) maybe the GPIO is incorrectly configured
> > to pull up or down?
>
> I have tried this but no luck.
OK, too bad

[...]
> > > After fix the phy driver code and dts changes I am getting this changes.
> > > # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
> > >     USB_VBUS                      1    2      0 unknown  5000mV
> > > 0mA  5000mV  5000mV
> > >
> > > Now I am able to enable both *Bus 01.Port 1* and *Bus 02.Port 1*
> > >
> > > # lsusb -t
> > > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> > >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> > >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> > >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> > >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> > >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > so this is the host-only controller (usb1) and it's working fine for
> > you - very nice!
> >
> > > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > >
> > > But not usb device are getting enable on *Bus 01.Port 1*
> > so you have something plugged into the OTG capable controller (usb0)
> > using an OTG cable?
>
> Yes I have connected USB-OTG cable with storage device attached,
> led lights on the device is blinking, but no power to the port is enable.
> so not hotplug of device is working on this port.
thanks for confirming this!
can you please send an updated version of both patches? if you want
someone else to test and/or review the patches before they are applied
you can use the subject prefix "RFT PATCH n/m" or "RFC PATCH n/m" (RFT
means "request for testing", "RFC" means "request for comments")

> > I've not tried this before on my Odroid-C1 because I'm using the micro
> > USB connector to power the board
>
> Correct me if I am wrong, we need to tune USB phy driver to enable as
> power the board ?
so far I have seen two designs on Amlogic boards:
- VBUS is hardwired to +5V
- VBUS is controlled by a regulator/current limiting switch/etc. which
can be toggled using a GPIO

the PHY is involved in this because for the OTG port it senses the ID
line to decide whether the controller has to go into host or device
(peripheral) mode.
however, this part is not implemented in the mainline phy-meson8b-usb2
driver yet

in case someone is interested in *why* dwc2 doesn't do OTG on the
Amlogic SoCs yet - here are the notes from the top of my head:
- the dwc2 controller doesn't get an interrupt when switching between
host and peripheral mode
- instead the Amlogic vendor kernel has a timer which polls the PHY registers
- if the timer handler detects a "mode change" in the PHY registers it
changes the dwc2 mode
- however, in mainline the PHY can't notify the USB controller driver
(dwc2) to change the mode (yet)

> >
> > do you get VBUS (maybe you have a USB thumb drive with an LED which
> > lights up when you connect it)?
> > do you get any errors or warnings from the dwc2 driver during boot?
> >
>
> Please find the boot log of my Odroid C1+ here
> [0]: https://pastebin.com/PiDmVmEC
>
> I dont see any major error on usb side.
that looks very good indeed. as I already mentioned above: please send
an updated version of the patches so I can try to reproduce your test
results!

> > > > on which board revision have you tested this patch?
> > > >
> > >
> > > I have with me for testing
> > >
> > > ODROID-C0 REV 0.4 20151217
> > > ODROID-C1+ REV 0.4 20150615 ----> current testing on
> > I have the exact same Odroid-C1+ board revision
> > this is my u-boot version:
> > U-boot-00000-gb7b8dc2-dirty(odroidc@b7b8dc21) (Sep 01 2017 - 01:18:22)
> > -> b7b8dc21 is the lastest commit of the hardkernel odroidc-v2011.03
> > u-boot branch at the time of writing
> >
>
> I am using the the u-boot from archlinux.
> If their is another u-boot for Odroid c1 plz let me know, I will try
> to install this on my system.
I don't remember where I got my u-boot version from.
maybe I should switch to the Arch Linux ARM one instead (so I'm back
to a well-known state). but let's wait for the test results from your
updated patches first.


Regards
Martin
