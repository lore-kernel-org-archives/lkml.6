Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F2DC282DE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1235A20989
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:31:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGSyGRIy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728412AbfAUHbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:31:24 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:40776 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfAUHbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:31:24 -0500
Received: by mail-ot1-f67.google.com with SMTP id s5so19723486oth.7;
        Sun, 20 Jan 2019 23:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z7cwIIFCDeiBXJV7wMIg6kFFBZTvqOc38vm9IOMy8AU=;
        b=nGSyGRIyw48sco31OK/x12HcF+eTUsOg5SNTPGiMBsHxf8vsgva18nTDtv8O0b34fX
         lCA7TDOiX+69xneROnNzSZLs+A6m5L5htN+qeONB5vZVJxADJVb6pQtiQ+XYsp4RW3Wi
         3tUjPv5386RbU61q88GQgAAq1BHVihoifsu2e0Y7XDbpQQ+6rQSYHKpQkeVkGaXQw8Zf
         0sFmpxN/NZhwMYs1CuhtfA2pBYFh85HVkGRzgAMAAObFIyiuRByYBi4LDiaKZb+Ss1Qp
         ls2gCcfTA+aA/QQZNxSY5bGSJNMoECCxgmAok+DUxLKXhEhXhFC5aCoLjWZdvRv4zS1S
         KP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z7cwIIFCDeiBXJV7wMIg6kFFBZTvqOc38vm9IOMy8AU=;
        b=KW3Dv5eKCn/w0HDMO+m1fdPUtvtyNAIuS6dxqnv/AogbF3T0/pM4sf6SCVne+jVE3R
         YoFKTbiLPar312QGlktxQNLsB9dXn8+fH/kTXb0BtjgOySGYKGWf64nd51fcGkRbqRWL
         HYc7NZniXq48wEKKjSBZDFlpyD2nDrlsvFsG6lUIO0FdlsA8w9iaC4UgGFncxV9RT3Yd
         8gDcorM3G4z6DzFATFKc1DF0QO9usbkshZ2zQ/8tMJjSlwXlC33NW0qIOfCgRMhUOwlw
         45RnSlRMFwoClnpPjnMuAOgwPsWBqmpBJx7AWA7h8WgKMs2Bq9ptGErkb0tMbkNonq2d
         l1XQ==
X-Gm-Message-State: AJcUukesqylMoreFknMaw3rXRKDluWXhXL3yI4PVlzaYITNVNdjj3bY8
        wy2uH8IM4CvcfreITQADc04Oj+f+quuexEYO9ZffK99S
X-Google-Smtp-Source: ALg8bN41eNYfRqouJoiXoRAEiotaTbLd4Y9vJ9HditckxF/gki9GnkrcBBW0s+TQ7pXvTaw18ubDdxTPo9GdVdNWVAc=
X-Received: by 2002:a9d:3464:: with SMTP id v91mr19841101otb.102.1548052667678;
 Sun, 20 Jan 2019 22:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20190113181808.5768-1-linux.amoon@gmail.com> <CAFBinCCD4o0cXEht_7bgV6moCK2WfVRvZq8UUZD3gDo-TaRKbQ@mail.gmail.com>
 <CANAwSgQNNRqr3rZRgr71iy7+0zuuYykd+4-1W3LB+Voux6KioQ@mail.gmail.com> <CAFBinCCXufowepJaHgkPwhhNrogXDP-0x0ZS09OGCM=ua-=5MQ@mail.gmail.com>
In-Reply-To: <CAFBinCCXufowepJaHgkPwhhNrogXDP-0x0ZS09OGCM=ua-=5MQ@mail.gmail.com>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Mon, 21 Jan 2019 12:07:33 +0530
Message-ID: <CANAwSgR6gGGx6RgAszwHp+FYeJTdBvMAzc4p4TNpWnFXdxDf4w@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: meson8b: odroidc1: Enable usb phy node
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Emiliano Ingrassia <ingrassia@epigenesys.com>
Content-Type: multipart/mixed; boundary="00000000000059ee3c057ff219c0"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000059ee3c057ff219c0
Content-Type: text/plain; charset="UTF-8"

Hi Martin,

Thanks for you comments.

