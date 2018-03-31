Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeCaSqW (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 14:46:22 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34068 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeCaSqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 14:46:20 -0400
X-Google-Smtp-Source: AIpwx4+xvhkn6QCm6JvjSANLGAuUDGY1NfLNlniS0GhinFZdy80Oa5S+rX5bxsaYpCK9cTeujKbW3Q==
Date: Sat, 31 Mar 2018 20:46:17 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: trim headers
Message-ID: <20180331184617.b7lmphk2jsipghii@gmail.com>
References: <20180313193410.GA12260@avx2>
 <20180331083632.zufg2gzgjsyemcsq@gmail.com>
 <20180331133918.GA9535@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331133918.GA9535@avx2>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Sat, Mar 31, 2018 at 10:36:32AM +0200, Ingo Molnar wrote:
> > > --- a/include/linux/refcount.h
> > > +++ b/include/linux/refcount.h
> > >  #include <linux/atomic.h>
> > > -#include <linux/mutex.h>
> > > -#include <linux/spinlock.h>
> > > -#include <linux/kernel.h>
> > > +#include <linux/compiler.h>
> > > +#include <linux/spinlock_types.h>
> > > +
> > > +struct mutex;
> 
> > Doesn't build on x86-64 defconfig...
> 
> Yeah, it doesn't :-(
> Is this going to go through -tip?
> Or I'll build test over both trees.

Yeah, refcount changes go through the locking tree, so testing it against -tip 
would be useful.

Thanks,

	Ingo
