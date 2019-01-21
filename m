Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735ADC31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D0C2089F
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:07:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXg3G8iQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbfAURHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:07:16 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52692 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfAURHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:07:16 -0500
Received: by mail-it1-f196.google.com with SMTP id g76so17334909itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 09:07:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U8aPMHD0c4Aq45zYfYHrTV1uy0fML3I0lPRBU/aXXpI=;
        b=lXg3G8iQuO/uw8xZDYSVDER5KvIC8M7szDSpulta3ZhDOrs+LVHCq5euRj8aToRJa6
         vomWdUXO4RwDlhA284ywdwSq5MXdZJ4/XFXaB575bM+Bedbkrgo/E+KL9nwBUpjGfT++
         j2zh3Ry03T79U9FpX8pT5Az34r0fq8dyuNBO65C8NUO9AkoM6vREj8W59foYo6qpN+12
         1LVQguS7uFxYNsCjAHX3oAKimx3UZO8894CEJqF/vfctcVNIpaNc35az16YbqzrrLF6P
         Pff1AcJQm2BkMLF+SXsDoIr81ltJsb2zyjjG2Lcc1OuwKgPSCJXUwNHlCyiQU8GYRF50
         y99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U8aPMHD0c4Aq45zYfYHrTV1uy0fML3I0lPRBU/aXXpI=;
        b=V71w1i2Va8ME0D2TYYnZcwtIQZyD7kxbuqu4qX/8qjFDhHBEuyb5gTD9q3zhLDeFkg
         8+5GLAdV/M1v4FvW992vE+PU/CiKpXiBzWDXq8SW+IQDJREABrLLd4DGH9o72QZBfu2K
         vtqDvraNafoEE4KuR4hpjbPou/FKGcVIjW4Bd24Q4PIblfIZTaaBpXPUG2y/8zeFbznS
         isbzwAjbdXkQDMRNATW8q+0KYIozaKjNrvtrOJVsLRMPBKGSa8SbDPkF0AhIBwiRwhBe
         HKtEMC/u+8TfagXdpPbnGthLBfan2FFVJr61mbhj836plMOd2qaLyIVhN0sC3S9SA7hT
         9wxA==
X-Gm-Message-State: AJcUukf5USAz4YuqY8YoiJUTPABuQL//fvpmDedz+e+ekUHWx03kLEMA
        CfTHJPSoCqmwbz6X7Q5qQs+iJn1KaGdxU9dQOYHxCg==
X-Google-Smtp-Source: ALg8bN4/IlAbHs4TbG9ZS0WpQQMDoptvkZvYyXU7Wgk6N7nU6ZW+WkZUegyPHVLY/aSD3GEDz4L8y0Hs0qsyHX9mOds=
X-Received: by 2002:a24:f14d:: with SMTP id q13mr147181iti.166.1548090434968;
 Mon, 21 Jan 2019 09:07:14 -0800 (PST)
MIME-Version: 1.0
References: <1547634429-772-1-git-send-email-elena.reshetova@intel.com>
 <20190121123836.GC47506@lakrids.cambridge.arm.com> <CACT4Y+Y6JNyQ+SSZXDSYVcBXZ_e1Hf3OMpoz=1eqGNhNKqYikg@mail.gmail.com>
 <2236FBA76BA1254E88B949DDB74E612BA4B89908@IRSMSX102.ger.corp.intel.com>
In-Reply-To: <2236FBA76BA1254E88B949DDB74E612BA4B89908@IRSMSX102.ger.corp.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 21 Jan 2019 18:07:03 +0100
Message-ID: <CACT4Y+b4kiRjFBhYc9OMcvNapb+xm5bzecT0zcMh0-QkKqJc2w@mail.gmail.com>
Subject: Re: [PATCH] kcov: convert kcov.refcount to refcount_t
To:     "Reshetova, Elena" <elena.reshetova@intel.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 3:07 PM Reshetova, Elena
<elena.reshetova@intel.com> wrote:
>
>  > Just to check, has this been tested with CONFIG_REFCOUNT_FULL and
> > > something poking kcov?
> > >
> > > Given lib/refcount.c is instrumented, the refcount_*() calls will
> > > recurse back into the kcov code. It looks like that's fine, given these
> > > are only manipulated in setup/teardown paths, but it would be nice to be
> > > sure.
> >
> > A simple program using KCOV is available here:
> > https://elixir.bootlin.com/linux/v5.0-rc3/source/Documentation/dev-
> > tools/kcov.rst#L42
> > or here (it's like strace but collects and prints KCOV coverage):
> > https://github.com/google/syzkaller/blob/master/tools/kcovtrace/kcovtrace.c
> >
>
> No, this one hasn't gone via any particular testing apart
> the tests that zero day runs automatically (like boot tests, etc.) since normally
> it is hard for me to know how exactly to test a particular component in a meaningful
> way.
>
> But I can try to test with the above example now, if it helps!

We really need automated tests but I wan't able to figure out how to
write/run kernel tests. Sorry about that. Need to try again. I've
filed https://bugzilla.kernel.org/show_bug.cgi?id=202363 for this.
