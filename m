Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDA5C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20CBE206B7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:40:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dGFI4GJh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20CBE206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbeLEPkL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:40:11 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:41603 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728064AbeLEPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:40:08 -0500
Received: by mail-ot1-f68.google.com with SMTP id u16so19010022otk.8;
        Wed, 05 Dec 2018 07:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4LK8vKYxLML5UTUxdpvvd8+mGoJ+sEjvcv5rgExeQuQ=;
        b=dGFI4GJhkKAByB2Z3q7uY35ErMUo0hQch5V3GVtXUcwTfFFaF748JcmHDWpcvMnGhv
         NjBR09gxTL8kubfEOFa6Kaij/t+PJqFWE38/iICKeEQ0ZMj1xmoLdaJmQi2uHmkp6wgG
         it104JLwinyz/pANUMwaLW9LwxvbJpyeUnWfc/69LwyhD53rSDx/QJg6f4cNzSroed8W
         +KvTns4ptbdYph4ott1qrBDirAcjGdNW4q8R9pkdBkQ8v4sAtMiYOuj//PYTTs1nUjGv
         nDqlcfcsjDOH6Y5Zw1V158wxaYgFuO2TZReC+84KkF6HIidkDcdjlnu3Zj/+fY6q0glC
         /VLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4LK8vKYxLML5UTUxdpvvd8+mGoJ+sEjvcv5rgExeQuQ=;
        b=GDo+Kk0Wc9jo+YsFRyXHfcAyP4i/Dt8q8WGjLs6F/cpZexWXUiMB1XSXQXo80t/afi
         6stbt4Yi0t5yqzlDsEXOd6tKqwYw6BmWBmqrzmQBCA+sa89DR3BK8CGQYVLKzL4MrSgd
         EDacRKVYTF2Xe6IdvcUK3JOWZjSzRMgQqW2mpksCGOnnjde5RbsTnuUtyPmvVbAmp4Bj
         2cGqP39eXGu/P6YKbOaTDLWh8IqjVe0gvzg5Ao/yD6RV43tVaLs+hrRkY+Ht1G0g12Xt
         ALBuPPMDw07+G6M9Ts17kcmBslt1dnw6OFHpwefpskrHmDNyBHubpLv7tBeRdruLZaQ8
         vrMA==
X-Gm-Message-State: AA+aEWYvAwYIkSFm1Oat9caVsyCyJevhxksOwED0quIiq3VmvhRDKVn3
        tMCVshUAwaIX4wDUcBhPq82IvRHY9ibEGzd4h5g=
X-Google-Smtp-Source: AFSGD/UZGCC8SRrn0FQqr6zkB2wFIi5KvQl3dbhM2EK9XSc4dLyty7f6sIMvniXuttzNyxAzg3bsfWIDYs7phACHptc=
X-Received: by 2002:a9d:b8e:: with SMTP id 14mr14758930oth.279.1544024407901;
 Wed, 05 Dec 2018 07:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-2-TheSven73@googlemail.com> <20181205101659.GA27058@kroah.com>
In-Reply-To: <20181205101659.GA27058@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 5 Dec 2018 10:39:56 -0500
Message-ID: <CAGngYiXXrrqGxTt339EP53tschLgZ82eRGvGifHQw6pg=C88+Q@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] fieldbus_dev: add Fieldbus Device subsystem.
To:     gregkh@linuxfoundation.org
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg, thanks for the feedback!

On Wed, Dec 5, 2018 at 5:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> And why is this a class and not just a "normal" device and bus?  Devices
> live on busses, not generally as a class.  Can your devices live on
> different types of busses (USB, PCI, etc.)?

This patchset can be a bit confusing, because it doesn't just add support for a
single fieldbus device - it proposes a general fieldbus subsystem.

Fieldbus devices from different vendors can sit on the usb, i2c, pci, etc.
buse, but they all register as a fieldbus device, via fieldbus_dev_register(),
and show up as a fieldbus class member.

Userspace can then enumerate all fieldbus devices connected to the system by
looking at the class. Without having to know which bus they happen to be
connected to.

If there is an abstraction in Linux that's a better fit, I'm very open to
making changes.

Sven
