Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3AF2C004D3
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDC9B205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 15:48:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDC9B205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbeJWAH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 20:07:26 -0400
Received: from smtprelay0215.hostedemail.com ([216.40.44.215]:46205 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727590AbeJWAHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 20:07:25 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8891F180A8126;
        Mon, 22 Oct 2018 15:48:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: house85_2a8d16fda765e
X-Filterd-Recvd-Size: 4498
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Oct 2018 15:48:12 +0000 (UTC)
Message-ID: <93bda268c5f55571b47c7f283c027454bbcb8469.camel@perches.com>
Subject: Re: [PATCH 2/2] Compiler Attributes: auxdisplay: panel: use
 __fallthrough
From:   Joe Perches <joe@perches.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dan <dan.carpenter@oracle.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
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
        Jonathan Corbet <corbet@lwn.net>, Ted Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Date:   Mon, 22 Oct 2018 08:48:11 -0700
In-Reply-To: <CANiq72=Eo-c7M1g1gmE0kXNpxe4vkOBT54n9gMB9UBSEfzTMAw@mail.gmail.com>
References: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
         <20181021171414.22674-3-miguel.ojeda.sandonis@gmail.com>
         <f46baa5bb0e3373c89d09b6e0d15170902e5f55c.camel@perches.com>
         <CANiq72=Eo-c7M1g1gmE0kXNpxe4vkOBT54n9gMB9UBSEfzTMAw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-10-22 at 11:51 +0200, Miguel Ojeda wrote:
> On Sun, Oct 21, 2018 at 8:11 PM Joe Perches <joe@perches.com> wrote:
> > On Sun, 2018-10-21 at 19:14 +0200, Miguel Ojeda wrote:
> > > Let gcc know these cases are meant to fall through to the next label
> > > by annotating them with the new __fallthrough statement attribute;
> > > and remove the comment since it conveys the same information
> > > (which was also parsed by gcc to suppress the warning).
> > 
> > Instead of many individual conversion patches,
> > perhaps a script to do all the conversions at once.
> 
> Note that this was only an example of the attribute (some people asked
> for an example when introducing another one, so I preemptively did it
> for this one).
> 
> Doing the conversion (and how :-) I left it for afterwards, if people
> agree with the attribute.
> 
> > Maybe:
> > 
> > pattern='(?:\/\*\s*fall(?:\s*|\s*\-\s*)thr(?:u|ough)\s*\*\/|\/\/\s*fall\s*thr(?:u|ough)\s*$)'
> > git grep -P -i --name-only "$pattern" -- '*.[ch]' |
> >     xargs perl -p -i -e "s/$pattern/__fallthrough;/gi"
> 
> By the way, I checked first if coccinelle could match input comments,
> but it doesn't, according to Julia. I am also thinking whether a
> compiler plugin could easily do this, but I don't have my hopes high
> given these are comments...
> 
> Also, regardless of how it is done, the patches need to be sent
> individually to maintainers, no?

Not really no.  For instance the spdx license treewide change.
commit b24413180f5600bcb3bb70fbed5cf186b60864bd

> I have a vague memory that big &
> automated conversions were a bit frozen upon in the kernel. Greg...?

There really needs to be some method to do treewide
conversions without involving multiple maintainers.

It'd be a good topic for a maintainer summit one day.


