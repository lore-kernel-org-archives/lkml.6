Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BB1C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C77552087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 20:09:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tobin.cc header.i=@tobin.cc header.b="pd9z71d8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mHWSJE/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfBYUJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 15:09:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:59115 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726740AbfBYUJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 15:09:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 2049623128;
        Mon, 25 Feb 2019 15:09:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 25 Feb 2019 15:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tobin.cc; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=6rNBST0qRZn1dVNKivmn9saKvfZ
        xhOqzFLCAl18T9Ks=; b=pd9z71d8Yp+YowczMg6iqxAjO1DEQsOxn76kViXx9Sq
        bUaa3BIjeQJWNE8uo78PlAFUnZwdINb9SGkYqpmzDpRLV5LLEYUfhhTHzl3uyQ9b
        EeurQNfeMEMHBgXMwxVsEWulHBnBC75XQ87EGt5ylrp2kManIf1Tot7H/h3f4mDc
        5vafqqNITnBbUItXXC7jZJ68ONTPbjb2alUBi2qdB0SKeJMEPHzlBlZ5i48dwA59
        o8/krraYiUlC1mHL5XHQd35JHrxKECQrLXUnjc2klfBqE6WIq5xrJb8v9wJg2XJt
        i/gXtb6o0c1Uj5QWp8Op5K5/lRZ6LAtmHnAx+LG4sdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6rNBST
        0qRZn1dVNKivmn9saKvfZxhOqzFLCAl18T9Ks=; b=mHWSJE/XoY83FB6Rz5cUO4
        KzaH/6xRlZTGlmMZlLA76sVKImtooD4SCLsHt3xyGKdqa2L7hM5WAIshnWrrKwmN
        Ru1W2vBfW26mx2rRKFKHBYMjKXhQFweOKC60Oxa1uRmoUaxZEGjgDn1bRyyPeqS3
        KLr2LFaExs4Dtf6KWn/dAnh3yXxlWZ60XGhlJKS28iuvzN775C7VViUJkqcEWDxb
        hjBdqSISg76lCojQFFTZfZGxJDBlHHmhesmYnOMOmXIR852lmzSs9rx+0qN/jyqe
        R3TiyLtbX620KioeVmSAWqaSXujkBpTljMRxF8ksO6JLm2TZ/N8hsSCVJQIArRiA
        ==
X-ME-Sender: <xms:k0t0XNoQGdNmywDb1RNVRK2yGra8pTPIHkQJrQLki87tZkRwuorAyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrudejgddufeeiucdltddurdegtdelrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhht
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdeftddmnecujfgurhepfffhvffukfhfgggtuggjofgfsehttder
    tdforedvnecuhfhrohhmpedfvfhosghinhcuvedrucfjrghrughinhhgfdcuoehmvgesth
    hosghinhdrtggtqeenucfkphepuddvuddrgeegrddvhedtrdekjeenucfrrghrrghmpehm
    rghilhhfrhhomhepmhgvsehtohgsihhnrdgttgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:k0t0XCq_Znavl1xjOT3KXnpgp9MMyMOaPkYPLaThSqHGHTaRapO_dQ>
    <xmx:k0t0XF0jOzyFpu1D6yU9sY9xE0V61KiFh48kb7_UtJsfD6vd44J6cA>
    <xmx:k0t0XHknd0kjIqoWFk7FL8Zc5Qqljol_Oy95y91Fd_covnfePeze0A>
    <xmx:lEt0XKKp9vNU2G8t_vs1bCfN9Y9pUgyOvAB0OEi_qFNlHlij8d5SbA>
Received: from localhost (ppp121-44-250-87.bras2.syd2.internode.on.net [121.44.250.87])
        by mail.messagingengine.com (Postfix) with ESMTPA id 99C4EE4624;
        Mon, 25 Feb 2019 15:09:53 -0500 (EST)
Date:   Tue, 26 Feb 2019 07:09:38 +1100
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
Message-ID: <20190225200938.GA5177@eros.localdomain>
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
> 
> Not a blocker, just a TODO: we need a wrapper to do
> CONFIG_FORTIFY_SOURCE checking for strscpy() (and strscpy_zeroed()) to
> check for __builtin_object_size() vs the "size" argument, as done in
> strlcpy() in include/linux/string.h
> 
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

(I meant to reply yesterday before posting v2).  At this stage we know
count >= 0 otherwise written would be less than 0.  So I removed the
'count' from the second part of this statement, leaving

  if (written < 0 || written == count - 1)

>     return written;
> 
> > +
> > +       if (written < count)
> > +               memset(dest + written, 0, count - written);

I used this :)

thanks,
Tobin.
