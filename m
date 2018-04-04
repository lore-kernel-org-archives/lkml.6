Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752163AbeDDPqd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 11:46:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36202 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751648AbeDDPq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 11:46:29 -0400
Date: Wed, 4 Apr 2018 11:46:28 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Tom Herbert <tom@quantonium.net>
Message-ID: <1366548861.16037365.1522856788263.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180329120612.6104-1-agruenba@redhat.com>
References: <20180329120612.6104-1-agruenba@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v2 0/2] gfs2: Stop using
 rhashtable_walk_peek
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.80, 10.4.195.4]
Thread-Topic: gfs2: Stop using rhashtable_walk_peek
Thread-Index: ZtGGhfwbsmsK5M0roIu6JXkYVcw0MQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> Here's a second version of the patch (now a patch set) to eliminate
> rhashtable_walk_peek in gfs2.
> 
> The first patch introduces lockref_put_not_zero, the inverse of
> lockref_get_not_zero.
> 
> The second patch eliminates rhashtable_walk_peek in gfs2.  In
> gfs2_glock_iter_next, the new lockref function from patch one is used to
> drop a lockref count as long as the count doesn't drop to zero.  This is
> almost always the case; if there is a risk of dropping the last
> reference, we must defer that to a work queue because dropping the last
> reference may sleep.
> 
> Thanks,
> Andreas
> 
> Andreas Gruenbacher (2):
>   lockref: Add lockref_put_not_zero
>   gfs2: Stop using rhashtable_walk_peek
> 
>  fs/gfs2/glock.c         | 47 ++++++++++++++++++++++++++++-------------------
>  include/linux/lockref.h |  1 +
>  lib/lockref.c           | 28 ++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 19 deletions(-)
> 
> --
> 2.14.3

Hi,

The patches look good. The big question is whether to add them to this
merge window while it's still open. Opinions?

Acked-by: Bob Peterson <rpeterso@redhat.com>

Regards,

Bob Peterson
