Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5052BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F393420835
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 09:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="F71TO2/2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F393420835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbeJJQ6B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 12:58:01 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:33122 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJJQ6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 12:58:00 -0400
Received: by mail-it1-f194.google.com with SMTP id h6-v6so15595377ith.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wWQakzbU9Qzis9UPCqPf26XF/Uq9wf2e0KdctGoJRUY=;
        b=F71TO2/2nqgpMNeVxk9mRJo9yX74nFevcT1YC5TuliVTVyWXBztK1kNmfVdw0M2yS7
         jvTRTIgp0NXr1hD7WjEDp2AYNEIZIrY36aNUCwg35MVfHbh15Rcrgf8Oi/5iUOqpfNuF
         /vEI1Zr3SzXmRs/rRf8yRRZqdY2rYUasZxKI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wWQakzbU9Qzis9UPCqPf26XF/Uq9wf2e0KdctGoJRUY=;
        b=mko02p7xva0etZDShtz+UDzcoOkCcQRjg4cQtLCt/0a0RsktK/3WZFfW3V1PtpaHmZ
         7DVs0fx1NWIJ0lrqrZlqzJ9n25WLp5WphMnF2QF/IxxSueAiO0qaqXRk3D+5MK9uipOJ
         OOm51MCHXNdnroRb05dC7Fq14GAY0DVupMfJfnRA6xBzsKRbz8XJmAWaxysJlg19pBIw
         bKVJ2lyFdRtT2PZbJDXX9l06cfWJ4UWqsfVutkhH3flaxREnxUaMstkkV2mUdEHKZ8n7
         hxCgOBEKM2K9MpB3KDQEmc9o4ZuhbYkXQf0F2d3sHBSajUvQDX4Wk3pqM6Kc0du2xPLT
         5VmQ==
X-Gm-Message-State: ABuFfoiHgxCrf6Ez+w+EAdOTsdQi0caKYe8ngVbRYfiI56bNw/U97Qmt
        IoIP2nqZH7rQUd6Sxc61RX8/GBpnImMvUfwAbjzpzQ==
X-Google-Smtp-Source: ACcGV60y14KIrMiufCQ+WranYLRlxAXwOZUhkR2gu4fNVQ7CldiEzZFDnYJV0GI34KpXUHlD2FBnzSs7vdALQC4LF0A=
X-Received: by 2002:a02:9643:: with SMTP id c61-v6mr26540127jai.37.1539164200057;
 Wed, 10 Oct 2018 02:36:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180930122703.7115-1-johan@kernel.org> <CACRpkdaG-S-6LfCKgxz4jdbD=kRO7q7k_8FAHqsSNBPdC07iDA@mail.gmail.com>
 <20181005134014.GH3774@localhost>
In-Reply-To: <20181005134014.GH3774@localhost>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Oct 2018 11:36:28 +0200
Message-ID: <CACRpkdbxShE3XEXNaKoFKWgAUVGUHU8rf0KaYV44coucu4=cRA@mail.gmail.com>
Subject: Re: [PATCH 0/2] USB: serial: gpio line-name fix and FT232R CBUS gpio support
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, pados@pados.hu,
        Loic Poulain <loic.poulain@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 5, 2018 at 3:40 PM Johan Hovold <johan@kernel.org> wrote:
> On Mon, Oct 01, 2018 at 11:43:55AM +0200, Linus Walleij wrote:

> > The idea is to make it possible for userspace to look up a GPIO
> > on a chip by name, so if the gpiochip has a unique name,
> > and the line name is unique on that chip it should be good
> > enough.
>
> I haven't really had time do dig into this again, but is this also an
> issue with the chardev interface?
>
> I thought this was one of the things
> you wanted to get right with the new interface, so hopefully that's
> already taken care of.

It is always possible to use /dev/gpiochipN and offet M on
that gpiochip to pick a unique line. That is a unique offset
on a unique chip. The gpiochip also has a "label" which may
be something user-readable such as part numer, but the unique
string is its name such as "gpiochip0".

For symbolic look-up though, like a file has to have a unique
path, the name of the line should be unique.

It is allowed to have unnamed lines though, so it is only a
hint. While I would like all drivers to uniquely name their
lines in DT or ACPI, or using the .names array in the gpio_chip
struct, it cannot be enforced because of legacy support,
so many old systems had no names specified, and
the DT and ACPI properties to name lines were introduced
after the chardev actually.

All I enforce is that if names are added, they should be
unique.

What we *could* do is conjure a unique name per line if
the hardware description doesn't provice one... like
"line0", "line1", "line2"... "lineN" on the chip.

Should we add a patch like that? The only side effect
I can see if that maybe the footprint increase is not so
nice.

I had it in mind but it slipped of my radar. It would make
all lines always have unique names.

> If the flat name space is only an issue with the legacy interface we
> might get away with simply not using the line names in sysfs when a new
> chip flag is set (unless we can resue .can_sleep, but there seems to be
> some i2c devices already using line names).

Hm. So you mean it is bad that the exporting GPIOs in the old
sysfs brings out the line name in sysfs if the line is named.

I just want the sysfs to die, but yeah what you say makes
sense. I don't know if it's such a big issue, my focus has been
on making the chardev more appetizing and the sysfs
uncomfortably oldschool amongst users. This would make it
even more uncomfortable.

But I don't know if the old sysfs users actually use the line
names much?

Yours,
Linus Walleij
