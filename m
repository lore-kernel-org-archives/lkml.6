Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeDFSCu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:02:50 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:40409 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751678AbeDFSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:02:48 -0400
X-Google-Smtp-Source: AIpwx4/kW/b0NeUQBmDZTK3BdBu2Ggo1Qt3/0DYxPTVUH6+Xnc9wZpUWlaFcM3lGy7hAkEvIMqnJXoUf/ND4f0RdfNY=
MIME-Version: 1.0
In-Reply-To: <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
References: <alpine.LFD.2.21.1804061125390.1819@schleppi> <CAGXu5jKTtU3fvqP-ygV51WcOAmTkm=y5fysKNv+k0crhJACtVg@mail.gmail.com>
From: Kees Cook <keescook@chromium.org>
Date: Fri, 6 Apr 2018 11:02:46 -0700
X-Google-Sender-Auth: tIowI0lA2_H6oDVUsfqzXKx9Wpk
Message-ID: <CAGXu5jKLsdfHEySg1w5EKO3Tt3=nWh7txWVsU6V65i3vS=Z2xw@mail.gmail.com>
Subject: Re: [bisected] 3c8ba0d61d04ced9f8d9ff93977995a9e4e96e91 oopses on s390
To: Sebastian Ott <sebott@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 6, 2018 at 9:47 AM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Apr 6, 2018 at 2:47 AM, Sebastian Ott <sebott@linux.vnet.ibm.com> wrote:
>> Today's kernel oopsed on s390. Bisect points to:
>> 3c8ba0d61d04 ("kernel.h: Retain constant expression output for max()/min()")
>>
>> [    1.898277] dasd-eckd 0.0.3304: DASD with 4 KB/block, 21636720 KB total size, 48 KB/track, compatible disk layout
>> [    1.898308] ------------[ cut here ]------------
>> [    1.898310] kernel BUG at block/bio.c:1798!
>
> Well that's extremely bad. :(
>
>> Bisect log and config attached. I'll look at min/max users in the affected
>> areas later today.
>
> Seems like a comparison of objdump output with/without the patch may
> be needed. And why is this s390 only? Ugh.

I did a objdump diff with your .config and it's rather large -- mostly
seems to be register swaps, so it's not easy to browse.

BTW, what version of gcc did you use? I built using:

s390x-linux-gnu-gcc (Ubuntu 7.3.0-13ubuntu1) 7.3.0

-Kees

-- 
Kees Cook
Pixel Security
