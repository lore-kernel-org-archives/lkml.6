Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752898AbeCaNjX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 09:39:23 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:55768 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeCaNjW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 09:39:22 -0400
X-Google-Smtp-Source: AIpwx49G0xJTpEIcqaZM3MiFozZM5Z/kpv98YLSmnG/tnRI6BOre1v1H0n6S0NnEBnfr9NBv8Z13LQ==
Date: Sat, 31 Mar 2018 16:39:18 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: peterz@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] refcount: trim headers
Message-ID: <20180331133918.GA9535@avx2>
References: <20180313193410.GA12260@avx2>
 <20180331083632.zufg2gzgjsyemcsq@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331083632.zufg2gzgjsyemcsq@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 10:36:32AM +0200, Ingo Molnar wrote:
> > --- a/include/linux/refcount.h
> > +++ b/include/linux/refcount.h
> >  #include <linux/atomic.h>
> > -#include <linux/mutex.h>
> > -#include <linux/spinlock.h>
> > -#include <linux/kernel.h>
> > +#include <linux/compiler.h>
> > +#include <linux/spinlock_types.h>
> > +
> > +struct mutex;

> Doesn't build on x86-64 defconfig...

Yeah, it doesn't :-(
Is this going to go through -tip?
Or I'll build test over both trees.
