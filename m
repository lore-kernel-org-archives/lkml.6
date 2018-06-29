Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0ADC6778A
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:20:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8E7627C92
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 20:20:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijNw0vWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8E7627C92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937297AbeF2UT7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 16:19:59 -0400
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36104 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755478AbeF2UT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 16:19:57 -0400
Received: by mail-ua0-f195.google.com with SMTP id y8-v6so6558398uan.3;
        Fri, 29 Jun 2018 13:19:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4qbBMmffOr6qjUWGm6yd+EDK0Rv4Qeoj/k6Yhj4D74o=;
        b=ijNw0vWF8j6TaBL2vyq6LAQ1bpPH+gn42WH0wSyB0NuaTRH+rqTrfnIlGibe+2tWxI
         nDikYRhoJFrQf0reAWUh+T6vEpAinrBf+3TXL8Kz2e5OXR7SX+pUZgei0csKZtUMIJgM
         Um+PTg9I0dekZxyFgQXGIua3OtOEEAB1reCz5BGocmdVa/k5ViycIT2YYkWYDlO0p5X7
         X+4UCnxnVQqpTqyvlE0+HNjinRCICLC8b4roXbQ3E7e7USCM/n29+AZe5CIFHjT5Vgml
         9kjDR9w8TL2xT+xhC/yERgEJFv/z6JECl3RLgBBvzOQEIDq27IgTQ6Xz8OoTGgQ8Hy5T
         Y10Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4qbBMmffOr6qjUWGm6yd+EDK0Rv4Qeoj/k6Yhj4D74o=;
        b=gYrpsvICeLpmAgrfWNdXjNOpT7DawT0Wi1PSMP75KMfX5OKOXSR+84cIzZ9vVWqvuW
         elwdYDNUOWCnrFSx+pycWKePmcf/GF5m4isVoCKsSMXAGbTlLQV/FNvTUAOpZJ0Bc445
         ioXJ/EQCWJmnKdI1IXckF/8AlSUpQGDjwJlh1lCoBLSoBIglZYG5VIoJHBOoOi/5fglw
         EJHGr9yOytnQ0F5gZiNJ4Whp9J1VWEveBsZQiLn5pP5bpZ1Z4qzyFE+Dr+GvDeZUJnip
         WNCiShCVdQ1HD0Z0kZc5KoSOO8Y4YsF2zJuzKl9OtiQYvO1vC/x2FgR+SbNWTBAJHkND
         169g==
X-Gm-Message-State: APt69E0wBtTOSCyytY+hLfQ0XQdfWt3H6r23EbsyjGTGj5+dio3WkI/I
        T7TE/4gRWsEOxdzTlsIqE7K4b29zGBIFEV33QYU=
X-Google-Smtp-Source: AAOMgpfM0ausUuBdJ/MbSVIpP3QhTKtuG5Qx6RKrBdYKNmQLiuejFdA+XNCnyXBbLBEJkJhtVEIiGL2t+q5mgh4WLJY=
X-Received: by 2002:ab0:1a23:: with SMTP id a35-v6mr10201773uai.47.1530303596235;
 Fri, 29 Jun 2018 13:19:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:8b02:0:0:0:0:0 with HTTP; Fri, 29 Jun 2018 13:19:55
 -0700 (PDT)
In-Reply-To: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 29 Jun 2018 23:19:55 +0300
Message-ID: <CAHp75VfR8JZaDbvzudW5mc4=nOoYM2EeXPMhUHCw1ovnPmGV5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] IIO: st_sensors_i2c: improve device enumeration
To:     Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>,
        linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2018 at 1:30 PM, Nikolaus Voss
<nikolaus.voss@loewensteinmedical.de> wrote:
> When trying to instantiate a st_accel_i2c device from an ACPI based
> system, I ran into some problems:
>
> For my device, there is no ACPI match table entry, so rather than
> creating /allocating a new ACPI HID for the device, I wanted to use an
> existing DT table compatible entry via creating an ACPI_DT_NAMESPACE_HID
> /PRP0001 HID ACPI entry (see Documentation/acpi/enumeration.txt).
>
> This did not work because st_accel_i2c.c bails out if there is a ACPI
> node but no ACPI table match instead of looking for a match from one of
> the fallback mechanisms (patch 1).
>
> Patch 2 removes an error message when a ACPI node exists but no table
> entry is found (this doesn't need to be fatal because of the fallback).
>
> Patch 3 syncs the strings in the I2C device table (which is used by the
> I2C core for fallback matching) with the DT compatible strings, so a
> PRP0001 entry can use the same compatible strings as a corresponding
> DT entry. As far as I can see, the old I2C table strings aren't used
> in mainline, so renaming them should be safe.
>

I'm not sure I understand how ->probe_new() is supposed to work
against i2c_id_table, but I don't care for legacy platform data
anyway.

What I would like to point to is device_get_match_data() API which
should simplify / unify the case how you get driver data.

> Nikolaus Voss (3):
>   IIO: st_accel_i2c.c: Use fallback if DT/ACPI enum failed
>   IIO: st_sensors_i2c.c: Don't print error on failed ACPI match
>   IIO: st_accel.h: sync DT and I2C device ID table strings
>
>  drivers/iio/accel/st_accel.h                  | 32 +++++++++----------
>  drivers/iio/accel/st_accel_i2c.c              | 21 ++++++------
>  .../iio/common/st_sensors/st_sensors_i2c.c    |  5 ++-
>  3 files changed, 30 insertions(+), 28 deletions(-)
>
> --
> 2.17.1
>



-- 
With Best Regards,
Andy Shevchenko
