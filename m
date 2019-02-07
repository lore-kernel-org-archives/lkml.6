Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F62CC282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAE8321872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnPqr9bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbfBGTp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:45:59 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39982 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726401AbfBGTp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:45:58 -0500
Received: by mail-pf1-f196.google.com with SMTP id i12so420830pfo.7;
        Thu, 07 Feb 2019 11:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JvpSFgNurCVQ0pSjB7JZlKGgNsPdHnhIpspVbJugIqI=;
        b=NnPqr9bCqxcGlDrfzqQV1c9O4qCAafCd4NZly5D9HXSOAoxjoYKucw00Mo6g83MEwo
         iiHdfxtYJ+HvKnuj8ZYH8POShdI5tA3Jn1GnKCkgeS2Od4FTJIdLhAeaIU5efqXFWaHO
         p0Nd5SznikTMAoWY8ykeQfXPINenXIb2T6KpjdRyBgxeY0Suhf8rq6BN8EPAIKgxc6uv
         O55lDskF6Qv7n4jWAhubDqufAkQeMVLCguP60vc6F7qYhRYm4OIHh2/OX1R4RpNA6S72
         Pouw3x+IQZKklyXFtn4P8HWBHXdwENSm+TzoUdVK39aqZtvznze958oImXKxvjZq3BQg
         R9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JvpSFgNurCVQ0pSjB7JZlKGgNsPdHnhIpspVbJugIqI=;
        b=ffGeYLoiHbFFWhk+8S3KzWhkHHxQ6q8N7ac5O/p25IIA7ooSioORRibVE/ORxxjjyN
         fOk52KupJTelSWTMMUV7BAqD3CSdm11/0r0Rvn1n0j3+cEfNIDEMpX9dcQUSvczJuKZp
         0utPUUOyafu/hY/5vYy3t+YbAsupDEN5gHpGvVs/dX+V732Zc45y6trwTlgWU6fA60MJ
         nrHzDtRMH5suT2En+OPqzLUdqm0ISHj7XJvhBZoGBj6IBTQEcGk605KYzi8g9xLE3CUK
         zEp/yKI1BbLt4MPBQgTZi+pLIgT6ZykXJ1qKIubCBWbi+IarGZVmIE/GzzUH06W65qrO
         owAg==
X-Gm-Message-State: AHQUAua34Kp1AjqdOeBrAASaJEktNVaf0IgyofGoEGdYdhJl0zRcmkW6
        52nfdE7cDgedhacKoxV+zXAdoe/q8h1YboYuHF4=
X-Google-Smtp-Source: AHgI3Iad+ozgfHXdcFNUmDxZekZ4gRbEkE+oMaTFEkbIE9FU3bHQxzmfzuiIRFMJip6A6kMlq4v7m/MjqS4hYUZUoaY=
X-Received: by 2002:a65:6116:: with SMTP id z22mr16324544pgu.265.1549568758203;
 Thu, 07 Feb 2019 11:45:58 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
 <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
In-Reply-To: <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Feb 2019 21:45:46 +0200
Message-ID: <CAHp75Ve7+S0rUTLQWn_K2p7yajA3q=BZS0R4nOPdZeMczvNb4A@mail.gmail.com>
Subject: Re: [PATCH] driver: platform: Add support for GpioInt() ACPI to platform_get_irq()
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     egranata@google.com,
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 7, 2019 at 9:39 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:

> > > This commit adds that functionality.
>
> How that can override the configuration / BIOS flavour when driver
> needs to register an interrupt out of GpioIo() resource?

One more missed example,

Two variants of the IRQ resources in the table for the _same_ device
but on different platforms.

--Variant1--
Device(XYZ)
_CRS1() {
 Interrupt()
 GpioInt()
 Interrupt()
}

--Variant2--
Device(XYZ)
_CRS2() {
 GpioInt()
 Interrupt()
 Interrupt()
}

How to always get second resource?

-- 
With Best Regards,
Andy Shevchenko
