Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44968C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0991E20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQ5lUhNC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbeLRAfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:35:00 -0500
Received: from mail-vk1-f196.google.com ([209.85.221.196]:42911 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbeLRAfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:35:00 -0500
Received: by mail-vk1-f196.google.com with SMTP id y14so3287981vky.9;
        Mon, 17 Dec 2018 16:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwzev31AaH99pYdLxHHZctCyHMR/tBLknS1FKpmQgN0=;
        b=PQ5lUhNCoGXVSyP+LCzbn+T+hBl/yDIz4zJYfNzES+vU0DZgCc3HRHBlC2d/Bj+8vP
         SUJbC07lYEE+8Ej56rIXjRl1i/KwpGxFXw1/LhY48zY85wiwTC1RyA5usFqjND+DHiSW
         hSVXDyyn2At/OMpQBQwFYOeKenyr75YhLTMZ2k2uT71l1zGoDnbg7eSI1uO6Szt5awLM
         nl1bidsZX0jDcSnyxziyirqeYDfdeewIYmLSZoHKMCw7Pl9i9BZArYVt2WnB8TcKzYcD
         pZPerw2OscToHk141q3GkHeDqH0xgQU1VuBdKP3gS+vfIKun3snxFP/jQTcGQCKiK4pA
         bxYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwzev31AaH99pYdLxHHZctCyHMR/tBLknS1FKpmQgN0=;
        b=MCInf1kHOLFwmxLfDgVPhJHYBU0B793N152Ve1r/q/t4OlcWdg+dJLEoePVPTrR6ZA
         YTHUutz1WxtYLBkOGdUo4VImgcG3Ua8wQEDTI6SEtyp6Ty//GnCTBHLDelTjEwsz+d74
         ZspeVxbepm5WxZTA30F94jIZuGMbNGWnGQpgvhNOH8kAoXyqS4yC4pQ+71d6/uLm2t1w
         njVuRkiWmhb/USh+OzEsrYJ4HlhiAgwpqAVg1wfe3ii1EKIA1S/D487nysCDn3FJNo0P
         SlxmrDEhqCFlynYMPbyuwqXGmgzS3NnW1z3IX4K9AWlDqv4Yg24jR/pxHXEhFpnkucPc
         1CYQ==
X-Gm-Message-State: AA+aEWYEpeHJV/Y/rMmb7aDfqSx00BujOYipKZl91HpZJeUNbQJMn6Ua
        K+Ky2EdN5BjAOmCJJOutEJ2HInnEL0zN1l8HY027nBOh5Iw=
X-Google-Smtp-Source: AFSGD/W+ejlgP2VjkgnQJbNG+UrsbV040l0kaNByB5qp63gxaBZRh3En14YT4BldafiO4i8Az2UaSiHI6iRQIP5SpCk=
X-Received: by 2002:a1f:8804:: with SMTP id k4mr6590628vkd.61.1545093298578;
 Mon, 17 Dec 2018 16:34:58 -0800 (PST)
MIME-Version: 1.0
References: <20181217061036.24143-1-amworsley@gmail.com> <Pine.LNX.4.44L0.1812171114170.1630-100000@iolanthe.rowland.org>
In-Reply-To: <Pine.LNX.4.44L0.1812171114170.1630-100000@iolanthe.rowland.org>
From:   Andrew Worsley <amworsley@gmail.com>
Date:   Tue, 18 Dec 2018 11:34:46 +1100
Message-ID: <CA+Y=x3mHS4h13dTe4549Zcir5w3U54wJjyuaAa802=brp_FpeQ@mail.gmail.com>
Subject: Re: [PATCH] Prevent race condition between USB authorisation and USB
 discovery events
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jon Flatley <jflat@chromium.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bin Liu <b-liu@ti.com>, Benson Leung <bleung@chromium.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Dec 2018 at 03:21, Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, 17 Dec 2018, Andrew Worsley wrote:
>
> > A sysfs driven USB authorisation change can trigger a usb_set_configuration
> > while a hub_event worker thread is running. This can result in a USB device
> > being disabled just after it was configured and bringing down all the
> > devices and impacting hardware and user processes that were established on
> > top of this these interfaces. In some cases the USB disable never completed
> > and the whole system hung.
>
> Can you be more specific about this?  Disabling a USB device shouldn't
> cause these kinds of problems, regardless of whether or not the device
> was just configured.

I can't say too much about the hardware - but there was an SPI bus and
an i2c bus built
on top of USB devices on a bus. It appears the SPI bus shutdown was
the item that was prone
to problems when being torn down.

I understand it would be better if the dependant systems shutdown
cleanly, which it
did about 75% of the time but then it was rather messy sequence. So
the current system
is far from ideal. The crux of the issue is the usb_disable_device()
(line 1874 of drivers/usb/core/message.c)
call in usb_set_configuration() is applied to a configured device and
triggers the
tear down of all the devices built on that USB device and is very disruptive.

> > At my work I had an occasional hang due to this race condition. Roughly 1
> > in 50 boots had the race occurrence and 1 in 4 of those resulted in a hang.
> > This patch fixed the problem and I had no problems (spurious disables
> > or hangs) in 750+ boots.
>
> usb_authorize_device, usb_deauthorize_device, and hub_event all acquire
> the device mutex.  Why should adding another mutex make any difference?

I believe the new usb_authorize_mutex prevents the cascade of USB
device bus scans,
discoveries and probes from colliding with those caused a change in
USB bus authorisation.
The individual device / hub locks are not across the whole system,
only an individual
component hub/device so any logic that gives an orderly USB device
scanning and probing is
undermined. The idea of the mutex is to keep the USB device discovery
work when a device is
added/removed/powered up is separated from those that are caused by
authorisation changes.

I don't pretend to understand all the logic and sequencing of the
current code which works works
faultlessly when these threads are serialised by the mutex (750+
times) in boot ups which
build up the system and shutdowns which bring down the system.
Likewise if I endlessly run
the authorisation off / on by itself it is faultless over hundreds of
iterations.

> In fact there's an actual disadvantage: Making hub_event acquire a
> global mutex will prevent us from handling multiple hubs concurrently.
> Although we don't do this now, we might want to in the future.
>
> Alan Stern

This is true - I am not trying to serialise the hub_event() threads -
but to prevent the authorisation changes
from happening during the hub_event threads. So perhaps there would be
a way of allowing multiple
concurrent hub_events from happening but only one authorisation thread
at a time. Assuming multiple
hub_event()s are deemed ok. Something like a lock which allows
multiple readers but only a single exclusive
writer lock?

Andrew
