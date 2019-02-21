Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A84A1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719252147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 06:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M1O9ANt2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbfBUGCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 01:02:50 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:34610 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725648AbfBUGCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 01:02:49 -0500
Received: by mail-vs1-f68.google.com with SMTP id e10so15525409vsp.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 22:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pBx9CEbPnMiUJdiCd3bLUjGQLI38u4YtYCRIk8C62SU=;
        b=M1O9ANt2kjEweh/AL2lRHyC58LdrEk9dwAodA/00rJ0ej1JINyeEsyFvOJshESviSH
         FWZoUMI1cZrxT34ZOpZNvgtpQyRsUOqkijzJEVaLIHHLyz2cMm1fJbALn5Fh1tlM/iqS
         5N+yTyr6fpP3dKcahG7FPQ+y0sPX9YwiO3px8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pBx9CEbPnMiUJdiCd3bLUjGQLI38u4YtYCRIk8C62SU=;
        b=FUXK4vLTiqCTMmP9cdFr8VLqWIzQxDaTWfHLJMemyMe5q5/Tp7WJWNIEByrMH1Hl+V
         VCmjPc8kPGK1xpJE3qi3dZyLadgG5qDiDoCpMYVATmYDf5cZQLU/bBrKsIeQOU0+HQsc
         sb8rlB377SBg37NPBtAMeLjWVSKo7heWEYDlBsKltsZQoogqJyIbRavgGs3zu579/FNP
         D+clOMSqJ5NSEoRaKPaGz4BX6jWGTjQ9WSr6b9dtB2H3BHRa9TA+2JEvxFv41eAxseSI
         Q+rt0lOCuFFdjq4UP12aoC7QbBH6jI0qKLeG22ZdcTQ+fS8WDjHvyj17suhBkuvAs67Z
         IOeg==
X-Gm-Message-State: AHQUAuZf97sehNdR0jxziNzEO4YrG3LUI4fQ+5/v+lqZpi8KdJa1J7c7
        8ZotqATS42VICJuzjlaujZau8VG9Ztw=
X-Google-Smtp-Source: AHgI3IajwgFATKNAlUgTpqhtan+vjTNYJKyNL0x2NUsY9IY/xiYxui4YtzO5R4ZS4/ZQgKUkh+SK3w==
X-Received: by 2002:a67:b605:: with SMTP id d5mr7372535vsm.202.1550728967741;
        Wed, 20 Feb 2019 22:02:47 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id n74sm4748085vkc.6.2019.02.20.22.02.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 22:02:45 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id y19so2232725vsc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 22:02:44 -0800 (PST)
X-Received: by 2002:a67:ec81:: with SMTP id h1mr19833821vsp.188.1550728964353;
 Wed, 20 Feb 2019 22:02:44 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com>
 <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com> <20190221052435.GF11758@eros.localdomain>
In-Reply-To: <20190221052435.GF11758@eros.localdomain>
From:   Kees Cook <keescook@chromium.org>
Date:   Wed, 20 Feb 2019 22:02:32 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
Message-ID: <CAGXu5j+Mf2D5LgkEmps7VVBhmNGt=49y4caP1y1E0OBURJEeXQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     "Tobin C. Harding" <me@tobin.cc>
Cc:     Jann Horn <jannh@google.com>,
        "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 9:25 PM Tobin C. Harding <me@tobin.cc> wrote:
>
> On Wed, Feb 20, 2019 at 05:05:10PM -0800, Kees Cook wrote:
> > So, generally speaking, I'd love to split all strncpy* uses into
> > strscpy_zero() (when expecting to do str->str copies), and some new
> > function, named like mempadstr() or str2mem() that copies a str to a
> > __nonstring char array, with trailing padding, if there is space. Then
> > there is no more mixing the two cases and botching things.

I should use "converts" instead of "copies" above, just to drive the
point home. :)

>
> Oh cool, treewide changes, I'm down with that.  So to v2 I'll add
> str2mem() and then attack the tree as suggested.  What could possibly go
> wrong :)?

Some clear documentation needs to be written for str2mem() to really
help people understand what a "non string" character array is
(especially given that it LOOKS like it has NUL termination -- when in
fact it's just "padding").

The tree-wide changes will likely take a while (and don't need to be
part of this series unless you want to find a couple good examples)
since we have to do them case-by-case: it's not always obvious when
it's actually a non-string, so getting help from maintainers here will
be needed. (And maybe some kind of flow chart added to
Documentation/process/deprecated.rst for how to stop using strncpy()
and strlcpy().)

What I can't quite figure out yet is how to find a way for sfr to flag
newly added users of strcpy, strncpy, and strlcpy. We might need to
bring back __deprecated, but hide it behind a W=linux-next flag or
something crazy. Stephen, in your builds you're already injecting
-Wimplicit-fallthrough: do you do W=1 or anything like that? If not, I
think we need some W= setting for your linux-next builds that generate
the maintainer-nag warnings...

-Kees

P.S. Here's C string API Rant (I just had to get this out, please feel
free to ignore):

strcpy returns dest ... which is already known, so it's a meaningless
return value.

strncpy returns dest (still meaningless)

strlcpy returns strlen(src) ... the length we WOULD have copied. Why
would we care about that? I'm operating on dest. Were there callers
that needed to both copy part of src and learn how long it was at the
same time?

strscpy returns -E2BIG or non-NUL bytes copied: yay, a return about
what actually happened from the operation!

... snprintf returns what it WOULD have written, much like strlcpy
above. At least snprintf has an excuse: it can be used to calculate an
allocation size (called with a NULL dest and 0 size) ... but shouldn't
"how big is this format string going to be?" be a separate function? I
wonder if we can kill all kernel uses of snprintf too (after
introducing a "how big would it be?" function and switching all other
callers over to scnprintf)...

So scnprintf() does the right thing (count of non-NUL bytes copied out).

So now our safe(r?) string API versions use different letters to show
they're safe: "s" in strcpy and "cn" in sprintf. /me cries forever.

-- 
Kees Cook
