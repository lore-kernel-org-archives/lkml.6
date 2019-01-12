Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17914C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0BF32084E
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 14:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GimcIYZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725863AbfALOVN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 09:21:13 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43061 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfALOVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 09:21:12 -0500
Received: by mail-pl1-f195.google.com with SMTP id gn14so8085739plb.10;
        Sat, 12 Jan 2019 06:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AgztArJgeyI5akkyciYTqOnUwbkH9r4FP5+/k10NYlQ=;
        b=GimcIYZKXTRu9g1J9k8L0qcyKVYBysJpjcAGwKF1FQ5PS+5A213ABMU3N4S60RJGjq
         AYWlgFQpTN6dWDaz9zTgd15Hkin1sfazkfJIgaVQPA06xP02f6M7XJLDMcrstcXiCxhH
         x5qdu8A9LyKyDxeTg0QzBbh/1eAuRnjgapXIrKV8FH5ifgS0tX4mDCI+qZKSAACtxsWm
         UREh7KwBEpVh8jDG6bTAjt+v0CVyLr07jaDcV5wUtVrZDhN14AHu+Wkh4rpe798n+pLv
         2gNLoXBbKmC/fxElnVHgD716ayuAjpv688SdllVuIma9V01oOVXu9VQrkT/yGC1uwzo/
         DBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AgztArJgeyI5akkyciYTqOnUwbkH9r4FP5+/k10NYlQ=;
        b=PBRA/hBk1y7aBUgiAPv2a67BqgwoCekBzYlWrcGhJa2gGbfGrMd8VF+TrzWql2P+lG
         Qsvhiitx1Pmuq+WVC+fZgMsUltiZZWOf60ON+c4nIjOhaKGvPVN+qeZWvb7hZuztnaJF
         8m1oXAAgXE7dXJoA0QDqFg6ccg+2HljmwPkEtad0paqtq7a89ePNfDQUDb+2vbIiDS7Z
         /O6bsvx7c3QXNkLFsCQwD7cUfrThoibNex4bbpyKRUCGuResMLLLHtcYKT2W2THay/aP
         3n23+EfXWy7BPuSX4FbTRz2MNOBKhqlT+YM4rvLyb1XHYKibGH0CbtmUBx6p6id+9m/o
         /xTQ==
X-Gm-Message-State: AJcUukfWPBlYVHIr/1pJcKOhA5xid3/MN5Kc5iRpfoL6eSC5NbM3/f+a
        L8Cd7xtJ6XWe6i8Qe/w6ISg=
X-Google-Smtp-Source: ALg8bN4u0a09j0SanHRTuHYZDh38d4cZ9d5mkCKGk53kYwNpFybtGRJj6Z3KYuyRp2SrYrrFmRErIw==
X-Received: by 2002:a17:902:d01:: with SMTP id 1mr19042800plu.127.1547302870972;
        Sat, 12 Jan 2019 06:21:10 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id w184sm92667189pgd.34.2019.01.12.06.21.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 12 Jan 2019 06:21:10 -0800 (PST)
Date:   Sat, 12 Jan 2019 22:20:58 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Changbin Du <changbin.du@gmail.com>, rostedt@goodmis.org,
        linux@armlinux.org.uk, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fgraph: record function return value
Message-ID: <20190112142056.6imezyzfw64qzg2x@mail.google.com>
References: <20190112065701.30841-1-changbin.du@gmail.com>
 <20190112122113.GR6310@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190112122113.GR6310@bombadil.infradead.org>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Matthew,
On Sat, Jan 12, 2019 at 04:21:13AM -0800, Matthew Wilcox wrote:
> On Sat, Jan 12, 2019 at 02:57:01PM +0800, Changbin Du wrote:
> > This patch adds a new trace option 'funcgraph-retval' and is disabled by
> > default. When this option is enabled, fgraph tracer will show the return
> > value of each function. This is useful to find/analyze a original error
> > source in a call graph.
> > 
> > One limitation is that kernel doesn't know the prototype of functions. So
> > fgraph assumes all functions have a retvalue of type int. You must ignore
> > the value of *void* function. And if the retvalue looks like an error code
> > then both hexadecimal and decimal number are displayed.
> 
> I don't think we can do this.  You're leaking a _lot_ of kernel addresses
> this way, and we've been trying very hard to avoid doing that because
> it gives a lot of information to attackers.
> 
> Something more clever that prints out only errors (ie IS_ERR_VALUE())
> might be acceptable.  I would think printing return values that are
> between 0 and 4095 should also be OK since they can't be real pointers.
> We'd leak whether a function called kmalloc(0, x) since that returns
> 16, but that seems like a not-very-useful information leak.
> 
Regarding to security concern, I don't think this is a problem. Because using
ftrace requires *root* permission. And if the attack has got root previlege,
he/her can obtain nearly all kernel inner information through variant tools.
For example, we can write an eBPF program to probe kernel functions and we
just need root previlege to load our program. We also can use the *crash*
tool to retreive kernel data.

> >  3)   0.247 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> >  3)               |    kvm_arch_vcpu_create() {
> >  3)               |      vmx_create_vcpu() {
> >  3) + 17.969 us   |        kmem_cache_alloc(); /* ret=0xffff88813a980040 */
> >  3) + 15.948 us   |        kmem_cache_alloc(); /* ret=0xffff88813aa99200 */
> >  3)   0.653 us    |        allocate_vpid.part.88(); /* ret=0x1 */
> >  3)   6.964 us    |        kvm_vcpu_init(); /* ret=0xfffffffb */
> >  3)   0.323 us    |        free_vpid.part.89(); /* ret=0x1 */
> >  3)   9.985 us    |        kmem_cache_free(); /* ret=0x80000000 */
> >  3)   9.491 us    |        kmem_cache_free(); /* ret=0x80000000 */
> >  3) + 69.858 us   |      } /* ret=0xfffffffffffffffb/-5 */
> >  3) + 70.631 us   |    } /* ret=0xfffffffffffffffb/-5 */
> >  3)               |    mutex_lock() {
> >  3)               |      _cond_resched() {
> >  3)   0.199 us    |        rcu_all_qs(); /* ret=0x80000000 */
> >  3)   0.594 us    |      } /* ret=0x0 */
> >  3)   1.067 us    |    } /* ret=0x0 */
> >  3)   0.337 us    |    mutex_unlock(); /* ret=0xffff8880738ed040 */
> >  3) + 92.730 us   |  } /* ret=0xfffffffffffffffb/-5 */

-- 
Cheers,
Changbin Du
