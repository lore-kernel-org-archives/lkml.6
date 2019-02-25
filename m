Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52590C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 093CC20578
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="hetXVtFt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K4KNdBqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733089AbfBYVh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:37:28 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36281 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387450AbfBYVhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:37:24 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id A637E21C79;
        Mon, 25 Feb 2019 16:37:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Feb 2019 16:37:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=2D2EijxwGcLwZk8cUexk4We++V9
        di4cQNkKvQBErlmU=; b=hetXVtFtBGj/mPvhJYIerdIyonyZzxBP5FfyrcCkOum
        2xs5LEDZqPvPXV8uyje++8NPo5bL1uVfn+JQ0qLW05ZQh3opK16PgUHjdcWRR9tq
        dhbypphJEQ0FuO0QeaXUtaFbwznFF+UWCtUrkmPGh2cj6h1hrJD1HvmlHX88i7jN
        7bil7N4ti1/kODT0QC60CKKBpIUxofWnGIC91PuW5wfieomLvCjZl1Y6dKyTylUE
        GKws9VgsB/2V95iaPikBEVsX6Q1mRRBNFKxnqk/Mf+lW9Mdv6xf72bEQlzTaNzse
        LgJnk8yi2M6geDQNKcABhtMhmKRiUbdAeJw0Pk7pB5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=2D2Eij
        xwGcLwZk8cUexk4We++V9di4cQNkKvQBErlmU=; b=K4KNdBqLRjxigpfzi0F9l1
        ExQ5r5GtRpNtopr8Exkg+jVaGeAiJIzD11SUCIgve/hXYQxfkNNmU26szXuwUvRg
        UwwHRqQdjNPVH4NGQL+TU4XfeaGjJkQZhsyDC1vXyyXMGr2PSzFBlAnk10h+VcpP
        iPQlqiYhOaUVaBM3cQN6qhKcEo3kLBBvLhLRfENNhArtsG8yD1TfsUCsGltWI7IY
        x2h6SNB3+psgn4Pypu3MBR5ujebonlmmhQApvYkwGvfVMDAvsB4hw9LLkA2GP749
        slSM2RVWvjTof2JWNXB9wG2BZkg/zOoRS2KTmB3LYp/F7yeSWvAyN+PT4A2xP7xQ
        ==
X-ME-Sender: <xms:EGB0XEEI6thELfsODUBtpRZ9QyaAh4FqJGz5X8ntn77GpeZSjWGKDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrudejgdduhedvucdltddurdegtdelrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesth
    hosghinhdrtggtqeenucffohhmrghinheptghouggvrddqqddquggvvhenucfkphepuddv
    uddrgeegrddvhedtrdekjeenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehtohgsih
    hnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:EGB0XBnfIDree1XwH9tkId0SI0y2K7rQogq1WRUDbminnShXJpKnSQ>
    <xmx:EGB0XJJgJmN5RZEVhK8L0HiCpF8F5yrLSsjopw_J2Z_NE7Kz02EtiQ>
    <xmx:EGB0XKZTsWOJo8T8b5HXWhok0XeafV3Me-Sj9tpOY0jjbXsnwkEK_A>
    <xmx:EmB0XP8dxyBvQq26enKKUru4tbUHKzrfo0LKITNdB2aBkuIQdYgOHA>
