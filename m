Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964883AbeEYDyY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:54:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:51935 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964889AbeEYDvK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:51:10 -0400
Date: Thu, 24 May 2018 20:34:27 -0700
From: Davidlohr Bueso <dave@stgolabs.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next 0/6] rhashtable: guarantee first allocation
Message-ID: <20180525033427.ydkkmadagerkzove@linux-n805>
References: <20180524211135.27760-1-dave@stgolabs.net>
 <CA+55aFxnrwFniJq6nCFn4pWRHLH-Wac9bVFKieBC-TixTsFg=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+55aFxnrwFniJq6nCFn4pWRHLH-Wac9bVFKieBC-TixTsFg=Q@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 May 2018, Linus Torvalds wrote:

>On Thu, May 24, 2018 at 2:28 PM Davidlohr Bueso <dave@stgolabs.net> wrote:
>>   10 files changed, 79 insertions(+), 86 deletions(-)
>
>I certainly can't complain about this small code removal, but I think if we
>did the kvmalloc_node() cleanup, we'd be able to get rid of even more.
>
>For example, bucket_table_alloc() does that
>
>         if (gfp != GFP_KERNEL)
>                 tbl = kzalloc(size, gfp | __GFP_NOWARN | __GFP_NORETRY);
>         else
>                 tbl = kvzalloc(size, gfp);
>
>purely due to the kvalloc_node() oddity. Wouldn't it be nice to just write
>it as
>
>         tbl = kvzalloc(size, gfp);
>
>knowing that the whole point of all the kv*alloc*() functions is to "just
>do the right thing given size, gpf mask, and ease of allocation".

Yes this makes a lot of sense. I'll see about adding it on top.

Thanks,
Davidlohr
