Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753376AbeCUU6Q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 16:58:16 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:45812 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbeCUU6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 16:58:11 -0400
X-Google-Smtp-Source: AG47ELsQW1/B4ZFw5bqg6VcwJVMoG6frHTqNny9rlTbUlUV1O0AgmyYCh4OkLxO8bVevHYMs+e26z+L42vzbpIarVUg=
MIME-Version: 1.0
In-Reply-To: <F4F10894-B101-4E46-A39D-7F09DEF2207D@informatik.uni-hamburg.de>
References: <D7FA4547-4FA6-46EC-99D7-F08ACCD3F13D@informatik.uni-hamburg.de>
 <CAOFm3uH1Nw3x6-T1yTMkoX2tpxiwjnerAXDh-WEpyFNROFwAYw@mail.gmail.com> <F4F10894-B101-4E46-A39D-7F09DEF2207D@informatik.uni-hamburg.de>
From: Philippe Ombredanne <pombredanne@nexb.com>
Date: Wed, 21 Mar 2018 13:57:30 -0700
Message-ID: <CAOFm3uEpDh1jp1+ODzR=TFH0uq08LL2qjqrMLOe+_jE+4Sw_og@mail.gmail.com>
Subject: Re: [PATCH 1/5 v4] add compression algorithm zBeWalgo
To: Benjamin Warnke <4bwarnke@informatik.uni-hamburg.de>
Cc: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, minchan@kernel.org,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin,

On Wed, Mar 21, 2018 at 12:32 AM, Benjamin Warnke
<4bwarnke@informatik.uni-hamburg.de> wrote:
> Ok, I will use
>
> /* SPDX-License-Identifier: GPL-2.0 */
> /*
>  * Copyright (c) 2018 Benjamin Warnke <4bwarnke@informatik.uni-hamburg.de>
> ...
>
> at the top of my files instead of that boilerplate text. And
>
> MODULE_LICENSE("GPL");
>
> at the bottom of the module-files.

<snip>
>
> I used the file "crypto/lz4.c" - since it is a compression algorithm too - as an example of how to format the licensing text.
> Unfortunately there is the same 'error'.
> I fixed this error in all of my files in all patches.

Actually to be consistent if you want to use GPL-2-0 (and not "or
later") you should use:

1. at the top, for a c. file:
// SPDX-License-Identifier: GPL-2.0

or for a .h file:
/* SPDX-License-Identifier: GPL-2.0 */

The doc explains it all. Including the comment style (a topic that has
been discussed also on list quite bit: Linus had the final word there)

2. and in your MODULE_LICENSE macro:

MODULE_LICENSE("GPL v2");

.... because a MODULE_LICENSE("GPL"); would mean GPL-2.0+ (e.g. or any
later version) and this would not match your top level license tag.

I know this may seem confusing, but there is little hope we can change
the MODULE_LICENSE tags that are used by many external module loaders.
Comments in module.h explain it all.

-- 
Cordially
Philippe Ombredanne
