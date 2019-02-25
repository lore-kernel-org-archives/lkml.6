Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E9A9C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5919420652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="TLesF+KJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4FUAXlQT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbfBYVbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:31:34 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:49901 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731868AbfBYVba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:31:30 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F4183231F9;
        Mon, 25 Feb 2019 16:31:28 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Feb 2019 16:31:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=sZVfSpxnxXTkOYoGGbfHSYccC2s
        No96JmudZBAEBtn8=; b=TLesF+KJPW6wH9Lwlr5EVXo4S77UofqLAZ0++ItlQGE
        NjDSKnhs5jRn7h8sYEhL7JKRjGGAJg+Wfq9IPYp7HxDOOoThqnfoE3DZHx2xBreC
        OWKDnV56YhEF151w8b0hiQoxXamxNdem0V63noqhFmHUkAQBVJDZJvnou+bC9p0o
        zT9k5+deorSRi0JWmLCErtl1W1GdihWjH8X2wYE04o+7LpqvYK100y+ClFsnKCeU
        /wJDEGD+zUncRFoz10zcr8XBU2Ra4rlxdxTAu0avHRMaTGRsDCEQLrwuSEJnUDhM
        lKLeR/EXBZF/9GNrHPd4RtDO8CqVh1cFu3CfEIPacmQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=sZVfSp
        xnxXTkOYoGGbfHSYccC2sNo96JmudZBAEBtn8=; b=4FUAXlQTtzOAUVEHLSFq5H
        Ak8/sYGl/9XFHcayPpFcPJRKtr+sr7bU8T9V9cWVWZPK0g6tLeaqhQPJmAHMStz2
        6AhoRMhp9UMX0AwSDZDuq0NZz8ShTM+hoVZ8UVzOva8+/TsqAdkYhNGyaDwxj+2c
        2bWFgQ7HXF9qHsmqtXza7oZP/CgC551r5KhYcKrAWsE6Ci6m7RAWhtGjSDN9pN9W
        ZBcbSt47ncbhfqdzQ4PN0Fe+i9yjr5JQVj8Z99ZY63l6C8Toh7dCM7P7jJfN1uoX
        xzVxdADGcEsCasE6jL90F5CQxRaDC9keaKMkQEOFB0z4sfmZJqepy8T1gG55sS8A
        ==
X-ME-Sender: <xms:rl50XJS9SVOxe3TP0-GAJjPlYW6E2SUGR_Z2f_TtPiTm-mc86PLPHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrudejgdduhedvucdltddurdegtdelrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesth
    hosghinhdrtggtqeenucffohhmrghinheptghouggvrddqqddquggvvhenucfkphepuddv
    uddrgeegrddvhedtrdekjeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsih
    hnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:r150XDnURMa2Vw8qkRP1Ssrb6RH4NMtG8BxWai7nza0hhqR852_qeQ>
    <xmx:r150XNbSzfqfMwfrLbxNJNpbvrrrcLevcb3-asg08mMi6x4C9uqI0w>
    <xmx:r150XG014BcAuz5AqNgH1fOdG8ln9kQiUhC69YM8aono7uJOrwU0gQ>
    <xmx:sF50XP6a3D6rO7zAVP4egqkwhg6IdURgTEzFbF-0qK4fsg7NLkl8OQ>
Received: from localhost (ppp121-44-250-87.bras2.syd2.internode.on.net [121.44.250.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id A6F1DE4146;
        Mon, 25 Feb 2019 16:31:25 -0500 (EST)
Date:   Tue, 26 Feb 2019 08:31:09 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Lutomirski <luto@amacapital.net>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] lib/string: Add strscpy_pad() function
Message-ID: <20190225213109.GB5177@eros.localdomain>
References: <20190225041534.27186-1-tobin@kernel.org>
 <20190225041534.27186-2-tobin@kernel.org>
 <CAHp75Vfq5KQupcyx_84YcSOQ8mvNDvFE3R20KdyLEqEz74p3OQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75Vfq5KQupcyx_84YcSOQ8mvNDvFE3R20KdyLEqEz74p3OQ@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2019 at 10:19:47AM +0200, Andy Shevchenko wrote:
> On Mon, Feb 25, 2019 at 6:17 AM Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > We have a function to copy strings safely and we have a function to copy
> > strings and zero the tail of the destination (if source string is
> > shorter than destination buffer) but we do not have a function to do
> > both at once.  This means developers must write this themselves if they
> > desire this functionality.  This is a chore, and also leaves us open to
> > off by one errors unnecessarily.
> >
> > Add a function that calls strscpy() then memset()s the tail to zero if
> > the source string is shorter than the destination buffer.
> >
> > Add test module for the new code.
> 
> > --- /dev/null
> > +++ b/lib/test_strscpy.c
> > @@ -0,0 +1,175 @@
> 
> > +// SPDX-License-Identifier: GPL-2.0
> 
> > +MODULE_LICENSE("GPL");
> 
> License mismatch.

Thanks, will re-spin with 

  // SPDX-License-Identifier: GPL-2.0+

> Do we need a separate module for this test?

Separate as in not in lib/test_string.h?  I intend on moving the test
into that file once I've done some cleanup in tools/testing/selftest/lib/

I also tried to do this without using a module using
tools/testing/selftest/kselftest_harness.h but I could not get the
compiler to see read the patched version of
linux/include/linux/string.h?

Related question if you feel like answering it; why are test modules for
lib/ in lib/ and not in tools/testing/?

Very much open to suggestions on current best practices for kernel testing.

thanks,
Tobin.
