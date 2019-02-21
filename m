Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D680C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:20:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4032148D
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 05:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="Rd1G7CS9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k2493IE4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbfBUFUv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 00:20:51 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47935 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725385AbfBUFUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 00:20:50 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 02CA43262;
        Thu, 21 Feb 2019 00:20:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 21 Feb 2019 00:20:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=HMvRU3rhm6Ybj/buxka43ilgnlz
        sTPH/BSI96sItIN8=; b=Rd1G7CS9UXWMEYiZ0HRwRPp7n89a6g3c6FHiRmPtmes
        gveiVh0D/Q9+Hq1s+GSj3X2sRj9aZQ3xJpQ00VlaXCFYEDR9SoHCUGzMGS0awKzg
        +DZM/RH+wdY0wt8aAbqOdnfakmJXacc8mAA8tCPypnAIjV5ahASnK9SP4DEdmXSY
        CYMKmx2J+e2J3ogth82UphrFnboHLzqsl/eCezelBrlncA3j0J87vqRvLoxk6196
        67LViSyznC6duAgDQlUcvb0NieXwGTz82lE+Lw9LDcwbrtSXmKodxFFMH0dsPyjV
        YP2jRTBrJDDaI3K5nOwJP4VEXKYsB5nEtLGI0Z5T95g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=HMvRU3
        rhm6Ybj/buxka43ilgnlzsTPH/BSI96sItIN8=; b=k2493IE4nCL9T5ko4UBbpi
        6Mmr6ZKKImlEYbVjLwgIqFAbv3jnSRgQ0xS3VF6toJReQl9/4IJ/DjvH7hRvNWsW
        QQcjAAp8PcCdPUUe64msyT7vC6w5f4CTCeO7ClTsXukHgpAzENypVhkRrHzKIqye
        mF/TOnbiEVKceMYUBZsP3mvmarjsYttxZCw8tWIT/eAeLM4ZJ3g97I5KbWoeH1sE
        XVVbzZziisIgjgGYSlLmfMm3kq5vfqA2ZAdvn5TDe5YL6xl428x5eOhhDfVGm9a5
        YspQ4t4IRYTA6Pi4HweW5KifzbN2xkOTUIxYRtNw8iocZAcZiuCMIFssqeaTWi7Q
        ==
X-ME-Sender: <xms:LzVuXOrNOdi_dZBT6dy6El5FlbNS2OcrzOyvceE_iwnq1itniwrcDQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrtdejgdekfeculddtuddrgedtledrtddtmd
    cutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpeffhffvuffkfhggtggujgfofgesthdtredt
    ofervdenucfhrhhomhepfdfvohgsihhnucevrdcujfgrrhguihhnghdfuceomhgvsehtoh
    gsihhnrdgttgeqnecukfhppeduvddurdeggedrvdefledrudeggeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:LzVuXA7eeWDZ-sg_GamLsLaHNI_jvsHpAtO0CIcAmnlC-LwZ74GIdg>
    <xmx:LzVuXOMM9ytKztqdzgm6tIK2oWff0mPsWJ16_JZyfTxPTxOGooSaLw>
    <xmx:LzVuXCN4B3jHhVvOQuCDwUxaOGhqDMFJJ81MS1HlceQJKc5it7BmbA>
    <xmx:MDVuXNxrRcq9CyGc-YLwGKnyyPOzGwdhlGth70K-aheQkqg0X1DEAg>
Received: from localhost (ppp121-44-239-144.bras2.syd2.internode.on.net [121.44.239.144])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1221AE461F;
        Thu, 21 Feb 2019 00:20:46 -0500 (EST)
Date:   Thu, 21 Feb 2019 16:20:34 +1100
From:   "Tobin C. Harding" <me@tobin.cc>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>
Subject: Re: [PATCH 4/6] lib/string: Add string copy/zero function
Message-ID: <20190221052034.GE11758@eros.localdomain>
References: <20190218232308.11241-1-tobin@kernel.org>
 <20190218232308.11241-5-tobin@kernel.org>
 <CAGXu5jJe7CiQ0aResT4Hnsuhm+grZyLTcVAkdwsBdtbdrnBbuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXu5jJe7CiQ0aResT4Hnsuhm+grZyLTcVAkdwsBdtbdrnBbuQ@mail.gmail.com>
X-Mailer: Mutt 1.11.3 (2019-02-01)
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 04:48:18PM -0800, Kees Cook wrote:
> On Mon, Feb 18, 2019 at 3:24 PM Tobin C. Harding <tobin@kernel.org> wrote:
> >
> > We have a function to copy strings safely and we have a function to copy
> > strings _and_ zero the tail of the destination (if source string is
> > shorter than destination buffer) but we do not have a function to do
> > both at once.  This means developers must write this themselves if they
> > desire this functionality.  This is a chore, and also leaves us open to
> > off by one errors unnecessarily.
> >
> > Add a function that calls strscpy() then memset()s the tail to zero if
> > the source string is shorter than the destination buffer.
> >
> > Add testing via kselftest.
> >
> > Signed-off-by: Tobin C. Harding <tobin@kernel.org>
> > ---
> >  include/linux/string.h |  4 ++++
> >  lib/Kconfig.debug      |  2 +-
> >  lib/string.c           | 30 ++++++++++++++++++++++++++++--
> >  lib/test_string.c      | 31 +++++++++++++++++++++++++++++++
> >  4 files changed, 64 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/string.h b/include/linux/string.h
> > index 7927b875f80c..695a5e6a31e3 100644
> > --- a/include/linux/string.h
> > +++ b/include/linux/string.h
> > @@ -31,6 +31,10 @@ size_t strlcpy(char *, const char *, size_t);
> >  #ifndef __HAVE_ARCH_STRSCPY
> >  ssize_t strscpy(char *, const char *, size_t);
> >  #endif
> > +
> > +/* Wrapper function, no arch specific code required */
> > +ssize_t strscpy_zeroed(char *dest, const char *src, size_t count);
> 
> bikeshed: I think "pad" is shorter and more descriptive. How about
> something like strspad() strscpy_pad() or strscpy_zero()? (just to
> shorten it slightly)

