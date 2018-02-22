Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933309AbeBVQ4P (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 11:56:15 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:34646 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933093AbeBVQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 11:56:13 -0500
X-Google-Smtp-Source: AG47ELs27EoQzHYHn7nbye3q2wSvNgiYfC57cBLvBc0ePaVlvxC/pPG0Nn3RlUiIHqki9hIBqCnHztWl1C+qYHeTK3M=
MIME-Version: 1.0
In-Reply-To: <1519317625.55655.58.camel@gmail.com>
References: <20180222155546.1747665-1-arnd@arndb.de> <1519317625.55655.58.camel@gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 22 Feb 2018 17:56:12 +0100
X-Google-Sender-Auth: LNOYr40zN5vruum8EsLEZDTQ33I
Message-ID: <CAK8P3a19TUvOuN_E=3s7SuLd240FYQyYqppAWJeH3ySf=JytiA@mail.gmail.com>
Subject: Re: [PATCH] ipv6 sit: work around bogus gcc-8 -Wrestrict warning
To: Eric Dumazet <eric.dumazet@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 5:40 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Thu, 2018-02-22 at 16:55 +0100, Arnd Bergmann wrote:
>
> ...
>>
>> This code is old, so Cc stable to make sure that we don't get the warning
>> for older kernels built with new gcc.
>>
>> Cc: stable@vger.kernel.org
>
>
> This part makes little sense to me for two reasons.
>
> 1) David Miller handles stable submission himself
>  ( Documentation/networking/netdev-FAQ.txt )

Right, sorry I keep forgetting this.

> 2) We are not supposed to make sure old kernels will compile with
> future compilers.
>
> That would need a lot of work and potential new bugs, not worth the
> time.

I did spent a some time backporting the gcc-7 fixes to stable kernels
already.

The 4.4 and 4.9 releases did not build cleanly with gcc-7 originally
but now they do, which is useful since Greg actually uses that
compiler for test building them.

I expect to do the same for gcc-8. Most of the fixes are trivial
anyway, and some of them fix actual bugs that would otherwise
get missed.

      Arnd
