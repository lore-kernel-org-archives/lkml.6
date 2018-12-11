Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB5DC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A86F20851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 17:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544549278;
	bh=dwqK2tKwgQnPscC9YeC7ymqibML7h+WGcSdCOVkbTuM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1BTUWM3gi6fjtSYiQkOovd+AACez6fMGT282C+9b6CMkS2Btfno7G9grZlKBr8QAF
	 pOuPRWXKIX7jn4S2/0NE/C2JvMJ0cXQ4dKBdckgtLeO9uCzAcCcTJFKZ+mD2Oo2vkZ
	 1KRDU3pPEpLe9RYoGoRpPJV8OBdz4wxjFkdWdgwQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A86F20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbeLKR15 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 12:27:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:33492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbeLKR14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 12:27:56 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A82F208E7;
        Tue, 11 Dec 2018 17:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544549274;
        bh=dwqK2tKwgQnPscC9YeC7ymqibML7h+WGcSdCOVkbTuM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Op0YYhUj02LYPWdCTH0KtZn8FkhOn6Z/gWtCYFv8QnCAWj2OSNUUYpFFqwe6KSpLo
         bOq0FGq/4iSvDlJsxr2Aj6jRtvi0i3W+Qyqk5D4aa2LuZDGy9fkU8g+q4dsDmSZSXs
         ig+zRFIYBN8aTCXhVekIhQ5ioiccCBFw+nNE0OWs=
Received: by mail-qk1-f176.google.com with SMTP id n12so9036965qkh.11;
        Tue, 11 Dec 2018 09:27:54 -0800 (PST)
X-Gm-Message-State: AA+aEWZzaTm2NBzFEInpOn2rXCDg0BmPlMWYTtgZUj3PWleRG01tjaTf
        pAGshJyp8W2maQf2hnwniS5kjIlo+j74bLPPQw==
X-Google-Smtp-Source: AFSGD/XwlzAiPOBrjfdPJpXIRaUqkVkbrXSMV8u4qlU8iWw2cTQkUxTxBayxpWCiSzeTmhdmU65Tfe0tiNCYzd98MmU=
X-Received: by 2002:a37:5686:: with SMTP id k128mr14520681qkb.29.1544549273756;
 Tue, 11 Dec 2018 09:27:53 -0800 (PST)
MIME-Version: 1.0
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com> <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
 <0a0b176c-4eb4-4b0e-6c3c-b3c6c8f5fff5@gmail.com> <CAL_JsqKEpbJjExkQKSXwYma9wPPO+8E0QMTyWTPs1nkGSd49_g@mail.gmail.com>
 <20181130210814.GA5756@amd> <CAL_JsqK4oaUTBemXiTZzLeOKOndQ_GZp2F7mJ0VzGEKVGHY20Q@mail.gmail.com>
 <fa5add90-e1b7-d527-374f-175abdf88455@gmail.com>
In-Reply-To: <fa5add90-e1b7-d527-374f-175abdf88455@gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Dec 2018 11:27:41 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+EsTXghh-bEtBmQ3oXEW45RJZJEJ2Zn1z-LfhvhNiXnQ@mail.gmail.com>
Message-ID: <CAL_Jsq+EsTXghh-bEtBmQ3oXEW45RJZJEJ2Zn1z-LfhvhNiXnQ@mail.gmail.com>
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color properties
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
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

On Sat, Dec 1, 2018 at 3:17 PM Jacek Anaszewski
<jacek.anaszewski@gmail.com> wrote:
>
> On 11/30/2018 11:19 PM, Rob Herring wrote:
> > On Fri, Nov 30, 2018 at 3:08 PM Pavel Machek <pavel@ucw.cz> wrote:
> >>
> >> Hi!
> >>
> >>>> Pavel gave following examples:
> >>>>
> >>>> eth0:green:link
> >>>> adsl0:green:link
> >>>> adsl0:red:error
> >>>>
> >>>> So we would have e.g.:
> >>>>
> >>>> associated-vl42-device = <&camera1>;
> >>>> associated-network-device = <&phy1>;
> >>>> associated-block-device = <&phy1>;
> >>>
> >>> Variable property names are kind of a pain to parse.
> >>
> >> Ok, would it be enough to have associated-device = <&whatever>?
> >
> > Yeah, but I though you needed the device type name in there.
> >
> >>> Perhaps when LEDs are associated with a device, we shouldn't care
> >>> within the context of the LED subsystem what the name is. The
> >>> association is more important and if you have that exposed, then you
> >>> don't really need to care what the name is. You still have to deal
> >>> with a device with more than 1 LED, but that becomes a problem local
> >>> to that device.
> >>>
> >>> What I'm getting at is following a more standard binding pattern of
> >>> providers and consumers like we have for gpios, clocks, etc. So we'd
> >>> have something like this:
> >>>
> >>> ethernet {
> >>>   ...
> >>>   leds = <&green_led>, <&red_led>;
> >>>   led-names = "link", "err";
> >>> };
> >>
> >> Basically every single device could have a LED associated with it
> >> ("activity"). Would doing it like this mean we'd have to modify every
> >> single driver to parse leds / led-names properties?
> >
> > Normally, that's how properties like this would work. A driver is also
> > what knows how the leds should function.
>
> This is not true in case of associations where LED controller is
> an independent device, as in Pavel's example [0].

I'm not really following how the HDD example is different. The parent
of an LED would be the controller. The link to the led node would be
in the disk controller node. Though maybe if things get complicated
enough, we'd want to describe the drives or drive bays in DT.

> > A driver can retrieve the led
> > and associate it with the 'foo-bar' function. The 'foo-bar' function
> > then doesn't have to be defined in DT nor exposed to userspace. It
> > wouldn't even have to be driver specific. The driver's subsystem could
> > handle it all if the led functions are standardized. Though then you'd
> > be back to needing standard names for 'led-names', but that's no worse
> > that trigger names. This model would also allow getting rid of
> > 'linux,default-trigger' properties in a lot of cases which wouldn't be
> > a bad thing.
> >
> > However, having drivers handle this is not required. You can iterate
> > thru the tree for nodes with 'leds' and find the node which has a
> > phandle to the led node you care about.
>
> This way of discovering associations between devices and LEDs
> would be more reliable than by devicename part of LED class device
> as discussed previously.
>
> However, I've just tried to verify how it works, but
> I can't find the way to get the of_node phandle from sysfs.
>
> The "of_node" link in per-device dirs in /sys/devices point
> to the directories containing DT properties of the node, but
> I see no way to obtain the node phandle.

You probably don't want to be doing this in userspace. It's possible,
but you've got to read the 'leds' property to get the phandle and then
walk the tree to find the node with the matching phandle property
value (i.e. reimplement what the kernel does). You'd probably would
instead want to define a LED specific symlink sysfs attr either in the
associated device to the led device or vice versa.

Rob
