Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751967AbeBAJY2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 04:24:28 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:37478 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751628AbeBAJYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 04:24:23 -0500
X-Google-Smtp-Source: AH8x22476TesbI3xCG3SQ3hKeGiZjJ3ZMQ4AaJnWc1+NuVmsF2GZmDM6VShLXj3QjsPFVnzLs2349nbOZLewvLrjsmc=
MIME-Version: 1.0
In-Reply-To: <20160616090359.984712-1-arnd@arndb.de>
References: <20160616090359.984712-1-arnd@arndb.de>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 1 Feb 2018 10:24:22 +0100
X-Google-Sender-Auth: gP97p7D5eALOG5XDAHhFv359ngM
Message-ID: <CAMuHMdVPrdNESrqoXEwrbwqJ-OBQOGkMDWm_sSzaH2e7c884ow@mail.gmail.com>
Subject: Re: [PATCH] dm raid: don't use 'const' in function return
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mike Snitzer <snitzer@redhat.com>, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com, Shaohua Li <shli@kernel.org>,
        Heinz Mauelshagen <heinzm@redhat.com>, linux-raid@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2016 at 11:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> A newly introduced function has 'const int' as the return type,
> but as "make W=1" reports, that has no meaning:
>
> drivers/md/dm-raid.c:510:18: error: type qualifiers ignored on function return type [-Werror=ignored-qualifiers]
>
> This changes the return type to plain 'int'.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 33e53f06850f ("dm raid: introduce extended superblock and new raid types to support takeover/reshaping")

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

The same issue has been reintroduced.
So please reapply commit 68c1c4d5eafc65dd ("dm raid: don't use 'const' in
function return") with

Fixes: 552aa679f2657431 ("dm raid: use rs_is_raid*()")

> index 96bcff7a0b94..55d25ac87bda 100644
> --- a/drivers/md/dm-raid.c
> +++ b/drivers/md/dm-raid.c
> @@ -507,7 +507,7 @@ static const char *raid10_md_layout_to_format(int layout)
>  }
>
>  /* Return md raid10 algorithm for @name */
> -static const int raid10_name_to_format(const char *name)
> +static int raid10_name_to_format(const char *name)
>  {
>         if (!strcasecmp(name, "near"))
>                 return ALGORITHM_RAID10_NEAR;

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
