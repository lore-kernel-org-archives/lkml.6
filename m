Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752453AbeERLE3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 07:04:29 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:56835 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752100AbeERLE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 07:04:27 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w4IB47kI024751
X-Nifty-SrcIP: [209.85.217.171]
X-Google-Smtp-Source: AB8JxZobtO8EI2PNVJxSFiwefly3w4aDbafkaNSlx9dRUskRh65qVXWEkjmWsukusbtevVT6sFhiVobYSKDbHIt0plM=
MIME-Version: 1.0
In-Reply-To: <20180518095833.kua6rcsrvz3vb4qv@gmail.com>
References: <20180518062553.kodjjrlrosrg7vfq@gmail.com> <CAK7LNAQaR6bLCL8cu4qbqB=oonr7kD_8XuLdG_ntRr_W_rfKUg@mail.gmail.com>
 <20180518093131.7g5m4mu3mtrgb7so@gmail.com> <CAK7LNATYiKYzD11anXzCqjWaqeezHo4R1db+qAdCAAJLkvuf9A@mail.gmail.com>
 <20180518095833.kua6rcsrvz3vb4qv@gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Fri, 18 May 2018 20:03:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbJKYkmZgE_0bZxff9L0RY8K4W_hndpqKS2d110ArduA@mail.gmail.com>
Message-ID: <CAK7LNAQbJKYkmZgE_0bZxff9L0RY8K4W_hndpqKS2d110ArduA@mail.gmail.com>
Subject: Re: [PATCH v3] scripts/tags.sh: don't parse `ls` for $ALLSOURCE_ARCHS generation
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arend van Spriel <arend.vanspriel@broadcom.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-18 18:58 GMT+09:00 Joey Pabalinas <joeypabalinas@gmail.com>:
> On Fri, May 18, 2018 at 06:52:48PM +0900, Masahiro Yamada wrote:
>> Why is 'paste' necessary?
>
> Without it newlines from find are retained from the find
> output (at least in bash when I tested it). Though it doesn't
> really matter here since we are feeding it to a for loop, I
> just wanted to be sure this didn't surprise someone in the
> future by squeezing the newlines into spaces.
>

Hmm, I would personally get upset about that code.


Does this work?
ALLSOURCE_ARCHS=$(find "${tree}"arch -mindepth 1 -maxdepth 1 -type d
-printf ' %f')

It would leave one leading space, but I do not think it is a big deal.


It would be possible to chop it like follows, but I wonder if it is worth doing.
ALLSOURCE_ARCHS=$(find "${tree}"arch -mindepth 1 -maxdepth 1 -type d
-printf ' %f' | cut -c2-)


> --
> Cheers,
> Joey Pabalinas



-- 
Best Regards
Masahiro Yamada
