Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66D6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F58B20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 21:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YT1/bCEe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbfBRVNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 16:13:40 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:42018 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfBRVNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 16:13:40 -0500
Received: by mail-ot1-f68.google.com with SMTP id i5so30614285oto.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 13:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8pVz6FJ96A6Mg/efqtfL2WLsrGV40vW25C2TmBPmZUU=;
        b=YT1/bCEeB16qk/gFF6vwA2aVnGQ83rJp49XSYWfgdjGU0f+1WL+MwOHRQR5+XF5MvB
         YnEfUTVQc6GQy5Om4T7RDoO4SG4pvomT+iGeoPdR1K0mpG3LWFQP+OOkVxLYb2h0v+wj
         Y57ZYR0HZV2Jcw46SjcQW6qlEiN90TD37S+dhvLIhChwag91vwAg/X0pSwFXngAB+UUB
         03FHfyMtXJbqVtTACMi8pu/evwpCzF2hXk5VAMCsu2G6m62/6ZZJejm/QNmb6v+hT/Rd
         Gwpvt4BuAtumx7lG2I6wlH6dC7jYYmkdUUG4abb8Y//zHKyuBI6Gb9RFNOicDGEaQ2Wc
         tX9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8pVz6FJ96A6Mg/efqtfL2WLsrGV40vW25C2TmBPmZUU=;
        b=j/6+vvHc8S0KhjhS2ERUT6p7A+T9kgWnRQSdmJWQgUlUayZ05sRqEcjTAnTqyg/W2U
         l5NH2v6tfoscRGX6PjnBKKeFvgRnsvVcL6D/K/EMdukcn0bOKmMoFAxdwG1JDk8FzHMO
         wsOcnf/mf0tkQWYKSK43/N1d8bPbRfF5m51fMeQ4/MUV3tt30bH2NCiPrJ9K5aSQ9vO1
         wUoYbHvhVQqfN8UOFtA3eNGrI6CNL9+sur43/FgqqnYJL49XxkSPEXxoNHWwcacHxyke
         aK4rhJmRBx8N6P0edCUW7QuLJAudgd8JKBwEOtjdHagamU120VnQMH9+Gj0PoX52kk4S
         6kSQ==
X-Gm-Message-State: AHQUAuZAsYdeYYOFxJW1FoD3OibpM2I2KoMu8DOvMSg+XN/+9V55Jo8G
        s3RN5F7/1xt2JNqiUvaxGG0vK0qB0ZK9OQurNmlD+g==
X-Google-Smtp-Source: AHgI3IYg/zSgjWfOTCp/iF1qXarSp7oCDM0hZE/XgxK+4j9W/MY6SWVNzXRR8XOL7glXjkqebyvmBOzw1t/cGCvs26M=
X-Received: by 2002:a9d:6c84:: with SMTP id c4mr8819071otr.242.1550524418806;
 Mon, 18 Feb 2019 13:13:38 -0800 (PST)
MIME-Version: 1.0
References: <20190215235901.23541-1-baloo@gandi.net> <CAG48ez2tYizTKncevLF=AMQ2nm3D=SqGHH5bM5f-U0fhQ1nL9Q@mail.gmail.com>
 <alpine.DEB.2.21.1902161358160.1683@nanos.tec.linutronix.de>
 <4F2693EA-1553-4F09-9475-781305540DBC@amacapital.net> <20190216234702.GP2217@ZenIV.linux.org.uk>
 <20190217034121.bs3q3sgevexmdt3d@khany> <20190217042201.GU2217@ZenIV.linux.org.uk>
 <alpine.DEB.2.21.1902181347500.1549@nanos.tec.linutronix.de> <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
In-Reply-To: <CALCETrXyard2OXmOafiLks3YuyO=ObbjDXB6NJo_08rL4M6azw@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 18 Feb 2019 22:13:12 +0100
Message-ID: <CAG48ez1+g+=AMbo--TYEH+LnVneBWgm_qQG0AXN2LTWfOaaBMg@mail.gmail.com>
Subject: Re: [PATCH] x86: uaccess: fix regression in unsafe_get_user
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arthur Gautier <baloo@gandi.net>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        kernel list <linux-kernel@vger.kernel.org>,
        Pascal Bouchareine <pascal@gandi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 8:15 PM Andy Lutomirski <luto@amacapital.net> wrote:
