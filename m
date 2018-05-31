Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbeEaPCG (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 11:02:06 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:39470 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755254AbeEaPCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 11:02:03 -0400
X-Google-Smtp-Source: ADUXVKLPhnZFdSakSeRYVCcFZY+l+x67wqRhmIgLInobmLN0l4K94urZR3XcJsnWu81eGh6Y8KAI/HGadW6Y54htdyI=
MIME-Version: 1.0
References: <20180524211135.27760-1-dave@stgolabs.net> <20180524211135.27760-4-dave@stgolabs.net>
 <CA+55aFxvNCEBQsxfr=yL3jgxiC8M8wY2MHwVBH+T8qSWyP-WPg@mail.gmail.com>
 <20180529144317.GA20910@dhcp22.suse.cz> <20180529145106.GV27180@dhcp22.suse.cz>
 <CA+55aFxoC0+hKBQ_TmbXM_X60fnP8JKC3aVvGc=8bKh2oxL12g@mail.gmail.com> <20180530074216.GZ27180@dhcp22.suse.cz>
In-Reply-To: <20180530074216.GZ27180@dhcp22.suse.cz>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 31 May 2018 10:01:51 -0500
Message-ID: <CA+55aFyu9HpoHcn0p6uaADOspTd2DKPYciAgHz+C6zwLBvVSJA@mail.gmail.com>
Subject: Re: [PATCH 3/6] lib/bucket_locks: use kvmalloc_array()
To: Michal Hocko <mhocko@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
        Andrew Morton <akpm@linux-foundation.org>, Thomas Graf <tgraf@suug.ch>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Manfred Spraul <manfred@colorfullife.com>,
        guillaume.knispel@supersonicimagine.com,
        Linux API <linux-api@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 2:42 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> That being sad, if you believe that silently fixing up a code like that
> is a good idea we can do the following of course:

Ack.

Except for:

> Linus argues that this just motivates people to do even
> more hacks like
>         if (gfp == GFP_KERNEL)
>                 kvmalloc
>         else
>                 kmalloc
>
> I haven't seen this happening but it is true that we can grow those in
> future.

This whole discussion came from the fact that YES, THIS IS ACTUALLY HAPPENING.

See lib/bucket_locks.c - it just uses gfpflags_allow_blocking()
instead of explicitly checking for GFP_KERNEL (probably because the
only two cases it actually deals with is GFP_ATOMIC and GFP_KERNEL).

              Linus
