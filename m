Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC528C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C71620850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uv3b73Ul"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C71620850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbeLCPn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:43:59 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43509 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeLCPn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:43:58 -0500
Received: by mail-qt1-f194.google.com with SMTP id i7so14192975qtj.10;
        Mon, 03 Dec 2018 07:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qbKtRVsSqvj/oG5dCIOO9l9S/nDq6xZ5rvOLPBisWws=;
        b=uv3b73UlNt8IYRWn20EjfNUc1rFNpZIZBAe0FwHiEjfhaKTT6rExvmN4aT+H4KGZhJ
         y7ornXT6hwkCVd27ztRhsGgvYgtHz068hI3OPLn8B6q3BBkj/jIasL0swg5vnYoimhUd
         DhQCX148CXtL23w2lOy3PjUMHFSz7Vmy5jdjmmV+u+DaxcKOVhQxXqgsUJod82RdjZPP
         0JTc9Nnrp1PzYKL7ri3V0sB923QoAFK8jTfbB93xGmb+lnB3NF4Q6PLFVvpLjHjC+oUK
         OoRg19n7gfuqIiv71Bxk4RZl2yl720eoc/AkY6XdIVOaIfw+1YSVviRquG9Kw1YBOQoN
         Ub/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qbKtRVsSqvj/oG5dCIOO9l9S/nDq6xZ5rvOLPBisWws=;
        b=EiGOk6xY3EJCzbq2I/YPmVsX5hugjZefe56s6/tNWM5RNkywCD4cowboVnbIekfIGe
         FYJvK3Pe1w1rtgWXoA6V8t2yK0feP//8l7IHw3fqXhU0neBpQr2RsixEbBsfdxmImv8S
         V6Co9wzJ5BJ7hQN2hHO3dJmV6e5vzWbiLaUEVg8onI4qjprvi5kNkgD7UScDHzZtespu
         URAuOSheYQam5eTYo5msH20OzLi3/yq/0DOUWGi2PTBtTtHjkKuxc6RCGZywZZoWq7vZ
         Qx+Xe1xrFhHypLWZsIhujdD0Ig+v/rxEVvRMdQ3Ol+lJZmsdII4wndAzzzPtuxf9wU1r
         1IjA==
X-Gm-Message-State: AA+aEWYtuy2MBRAQORIYn5d3CncMQ6Wt2hG8VuhdivcIDsVek0amLAGP
        d8IggsH0nH8HpNqVTV1Mba5lm0wMJFXZl08W8Tc=
X-Google-Smtp-Source: AFSGD/XkUMqMj9FrcpuuYh1LPKJm1Tf1aXAtYej4ROA6cd77A1QDTDaf1JNPhWYOVNuXAq+A1EIeZYIFrGDUQW6NRVk=
X-Received: by 2002:aed:3e49:: with SMTP id m9mr14650015qtf.99.1543851831458;
 Mon, 03 Dec 2018 07:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20181127132508.5501-1-fe@dev.tdt.de> <CAHp75VfFYJQzTv_oe8RKPo03-FLYHy6BkrKaG23svAKtC+jVBg@mail.gmail.com>
 <583ca922b4a877a4b0577994e40ddf5f@dev.tdt.de> <CAHp75VcKu4fhP8=NH7fgfSFCh6xdCLWrNLcsHSuWvMcW+irfmA@mail.gmail.com>
 <70e7b8e2346b9837273b5edce0524584@dev.tdt.de> <CAHp75VfSKz8sauUKq2pxUhQ6xvmX4UeOBw6eEA+71=NUyWES9g@mail.gmail.com>
 <51e0d3f36dc23de801f2fdfc990f6c23@dev.tdt.de>
In-Reply-To: <51e0d3f36dc23de801f2fdfc990f6c23@dev.tdt.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Dec 2018 17:43:39 +0200
Message-ID: <CAHp75VdEgm-=jHgJXz_mM6DZMnFVEeZW_es3VyL4L2V+khYWtg@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Add device driver for APU2/APU3 GPIOs
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Eckert.Florian@googlemail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 3, 2018 at 9:58 AM Florian Eckert <fe@dev.tdt.de> wrote:

