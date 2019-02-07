Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B77C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:18:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 710C121721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 20:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BOdtVZoE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBGUSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 15:18:17 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:44186 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727214AbfBGUSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 15:18:17 -0500
Received: by mail-pg1-f193.google.com with SMTP id y1so427238pgk.11;
        Thu, 07 Feb 2019 12:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Y6GW/TynmP9/Wu+Nq5EnfUHpaUSTiqwx8XVGEI0ypy4=;
        b=BOdtVZoEqTz6tEfV9xPFNVeA6Y4D5UTXasYCvntYqieKU4/NJEToQETy1WcnxLbLIy
         xVPN3fqb2M2OpYESzM8jp79+DeAHWVeuLZhBFxN5lUn6d5vpU2KJGqy/0nhU2gGS11WM
         ROE8ix4pwoLAz7Sp1OdSyvIfQgT7SaN7ogWxmQKZ+h4xC+GvT5gkP/c0v2KkAnEj49SZ
         1yZEfJpgEaUB1q/yYBoAvhrdgzCLeyFLbRyr7+zw6PoC2hi0oHe/JYzGaD3cFaKvpZKR
         nhwHf5LRcD1y2dkyYPutLyyejbUKPzxMhmUIx9ABpT+kuVRB9iUo0fJqfEDtWiqtENZo
         1SkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y6GW/TynmP9/Wu+Nq5EnfUHpaUSTiqwx8XVGEI0ypy4=;
        b=dbpHEVXpr0R3L5kXTcUsHi9HLQmBmxAbZobQVHmjpOVuCqvFqKXjC+S25BuHqXk9GS
         cnDqR32Ckk/lCPtMOeG5FXghTWkNGiY8exdESsqa3th+6jNlhWbb8bANYFGFO8+TcJKH
         GmFpO/Gd/TQWpeMQb+EJ0n7LvAimqiJZQaiYqStAwUNL8b7tc6xOQXhjlwDUqywJpN0L
         gUkBc3n9t6SeD/nsWKk9fxBVfTp5YboBNYJEatUF+P/6W3HuuFz7yd+6J9PACC+B5REd
         dQPLnyDntze3/4tIsfSnV2JsFrMhK0ZkYVRufuWeF/oy428qltLcfZNRld1blxPK4lAX
         rJFw==
X-Gm-Message-State: AHQUAuZ9Ksitbqe88E8DGNGZoUDJIDFiKjzGviHk5bujjszt+zoE3W/s
        C36ThYxncRHCRyTHi3H+kE6qJ0Iq7RbdWDFbe5n85HI5
X-Google-Smtp-Source: AHgI3IY6xONBO0MJ7a7HrW0tDN3S3jthcVWtwXnaXDZ6RuNwRtFdKtqGhX1OUr2wZB08YxBAQ8p5mf+3MibfCpWrl7M=
X-Received: by 2002:a62:d005:: with SMTP id p5mr18108743pfg.175.1549570696236;
 Thu, 07 Feb 2019 12:18:16 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com> <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com>
In-Reply-To: <CAPR809vnpuh8nOjU3QMCh6YJUKmtX92+bnHSUKGiAXAp6NwCHQ@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Feb 2019 22:18:05 +0200
Message-ID: <CAHp75Ve5Q0d0PCmQ6KZdcyuLd-XFfVjYqyujjM9SSbyBG+Hrmg@mail.gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
To:     Enrico Granata <egranata@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Enrico Granata <egranata@chromium.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:45 PM Enrico Granata <egranata@google.com> wrote:
> On Thu, Feb 7, 2019 at 11:39 AM Andy Shevchenko <andy.shevchenko@gmail.co=
m> wrote:
>> On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> wro=
te:

>> > > This is not currently done for the platform drivers, as platform_get=
_irq()
>> > > does not try to parse GpioInt() resources.
>>
>> And why is this a problem?

> In ChromeOS, we have a driver (cros_ec_lpc) which can run either on syste=
ms that directly expose the interrupt,
> or systems where the interrupt goes through a GPIO controller. On the for=
mer, firmware provides an Interrupt resource
> and platform_get_irq() finds it. On the latter, firmware provides a GpioI=
nt resource and platform_get_irq does not
> find it. We could work around this in the driver by probing both paths, b=
ut since other subsystems seem to directly
> look for GpioInt resources, it seemed to us to make more sense to extend =
platform_get_irq() instead.

Looking briefly into the driver I found third scenario =E2=80=94 no resourc=
e at all.
So, you already have a quirk for that. Now it's the question either
you go for global quirk (trying to find an IRQ via iterating over
GpioInt() resources like in this patch, but in the driver), or use DMI
table for more stricter rules.

Either way you choose, I don't see a necessity to put this to the
driver core for now since it would be the only (let's assume properly
written ACPI tables) driver needs such.

> Do you have a suggestion as to how to write ACPI tables to avoid the issu=
e?

1. Allocate new ID and use it (perhaps not the best path).
2. Use GPE(s).

--
With Best Regards,
Andy Shevchenko
