Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750860AbeEJWyz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 18:54:55 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44269 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750710AbeEJWyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 18:54:54 -0400
X-Google-Smtp-Source: AB8JxZpSze1JDjj+su4rXILkeMkGINvogU/4VzQsoMjQsn7gtAQFxi8AeTo9MkPfFkHzjhtPP/k9bjebfCM5lwXGBVE=
MIME-Version: 1.0
In-Reply-To: <20180510154844.dc4e4c7471a885b73ed50576@linux-foundation.org>
References: <20180503192430.7582-1-ross.zwisler@linux.intel.com>
 <20180508174424.GA12638@linux.intel.com> <20180510154844.dc4e4c7471a885b73ed50576@linux-foundation.org>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 10 May 2018 15:54:53 -0700
Message-ID: <CAPcyv4hy40dRr81aO7mr5LhC4L=es6NXE_kDCO2+USGXovGDiQ@mail.gmail.com>
Subject: Re: [PATCH 0/5] fix radix tree multi-order iteration race
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Ross Zwisler <ross.zwisler@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 10, 2018 at 3:48 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Tue, 8 May 2018 11:44:24 -0600 Ross Zwisler <ross.zwisler@linux.intel.com> wrote:
>
>> On Thu, May 03, 2018 at 01:24:25PM -0600, Ross Zwisler wrote:
>> > The following series gets the radix tree test suite compiling again in
>> > the current linux/master, adds a unit test which exposes a race in the
>> > radix tree multi-order iteration code, and then fixes that race.
>> >
>> > This race was initially hit on a v4.15 based kernel and results in a GP
>> > fault.  I've described the race in detail in patches 4 and 5.
>> >
>> > The fix is simple and necessary, and I think it should be merged for
>> > v4.17.
>> >
>> > This tree has gotten positive build confirmation from the 0-day bot,
>> > passes the updated radix tree test suite, xfstests, and the original
>> > test that was hitting the race with the v4.15 based kernel.
>> >
>> > Ross Zwisler (5):
>> >   radix tree test suite: fix mapshift build target
>> >   radix tree test suite: fix compilation issue
>> >   radix tree test suite: add item_delete_rcu()
>> >   radix tree test suite: multi-order iteration race
>> >   radix tree: fix multi-order iteration race
>> >
>> >  lib/radix-tree.c                      |  6 ++--
>> >  tools/include/linux/spinlock.h        |  3 +-
>> >  tools/testing/radix-tree/Makefile     |  6 ++--
>> >  tools/testing/radix-tree/multiorder.c | 63 +++++++++++++++++++++++++++++++++++
>> >  tools/testing/radix-tree/test.c       | 19 +++++++++++
>> >  tools/testing/radix-tree/test.h       |  3 ++
>> >  6 files changed, 91 insertions(+), 9 deletions(-)
>> >
>> > --
>> > 2.14.3
>> >
>>
>> Ping on this series.  Does anyone have any feedback?  Matthew?
>>
>> I'd really like to get it into v4.17.
>>
>> We can take it through the libnvdimm tree, if that's easiest.
>
> There's a copy in Dan's linux-next tree which is missing
>
> - The Link: tag

Yes, I normally don't add those.

> - The Fixes: tag
> - The Reported-by

Those were there.

> - Jan's reviewed-by

Right, Jan's came after I pushed it for -next soaking, but I updated it.

> - the cc:stable tag

That was there too, not sure where you were looking.

> so I think I'll just ignore all that and send this series off to Linus next
> week.

It's all backed out now from my tree.
