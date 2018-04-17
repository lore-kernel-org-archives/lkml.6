Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752916AbeDQAvj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 20:51:39 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:37621 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752813AbeDQAvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 20:51:33 -0400
X-Google-Smtp-Source: AIpwx48OjXh+kMxxCyJ5E0eR3V6/Y+ok6FltWSFysZmj3Td0k1CG6ghXf7tZxvgy2xgvTDn0Yz5EP7HRoEZRABd/B+c=
MIME-Version: 1.0
In-Reply-To: <20180417092859.358573be@canb.auug.org.au>
References: <20180417092859.358573be@canb.auug.org.au>
From: Cong Wang <xiyou.wangcong@gmail.com>
Date: Mon, 16 Apr 2018 17:51:12 -0700
Message-ID: <CAM_iQpXT2p1tQFHdRG9iZf_Wc5=H6P+0Q493k3VOLJ+fqr8GYQ@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the netfilter tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 16, 2018 at 4:28 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi all,
>
> After merging the netfilter tree, today's linux-next build (powerpc
> ppc64_defconfig) failed like this:
>
> net/netfilter/nf_conntrack_extend.c: In function 'nf_ct_ext_
> add':
> net/netfilter/nf_conntrack_extend.c:74:2: error: implicit declaration of function 'kmemleak_not_leak' [-Werror=implicit-function-declaration]
>   kmemleak_not_leak(old);
>   ^~~~~~~~~~~~~~~~~
> cc1: some warnings being treated as errors
>
> Caused by commit
>
>   114aa35d06d4 ("netfilter: conntrack: silent a memory leak warning")
>
> I have added this patch for today:

Ouch, this is actually a correct fix.

Can you please send it formally or maybe Pablo can just take it directly?

Thanks!
