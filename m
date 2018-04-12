Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752894AbeDLRAl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 13:00:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50672 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752446AbeDLRAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 13:00:39 -0400
Date: Thu, 12 Apr 2018 13:00:38 -0400 (EDT)
From: Bob Peterson <rpeterso@redhat.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: cluster-devel@redhat.com, Herbert Xu <herbert@gondor.apana.org.au>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        NeilBrown <neilb@suse.com>, Thomas Graf <tgraf@suug.ch>,
        Tom Herbert <tom@quantonium.net>
Message-ID: <2059591212.18898416.1523552438431.JavaMail.zimbra@redhat.com>
In-Reply-To: <20180329120612.6104-1-agruenba@redhat.com>
References: <20180329120612.6104-1-agruenba@redhat.com>
Subject: Re: [Cluster-devel] [PATCH v2 0/2] gfs2: Stop using
 rhashtable_walk_peek
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.3.116.80, 10.4.195.6]
Thread-Topic: gfs2: Stop using rhashtable_walk_peek
Thread-Index: s6Q4xPpE6clD196Go+Y/DeDzy/M1pg==
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

Thanks. These two patches are now pushed to the for-next branch of the linux-gfs2 tree:

https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?h=for-next&id=450b1f6f56350c630e795f240dc5a77aa8aa2419
https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git/commit/?h=for-next&id=3fd5d3ad35dc44aaf0f28d60cc0eb75887bff54d

Regards,

Bob Peterson
Red Hat File Systems
