Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB0BC61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:43:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAC4A2084F
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 17:43:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v+O2pcT2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbfASRns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 12:43:48 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36463 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728658AbfASRns (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 12:43:48 -0500
Received: by mail-vs1-f67.google.com with SMTP id v205so10385365vsc.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 09:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J9f9Ib7OsMwZwSlG36Gi36yT7CnmZRZfUF9UxxUakKI=;
        b=v+O2pcT2uhD1PvHK6ViSG+YUjJlHzZa1JJcO26IowOx2qvJSVyYhm2A0SUrd1xapeY
         cI1s49YTUy1HstWhV0tgi9VdAVv8M931J3F49jpUo5A0kdRJFrHc9zt01wOS6yLxCIOn
         dgQ1PdvMoohT1CqX87vPAU8L3YJGZIjgy2SOVUDQP58kZvNZu1+d5fRNS5jMCtpGwcUS
         yo61Yy0u1xG1c5mNpQCuL9EWekMYIVAIbPVWTYQ3HppUWQxty5x6RWRXfjzBADpVe16s
         lS2phFEXdjhKKUvVRe9FRdFmimmnOZHAez+2JsopuU6Chu51unJi7XV0iLwPY3gANIxL
         nuqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J9f9Ib7OsMwZwSlG36Gi36yT7CnmZRZfUF9UxxUakKI=;
        b=Ge4gdcT1B4DFRT9i6ucYtA5eKtgr6RSAOJCgDJkNmL//sSYRhjg/GbKDvqlZljrLB5
         JqTeG+ReG1oKv8pXvfYy8Mji3JsIzhPet7nIvTUfdenxn/S5/qCkmWDyDdmd6oTi98hL
         n4dnIcWSmaHiHRWAsxqmR105fPIH2S3e0325aspSMyno6eO8KHEyUjzhovKIIJI1bTe9
         w1ywtxHHQoVNt35VQpnvIt4nJDxT4m33W6hZmLeI8HTPQQDU/gcY8f1xPBkGDxMukJib
         kDoZp4qkMGKIUDC+kWxGKhJLfez46GmUfYkQEvWM9N3Sz8kmZXR9qqP7JQNDER/+8ILo
         Rfsw==
X-Gm-Message-State: AJcUukdUCv5DlYVhcng9w9de61eGy8n0W2Xi5oEJUlBfFqKR9mHcb+dU
        iQsIIaQHgX0QIjInxcX+sJf7SavW4C0kBKmjwg6Sjr1GemY=
X-Google-Smtp-Source: ALg8bN59BJ4yHuqXxBqfA3BqnqKOmafpnOPQJSZwsU6WI7HCLxcH+4LiZAA8vKsWakY/u0SZFYVd9MuNcaVU+jvYmEM=
X-Received: by 2002:a67:f943:: with SMTP id u3mr10178670vsq.149.1547919826517;
 Sat, 19 Jan 2019 09:43:46 -0800 (PST)
MIME-Version: 1.0
References: <20190118225543.86996-1-joel@joelfernandes.org>
 <20190119082532.GA9004@kroah.com> <20190119162754.GC231277@google.com>
In-Reply-To: <20190119162754.GC231277@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Sat, 19 Jan 2019 12:43:35 -0500
Message-ID: <CAKOZuet+7a4jdox6rebMN=kJtDn5RUYzvNjFh+Pzn2UkuP0Y8Q@mail.gmail.com>
Subject: Re: [RFC] Provide in-kernel headers for making it easy to extend the kernel
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, ast@kernel.org,
        atishp04@gmail.com, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>,
        karim.yaghmour@opersys.com, Kees Cook <keescook@chromium.org>,
        kernel-team@android.com,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Manoj Rao <linux@manojrajarao.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>, rostedt@goodmis.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 11:27 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Sat, Jan 19, 2019 at 09:25:32AM +0100, Greg KH wrote:
> > On Fri, Jan 18, 2019 at 05:55:43PM -0500, Joel Fernandes wrote:
> > > --- /dev/null
> > > +++ b/kernel/kheaders.c

Thanks a ton for this work. It'll make it much easier to do cool
things with BPF. One question: I can imagine wanting to probe
structures that are defined, not in headers, but in random
implementation files. Would it be possible to optionally include *all*
kernel source files? If not, what about a hash, so we could at least
do precise correlation between a candidate local tree and what's
actually on device?

BTW, I'm not sure that the magic constants you've defined are long
enough.  I'd feel more comfortable with two UUIDs (16 bytes each).

I'd also strongly consider LZMA compression: xz -9 on the kernel
headers (with comments) brings the size down to 5MB, compared to the
7MB I get for gzip -9. Considering that this feature is optional, I
think it's okay to introduce a dependency on widespread modern
compression tools. (For comparison, bzip2 -9 gets us 6MB.)
