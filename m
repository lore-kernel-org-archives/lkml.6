Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0F6C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D2208B3
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 00:34:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWktOBfb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1D2208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726914AbeI0GuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 02:50:17 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:52120 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbeI0GuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 02:50:17 -0400
Received: by mail-it1-f193.google.com with SMTP id 74-v6so3902378itw.1;
        Wed, 26 Sep 2018 17:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aCL+Y3Elp9js0tskQ42GEDjYhI0l5SAZZjTRQ2rGzW4=;
        b=gWktOBfbdrBncdviL20J5F04FWoaz6YrOuZLdcCDBv1a1+de7firBMdo56D5siKbuP
         knUUB/mvtfUFAgKRLK6W3vSmF/mpPs+gnm6yp5S+r9Ha9FPHQr2nPuRnqXV2poXWKJJ3
         HIOfbb4fDeKHAeNv1BJcfuUtpb1jGZYjKdkWtTH9UaLxMDvX8nuhR5WKVgZkkOz9BpEd
         CI7OaIPDPdJciw65l552y88iAqeLkftXzSYBxY3FdNga0rrtQBxT8YIewUygbcNpeekX
         N1FJ36m7Pb9UOF1rdrmYpWB/Tlp8yZqialQsEs2ivoPFIrl6lxYgw/zD3yJUoC9cbydD
         y/kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aCL+Y3Elp9js0tskQ42GEDjYhI0l5SAZZjTRQ2rGzW4=;
        b=bOk2SQIDQa9qg2j0oTCXzJcVx08eoORVxGGHKVN1Cabg9OpQ53YulLZB5TUlws2oPh
         H0ZGCDfALRwXzvGKulmeW1WYZJypZ6RcuVYGkr/MmdyHnd5QD0QRSNOEKLBWzeRW0Gof
         XaIOuktmh+J1PhpkWpFij4/66BNSY4QG2aZ2BvS4e4v7gF38Fs/4vLdzf3yXiSDwKNoO
         j5X1s4wILLQo1bUuxjLn0L0kVujX4GKATy6GaMrrWp5dBvzQ0ymHKQBdz7OJYIiBRpVW
         nFK+hUdHfodStPW9rTCQBC5aaFsUxQeQmNIfjU3MNCtbjpWQqGlTQBImXg3WzM+E/4jO
         +KGw==
X-Gm-Message-State: ABuFfojG1t/W3MrfOM7rpFN6XUWovS/NsciycGaWSP4iVSV9rr1r6Inj
        qt+t/ZpYtrStzf4H/91sDCq/6cb6M2rckgEEh68=
X-Google-Smtp-Source: ACcGV60OAZQmP5vY8eqKtSx1NklVALWsgxgzNJor5OtZ8jnmAORXbLTb9Endu8EQp7BjsTC54YL6VZvdYwYvpa0EezA=
X-Received: by 2002:a02:7a12:: with SMTP id a18-v6mr7812760jac.42.1538008483880;
 Wed, 26 Sep 2018 17:34:43 -0700 (PDT)
MIME-Version: 1.0
References: <1536927045-23536-1-git-send-email-rppt@linux.vnet.ibm.com>
 <1536927045-23536-4-git-send-email-rppt@linux.vnet.ibm.com>
 <CAKgT0UdP=78RsWHMxFu4PD8a3AhA3eNcG68Z_9aGY0vhOKf7xA@mail.gmail.com> <20180926183152.GA4597@rapoport-lnx>
In-Reply-To: <20180926183152.GA4597@rapoport-lnx>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Wed, 26 Sep 2018 17:34:32 -0700
Message-ID: <CAKgT0UcC-GTtyPK9ynvj6r3YFqy8kE40iMJxzPowbNoXGf9iWg@mail.gmail.com>
Subject: Re: [PATCH 03/30] mm: remove CONFIG_HAVE_MEMBLOCK
To:     rppt@linux.vnet.ibm.com
Cc:     linux-mm <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>, chris@zankel.net,
        David Miller <davem@davemloft.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>, green.hu@gmail.com,
        Greg KH <gregkh@linuxfoundation.org>, gxt@pku.edu.cn,
        Ingo Molnar <mingo@redhat.com>, jejb@parisc-linux.org,
        jonas@southpole.se, Jonathan Corbet <corbet@lwn.net>,
        lftan@altera.com, msalter@redhat.com,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        mattst88@gmail.com, mpe@ellerman.id.au,
        Michal Hocko <mhocko@suse.com>, monstr@monstr.eu,
        palmer@sifive.com, paul.burton@mips.com, rkuo@codeaurora.org,
        richard@nod.at, dalias@libc.org,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        fancer.lancer@gmail.com, Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, vgupta@synopsys.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:32 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
>
> On Wed, Sep 26, 2018 at 09:58:41AM -0700, Alexander Duyck wrote:
> > On Fri, Sep 14, 2018 at 5:11 AM Mike Rapoport <rppt@linux.vnet.ibm.com> wrote:
> > >
> > > All architecures use memblock for early memory management. There is no need
> > > for the CONFIG_HAVE_MEMBLOCK configuration option.
> > >
> > > Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
> >
> > <snip>
> >
> > > diff --git a/include/linux/memblock.h b/include/linux/memblock.h
> > > index 5169205..4ae91fc 100644
> > > --- a/include/linux/memblock.h
> > > +++ b/include/linux/memblock.h
> > > @@ -2,7 +2,6 @@
> > >  #define _LINUX_MEMBLOCK_H
> > >  #ifdef __KERNEL__
> > >
> > > -#ifdef CONFIG_HAVE_MEMBLOCK
> > >  /*
> > >   * Logical memory blocks.
> > >   *
> > > @@ -460,7 +459,6 @@ static inline phys_addr_t memblock_alloc(phys_addr_t size, phys_addr_t align)
> > >  {
> > >         return 0;
> > >  }
> > > -#endif /* CONFIG_HAVE_MEMBLOCK */
> > >
> > >  #endif /* __KERNEL__ */
> >
> > There was an #else above this section and I believe it and the code
> > after it needs to be stripped as well.
>
> Right, I've already sent the fix [1] and it's in mmots.
>
> [1] https://lkml.org/lkml/2018/9/19/416
>

Are you sure? The patch you reference appears to be for
drivers/of/fdt.c, and the bit I pointed out here is in
include/linux/memblock.h.

- Alex
