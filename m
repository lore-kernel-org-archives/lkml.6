Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752653AbeBBUu3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:50:29 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:36686 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbeBBUuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:50:21 -0500
X-Google-Smtp-Source: AH8x225AviMDwLP9xcA9JYbBbBxXjHdrxHlzffDy/HF9CBEypnowlwnykneNqT7cUwGXzC5dsjbJCn1+DHVqoAq1JgQ=
MIME-Version: 1.0
In-Reply-To: <20180201231313.28458-1-jschoenh@amazon.de>
References: <20180201231313.28458-1-jschoenh@amazon.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 Feb 2018 22:50:20 +0200
Message-ID: <CAHp75Vf--xVkNoEaNRntzygQYHorbNQYhSCDVcxyLAz2PHEWEQ@mail.gmail.com>
Subject: Re: [PATCH] x86: e820: Implement a range manipulation operator
To: =?UTF-8?Q?Jan_H=2E_Sch=C3=B6nherr?= <jschoenh@amazon.de>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w12KoaI6030109

On Fri, Feb 2, 2018 at 1:13 AM, Jan H. Schönherr <jschoenh@amazon.de> wrote:

> +                       [KNL,ACPI] Convert memory within the specified region
> +                       from <oldtype> to <newtype>. If "-<oldtype>" is left
> +                       out, the whole region will be marked as <newtype>,
> +                       even if previously unavailable. If "+<newtype>" is left
> +                       out, matching memory will be removed. Types are
> +                       specified as e820 types, eg, 1==RAM, 2==reserved,
> +                       3==ACPI, 12==PRAM.

s/==/ = /g


> +       } else if (*p == '%') {
> +               enum e820_type from = 0, to = 0;
> +
> +               start_at = memparse(p + 1, &p);
> +               if (*p == '-')
> +                       from = simple_strtoull(p + 1, &p, 0);
> +               if (*p == '+')
> +                       to = simple_strtoull(p + 1, &p, 0);
> +               if (*p != 0)

if (*p)

or

if (*p != '\0')

?

> +                       return -EINVAL;
> +               if (from && to)
> +                       e820__range_update(start_at, mem_size, from, to);
> +               else if (to)
> +                       e820__range_add(start_at, mem_size, to);
> +               else if (from)
> +                       e820__range_remove(start_at, mem_size, from, 1);
> +               else
> +                       e820__range_remove(start_at, mem_size, 0, 0);

-- 
With Best Regards,
Andy Shevchenko
