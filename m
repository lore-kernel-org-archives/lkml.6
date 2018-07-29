Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C3D8C46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 16:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D3D020857
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 16:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D3D020857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbeG2SCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 14:02:54 -0400
Received: from smtprelay0214.hostedemail.com ([216.40.44.214]:48579 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726458AbeG2SCy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 14:02:54 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BD21B837F243;
        Sun, 29 Jul 2018 16:31:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: lead14_84ef92bce8f2a
X-Filterd-Recvd-Size: 2002
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 29 Jul 2018 16:31:53 +0000 (UTC)
Message-ID: <fe87537776a8a22676536babd2a8eba3c8667705.camel@perches.com>
Subject: Re: [PATCH V2] riscv: Convert uses of REG_FMT to %p
From:   Joe Perches <joe@perches.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sun, 29 Jul 2018 09:31:52 -0700
In-Reply-To: <CAHp75VcvdAVWCuUpj+aQeD5aEU1LM1SjOPJ7_1hdQnQiya36SA@mail.gmail.com>
References: <e14dedc721b7aed1cf3ff1bdbc09014c0131c276.1532795905.git.joe@perches.com>
         <CAHp75VcvdAVWCuUpj+aQeD5aEU1LM1SjOPJ7_1hdQnQiya36SA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-07-29 at 17:21 +0300, Andy Shevchenko wrote:
> On Sat, Jul 28, 2018 at 7:39 PM, Joe Perches <joe@perches.com> wrote:
> > Use %p pointer output instead of REG_FMT and cast the unsigned longs to
> > (void *) to avoid exposing kernel addresses.
> > 
> > Miscellanea:
> > 
> > o Convert pr_cont to printk(KERN_DEFAULT as these uses are
> >   new logging lines and not previous line continuations
> > o Remove the now unused REG_FMT defines
> > +       pr_alert("Unable to handle kernel %s at virtual address %p\n",
> > +                (addr < PAGE_SIZE) ? "NULL pointer dereference" :
> > +                "paging request", (void *)addr);
> 
> Hmm... This is what printf() should take care of.

Why is that so here?

Here this is just a description of the address.
It's not actually dereferencing the address.

> Petr, what is the status of your series to unify this kind of
> addresses to be printed?

