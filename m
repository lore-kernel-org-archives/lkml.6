Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084B3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C066920864
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDu+9HGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C066920864
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729158AbeK2Gmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:42:52 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43991 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeK2Gmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:42:52 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so24643948otr.10;
        Wed, 28 Nov 2018 11:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fDV5hrcjvpW2qmfkLMEOOJJQbd2kl3YUQbhKBf+iljQ=;
        b=kDu+9HGon5n1nRxn95YYFnhYMXENaw5OMBBOlGcJM38xagVwjH46YUfF0j9ebd6e+8
         v0S6ZSAMasvQJr0deciPoDttoNfvmiVlBQabh1AMVwZOE7WGxntf6LPn5XG/tggZUDps
         BWrHpHiE2vRZuNpRdQMuvC2Pw+DveUi1xqsf/mOxEnJDxipC7HAOXdf7Ru0m1Vh8eegz
         9qqLzSwHm/SYMSwCBxDqdbvaI8zHpMJxXfYWxBs8mxDqUHo12QYjQrE/aTmNrxXtTH/m
         ta0xK+fCEHsWfv5939DkQlF9Uu98+vDwn7VMS2Nnn9XV33reH470y4ZDyfztiYH1K9uD
         fbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fDV5hrcjvpW2qmfkLMEOOJJQbd2kl3YUQbhKBf+iljQ=;
        b=J6O3OLv2CSgDkVu+FDIEjtQfNcyXtQ+ZqBNXn+b7AtrYaJnBJMTkfZiDHPOAOl3lpB
         NjeL7GIBHMPyc5OCyWe6Ew0WtsM2TQvt/rIpm8a9IXxmRumXe5p1fCnC41SWqvw4WnkX
         Pim/4SBiWTCgRaDtpm6oGQUrFS33y6zyG9R68Qj3nF8o+4CKv5eLTEYd/ev8hLSqiZtj
         7ihodEyZkYpZXCvAXZ5+fiu/grwL0VoxZ8xXxH4rZFV+wJV5l+Fyb/Z3WEyPD14gBfyP
         B8BOEMBMJyTsbJQ2O1+E2KhHhnpCyhSkuQUR5yuOjX7o4oonLrlFW9Ke2GFYgoqjhfEZ
         qOfw==
X-Gm-Message-State: AA+aEWZ6qTsghQV7ESUHvly/+35mWuP0GjkHsPP1Y/kjzogezwRxS7ou
        QQFBpGxI9klQaWShaVPrljYGTVLPxZdw2Ozs8MM=
X-Google-Smtp-Source: AFSGD/UPjdnk6RfqlsP6h1GWpTwrXM+g06l1dduhP6GlaAPotCOEW7q11UVNLEHnoeRpTqYT5iIDxagYs1hnyZPCwp8=
X-Received: by 2002:a9d:7e87:: with SMTP id m7mr23356645otp.225.1543434006921;
 Wed, 28 Nov 2018 11:40:06 -0800 (PST)
MIME-Version: 1.0
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-2-TheSven73@googlemail.com> <20181127075431.GG13965@kroah.com>
 <CAGngYiUL7bZVEehj4LGC2H+kv+Z4v_s=tG4uosOp1-Rc4_pGWw@mail.gmail.com>
 <20181128174238.GA4367@kroah.com> <CAGngYiXqscqVtSUkwwKGGweOgMm=E=W8nbxOXAbpeyYsk=5B0g@mail.gmail.com>
 <20181128183622.GA9236@kroah.com>
In-Reply-To: <20181128183622.GA9236@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Wed, 28 Nov 2018 14:39:55 -0500
Message-ID: <CAGngYiXYVoesCQyf4+trM1V4ydwasrZnx_CqSDzQGHM-v81ZZA@mail.gmail.com>
Subject: Re: [PATCH anybus v4 1/7] fieldbus_dev: add Fieldbus Device subsystem.
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

On Wed, Nov 28, 2018 at 1:36 PM Greg KH <gregkh@linuxfoundation.org> wrote:

> So you still need a char device, and you will have have a load of them,
> just use the misc device api.  It's simple, clean, and is hard to get
> wrong.  The cdev api is hard, complex, and trivial to get wrong in any
> number of different ways that it can be used :)

Awesome little nugget! These things you just can't tell by reading the kernel
tree. In many cases, it's not immediately obvious to me which of the various
methods are 'recommended', and which ones are historic leftovers.

> And your /sys/class/fieldbus_dev/ is "interesting", why name it that?

Not sure why it's interesting? I figured it would allow userspace to enumerate
all fieldbus devices simply by going to /sys/class/fieldbus_dev/ and process
every subdirectory.

Example with 3 fieldbus cards:
/sys/class/fieldbus_dev/fieldbus_dev0/name etc
/sys/class/fieldbus_dev/fieldbus_dev1/name etc
/sys/class/fieldbus_dev/fieldbus_dev2/name etc

Is there a better way?

> So keep submitting, I'll try to review it the next time around, and all
> should be fine.  But keep your user api as simple as possible for now,
> only doing what you need it to do, worry about future stuff then.

Thanks, that's awesome !!

I figured that I should take baby steps. I simplified the userspace API to the
absolute bare minimum. To the point that the profinet card isn't useable in
our company's specific use case, because there's no configuration API yet.

> Why not just /sys/class/fieldbus/ ?  No need for "dev", right?

Good question... Two very different classes of devices sit on a fieldbus:
Fieldbus device     is like a slave
Fieldbus controller is like a master

This subsystem is specific for fieldbus *devices*. I figured I'd encode this
in the API name, in case someone wants to support fieldbus controllers later.
