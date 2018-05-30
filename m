Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbeE3UrT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 16:47:19 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:37775 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932233AbeE3UrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 16:47:15 -0400
X-Google-Smtp-Source: ADUXVKJgYDUhva5fFJK1Jcq3HlcEPGTNdeQK1p6p6rmY9iuFaw7LEhHRK0+ZCxM/fqeSL11WmEzp5vr4v5thz+JAuEg=
MIME-Version: 1.0
In-Reply-To: <20180530143415.ksc6fb4zo6m7xb25@holly.lan>
References: <1527573427-16569-1-git-send-email-nick.desaulniers@gmail.com>
 <CAK8P3a2=THd7YL6sB4=xXZShD=wOjk_taM1L-E5VPH77TiQK0w@mail.gmail.com>
 <CAH7mPvhQo5S5EbgvkteoL1xftLWjWBqkfoanG0dTLzaa=FtTgw@mail.gmail.com> <20180530143415.ksc6fb4zo6m7xb25@holly.lan>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 30 May 2018 22:47:13 +0200
X-Google-Sender-Auth: 2s9rX8ykln7BGywLEMWnIxn6tQA
Message-ID: <CAMuHMdXE980MDNO4mxOkwO=5AWV=Nzwwu1Sjt653AK8bMHbWsA@mail.gmail.com>
Subject: Re: [PATCH] kdb: prefer strlcpy to strncpy
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

H Daniel,

On Wed, May 30, 2018 at 4:34 PM, Daniel Thompson
<daniel.thompson@linaro.org> wrote:
> On Tue, May 29, 2018 at 07:01:35PM -0700, Nick Desaulniers wrote:
>> On Tue, May 29, 2018 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Tue, May 29, 2018 at 7:57 AM, Nick Desaulniers
>> > <nick.desaulniers@gmail.com> wrote:
>> >> Fixes stringop-truncation and stringop-overflow warnings from gcc-8.

>> Eric points out that this will leak kernel memory if size is less than
>> sizeof src.
>
> Don't quite understand what this means (there's no allocation here, how
> can there be a leak?) but the symbol completion certainly won't work if
> we truncate the copy here.

Not leak an is memory leak, but leak as in information leak of uninitialized
data to userspace (if the buffer is ever copied to userspace).

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
