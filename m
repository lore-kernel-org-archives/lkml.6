Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 821CEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B10920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 13:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B10920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbeKHXPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 18:15:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36908 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbeKHXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 18:15:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id 131so26441412qkd.4;
        Thu, 08 Nov 2018 05:40:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+WH+TBA+ttso5qoOGbz9K70Y5upwqCAShyaOWEC2UDY=;
        b=bXf2Tn2uth43+HStR3ENeRsyt7WgtPAimt6qa5aKkGVe5X140pc11OU++Pr9lxqhvF
         QZmk2BnXhwOSVQeM6J1aQ1HursmvADf52SDRKsERfvUUR0BdE5t62DN0QbNLJDEPaVyq
         yKqkOGvCwtRI5PtfOIuSs9ml0qxAKYY7god5qqD+q+HZ1XCtoqbV0UdA+UmgHlGfk0XT
         dmUGtK52sE/IGupJe8ZPW9c1Pt8ewKEKh14RGIjaQiOpJ2cqQ47h2erHol9gf6qUFPPa
         WZHRFTeah2w+SfReN7zuHdqHOz1+7Sh37r/Kz6yJexjY1SZMrfeuFHAwJeDMIUa4VLOO
         y/jQ==
X-Gm-Message-State: AGRZ1gJ3WQSm6ZqUODU3l+VQ9PmoJ4EltApkN57/PXbe1jx8umykyMRJ
        0dcOHgwiDysWrl2vkquj8cuos81Qi+b+SfjmDNY=
X-Google-Smtp-Source: AJdET5e/xfc1OPYep6gFh0BGqgWkJXtEQsyL8k0Cq44tNYu2qCTFVbRgCS/m60qi//qUIE4QAWruhPPB3NS4MN4H7Y4=
X-Received: by 2002:a37:4116:: with SMTP id o22-v6mr3927693qka.107.1541684416887;
 Thu, 08 Nov 2018 05:40:16 -0800 (PST)
MIME-Version: 1.0
References: <20181104155501.14767-1-TheSven73@googlemail.com>
 <20181104155501.14767-2-TheSven73@googlemail.com> <20181105212049.GA320@bogus>
 <CAGngYiUZTm-r0KJ07tKsPmgKCUWcqAOx2S82iLPRjkcDiw0R3g@mail.gmail.com>
 <CAL_JsqLgz9Z3J0x+QFU6jHOoHn6A1KASc+HbVLnW1=ow0RHv6w@mail.gmail.com>
 <CAGngYiXczK6dsfyDGxe1ym-vQQfH5XS0jeEkuWW_og23JmTAZg@mail.gmail.com>
 <CAL_Jsq+YeW+BtVh=L8PBjXYLj9sp91BcUQrJJrwnmChRnXoK_w@mail.gmail.com> <CAGngYiXfmD-EVKcN-L1fBOgyX4JrMqRx295F1p90shygL7zccg@mail.gmail.com>
In-Reply-To: <CAGngYiXfmD-EVKcN-L1fBOgyX4JrMqRx295F1p90shygL7zccg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 8 Nov 2018 14:40:00 +0100
Message-ID: <CAK8P3a3uS5wbNwmGGdYqEFdVi0ErzG7_6yaMheAACh6Tta+DZQ@mail.gmail.com>
Subject: Re: [PATCH anybus v3 1/6] misc: support the Arcx anybus bridge
To:     thesven73@gmail.com
Cc:     Rob Herring <robh@kernel.org>, svendev@arcx.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        gregkh <gregkh@linuxfoundation.org>,
        John Garry <john.garry@huawei.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Robin Murphy <robin.murphy@arm.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sebastien Bourdelin <sebastien.bourdelin@savoirfairelinux.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Stuart Yoder <stuyoder@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 9:05 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> On Tue, Nov 6, 2018 at 1:31 PM Rob Herring <robh@kernel.org> wrote:
>
> > If the host is not a h/w component, but just a s/w protocol then it
> > doesn't belong in DT. Perhaps it could be a library which the bridge
> > driver can call into.
>
> Anybus cards have an id register, which identifies what they are, so
> that the appropriate client driver may be instantiated.
> In that sense anybus is very suited to the bus/client abstraction of
> pci/usb/etc.
>
> > What are the resets connected to? The slots? Maybe you should model
> > the slots in DT.
> >
>
> Yes, the resets are ultimately connected to the slots.
> I'm happy to model the slots in DT. It makes sense, they are physical,
> hardware components.

It may also be necessary to have a way to add more DT properties to
a device in the slot that can not be probed by looking at the ID
register. Ideally it should not be needed, but we have added this
to most buses anyway: USB, PCI, MMC and others can all be
probed automatically for many devices, but there are some devices
that need a place where extra information can be stored, e.g.
an ethernet MAC address (in the absence of a PROM), an
external clock or reset line that is not part of the normal protocol,
or a more specific identification when two devices accidentally
have the same ID.

       Arnd
