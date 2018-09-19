Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B553BC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F7CC2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 21:24:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F7CC2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbeITDEB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 23:04:01 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37120 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727860AbeITDEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 23:04:00 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC4FDFDA;
        Wed, 19 Sep 2018 21:15:00 +0000 (UTC)
Date:   Wed, 19 Sep 2018 23:14:58 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-sparse@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Compiler Attributes: naked can be shared
Message-ID: <20180919211458.GA8757@kroah.com>
References: <20180918165542.4691-1-miguel.ojeda.sandonis@gmail.com>
 <20180918165542.4691-3-miguel.ojeda.sandonis@gmail.com>
 <20180918173428.GA21591@kroah.com>
 <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=ZU61EaoWm2N4G1SZF0QUvzquULo50uEvDRU-hitOJVQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2018 at 08:56:04PM +0200, Miguel Ojeda wrote:
> Hi Greg,
> 
> On Tue, Sep 18, 2018 at 7:34 PM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Sep 18, 2018 at 06:55:42PM +0200, Miguel Ojeda wrote:
> >> The naked attribute is supported by at least gcc >= 4.6 (for ARM,
> >> which is the only current user), gcc >= 8 (for x86), clang >= 3.1
> >> and icc >= 13. See https://godbolt.org/z/350Dyc
> >>
> >> Therefore, move it out of compiler-gcc.h so that the definition
> >> is shared by all compilers.
> >>
> >> This also fixes Clang support for ARM32 --- 815f0ddb346c
> >> ("include/linux/compiler*.h: make compiler-*.h mutually exclusive").
> >
> > So, with this applied, does clang really build an arm32 kernel
> > successfully?  No other problem at all?  And this isn't really a
> > regression, arm32 never really worked with clang yet, right?
> >
> 
> To recap a bit: these two patches come from the "Compiler Attributes"
> series which is meant as a general improvement.

Ok, so that's not for regressions, that's fine.

> Since Linus/Andrew/you
> didn't comment on whether you wanted or not this for 4.19, we are
> assuming they would go in for 4.20. However, Stefan/Nick/... wanted
> this for 4.19 instead, they asked me to extract these patches two
> separately for 4.19. I let them comment further on the status of Clang
> on arm32.

If these do not fix a regression, I don't see how they would be ready
for 4.19-final.

> I am going to send a v5 of the entire series without these two
> patches, based on -rc4 (or -next, which one do you prefer? I would say
> these patches should be applied early in the -next branches, so that
> everyone is ready for the change, given it "touches" every translation
> unit).

That's up to whomever takes these into their tree for linux-next
inclusion.  If you are about to break everything, then you might
consider changing your patches so they do not do that :)

good luck!

greg k-h
