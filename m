Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA40C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E6A12083F
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 18:39:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E6A12083F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbeIAWwQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 18:52:16 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58176 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbeIAWwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 18:52:16 -0400
Received: from localhost (65-114-90-19.dia.static.qwest.net [65.114.90.19])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 01D45CE6;
        Sat,  1 Sep 2018 18:39:22 +0000 (UTC)
Date:   Sat, 1 Sep 2018 11:39:20 -0700
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: Re: [PATCH 7/7] Compiler Attributes: use feature checks instead of
 version checks
Message-ID: <20180901183920.GA8341@kroah.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
 <20180831170514.24665-7-miguel.ojeda.sandonis@gmail.com>
 <CAKwvOdmF7bPJvnf38HYvnzdo8vO4K5=qkFwdTqwNnKA6PUVwpQ@mail.gmail.com>
 <CANiq72mfuJ2=v8U9vUs1vJVEjY2sp7f-WbTRZRHNvgh+VbAgnA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72mfuJ2=v8U9vUs1vJVEjY2sp7f-WbTRZRHNvgh+VbAgnA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 01, 2018 at 03:38:13PM +0200, Miguel Ojeda wrote:
> Hi Nick,
> 
> On Sat, Sep 1, 2018 at 1:07 AM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > Overall, pretty happy with this patch.  Still some thoughts for a v3,
> >> -#define __visible      __attribute__((externally_visible))
> >> diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
> >> new file mode 100644
> >> index 000000000000..a9dfafc8fd19
> >> --- /dev/null
> >> +++ b/include/linux/compiler_attributes.h
> >> @@ -0,0 +1,226 @@
> >
> > New file needs an SPDX license identifier right?
> 
> Yeah, but I wasn't sure of adding it, since the code I moved (even if
> rearranged) from _types.h does not have it either. Any legal expert
> here? Is _types.h it implicitly GPL 2? We should add the identifier to
> both if so.

It looks like we missed that file in the big "properly add SPDX
identifiers to all files without a license" commit as it came in from a
different tree.

But yes, it is GPLv2 only implicitly, so you can add that.  I should
sweep the tree again to see if anything else has been added accidentally
with that same problem.

thanks,

greg k-h
