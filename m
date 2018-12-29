Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A58C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B91220873
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 21:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="d7P28SSx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbeL2VBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 16:01:09 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:40792 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbeL2VBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 16:01:09 -0500
Received: by mail-lf1-f48.google.com with SMTP id v5so16461946lfe.7
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 13:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HXIqqeXbam/lzjLJFdDUubWem918tYsWEHOiU1rXsj4=;
        b=d7P28SSxy5v86rScb0XhbdyeJugYPOEs7Lcz8/7VSrXg0ALBoxj1aRj/3muOoJtYMZ
         ByxMHeXIsby096p3ZmNMHN+cGtK6N0FA0ufPkzD9EIviEYa13gF4HO2usdW6l+3DOHMg
         Prh1SSg0eaB+P2eC1mBf07t8MxRECVY8ve9wA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HXIqqeXbam/lzjLJFdDUubWem918tYsWEHOiU1rXsj4=;
        b=Xc04A+EoDggC24D+AqDDBE2xFyi7drkn03OGgnps1++ecL6dyFI0bkXrR+SQEXGeJd
         Go/oOTWpmG4ei9c5Sbftzw+0ehv/EhsEMTFA9C0musrQZ47fvMY5gimuiSrCWWBRwe4n
         iSlSqLaphvdNXIkLo9bJtaGRufkDFcFbW8/fxGYjQbUdD8oLDOpRmucgNzQT7ACNOMGY
         R94/tGz83iP3u1rd2LusmJWTXmvRHuO+HCGufH5sUYtlESQhznBDpRXhSKVlq4OtVJnp
         v89qrwiTNwAQLGnBILoKllr6GVvOGA96g+clXk8C3rQKzwnB/TEToypTacE/QK27kOdS
         EIPA==
X-Gm-Message-State: AA+aEWbPc9gVVNe/1tpR+t057Ixo0DUAnauvV+2aQ5Tn8iCTJ9Q811ml
        GyYztXjqNByp4ax6suckIb3PFSIg5tQ=
X-Google-Smtp-Source: AFSGD/WJAun5lXUkE1ff+vRblT8nG23YYbK8l4N0AHbUHzW7WHs/wL5ah0zCjsoFvIItJK1pD9M82g==
X-Received: by 2002:a19:f20:: with SMTP id e32mr16917030lfi.51.1546117266408;
        Sat, 29 Dec 2018 13:01:06 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id d23sm8579575lfc.11.2018.12.29.13.01.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 29 Dec 2018 13:01:05 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id l10so16463999lfh.9
        for <linux-kernel@vger.kernel.org>; Sat, 29 Dec 2018 13:01:05 -0800 (PST)
X-Received: by 2002:a19:4287:: with SMTP id p129mr17223923lfa.135.1546117264611;
 Sat, 29 Dec 2018 13:01:04 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com>
In-Reply-To: <CAK7LNARQggM3aKEPRKJqa4tunFAfmfErMZuS-rrnRv6UB1VpPQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 29 Dec 2018 13:00:48 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com>
Message-ID: <CAHk-=wiLt3rgeyM3BWAd5VJrKcnxxuHybwoQiDGMgyspo6oXDg@mail.gmail.com>
Subject: Re: [GIT PULL 2/4] Kbuild updates for v4.21 part2
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        masahiroy@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 28, 2018 at 8:00 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Introduce a new option CONFIG_NO_AUTO_INLINE as well. With this option,
> only functions explicitly marked with "inline" will be inlined. This
> will allow the function tracer to trace more functions.

Ugh. This causes new and bogus warnings, because gcc doesn't see some
of the checks.

For example, the x86 emulate_vsyscall() function now warns that

    warning: =E2=80=98syscall_nr=E2=80=99 may be used uninitialized in this=
 function

because addr_to_vsyscall_nr() isn't inlined any more, so gcc doesn't
see that the return value is always smaller than three (and then it
doesn't see that we handle all the cases in the switch statement
later).

So honestly, these "debugging improvements" have a rather nasty side
effect. I'm not at all convinced that we should do this.  It is *not*
worth causing extra development pain with a totally pointless option
that changes code generation radically like this. It's going to cause
lots of extra churn.

This branch already added a couple of extra inline markers just to
make code work reasonably. How many tens (or hundreds) got missed just
because the build still works, but the lack of inlining means that we
generate completely garbage code?

I'm going to skip this pull request.

We have basically always required a certain level of competence from
the compiler, and this basically says that the compiler can do stupid
things and we'd have to fix those stupidities by hand.

             Linus
