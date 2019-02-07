Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D59CC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C57E2175B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 19:39:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdHmYb2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfBGTji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:39:38 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33831 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBGTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 14:39:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id w4so426553plz.1;
        Thu, 07 Feb 2019 11:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lRfueK/ix/eHZS8tSp2NYZP9pA/TbqrX2eeoWnyupZ8=;
        b=qdHmYb2Nqb7P8gyVNjkM2SXw6VuC7r44iJGkP7vVypgjYLYCvJghrbWl/ywV8ZyvlZ
         6cjPryjIjq88Fq5yJSMEeDtAxNx3ImxVHAJCZOt1BsNbVuRlt3U1JZV4p1JY9DYrmuBl
         CwuDE9XFjkEZmat5gV1do/vgvzfvZFc7DpcDtUZoj4o1e8eA1QYHHmtMr6NunVZvQy2d
         oKBeE3gNAo5yb3hRqFvbDfZgohpwhD7xtKdAHlicjyNzZGCK5GtMVvcFjeDVrXbGsTNP
         obEdjJR32tZ1OSosCP553/dS1DAy++RVi9nWw1khgRjss4dPzaJHk+ozq0ZU3yc2CduF
         r1ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lRfueK/ix/eHZS8tSp2NYZP9pA/TbqrX2eeoWnyupZ8=;
        b=eKGPsVBHHzcFErJVSDt9WJrdF0W0IzIMV71qYxIRiX+7+RP1JFIj4QLEQy2jbcTC9c
         Ox4VN2ZojxUT//yssunSiWiUTKY/1Q6Co7e802oTgDZHfOimwrPz6e++BbqJzVqarYm0
         TwKohpKjt+uAM+8jvLWcwc7I6lhj7E+omUu2+KfR72Eh7E+lwHcFmvpnBL1tP4fax2aY
         qgfjbGog5lcZJpxTJyfscn1QCRTWPxLh1wE2kq3KZ6SdSSGoMiCtB7xz6ayQnyXacEiI
         vnlk1NnC/C9r6aPRh8lzoZ2efphATfKESwnXfGKFmsmZeJL45cHNx7P2PKhoWsxtSgWH
         Ypfg==
X-Gm-Message-State: AHQUAuZjUqzryifOdOP4AjydbxGFw9ulsrwqBB4/26Y/TjsPrvL2xEaF
        Db/PsAzVeX1yX6psRcnuC1id5zy0W5urNzjJghc=
X-Google-Smtp-Source: AHgI3IY5k1NtYRWnFRutoufcUAoRBGf/fdcYse8V6M/IeQHD9zP0xCV7x6p/y8E5bGJIMR2OPldaLvz4sX0caN2INFw=
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr6351721plq.311.1549568377604;
 Thu, 07 Feb 2019 11:39:37 -0800 (PST)
MIME-Version: 1.0
References: <20190207185917.167829-1-egranata@google.com> <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
In-Reply-To: <CAJZ5v0jFqkTS__oOfPNvatHOa6OA++uRNLx1-PhiPvS1VnPVXg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 Feb 2019 21:39:25 +0200
Message-ID: <CAHp75Ve5nw-TD0MqFq6Rzbuhqz2SjyqmOCst1-U3QV=U7k3cbg@mail.gmail.com>
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

On Thu, Feb 7, 2019 at 9:04 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> +Mika Westerberg
> +Andy Shevchenko
> +Hans de Goede

Thanks, Rafael.
My comments below.

> On Thu, Feb 7, 2019 at 7:59 PM <egranata@google.com> wrote:
> >
> > From: Enrico Granata <egranata@chromium.org>
> >
> > ACPI 5 added support for GpioInt resources as a way to provide
> > information about interrupts mediated via a GPIO controller.
> >
> > Several device buses (e.g. SPI, I2C) have support for retrieving
> > an IRQ specified via this type of resource, and providing it
> > directly to the driver as an IRQ number.

> > This is not currently done for the platform drivers, as platform_get_irq()
> > does not try to parse GpioInt() resources.

And why is this a problem?

> > This commit adds that functionality.

How that can override the configuration / BIOS flavour when driver
needs to register an interrupt out of GpioIo() resource?

P.S. Have you looked at drivers/platform/x86/i2c-multi-instantiate.c
and intel_cht_int33fe.c?
They are the only drivers which needs something like this for now and
I would rather say it's a bad BIOS decision to write a table like
that.

-- 
With Best Regards,
Andy Shevchenko
