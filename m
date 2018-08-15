Return-Path: <SRS0=5j8r=K6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82CB0C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAEA2154F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Aug 2018 20:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Ki4P+7D2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DAEA2154F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbeHOXMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Aug 2018 19:12:49 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:38606 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727745AbeHOXMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Aug 2018 19:12:48 -0400
Received: by mail-io0-f193.google.com with SMTP id v26-v6so2040591iog.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Aug 2018 13:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+WctarvA9CmISd2Z45RErbMf72icxKKLDiYyywxWO0=;
        b=Ki4P+7D2UVsgGi3+XlYgV4+kt73hLC59MTm1SRmjxQ7gdnX/NzzFT3tVCdSHynRj1S
         fRCj7oJcQ8LiYZyZfkve0BFqczwqMQAEb+HJFefOcTen6mcBkoefIISn+NmI3fNnPZtk
         0JlguXNjTtHUR9vK0VGTkCqTVQVcG6nNGDOmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+WctarvA9CmISd2Z45RErbMf72icxKKLDiYyywxWO0=;
        b=YHvxHUTyPDYIxYdy1+S5FJ5cecUQD6GF4Hfk2VM2LIz8sh2c4/keWc33Xvr2iGwx1V
         OdEKr05YWkchBb/vjRKWmfA/xVwisBzcDCRaSWzhy6H5IT5baPMemOdzxT/IULLBmYCD
         +ozpCFgV/0fKTm15xXNAbNZr0C6usJIt27t9ajd38wrohNDJlph/G14jMovatC4owtJD
         RQajV90WQ4qGscJjAT9irivYMj1SIkqRllA58fTutuMh+EhQ2UjZE8jcbboOq4Op2QkV
         h9JL5VYyTx5kXD+wr3Yl7zNoYSWBowY7zd8O6Fxaqx5MhU7yyDp3e84PH9vvwtVms8Fh
         MLXQ==
X-Gm-Message-State: AOUpUlGJzONbnY8f8byNaqDECRwSJTqp6ktzUf42v+fRpBWKgx+/NvpX
        Ur0TKWtO1lc0mxLxSHQtPTEgEvRTwEJwfCbD9M8=
X-Google-Smtp-Source: AA+uWPwQcvc9QUfaGKc3JN7X4BtxL+JAefQwsrnET1mIBHlwK6UJ2qF7XBXLUe5uiyn2ckuNpSTEeqB4VXfKzP7RTTg=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr10581622ioh.203.1534364348706;
 Wed, 15 Aug 2018 13:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180813214328.GA15137@beast> <CA+55aFw5Tkn6DgkAZS-UGOjJpYp2R4rFAm9ixu_=FONeqRyofg@mail.gmail.com>
 <CAGXu5jK_w7JRywdQ78FfQxeLSMmXbvyDDnaYzj27=y8wnAzKxQ@mail.gmail.com>
 <CA+55aFyFCWH3YJnRUKtSzs9Mvny0eU+=QANxoPTE+9B9CkUWDw@mail.gmail.com> <CAGXu5jJ1JNSxJABUTAO85z_hXjSkjD=nWEho7KrYJTqqVGivig@mail.gmail.com>
In-Reply-To: <CAGXu5jJ1JNSxJABUTAO85z_hXjSkjD=nWEho7KrYJTqqVGivig@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 15 Aug 2018 13:18:57 -0700
Message-ID: <CA+55aFy6jNLsywVYdGp83AMrXBo_P-pkjkphPGrO=82SPKCpLQ@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin updates for v4.19-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Popov <alex.popov@linux.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>,
        Mark Rutland <mark.rutland@arm.com>,
        Laura Abbott <labbott@redhat.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 15, 2018 at 12:45 PM Kees Cook <keescook@chromium.org> wrote:
>
> I feel like we're talking cross purposes. The BUG() cases were for
> places where we detect that we're executing with an impossible stack
> pointer. It seems like trying to recover from that would just hide the
> corruption for a later time that would be much harder to debug. These
> weren't left in here to upset you. :) I have tried to take your "make
> it debuggable" declaration to heart.

The thing is, BUG() is not debuggable.

I absolutely refuse to take any hardening patches at all that have
BUG() or panic() or similar machine-killing in it.

I care not one whit about the reason for them. In fact, if the reason
is stated as "it makes debugging easiler", then I fart in your general
direction and call your mother a hamster.

Dammit, I suspect you guys are "testing" this by running things in a
VM, and then a BUG() looks like a good thing to do.

But if people run things on real machines, then BUG() is absolutely
the last thing you EVER want to do for "debugging".

This is why I scanned your pull request for BUG() and similar. Because
I simply will not take "hardening" that kills the machine. That's a
hard requirement. No excuses, and absolutely zero exceptions.

After a year or two, when the hardening has actually been in place,
and you can say "hey, look, none of the warnings happened", I may be
ok with turning them into BUG() calls.

> It also handles VLA abuse, since those could (and have in past
> exploits) been used to jump over guard pages.

I really don't think that's a valid model at all. We need to get rid
of the VLA abuse, not make complex compiler plugins for it.

I thought VLA's were mostly gone. I think we can at this point almost
just mark them broken, or disable any code that uses them when people
enable the stack options.

Adding a few

        depends on !SAFE_STACK

to the drivers or code that still uses VLA's and then making the stack plugin do

        select SAFE_STACK

and simply refuse to compile alloca sounds reasonable to me.

People who then want some stack validation or clearing can either
decide they don't care about those pieces, or fix them one by one.

               Linus