On Mon, 21 Jan 2019 at 03:21, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Anand,
>
> On Sun, Jan 20, 2019 at 7:44 PM Anand Moon <linux.amoon@gmail.com> wrote:
> >
> > Hi Martin,
> >
> > Thanks for your review comments.
> >
> > On Sat, 19 Jan 2019 at 03:59, Martin Blumenstingl
> > <martin.blumenstingl@googlemail.com> wrote:
> > >
> > > Hi Anand,
> > >
> > > thank you for this patch!
> > >
> > > On Sun, Jan 13, 2019 at 7:18 PM Anand Moon <linux.amoon@gmail.com> wrote:
> > > >
> > > > Add missing vbus-supply link to phy controller for usb_phy0
> > > > and usb_phy1 nodes, this changes fixed the power issue
> > > > on usb ports usb, changes help fix usb reset warning.
> > > I trust you on the fact that GPIOAO_5 controls VBUS of USB0 and USB1
> > >
> > > to me the schematics are not 100% clear or I'm bad at interpreting them:
> > > - I'll refer to odroid-c1+_rev0.4_20150615.pdf
> > > - page 1 lists GPIOAO.BIT5 as input for the PWREN signal of the
> > > USB_OTG controller (usb0)
> > > - page 1 also shows a PWREN signal in the USB_HOST controller (usb1)
> > > but not it's input
> > > - based on your patch I assume that PWREN is the same signal for both
> > > USB controllers
> > >
> > As per the schematics odroid-c1+_rev0.4_20150615.pdf
> >
> > It seem that their  vbus setting for *OTG* port. *Bus 01.Port 1* using
> > *GPIOAO.BIT5* gpio
> that matches my interpretation of the schematics

Yep, I feel that GPIOAO.BIT5 enable the PWREN power on  Bus 02.Port (usb1)
But I could not get this to enable on Bus 01.Port (usb0).

usb hot-plug of devices is working fine on *usb1* but not on *usb0*.
I have tried different combination but it's not working for me.

I am attaching small changes to phy which enables the Bus 01.Port
(usb0) on Odroid C1+/Odroidc2.
we need to set dr_mode="otg" to enable this bus in dts.

>
> > But we also need set power supply for *USB_B* port. *Bus 02.Port 1* ?
> > I don't know but I will try to find solution.
> I assume we also have to enable VBUS for the host only port, but I
> don't know how
>
> > We need to enable some bit in phy driver ?
> I'm not aware of any bit in the PHY driver which can toggle VBUS
>
> (trying to be creative here) maybe the GPIO is incorrectly configured
> to pull up or down?

I have tried this but no luck.