> On Mon, Feb 18, 2019 at 5:04 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > > Another would be to have the buffer passed to flush_buffer() (i.e.
> > > the callback of decompress_fn) allocated with 4 bytes of padding
> > > past the part where the unpacked piece of data is placed for the
> > > callback to find.  As in,
> > >
> > > diff --git a/lib/decompress_inflate.c b/lib/decompress_inflate.c
> > > index 63b4b7eee138..ca3f7ecc9b35 100644
> > > --- a/lib/decompress_inflate.c
> > > +++ b/lib/decompress_inflate.c
> > > @@ -48,7 +48,7 @@ STATIC int INIT __gunzip(unsigned char *buf, long len,
> > >       rc = -1;
> > >       if (flush) {
> > >               out_len = 0x8000; /* 32 K */
> > > -             out_buf = malloc(out_len);
> > > +             out_buf = malloc(out_len + 4);
> >
> >   +8 actually.
> >
> > >       } else {
> > >               if (!out_len)
> > >                       out_len = ((size_t)~0) - (size_t)out_buf; /* no limit */
> > >
> > > for gunzip/decompress and similar ones for bzip2, etc.  The contents
> > > layout doesn't have anything to do with that...
> >
> > Right. That works nicely.
> >
>
> This seems like it's just papering over the underlying problem: with
> Jann's new checks in place, strncpy_from_user() is simply buggy.  Does
> the patch below look decent?  It's only compile-tested, but it's
> conceptually straightforward.

Nit: The "This could be optimized" comment has unbalanced parentheses around it.
Nit: Maybe switch the order of "max" and "IS_UNALIGNED(src+res)" in
the loop for unaligned prefix, or tell the compiler that "max" is
likely to be non-zero? That might be a tiny bit more efficient in the
aligned case? But I don't know much about making code fast, so feel
free to ignore this.

I think there is still similar code in some other places in arch/x86;
back when I did the conversion to _ASM_EXTABLE_UA, I stumbled over a
few similar-looking things. In particular:

load_unaligned_zeropad() (used in some VFS code that looks pretty
performance-critical) still uses _ASM_EXTABLE for reading from kernel
memory; it has a comment saying:
/*
 * Load an unaligned word from kernel space.
 *
 * In the (very unlikely) case of the word being a page-crosser
 * and the next page not being mapped, take the exception and
 * return zeroes in the non-existing part.
 */

csum_partial_copy_generic() uses PREFETCHT0 together with the
following macro; I think this can be used on both kernel and user
addresses?
        /*
         * No _ASM_EXTABLE_UA; this is used for intentional prefetch on a
         * potentially unmapped kernel address.
         */
        .macro ignore L=.Lignore
30:
        _ASM_EXTABLE(30b, \L)
        .endm
(That comment says "kernel address", but I wrote that, and I think
what I really meant is "kernel or userspace address".)

> I was hoping I could get rid of the
> check-maximum-address stuff, but it's needed for architectures where
> the user range is adjacent to the kernel range (i.e. not x86_64).

> Jann, I'm still unhappy that this code will write up to sizeof(long)-1
> user-controlled garbage bytes in-bounds past the null-terminator in
> the kernel buffer.  Do you think that's worth changing, too?  I don't
> think it's a bug per se, but it seems like a nifty little wart for an
> attacker to try to abuse.

Hm. I guess it might be interesting if some code path first memsets a
kernel buffer to all-zeroes, then uses strncpy_from_user() to copy
into it, and then exposes the entire buffer to a different user task
(or, if strncpy_from_user() was called on kernel memory, to any user
task).

And if the source is kernel memory (might happen e.g. via splice,
there are VFS write handlers that use strncpy_from_user()), it could
potentially be used to make an uninitialized memory read bug
(constrained to a specific field in some slab object, or something
like that) more powerful, by shoving out-of-bounds kernel data around
such that it is aligned properly for the leak.

So, yeah, I think if it's not too much trouble, changing that would be nice.
