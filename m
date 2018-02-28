Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934629AbeB1QI5 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:08:57 -0500
Received: from mail-qt0-f175.google.com ([209.85.216.175]:36471 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933089AbeB1QIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:08:54 -0500
X-Google-Smtp-Source: AG47ELvv0MmnXrYQ0h3IY6rAGeXPN3Sxx7tyWTRK7QJ0A55r0fdKgmL2AKHZNJy8FKuMUN5zYhuEWBfQH9r+L8eazh0=
MIME-Version: 1.0
In-Reply-To: <20180227211539.5708-2-kernel@kempniu.pl>
References: <20180227211539.5708-1-kernel@kempniu.pl> <20180227211539.5708-2-kernel@kempniu.pl>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 28 Feb 2018 18:08:52 +0200
Message-ID: <CAHp75VdDQ1xAYcXEN04kSug2sgi-G8+7PBEOC8MJSBw7gSCyRQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] platform/x86: fujitsu-laptop: Define constants for
 FUNC operations
To: =?UTF-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <kernel@kempniu.pl>
Cc: Jonathan Woithe <jwoithe@just42.net>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w1SGALbi002606

On Tue, Feb 27, 2018 at 11:15 PM, Michał Kępień <kernel@kempniu.pl> wrote:
> Various functions exposed by the firmware through the FUNC interface
> tend to use a consistent set of integers for denoting the type of
> operation to be performed for a specified feature.  Use named constants
> instead of integers in each call_fext_func() invocation in order to more
> clearly convey the intent of each call.
>
> Note that FUNC_FLAGS is a bit peculiar:

> +/* FUNC interface - operations */
> +#define OP_GET                         BIT(1)
> +#define OP_GET_CAPS                    0
> +#define OP_GET_EVENTS                  BIT(0)
> +#define OP_GET_EXT                     BIT(2)
> +#define OP_SET                         BIT(0)
> +#define OP_SET_EXT                     (BIT(2) | BIT(0))

Hmm... this looks unordered a bit.
And plain 0 doesn't look right in this concept (something like (0 <<
0) would probably do it).

-- 
With Best Regards,
Andy Shevchenko
