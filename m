Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E17C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:45:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FAE020893
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 16:45:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FAE020893
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727443AbeHUUG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 16:06:27 -0400
Received: from smtprelay0052.hostedemail.com ([216.40.44.52]:54881 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726734AbeHUUG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 16:06:27 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id CBFDE180A884B;
        Tue, 21 Aug 2018 16:45:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: peace76_876e920e42646
X-Filterd-Recvd-Size: 2780
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Tue, 21 Aug 2018 16:45:30 +0000 (UTC)
Message-ID: <acb93bae0086447c7cbe0eec05907335ebae7788.camel@perches.com>
Subject: Re: [PATCH] compiler-gcc: get back Clang build
From:   Joe Perches <joe@perches.com>
To:     Nick Desaulniers <ndesaulniers@google.com>, asmadeus@codewreck.org
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Arnd Bergmann <arnd@arndb.de>, dwmw@amazon.co.uk,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will.deacon@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Date:   Tue, 21 Aug 2018 09:45:28 -0700
In-Reply-To: <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
References: <1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com>
         <20180821123832.GA19034@nautica>
         <CAKwvOdmLQen+TWF_F3e5-66vtF3FEnoxjEgZbjmOZ9cv6YrEpA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-08-21 at 09:32 -0700, Nick Desaulniers wrote:
> On Tue, Aug 21, 2018 at 5:38 AM Dominique Martinet
> <asmadeus@codewreck.org> wrote:
> > 
> > Nick Desaulniers Aug. 21, 2018, 8:09 a.m. UTC:
> > > Thanks for noticing, and sending this patch.  I'm happy to see others
> > > testing with Clang.  I noticed this too near the end of the day
> > > https://github.com/ClangBuiltLinux/linux/issues/27.
> > 
> > FWIW libbcc so many BPF users also use clang, so this has more impact
> > than just testing to build linux with clang (not that this would be any
> > reason to delay fixing either way)
> > 
> > I would tend to agree havin a compiler-common + make clang/intel not
> > include compiler-gcc would probably be best in the long run but we might
> > want a quick fix for 4.19 meanwhile..
> 
> That's fair. SOP here is quick (full) revert, then come up with a
> better fix.  And I do prefer Masahiro's partial revert to a full
> revert of Joe's patch.  That will give us more time to develop the
> proper fix rather than rush.  I'll try to see how we can more properly
> split the compiler specific headers.
> 
> Tested with gcc-7 and clang-8.

clang-8? Isn't the latest officlal clang 6.0.1 ?

http://releases.llvm.org/

vs

https://clang.llvm.org/docs/ReleaseNotes.html

So if something other than 6.0.x is required,
then some additional check should probably be
added to compiler-clang.h as well.

