Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751984AbeCLOR0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:17:26 -0400
Received: from mail-qt0-f180.google.com ([209.85.216.180]:36606 "EHLO
        mail-qt0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeCLORY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:17:24 -0400
X-Google-Smtp-Source: AG47ELu+EfwCMFrQlH9ro5K4yC8mPzhX6nZUiNYtvRd1nSV4FiahE7wZekYXAialcxhiOjY9tJICv4yq9JgGkLKlhMM=
MIME-Version: 1.0
In-Reply-To: <26ba21d8-c11f-4042-8f04-56f9bd582fd8@molgen.mpg.de>
References: <26ba21d8-c11f-4042-8f04-56f9bd582fd8@molgen.mpg.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 12 Mar 2018 15:17:23 +0100
X-Google-Sender-Auth: KlHnKBTabcp3oeulUUIwhavefyA
Message-ID: <CAMuHMdX=tPO+Q2H=1GNOyvpNQ=FSb5GHaCzrHGmRSgLVO4TA8Q@mail.gmail.com>
Subject: Re: string_selftest_init needs 636 ms to run
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Shuah Khan <shuah@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2CEHVbv014026

Hi Paul,

On Mon, Mar 12, 2018 at 2:45 PM, Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> Sorry for writing you directory, but I saw you created the module
> *string_selftest* in commit d6b28e09 (lib: add module support to string
> tests).
>
> I believe, I only did `make olddefconfig`, and the option is selected.
>
> ```
> $ grep STRING_SELFTEST .config
> CONFIG_STRING_SELFTEST=y
> ```
>
> But booting with `initcall_debug` and looking at the systemd-bootchart
> output in `/run/log`, doing this lasts 600 ms on my ASRock E350M1 with Linux
> 4.16-rc5 (probably since the 4.15 cycle).
>
>> string_selftest_init 636.2ms
>
> If I didn’t do anything incorrectly, should the module be disable by
> default?

lib/Kconfig:

    config STRING_SELFTEST
            tristate "Test string functions"

In the absence of any "default" statement, the default is "n", so the module
should be already disabled by default.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
