Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754132AbeEaIYg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:24:36 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46575 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753957AbeEaIYc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:24:32 -0400
X-Google-Smtp-Source: ADUXVKJC3Kyl88cyWHGBYkiCXvkgKhdiMDK0jZZSxfGDzzXdz+3fFAk9Efkw9uolmL2y0KOQxla+LA==
Date: Thu, 31 May 2018 09:24:28 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Nick Desaulniers <nick.desaulniers@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jason Wessel <jason.wessel@windriver.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Subject: Re: [PATCH] kdb: prefer strlcpy to strncpy
Message-ID: <20180531082428.c5z7cpdetdrhy5wd@holly.lan>
References: <1527573427-16569-1-git-send-email-nick.desaulniers@gmail.com>
 <CAK8P3a2=THd7YL6sB4=xXZShD=wOjk_taM1L-E5VPH77TiQK0w@mail.gmail.com>
 <CAH7mPvhQo5S5EbgvkteoL1xftLWjWBqkfoanG0dTLzaa=FtTgw@mail.gmail.com>
 <20180530143415.ksc6fb4zo6m7xb25@holly.lan>
 <CAMuHMdXE980MDNO4mxOkwO=5AWV=Nzwwu1Sjt653AK8bMHbWsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXE980MDNO4mxOkwO=5AWV=Nzwwu1Sjt653AK8bMHbWsA@mail.gmail.com>
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 10:47:13PM +0200, Geert Uytterhoeven wrote:
> H Daniel,
> 
> On Wed, May 30, 2018 at 4:34 PM, Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > On Tue, May 29, 2018 at 07:01:35PM -0700, Nick Desaulniers wrote:
> >> On Tue, May 29, 2018 at 12:57 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> >> > On Tue, May 29, 2018 at 7:57 AM, Nick Desaulniers
> >> > <nick.desaulniers@gmail.com> wrote:
> >> >> Fixes stringop-truncation and stringop-overflow warnings from gcc-8.
> 
> >> Eric points out that this will leak kernel memory if size is less than
> >> sizeof src.
> >
> > Don't quite understand what this means (there's no allocation here, how
> > can there be a leak?) but the symbol completion certainly won't work if
> > we truncate the copy here.
> 
> Not leak an is memory leak, but leak as in information leak of uninitialized
> data to userspace (if the buffer is ever copied to userspace).

I see... I saw "leak", I saw "memory" and was perhaps too quick to link
the two together.

The underlying bug is a buffer overflow (so a good catch and I look
forward to a v2) but, with or without Nick's change, I can't see a leak
in either sense of the word in the code that Arnd was commenting on[1].


Daniel.


[1] Clearly the undefined behaviour post-overflow *could* be a leak but
    I stopped analyzing after the overflow.
