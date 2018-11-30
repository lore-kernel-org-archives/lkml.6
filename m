Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6BA7C04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A53F20867
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 22:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ph2rZ+Jb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A53F20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbeLAJaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 04:30:18 -0500
Received: from mail.kernel.org ([198.145.29.99]:56072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726877AbeLAJaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 04:30:18 -0500
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 69FBF21479;
        Fri, 30 Nov 2018 22:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543616371;
        bh=LA/PfnhDfVkeFfga7qgRNkvrRtFx+kj5fkxfWxfssvs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ph2rZ+JbuYCfr8BIST2w3dwI394pHunTuvYQBUVnGXWNZNONfzSlNPjcmBKCLdBf+
         XECL5VDObcnWtpcik11R98AAbwy1IjzvJNMrm2b5kkFZRiUg7WD8f/BOktcuWwA4y/
         nXS1+0RVu1oclnkJfw95Y2BEgEr0ZxX+yZRZ2ib0=
Received: by mail-qt1-f172.google.com with SMTP id p17so7676869qtl.5;
        Fri, 30 Nov 2018 14:19:31 -0800 (PST)
X-Gm-Message-State: AA+aEWZOMK6Xa9wVQmsI8dRln9zip4Di+UL8ZGBHUFU9K4iJkSnnIzcS
        GUIbUH8BAGehP/MXtfwcZE2q7Me4yGXiJRXjoA==
X-Google-Smtp-Source: AFSGD/VXXa4a0RH1Z6bkkdMnhmHtDRywFcrPlAlUa3so6i/9Dvbo6/G/LHGaU5sPk4kf+XlEanij1LCKY1jS8jq455Y=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr7320505qvi.90.1543616370592;
 Fri, 30 Nov 2018 14:19:30 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com> <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com> <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181130210814.GA5756@amd>
In-Reply-To: <20181130210814.GA5756@amd>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 30 Nov 2018 16:19:18 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK4oaUTBemXiTZzLeOKOndQ_GZp2F7mJ0VzGEKVGHY20Q@mail.gmail.com>
Message-ID: <CAL_JsqK4oaUTBemXiTZzLeOKOndQ_GZp2F7mJ0VzGEKVGHY20Q@mail.gmail.com>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color properties
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 30, 2018 at 3:08 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > Pavel gave following examples:
> > >
> > > eth0:green:link
> > > adsl0:green:link
> > > adsl0:red:error
> > >
> > > So we would have e.g.:
> > >
> > > associated-vl42-device = <&camera1>;
> > > associated-network-device = <&phy1>;
> > > associated-block-device = <&phy1>;
> >
> > Variable property names are kind of a pain to parse.
>
> Ok, would it be enough to have associated-device = <&whatever>?

Yeah, but I though you needed the device type name in there.

> > Perhaps when LEDs are associated with a device, we shouldn't care
> > within the context of the LED subsystem what the name is. The
> > association is more important and if you have that exposed, then you
> > don't really need to care what the name is. You still have to deal
> > with a device with more than 1 LED, but that becomes a problem local
> > to that device.
> >
> > What I'm getting at is following a more standard binding pattern of
> > providers and consumers like we have for gpios, clocks, etc. So we'd
> > have something like this:
> >
> > ethernet {
> >   ...
> >   leds = <&green_led>, <&red_led>;
> >   led-names = "link", "err";
> > };
>
> Basically every single device could have a LED associated with it
> ("activity"). Would doing it like this mean we'd have to modify every
> single driver to parse leds / led-names properties?

Normally, that's how properties like this would work. A driver is also
what knows how the leds should function. A driver can retrieve the led
and associate it with the 'foo-bar' function. The 'foo-bar' function
then doesn't have to be defined in DT nor exposed to userspace. It
wouldn't even have to be driver specific. The driver's subsystem could
handle it all if the led functions are standardized. Though then you'd
be back to needing standard names for 'led-names', but that's no worse
that trigger names. This model would also allow getting rid of
'linux,default-trigger' properties in a lot of cases which wouldn't be
a bad thing.

However, having drivers handle this is not required. You can iterate
thru the tree for nodes with 'leds' and find the node which has a
phandle to the led node you care about. Sure, it's not that efficient,
but it does work and it's only done once. Basically, as long as the
linkage is there, we can make it work. I think using
'associated-device' might work better for the current implementation
of Linux LED support, but leds/led-names would be more inline with
other DT bindings. The current Linux implementation shouldn't dictate
the binding design.

Rob
