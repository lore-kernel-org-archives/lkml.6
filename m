Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031507AbeCAO1r (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:27:47 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:52059 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031485AbeCAO1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:27:42 -0500
X-Google-Smtp-Source: AG47ELuy3G6wHkK3HdjFXvC+/KARZNgLQJydesBcYGU1WewvAluQlTg2aAgckYLZ4ktOOg4IOyGW/FjhAHsguH94kyw=
MIME-Version: 1.0
In-Reply-To: <20180221213334.19969-1-anders.roxell@linaro.org>
References: <20180221213334.19969-1-anders.roxell@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 15:27:41 +0100
Message-ID: <CACRpkdbPU=O68q=VY1Qbibmk01MC9j9uiEXOmd65kG5pg_L3AQ@mail.gmail.com>
Subject: Re: [PATCH] tools/gpio/gpio-event-mon: fix warning
To: Anders Roxell <anders.roxell@linaro.org>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w21ERsNI008355

On Wed, Feb 21, 2018 at 10:33 PM, Anders Roxell
<anders.roxell@linaro.org> wrote:

> PRIu64 is defined in user space to match libc's uint64_t definition.
> However, gpioevent_data structure in the kernel is defined using the
> kernel's own __u64 type.
>
> gpio-event-mon.c: In function ‘monitor_device’:
> gpio-event-mon.c:102:19: warning: format ‘%lu’ expects argument of type
>     ‘long unsigned int’, but argument 3 has type ‘__u64 {aka long long
>     unsigned int}’ [-Wformat=]
>    fprintf(stdout, "GPIO EVENT %" PRIu64 ": ", event.timestamp);
>                    ^~~~~~~~~~~~~~
>   LD       /tmp/kselftest/gpiogpio-event-mon-in.o
>   LINK     /tmp/kselftest/gpiogpio-event-mon
>
> Fix is to replace PRIu64 with llu, which we know is what the kernel uses
> for __u64.
>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Patch applied with Daniel's test tag.

Yours,
Linus Walleij