I like strscpy_pad()

> Not a blocker, just a TODO: we need a wrapper to do
> CONFIG_FORTIFY_SOURCE checking for strscpy() (and strscpy_zeroed()) to
> check for __builtin_object_size() vs the "size" argument, as done in
> strlcpy() in include/linux/string.h

I'll look into this for v2

> > @@ -238,6 +237,33 @@ ssize_t strscpy(char *dest, const char *src, size_t count)
> >  EXPORT_SYMBOL(strscpy);
> >  #endif
> >
> > +/**
> > + * strscopy_zeroed() - Copy a C-string into a sized buffer
> > + * @dest: Where to copy the string to
> > + * @src: Where to copy the string from
> > + * @count: Size of destination buffer
> > + *
> > + * If the source string is shorter than the destination buffer, zeros
> > + * the tail of the destination buffer.
> > + *
> > + * Return: The number of characters copied (not including the trailing
> > + *         NUL) or -E2BIG if the destination buffer wasn't big enough.
> > + */
> > +ssize_t strscpy_zeroed(char *dest, const char *src, size_t count)
> > +{
> > +       ssize_t written;
> > +
> > +       written = strscpy(dest, src, count);
> > +       if (written < 0)
> > +               return written;
> 
> If written < 0 we filled everything (i.e. we wrote "count - 1" bytes).
> If we also exactly wrote "count - 1", then we also don't need the zero
> padding either, since strscpy wrote the trailing NUL.
> 
> so:
> 
> if (written < 0 || (count && written == count - 1))
>     return written;
> 
> > +
> > +       if (written < count)
> > +               memset(dest + written, 0, count - written);
> 
> Now we know written must be [0, count - 2], so we can just:
> 
> memset(dest + written + 1, 0, count - written - 1);
> 
> The pattern (which should be added to the seltest) is:
> 
> count           source  written                                 pad@
> 0               *       -E2BIG (0 char, 0 NUL, 0 to zero)
> 
> 1               "a"     -E2BIG (0 char, 1 NUL, 0 to zero)
> 1               ""      0 (0 char, 1 NUL, 0 to zero)
> 
> 2               "ab"    -E2BIG (1 char, 1 NUL, 0 to zero)
> 2               "a"     1 (1 char, 1 NUL, 0 to zero)
> 2               ""      0 (0 char, 1 NUL, 1 to zero)            dest + 1
> 
> 3               "abc"   -E2BIG (2 char, 1 NUL, 0 to zero)
> 3               "ab"    2 (2 char, 1 NUL, 0 to zero)
> 3               "a"     1 (1 char, 1 NUL, 1 to zero)            dest + 2
> 3               ""      0 (0 char, 1 NUL, 2 to zero)            dest + 1
> 
> 4               "abcd"  -E2BIG (3 char, 1 NUL, 0 to zero)
> 4               "abc"   3 (3 char, 1 NUL, 0 to zero)
> 4               "ab"    2 (2 char, 1 NUL, 1 to zero)            dest + 3
> 4               "a"     1 (1 char, 1 NUL, 2 to zero)            dest + 2
> 4               ""      0 (0 char, 1 NUL, 3 to zero)            dest + 1

So thorough, you're the man.

> > +
> > +       return written;
> > +}
> > +EXPORT_SYMBOL(strscpy_zeroed);
> > +
> >  #ifndef __HAVE_ARCH_STRCAT
> >  /**
> >   * strcat - Append one %NUL-terminated string to another
> > diff --git a/lib/test_string.c b/lib/test_string.c
> > index a9cba442389a..cc4eef51a395 100644
> > --- a/lib/test_string.c
> > +++ b/lib/test_string.c
> > @@ -111,6 +111,32 @@ static __init int memset64_selftest(void)
> >         return 0;
> >  }
> >
> > +static __init int strscpy_zeroed_selftest(void)
> > +{
> > +       char buf[6];
> > +       int written;
> > +
> > +       memset(buf, 'a', sizeof(buf));
> > +
> > +       written = strscpy_zeroed(buf, "bb", 4);
> > +       if (written != 2)
> > +               return 1;
> > +
> > +       /* Copied correctly */
> > +       if (buf[0] != 'b' || buf[1] != 'b')
> > +               return 2;
> > +
> > +       /* Zeroed correctly */
> > +       if (buf[2] != '\0' || buf[3] != '\0')
> > +               return 3;
> > +
> > +       /* Only touched what it was supposed to */
> > +       if (buf[4] != 'a' || buf[5] != 'a')
> > +               return 4;
> > +
> > +       return 0;
> > +}
> 
> Cool, I like both the positive and negative tests. :) Can you add all
> the cases above, too, which should validate the various corners?

Sure thing.

> > +
> >  static __init int test_string_init(void)
> >  {
> >         int test, subtest;
> > @@ -130,6 +156,11 @@ static __init int test_string_init(void)
> >         if (subtest)
> >                 goto fail;
> >
> > +       test = 4;
> > +       subtest = strscpy_zeroed_selftest();
> > +       if (subtest)
> > +               goto fail;
> > +
> >         pr_info("String selftests succeeded\n");
> >         return 0;
> >  fail:
> > --
> > 2.20.1
> >
> 
> Nice! :)

Cheers.  And they said we don't test in kernel land :)

	Tobin
