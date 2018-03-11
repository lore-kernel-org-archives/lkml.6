Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932332AbeCKUrk (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 16:47:40 -0400
Received: from mail.us.es ([193.147.175.20]:34294 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932232AbeCKUri (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 16:47:38 -0400
Date: Sun, 11 Mar 2018 21:47:34 +0100
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Joe Perches <joe@perches.com>
Cc: Arushi Singhal <arushisinghal19971997@gmail.com>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: netfilter: Replace printk() with appropriate
 pr_*() macro
Message-ID: <20180311204734.aczkhqqgtb7z2kkj@salvia>
References: <20180311194104.GA17450@seema-Inspiron-15-3567>
 <1520797961.19456.4.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520797961.19456.4.camel@perches.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sun, Mar 11, 2018 at 12:52:41PM -0700, Joe Perches wrote:
> On Mon, 2018-03-12 at 01:11 +0530, Arushi Singhal wrote:
> > Using pr_<loglevel>() is more concise than
> > printk(KERN_<LOGLEVEL>).
> > Replace printks having a log level with the appropriate
> > pr_*() macros.
> > 
> > Signed-off-by: Arushi Singhal <arushisinghal19971997@gmail.com>
> > ---
> > changes in v2
> > *in v1 printk() were replaced with netdev_*()
> 
> >  net/netfilter/nf_conntrack_acct.c      | 2 +-
> >  net/netfilter/nf_conntrack_ecache.c    | 2 +-
> >  net/netfilter/nf_conntrack_timestamp.c | 2 +-
> >  net/netfilter/nf_nat_core.c            | 2 +-
> >  net/netfilter/nfnetlink_queue.c        | 4 ++--
> >  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> None of these files have a #define for pr_fmt so this
> should be OK.

I think Arushi could add pr_fmt in the same go, so we skip another
follow up patch for this. @Arushi: I suggested this in my previous
email, please have a look.

This would also probably allows us to save the line break in the error
message, which IIRC is not a good practise either, eg.

				pr_warn("nf_queue: OOM "
					"in mangle, dropping packet\n");

> Perhaps coalesce the formats and remove the unnecessary periods too.

Yes, removing periods seems fine.

Thanks.
