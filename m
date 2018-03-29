Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeC2NP5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:15:57 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35742 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC2NP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:15:56 -0400
X-Google-Smtp-Source: AG47ELu3ZqSBt9IYZHXk9hJqkOlhdr+VNmkftz73QzcW+LLoggPnq4ti4/eHs2Z9eh/orKdxDLBMO02VoF16Ipv5Tfc=
MIME-Version: 1.0
In-Reply-To: <20180329123544.GA22551@gondor.apana.org.au>
References: <20180329120612.6104-1-agruenba@redhat.com> <20180329123544.GA22551@gondor.apana.org.au>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Thu, 29 Mar 2018 15:15:54 +0200
Message-ID: <CAHc6FU4i5LDoqXXTgAKtTA8EtGyawxXtY4iavo7NjHCsbX1G8w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gfs2: Stop using rhashtable_walk_peek
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: cluster-devel <cluster-devel@redhat.com>, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, NeilBrown <neilb@suse.com>,
        Thomas Graf <tgraf@suug.ch>, Tom Herbert <tom@quantonium.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29 March 2018 at 14:35, Herbert Xu <herbert@gondor.apana.org.au> wrote:
> On Thu, Mar 29, 2018 at 02:06:10PM +0200, Andreas Gruenbacher wrote:
>> Here's a second version of the patch (now a patch set) to eliminate
>> rhashtable_walk_peek in gfs2.
>>
>> The first patch introduces lockref_put_not_zero, the inverse of
>> lockref_get_not_zero.
>>
>> The second patch eliminates rhashtable_walk_peek in gfs2.  In
>> gfs2_glock_iter_next, the new lockref function from patch one is used to
>> drop a lockref count as long as the count doesn't drop to zero.  This is
>> almost always the case; if there is a risk of dropping the last
>> reference, we must defer that to a work queue because dropping the last
>> reference may sleep.
>
> In light of Neil's latest patch, do we still need this?

For all I know, Neil's latest plan is to get rhashtable_walk_peek
replaced and removed because it is unfixable. This patch removes the
one and only user.

Thanks,
Andreas
