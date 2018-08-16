Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF12FC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:48:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E3712148E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E3712148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389841AbeHPLp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:45:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:35924 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726284AbeHPLp4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:45:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 05A2EAE10;
        Thu, 16 Aug 2018 08:48:54 +0000 (UTC)
Date:   Thu, 16 Aug 2018 10:48:53 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] riscv: Convert uses of REG_FMT to %p
Message-ID: <20180816084853.plptubcgubpc5fm4@pathway.suse.cz>
References: <e14dedc721b7aed1cf3ff1bdbc09014c0131c276.1532795905.git.joe@perches.com>
 <CAHp75VcvdAVWCuUpj+aQeD5aEU1LM1SjOPJ7_1hdQnQiya36SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcvdAVWCuUpj+aQeD5aEU1LM1SjOPJ7_1hdQnQiya36SA@mail.gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2018-07-29 17:21:19, Andy Shevchenko wrote:
> On Sat, Jul 28, 2018 at 7:39 PM, Joe Perches <joe@perches.com> wrote:
> > Use %p pointer output instead of REG_FMT and cast the unsigned longs to
> > (void *) to avoid exposing kernel addresses.
> >
> > Miscellanea:
> >
> > o Convert pr_cont to printk(KERN_DEFAULT as these uses are
> >   new logging lines and not previous line continuations
> > o Remove the now unused REG_FMT defines
> 
> > +       pr_alert("Unable to handle kernel %s at virtual address %p\n",
> 
> > +                (addr < PAGE_SIZE) ? "NULL pointer dereference" :
> > +                "paging request", (void *)addr);
> 
> Hmm... This is what printf() should take care of.
> 
> Petr, what is the status of your series to unify this kind of
> addresses to be printed?

Ah, I had to put the series on hold because of other urgent work and
vacations. But I am going to continue on it and resend it within next
weeks or so.

Best Regards,
Petr
