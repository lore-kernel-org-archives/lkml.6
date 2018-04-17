Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752357AbeDQJBW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 05:01:22 -0400
Received: from mail.us.es ([193.147.175.20]:37084 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751211AbeDQJBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 05:01:21 -0400
Date: Tue, 17 Apr 2018 11:00:52 +0200
X-SMTPAUTHUS: auth mail.us.es
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the netfilter tree
Message-ID: <20180417090052.h5ilsnezy66exmrr@salvia>
References: <20180417092859.358573be@canb.auug.org.au>
 <CAM_iQpXT2p1tQFHdRG9iZf_Wc5=H6P+0Q493k3VOLJ+fqr8GYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM_iQpXT2p1tQFHdRG9iZf_Wc5=H6P+0Q493k3VOLJ+fqr8GYQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 05:51:12PM -0700, Cong Wang wrote:
> On Mon, Apr 16, 2018 at 4:28 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Hi all,
> >
> > After merging the netfilter tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> >
> > net/netfilter/nf_conntrack_extend.c: In function 'nf_ct_ext_
> > add':
> > net/netfilter/nf_conntrack_extend.c:74:2: error: implicit declaration of function 'kmemleak_not_leak' [-Werror=implicit-function-declaration]
> >   kmemleak_not_leak(old);
> >   ^~~~~~~~~~~~~~~~~
> > cc1: some warnings being treated as errors
> >
> > Caused by commit
> >
> >   114aa35d06d4 ("netfilter: conntrack: silent a memory leak warning")
> >
> > I have added this patch for today:
> 
> Ouch, this is actually a correct fix.
> 
> Can you please send it formally or maybe Pablo can just take it directly?

I have applied Stephen's patch, thanks!