> if you want me to compare anything: there's some Armbian image (where
> the USB host ports are working fine) on the eMMC of my Odroid-C1 so I
> can get you the values you're looking for
>
> > > > [  821.991470] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > > [  825.243385] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > > [  828.151310] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > > [  830.991241] usb 1-1.2: reset high-speed USB device number 3 using dwc2
> > > >
> > > > Fixes: 2eb79a4d15ff (ARM: dts: meson: enabling the USB Host controller on Odroid-C1/C1+ board)
> > > you already split your original patch into two, however I suggest
> > > splitting these patches differently:
> > > - this one (personally I would choose "ARM: dts: meson8b: odroidc1:
> > > fix USB VBUS supplies" as title), which contains the Fixes tag, adds
> > > the "usb_vbus" and references it in the "usb0" and "usb1" nodes
> > > - enables usb0_phy and usb0 as part of your second patch (I would call
> > > that "ARM: dts: meson8b: odroidc1: enable the OTG capable USB
> > > controller")
> >
> > Ok I will fix this as per you suggestion in the next version.
> >
> > >
> > > > Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> > > > Cc: Jerome Brunet <jbrunet@baylibre.com>
> > > > Cc: Neil Armstrong <narmstrong@baylibre.com>
> > > > Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> > > > ---
> > > > Rebased on Kevin's amlogic/v5.0/fixes branch
> > > >
> > > > [alarm@archl-c1t ~]$ lsusb -t
> > > > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> > > >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> > > >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> > > >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> > > >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> > > >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> > > >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> > > > [alarm@archl-c1t ~]$
> > > > [alarm@archl-c1t ~]$ lsusb -v|egrep "^Bus|MaxPower"
> > > > Couldn't open device, some information will be missing
> > > > Bus 001 Device 003: ID 1b71:0056 Fushicai
> > > >     MaxPower              500mA
> > > > Couldn't open device, some information will be missing
> > > > Bus 001 Device 004: ID 152d:0578 JMicron Technology Corp. / JMicron USA Technology Corp. JMS567 SATA 6Gb/s bridge
> > > >     MaxPower               30mA
> > > > Couldn't open device, some information will be missing
> > > > Couldn't open device, some information will be missing
> > > > Bus 001 Device 002: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
> > > >     MaxPower              100mA
> > > > Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
> > > >     MaxPower                0mA
> > > > ---
> > > >  arch/arm/boot/dts/meson8b-odroidc1.dts | 23 +++++++++++++++++++++++
> > > >  1 file changed, 23 insertions(+)
> > > >
> > > > diff --git a/arch/arm/boot/dts/meson8b-odroidc1.dts b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > > index 0f0a46ddf3ff..a49a8509b288 100644
> > > > --- a/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > > +++ b/arch/arm/boot/dts/meson8b-odroidc1.dts
> > > > @@ -83,6 +83,19 @@
> > > >                 regulator-max-microvolt = <5000000>;
> > > >         };
> > > >
> > > > +       usb_vbus: regulator-usb-vbus {
> > > please add a comment here with some details about the regulator and
> > > add a hint that the signal in the schematics is called "PWREN"
> > Ok I will add this comment in the next patch.
> > >
> > > > +               compatible = "regulator-fixed";
> > > > +
> > > > +               regulator-name = "USB_VBUS";
> > > > +               regulator-min-microvolt = <5000000>;
> > > > +               regulator-max-microvolt = <5000000>;
> > > > +
> > > > +               vin-supply = <&p5v0>;
> > > > +
> > > > +               gpio = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> > > > +               enable-active-high;
> > > > +       };
> > > > +
> > > >         tflash_vdd: regulator-tflash_vdd {
> > > >                 /*
> > > >                  * signal name from schematics: TFLASH_VDD_EN
> > > > @@ -293,8 +306,18 @@
> > > >         pinctrl-names = "default";
> > > >  };
> > > >
> > > > +&usb0_phy {
> > > > +       status = "okay";
> > > > +       vbus-supply = <&usb_vbus>;
> > > > +};
> > > > +
> > > >  &usb1_phy {
> > > >         status = "okay";
> > > > +       vbus-supply = <&usb_vbus>;
> > > > +};
> > > > +
> > > > +&usb0 {
> > > > +       status = "okay";
> > > >  };
> > > I believe there's a problem with the usb/usb_phy nodes here. on my
> > > Odroid-C1 this results in:
> > > # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
> > >    USB_VBUS                      0    0      0 unknown  5000mV     0mA
> > >  5000mV  5000mV
> > > (open count is 0)
> > >
> > > if I move "vbus-supply" to the "usb1" node (just as an example) then I get:
> > > # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
> > >    USB_VBUS                      1    1      0 unknown  5000mV     0mA
> > >  5000mV  5000mV
> >
> > Sorry for the mixing the vbus-supply node.
> >
> > After fix the phy driver code and dts changes I am getting this changes.
> > # cat /sys/kernel/debug/regulator/regulator_summary | grep USB_VBUS
> >     USB_VBUS                      1    2      0 unknown  5000mV
> > 0mA  5000mV  5000mV
> >
> > Now I am able to enable both *Bus 01.Port 1* and *Bus 02.Port 1*
> >
> > # lsusb -t
> > /:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> >     |__ Port 1: Dev 2, If 0, Class=Hub, Driver=hub/4p, 480M
> >         |__ Port 1: Dev 4, If 0, Class=Mass Storage, Driver=usb-storage, 480M
> >         |__ Port 3: Dev 3, If 0, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 3, If 1, Class=Video, Driver=uvcvideo, 480M
> >         |__ Port 3: Dev 3, If 2, Class=Audio, Driver=snd-usb-audio, 480M
> >         |__ Port 3: Dev 3, If 3, Class=Audio, Driver=snd-usb-audio, 480M
> so this is the host-only controller (usb1) and it's working fine for
> you - very nice!
>
> > /:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=dwc2/1p, 480M
> >
> > But not usb device are getting enable on *Bus 01.Port 1*
> so you have something plugged into the OTG capable controller (usb0)
> using an OTG cable?

Yes I have connected USB-OTG cable with storage device attached,
led lights on the device is blinking, but no power to the port is enable.
so not hotplug of device is working on this port.

> I've not tried this before on my Odroid-C1 because I'm using the micro
> USB connector to power the board

Correct me if I am wrong, we need to tune USB phy driver to enable as
power the board ?

>
> do you get VBUS (maybe you have a USB thumb drive with an LED which
> lights up when you connect it)?
> do you get any errors or warnings from the dwc2 driver during boot?
>

Please find the boot log of my Odroid C1+ here
[0]: https://pastebin.com/PiDmVmEC

I dont see any major error on usb side.

> > >
> > > unfortunately neither your original patch nor the modified version
> > > seem to enable USB VBUS on my Odroid-C1.
> > > I have documented my findings already back in December, see "USB
> > > issues on Odroid-C1" [0]
> > > help on that would be highly appreciated :)
> > >
> > > on which board revision have you tested this patch?
> > >
> >
> > I have with me for testing
> >
> > ODROID-C0 REV 0.4 20151217
> > ODROID-C1+ REV 0.4 20150615 ----> current testing on
> I have the exact same Odroid-C1+ board revision
> this is my u-boot version:
> U-boot-00000-gb7b8dc2-dirty(odroidc@b7b8dc21) (Sep 01 2017 - 01:18:22)
> -> b7b8dc21 is the lastest commit of the hardkernel odroidc-v2011.03
> u-boot branch at the time of writing
>

I am using the the u-boot from archlinux.
If their is another u-boot for Odroid c1 plz let me know, I will try
to install this on my system.

Thanks for your input.

>
> Regards
> Martin

--00000000000059ee3c057ff219c0
Content-Type: application/octet-stream; name="otgbusport0.patch"
Content-Disposition: attachment; filename="otgbusport0.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jr5xh54n0>
X-Attachment-Id: f_jr5xh54n0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uOGItdXNiMi5jIGIvZHJp
dmVycy9waHkvYW1sb2dpYy9waHktbWVzb244Yi11c2IyLmMKaW5kZXggOWMwMWI3ZTE5YjA2Li4x
MzMzYzc3ZTkxNzIgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uOGIt
dXNiMi5jCisrKyBiL2RyaXZlcnMvcGh5L2FtbG9naWMvcGh5LW1lc29uOGItdXNiMi5jCkBAIC0x
MDksNiArMTA5LDcgQEAKIAogI2RlZmluZSBSRVNFVF9DT01QTEVURV9USU1FCQkJCTUwMAogI2Rl
ZmluZSBBQ0FfRU5BQkxFX0NPTVBMRVRFX1RJTUUJCQk1MAorI2RlZmluZSBEQ0RfRU5BQkxFX0NP
TVBMRVRFX1RJTUUJCQkxMAogCiBzdHJ1Y3QgcGh5X21lc29uOGJfdXNiMl9wcml2IHsKIAl2b2lk
IF9faW9tZW0JCSpyZWdzOwpAQCAtMTg4LDYgKzE4OSwyMCBAQCBzdGF0aWMgaW50IHBoeV9tZXNv
bjhiX3VzYjJfcG93ZXJfb24oc3RydWN0IHBoeSAqcGh5KQogCiAJCXVkZWxheShBQ0FfRU5BQkxF
X0NPTVBMRVRFX1RJTUUpOwogCisJCWlmIChwaHlfbWVzb244Yl91c2IyX3JlYWQocHJpdiwgUkVH
X0FEUF9CQykgJgorCQkJUkVHX0FEUF9CQ19BQ0FfUElOX0ZMT0FUKSB7CisJCQlkZXZfd2Fybigm
cGh5LT5kZXYsICJVU0IgSUQgZGV0ZWN0IGZhaWxlZCFcbiIpOworCQkJY2xrX2Rpc2FibGVfdW5w
cmVwYXJlKHByaXYtPmNsa191c2IpOworCQkJY2xrX2Rpc2FibGVfdW5wcmVwYXJlKHByaXYtPmNs
a191c2JfZ2VuZXJhbCk7CisJCQlyZXR1cm4gLUVJTlZBTDsKKwkJfQorCX0gZWxzZSBpZiAocHJp
di0+ZHJfbW9kZSA9PSBVU0JfRFJfTU9ERV9PVEcpIHsKKwkJcGh5X21lc29uOGJfdXNiMl9tYXNr
X2JpdHMocHJpdiwgUkVHX0FEUF9CQywKKwkJCQkJICAgUkVHX0FEUF9CQ19EQ0RfRU5BQkxFLAor
CQkJCQkgICBSRUdfQURQX0JDX0RDRF9FTkFCTEUpOworCisJCXVkZWxheShEQ0RfRU5BQkxFX0NP
TVBMRVRFX1RJTUUpOworCiAJCWlmIChwaHlfbWVzb244Yl91c2IyX3JlYWQocHJpdiwgUkVHX0FE
UF9CQykgJgogCQkJUkVHX0FEUF9CQ19BQ0FfUElOX0ZMT0FUKSB7CiAJCQlkZXZfd2FybigmcGh5
LT5kZXYsICJVU0IgSUQgZGV0ZWN0IGZhaWxlZCFcbiIpOwo=
--00000000000059ee3c057ff219c0--
