Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D651C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:51:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2ED8208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2ED8208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeLEWvG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:51:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40511 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727592AbeLEWvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:51:06 -0500
Received: by mail-qt1-f195.google.com with SMTP id k12so24261788qtf.7;
        Wed, 05 Dec 2018 14:51:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fc2wlGsV/6cnLR4lBPEfdEY3h9NpXDGasmQxPGH9Ikc=;
        b=bd13kP3Eq7jUapeJkgiGo+vHTE17dPcmdfddAFawRUXH9dzUNmX0ijXNtTa0dpxH2+
         8NOQRIHF8ZYHVP2vAz1e30t0XKiSALddXYJl3KjGNFMvSBIsEmBNvm4VWrLURyZmtjl/
         hhMh/vjvQTZEEmRpNZn9GBGkyEtzZlsmXHa3J/82ecsjLkzNe7rEU/YPliBctdMtXiiU
         1ICYvyRD+QcIWU7PU5VF1l+reuGLilPAm6jwz8DeHOQNvJv2ImjGWTcQxHhiF5XU7q7o
         n7671kSX0TX86c/CLhRvWHhUH8PWVWcv7rxm1D7gkX0lMzTVI7o618URThZ2F0x0pWWA
         xSgQ==
X-Gm-Message-State: AA+aEWYjPjXcYJSVFJjlVFKHYvzQGDe6IrWAR/QIUOGpwo6FWIZ1SwWp
        WUQNS7kLstStHWPYGO7TdHeoM6idbxIx3PnHgyI=
X-Google-Smtp-Source: AFSGD/V0799B0DUbiFWotroi+AHXadEjrZy3FnQHhbHCRsv4l2rASBpZvbZJ0qgor3nKMAb4Pl2q0hDo43C4aeRCb1U=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr6893786qtl.343.1544050265023;
 Wed, 05 Dec 2018 14:51:05 -0800 (PST)
MIME-Version: 1.0
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-2-TheSven73@googlemail.com> <20181205101659.GA27058@kroah.com>
 <CAGngYiXXrrqGxTt339EP53tschLgZ82eRGvGifHQw6pg=C88+Q@mail.gmail.com>
 <20181205191724.GA434@kroah.com> <CAGngYiWG74nDt1_hN0-bKCDRxm-f=N-Rnjtk02Vd7dgKtGRaBA@mail.gmail.com>
In-Reply-To: <CAGngYiWG74nDt1_hN0-bKCDRxm-f=N-Rnjtk02Vd7dgKtGRaBA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 5 Dec 2018 23:50:48 +0100
Message-ID: <CAK8P3a2+ehccfdD7kwo=ev6P7Oka7CqEiq6BgkjUafFRwgnTQQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] fieldbus_dev: add Fieldbus Device subsystem.
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     gregkh <gregkh@linuxfoundation.org>, svendev@arcx.com,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>, noralf@tronnes.org,
        Johan Hovold <johan@kernel.org>,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
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

On Wed, Dec 5, 2018 at 11:32 PM Sven Van Asbroeck <thesven73@gmail.com> wrote:
> On Wed, Dec 5, 2018 at 2:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Great, then call it a 'fieldbus' class, not "fieldbus_dev' class.
>
> Small nit:
>
> Hardware connected to a fieldbus comes in two distinct flavours:
> - clients (e.g. thermometer, robotic arm) called "fieldbus devices"
> - servers (e.g. a PLC) called "fieldbus controllers"
>
> Their userspace APIs will probably differ quite a lot.
>
> The userspace API created by the patch is only for clients a.k.a.
> "fieldbus devices". That's why I'm writing 'fieldbus_dev' all over the place.
>
> For simplicity, we could change that to just 'fieldbus'. But would this get
> us in trouble when, at some point, we want to add a userspace API for
> servers a.k.a. "fieldbus controllers" ?

In the long run, would you expect to support more devices or more
controllers that need a distinct driver? Whichever we have more of should
probably get the shorter name.

      Arnd
