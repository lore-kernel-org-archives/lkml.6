Return-Path: <SRS0=XIf+=PH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A8FC43387
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 07:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52D4620866
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Dec 2018 07:09:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726049AbeL3HJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Dec 2018 02:09:08 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:33076 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725991AbeL3HJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Dec 2018 02:09:07 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id wBU78kQI017145;
        Sun, 30 Dec 2018 08:08:46 +0100
Date:   Sun, 30 Dec 2018 08:08:46 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Joey Pabalinas <joeypabalinas@gmail.com>, mingo@kernel.org,
        paulmck@linux.vnet.ibm.com, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] rcutorture/nolibc: add a bit of documentation to
 explain how to use nolibc
Message-ID: <20181230070846.GA17139@1wt.eu>
References: <20181229180218.15798-1-w@1wt.eu>
 <20181229180218.15798-4-w@1wt.eu>
 <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181229223324.slqx3qjrmzg5g2w2@gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 29, 2018 at 12:33:24PM -1000, Joey Pabalinas wrote:
> On Sat, Dec 29, 2018 at 07:02:18PM +0100, Willy Tarreau wrote:
> > + *   - the lower level is the arch-specific syscall() definition, consisting in
> > + *     assembly code in compound expressions. These are called my_syscall0() to
> > + *     my_syscall6() depending on the number of arguments. The MIPS
> > + *     implementation is limited to 5 arguments. All input arguments are cast
> > + *     to a long stored in a register. These expressions always return the
> > + *     syscall's return value as a signed long value which is often either a
> > + *     pointer or the negated errno value.
> > + *
> > + *   - the second level is mostly architecture-independent. It is made of
> > + *     static functions called sys_<name>() which rely on my_syscallN()
> > + *     depending on the syscall definition. These functions are responsible
> > + *     for exposing the appropriate types for the syscall arguments (int,
> > + *     pointers, etc) and for setting the appropriate return type (often int).
> > + *     A few of them are architecture-specific because the syscalls are not all
> > + *     mapped exactly the same among architectures. For example, some archs do
> > + *     not implement select() and need pselect6() instead, so the sys_select()
> > + *     function will have to abstract this.
> > + *
> > + *   - the third level is the libc call definition. It exposes the lower raw
> > + *     sys_<name>() calls in a way that looks like what a libc usually does,
> > + *     takes care of specific input values, and of setting errno upon error.
> > + *     There can be minor variations compared to standard libc calls. For
> > + *     example the open() call always takes 3 args here.
> 
> Shouldn't these sentences begin with a capitalized "The" for
> consistency?

Not sure since they're just list items. But probably as such they should
end with a semi-colon and not a dot. Anyway, this is minor and likely for
a later update to the file.

> >  /* some archs (at least aarch64) don't expose the regular syscalls anymore by
> >   * default, either because they have an "_at" replacement, or because there are
> >   * more modern alternatives. For now we'd rather still use them.
> 
> Also here. Shouldn't this begin with a capitalized "Some"?

Definitely! Same, I won't emit a patch just for this, Paul already queued it.

Thanks!
Willy
