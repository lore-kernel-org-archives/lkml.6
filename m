Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4999BC00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:30:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 023DE21470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 12:30:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 023DE21470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbeJCTTC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 15:19:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:53318 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726619AbeJCTTC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 15:19:02 -0400
Received: from gandalf.local.home (cpe-66-24-56-78.stny.res.rr.com [66.24.56.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA2F42082A;
        Wed,  3 Oct 2018 12:30:45 +0000 (UTC)
Date:   Wed, 3 Oct 2018 08:30:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        David Miller <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>, "Ted Ts'o" <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [GIT PULL linux-next] Add Compiler Attributes tree
Message-ID: <20181003083043.380a2c74@gandalf.local.home>
In-Reply-To: <CANiq72=M2xQa6FJ1YZ2kKuNXES-XSn1O9yJ+FbhgMawND_kAqA@mail.gmail.com>
References: <CANiq72=rgT9cPWH64Tf_8gAU09EiH5FvGqFUdOjV=spVbM5m8Q@mail.gmail.com>
        <20181003071059.02b3fd6f@canb.auug.org.au>
        <CAKwvOdmt4-jFv6d-ZVUH5OOvXSz38jpuNvQy-jtoSS3xEoh78A@mail.gmail.com>
        <CANiq72mmxiO6RWBTQfWYDaa6gmOF01nXmN6BJNCAjAFz3QJqqA@mail.gmail.com>
        <20181002223652.GA4290@nautica>
        <CANiq72=M2xQa6FJ1YZ2kKuNXES-XSn1O9yJ+FbhgMawND_kAqA@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Oct 2018 14:14:28 +0200
Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> wrote:

> HI Dominique,
> 
> On Wed, Oct 3, 2018 at 12:37 AM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> >
> > Miguel Ojeda wrote on Wed, Oct 03, 2018:  
> > > As I have read, -next is supposed to be a vision of what the merge
> > > window will look like after merging everything, i.e. ideally -rc1. For
> > > that to work for files out-of-tree (like these ones, which are not
> > > maintained by a single tree), changes should be allowed to be stacked
> > > on each other; otherwise, we cannot handle conflicts :-(  
> >
> > The rule is the same as with a regular mainline pull; I don't have the
> > reference at hand but in some recent-ish pull request Linus said he  
> 
> That is actually the first problem: there is no
> reference/documentation at hand. :-P
>

Yes, and one of the topics for Maintainers Summit is to create one. One
is actually in the works led by Dan Williams.

-- Steve
