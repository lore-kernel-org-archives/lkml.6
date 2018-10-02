Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60F2C64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:33:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604AA20666
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Is4l+58R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 604AA20666
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727395AbeJCFT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:19:28 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34261 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725198AbeJCFT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:19:28 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so675891pfi.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iigaVyrK7/HGlyLRB+8w/G2AvrQVCbJgqXWfiS0csSc=;
        b=Is4l+58RtumOGrySG2tdRjIABZwCmAidNBdaI6mr8VdvUK3nzwND+Cto2VlsjoujZT
         KwgKD9S5y6Ej4xSj8CQbN5nMPqLyEYmoFWgzag3iwQPhoax6Clah2WksDOWXLr0rIp0u
         /szbvADPbVzCXOPQrhAOy3ddHFVkB+jYos52uDbWvED0oqDsp9UvhcxTg96528zM8PJq
         4WZiVBS4+yHeIwiuq/XyRpxXL6QdRo10Ca1qypikjcYWPCuljebtoZJvTKRZJVBD5QPi
         STlXVI3gXhUR6G3OF0VXs9tB2QT+HKBCaoAuLGLsf+fSrRHbGsCotShmFLocqfXUXeA7
         M55Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iigaVyrK7/HGlyLRB+8w/G2AvrQVCbJgqXWfiS0csSc=;
        b=RNiYewglo/dcFY5sVyaX27EToLt3f9w+ImyktHKGA/jIDI9ftWzR3DKvkaC9EozxPu
         2NH1AWCzDKXViPTjmpilg5lXoXU1/bHaBAYwH7tr2xVqDTqQNcfvlwx+8BLv585QGZzd
         xTNpzgVxML6eYCKO4JkVvFYE8UC472eIuDMocpZAM+cY+7FdhQgH7HN2RqRby7h21yfk
         07a/h7U7t/YJTRUPVwH73b6z4DKipX9knDGWW6O2v52jt0TIBZp4Zy8eOQzzviLr2YbO
         z++bcmsz/dZBIIeIXHztybmeERc7zQLPRnVb4ztdBBa0tKozJKK7Nfl5B2Mo08ho5Nt0
         NIiQ==
X-Gm-Message-State: ABuFfohZTuaIF8HMd0hy+SgS5/SKU09z2F+2YPdwp1JWFHWEPCcGGKW+
        jB7CljnLGNtXOP2YzLfQDEOtLrQg4qWXYdRwcaGXjA==
X-Google-Smtp-Source: ACcGV61ithODlkr6t+3CevyhCzm0VAVfVTIfn+0A/NtvC1vXrxesFnN4dnXVafOn2KzfSGKw5ZFrS9UpYnAdrgHUHY8=
X-Received: by 2002:a63:a047:: with SMTP id u7-v6mr16418236pgn.145.1538519630068;
 Tue, 02 Oct 2018 15:33:50 -0700 (PDT)
MIME-Version: 1.0
References: <20180930205448.26205-1-natechancellor@gmail.com>
 <10b12992-3570-4646-374b-82cbd7276839@acm.org> <CAKwvOd=wgxB69dMxzMeH2edCn=TdQGPGkNVW1e=QHPTJtO9ZNw@mail.gmail.com>
 <1538503063.193396.6.camel@acm.org>
In-Reply-To: <1538503063.193396.6.camel@acm.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Oct 2018 15:33:38 -0700
Message-ID: <CAKwvOdmsNEexQL9R8rgcRcXTZButYM6YWwG8bhVWCoJ8bOqCrA@mail.gmail.com>
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
To:     bvanassche@acm.org
Cc:     Nathan Chancellor <natechancellor@gmail.com>, ooo@electrozaur.com,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 10:57 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On Tue, 2018-10-02 at 10:24 -0700, Nick Desaulniers wrote:
> > On Mon, Oct 1, 2018 at 6:16 PM Bart Van Assche <bvanassche@acm.org> wrote:
> > > Additionally, zero initializers should be left out to minimize
> > > the size of object files.
> >
> > Sorry, my understanding was that global variables either occupy the
> > .bss section or the .data section, depending on whether they were
> > zero-initialized vs initialized to non-zero, respectively (where
> > non-initialized are treated as zero initialized).  Looks like without
> > the explicit zero initialization, compilers will put the symbols in a
> > "common" section, which `man 1 nm` says is also unitialized data.  I
> > didn't think .bss sections occupied space in an object file or binary;
> > the kernel's loader would set up the mappings at execution?  Can you
> > clarify?
>
> Explicitly initialized global and static variables end up in the .data
> section and need space in that section.

Unless the initial value is zero.
https://godbolt.org/z/curRoO

So you don't wind up with an increase in binary size simply by having
global variables initialized to zero, right?  Instead the kernel knows
to create a zero'd out mapping for bss.  You don't need a run of zeros
in the binary.

So I disagree when you said earlier "zero initializers should be left
out to minimize the size of object files." I assert they don't affect
the size of the binary.

If you had many global variables all initialized to zero, why would
you encode that many zeros in a binary, when you can just set a size
on the bss section and have the kernel create the appropriate sized
and zero'd mapping?

> That is not the case if the
> initializer is left out and these variables end up in the .bss section.

From my above link, gcc will put globals without initializers into "common."

> From https://en.wikipedia.org/wiki/.bss:
>
> "In computer programming, the name .bss or bss is used by many compilers
> and linkers for the portion of an object file or executable containing
> statically-allocated variables that are not explicitly initialized to any
> value. It is often referred to as the "bss section" or "bss segment".
>
> Typically only the length of the bss section, but no data, is stored in
> the object file."
>
> This is why checkpatch warns if a global or static variable is initialized
> explicitly to zero. From scripts/checkpatch.pl:
>
> our $zero_initializer = qr{(?:(?:0[xX])?0+$Int_type?|NULL|false)\b};
>
> # check for global initialisers.
>
>                 if ($line =~ /^\+$Type\s*$Ident(?:\s+$Modifier)*\s*=\s*($zero_initializer)\s*;/) {
>                         if (ERROR("GLOBAL_INITIALISERS",
>                                   "do not initialise globals to $1\n" . $herecurr) && $fix) {
>                                 $fixed[$fixlinenr] =~ s/(^.$Type\s*$Ident(?:\s+$Modifier)*)\s*=\s*$zero_initializer\s*;/$1;/;
>                         }
>                 }
>
> # check for static initialisers.
>
>                 if ($line =~ /^\+.*\bstatic\s.*=\s*($zero_initializer)\s*;/) {
>                         if (ERROR("INITIALISED_STATIC",
>                                   "do not initialise statics to $1\n" . $herecurr) && $fix) {
>                                 $fixed[$fixlinenr] =~ s/(\bstatic\s.*?)\s*=\s*$zero_initializer\s*;/$1;/;
>                         }
>                 }
>
> Bart.



-- 
Thanks,
~Nick Desaulniers