Received: from localhost (ppp121-44-250-87.bras2.syd2.internode.on.net [121.44.250.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9078AE4146;
        Mon, 25 Feb 2019 16:37:18 -0500 (EST)
Date:   Tue, 26 Feb 2019 08:37:03 +1100
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
Message-ID: <20190225213703.GC5177@eros.localdomain>
References: <20190225041534.27186-1-tobin@kernel.org>
 <20190225041534.27186-2-tobin@kernel.org>
 <CAHp75Vfq5KQupcyx_84YcSOQ8mvNDvFE3R20KdyLEqEz74p3OQ@mail.gmail.com>
 <20190225213109.GB5177@eros.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225213109.GB5177@eros.localdomain>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 08:31:09AM +1100, Tobin C. Harding wrote:
> On Mon, Feb 25, 2019 at 10:19:47AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 25, 2019 at 6:17 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > >
> > > We have a function to copy strings safely and we have a function to copy
> > > strings and zero the tail of the destination (if source string is
> > > shorter than destination buffer) but we do not have a function to do
> > > both at once.  This means developers must write this themselves if they
> > > desire this functionality.  This is a chore, and also leaves us open to
> > > off by one errors unnecessarily.
> > >
> > > Add a function that calls strscpy() then memset()s the tail to zero if
> > > the source string is shorter than the destination buffer.
> > >
> > > Add test module for the new code.
> > 
> > > --- /dev/null
> > > +++ b/lib/test_strscpy.c
> > > @@ -0,0 +1,175 @@
> > 
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > > +MODULE_LICENSE("GPL");
> > 
> > License mismatch.
> 
> Thanks, will re-spin with 
> 
>   // SPDX-License-Identifier: GPL-2.0+
> 
> > Do we need a separate module for this test?
> 
> Separate as in not in lib/test_string.h?  I intend on moving the test
> into that file once I've done some cleanup in tools/testing/selftest/lib/
> 
> I also tried to do this without using a module using
> tools/testing/selftest/kselftest_harness.h but I could not get the
> compiler to see read the patched version of
> linux/include/linux/string.h?
> 
> Related question if you feel like answering it; why are test modules for
> lib/ in lib/ and not in tools/testing/?
> 
> Very much open to suggestions on current best practices for kernel testing.

I just read Andy mirskFrom: "Tobin C. Harding" <me@tobin.cc>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Tobin C. Harding" <tobin@kernel.org>,
	Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andy Lutomirski <luto@amacapital.net>,
	Daniel Micay <danielmicay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Bcc: 
Subject: Re: [PATCH v2 1/1] lib/string: Add strscpy_pad() function
Reply-To: 
In-Reply-To: <20190225213109.GB5177@eros.localdomain>
X-Mailer: Mutt 1.11.3 (2019-02-01)

On Tue, Feb 26, 2019 at 08:31:09AM +1100, Tobin C. Harding wrote:
> On Mon, Feb 25, 2019 at 10:19:47AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 25, 2019 at 6:17 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > >
> > > We have a function to copy strings safely and we have a function to copy
> > > strings and zero the tail of the destination (if source string is
> > > shorter than destination buffer) but we do not have a function to do
> > > both at once.  This means developers must write this themselves if they
> > > desire this functionality.  This is a chore, and also leaves us open to
> > > off by one errors unnecessarily.
> > >
> > > Add a function that calls strscpy() then memset()s the tail to zero if
> > > the source string is shorter than the destination buffer.
> > >
> > > Add test module for the new code.
> > 
> > > --- /dev/null
> > > +++ b/lib/test_strscpy.c
> > > @@ -0,0 +1,175 @@
> > 
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > > +MODULE_LICENSE("GPL");
> > 
> > License mismatch.
> 
> Thanks, will re-spin with 
> 
>   // SPDX-License-Identifier: GPL-2.0+
> 
> > Do we need a separate module for this test?
> 
> Separate as in not in lib/test_string.h?  I intend on moving the test
> into that file once I've done some cleanup in tools/testing/selftest/lib/
> 
> I also tried to do this without using a module using
> tools/testing/selftest/kselftest_harness.h but I could not get the
> compiler to see read the patched version of
> linux/include/linux/string.h?
> 
> Related question if you feel like answering it; why are test modules for
> lib/ in lib/ and not in tools/testing/?
> 
> Very much open to suggestions on current best practices for kernel testing.

I just read Andy mirskFrom: "Tobin C. Harding" <me@tobin.cc>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "Tobin C. Harding" <tobin@kernel.org>,
	Kees Cook <keescook@chromium.org>, Jann Horn <jannh@google.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Andy Lutomirski <luto@amacapital.net>,
	Daniel Micay <danielmicay@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Bcc: 
Subject: Re: [PATCH v2 1/1] lib/string: Add strscpy_pad() function
Reply-To: 
In-Reply-To: <20190225213109.GB5177@eros.localdomain>
X-Mailer: Mutt 1.11.3 (2019-02-01)

On Tue, Feb 26, 2019 at 08:31:09AM +1100, Tobin C. Harding wrote:
> On Mon, Feb 25, 2019 at 10:19:47AM +0200, Andy Shevchenko wrote:
> > On Mon, Feb 25, 2019 at 6:17 AM Tobin C. Harding <tobin@kernel.org> wrote:
> > >
> > > We have a function to copy strings safely and we have a function to copy
> > > strings and zero the tail of the destination (if source string is
> > > shorter than destination buffer) but we do not have a function to do
> > > both at once.  This means developers must write this themselves if they
> > > desire this functionality.  This is a chore, and also leaves us open to
> > > off by one errors unnecessarily.
> > >
> > > Add a function that calls strscpy() then memset()s the tail to zero if
> > > the source string is shorter than the destination buffer.
> > >
> > > Add test module for the new code.
> > 
> > > --- /dev/null
> > > +++ b/lib/test_strscpy.c
> > > @@ -0,0 +1,175 @@
> > 
> > > +// SPDX-License-Identifier: GPL-2.0
> > 
> > > +MODULE_LICENSE("GPL");
> > 
> > License mismatch.
> 
> Thanks, will re-spin with 
> 
>   // SPDX-License-Identifier: GPL-2.0+
> 
> > Do we need a separate module for this test?
> 
> Separate as in not in lib/test_string.h?  I intend on moving the test
> into that file once I've done some cleanup in tools/testing/selftest/lib/
> 
> I also tried to do this without using a module using
> tools/testing/selftest/kselftest_harness.h but I could not get the
> compiler to see read the patched version of
> linux/include/linux/string.h?
> 
> Related question if you feel like answering it; why are test modules for
> lib/ in lib/ and not in tools/testing/?
> 
> Very much open to suggestions on current best practices for kernel testing.

I just read Andy Lutomirski's patch

       [PATCH 2/2] uaccess: Add a selftest for strncpy_from_user()

That's a better approach for this one also, right?  Put the test in
string.c and ifdef guard it with a config option.

thanks,
Tobin.