> >> > Btw, is the statement in above email still actual? "...I can fix
> >> > required things."
> >
> >> Yes i will fix your hints tomorrow and send a v6 of my patchset.
> >> Thank you for your hints and time
> >> It would be nice if you could fix ACPI problemmatik.
> >
> > I would like to see the ACPI dump for that...
>
> See https://github.com/openwrt/openwrt/pull/1232#issuecomment-443224576
> In this comment Micha=C5=82 =C5=BBygowski appended to this thread the mis=
sing
> files you want to have.

Thanks!

So, let me clarify what we have:
 - some platforms are in the wild with old BIOS with broken ACPI tables
 - you still may fix the things for new BIOS version for all affected platf=
orms
 - you need to support both

Is this all correct?

For broken firmware you need to do the following:
 - create an MFD driver, which would instantiate GPIO and GPIO keys
support (at least)
 - create one of each above drivers w/o any DMI crap (should be done
as a part of MFD driver)

For fixed BIOS you need to add the following (example, not a fully
correct solution) at the level behind SB:

Scope (SB)
{
  Device(GPIO)
  {
           Name (_ADR, Zero)  // _ADR: Address
           Name (_HID, "AMDxxxx") // One ID per platform, so, APU2 :
1, APU 3: 1 =3D> 2 unique IDs, in this case no need to add neither _HRV
nor _UID
           Name (_HRV, 2)          // Other approach is to have one ID
but different _HRV: e.g. 2 for APU2, 3 for APU3
           Name (_UID, Zero)        // Another approach is to have one
device per community of pins and several _UID:s
           Name (_DDN, "AMD APU General Purpose Input/Output (GPIO) control=
ler")
           Method (_CRS, 0, NotSerialized)
           {
               Name (RBUF, ResourceTemplate ()
               {
                   Memory32Fixed (ReadWrite,
                       0xFED80000 // + offset + community0 offset
                       0x0000xxxx, // + size of the community0
                       )
...
                  Memory32Fixed (ReadWrite,
                       0xFED80000 // + offset + communityN offset
                       0x0000xxxx, // + size of the communityN
                       )
                   /* IRQ resource if needed and present on real HW */
                   Interrupt (ResourceConsumer, Level, ActiveLow, Shared, ,=
, )
                   {
                       0x000000xx,
                   }
               })
               Return (RBUF) /* \_SB_.GPIO._CRS.RBUF */
           }

           Method (_STA, 0, NotSerialized)
           {
               Return (0x0F)
           }
  }

  Device (BTNS)
  {
           Name (_HID, "PRP0001")
           Name (_DDN, "GPIO buttons device")
           Name (_CRS, ResourceTemplate () {
               GpioIo (
                   Exclusive,                  // Not shared
                   PullUp,                     // Pull up the line
                   0,                          // Debounce timeout
                   0,                          // Drive strength
                   IoRestrictionInputOnly,     // Only used as input
                   "\\_SB.GPIO",           // GPIO controller
                   0)                          // Must be 0
               {
                   x0,                         // GPIO pin offset in
corresponding controller for Button 0
                   x1,                         // for Button 1, and so on
...
               }
           })

           Name (_DSD, Package () {
               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
               Package () {
                   Package () {"compatible", "gpio-keys-polled"},
                   Package () {"poll-interval", 100},
                   Package () {"autorepeat", 1}
               },
               ToUUID("dbb8e3e6-5886-4ba6-8795-1319f52a966b"),
               Package () {
                   Package () {"button-0", "BTN0"},
                   Package () {"button-1", "BTN1"},
...
               }
           })

           // For more information about these bindings see:
           // Documentation/devicetree/bindings/input/gpio-keys-polled.txt
           // and Documentation/acpi/gpio-properties.txt.

           Name (BTN0, Package () {
               ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
               Package () {
                   Package () {"linux,code", 105},
                   Package () {"linux,input-type", 1},
                   Package () {"gpios", Package () {^BTNS, 0, 0, 1}}
               }
           })

  }
}

After updating firmware you would need just an ACPI ID table to be
added to the GPIO driver. MFD driver should not be enumerated at all.

--=20
With Best Regards,
Andy Shevchenko
