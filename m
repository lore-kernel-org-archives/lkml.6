Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DC0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C8821738
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 18:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="U4NOB8Tj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfBSSoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 13:44:00 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36785 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbfBSSn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 13:43:57 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so18399294ljk.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 10:43:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FcohW2Uz9LiHmR52lLLSD+rd6+blYhTzEReGsgOY0RU=;
        b=U4NOB8TjneKfX2Lu4BPT/C40TyE9lLoP1nE8k8skfdppwO8/oAngJ6iBIvYJk3bq/s
         U+o9HhfKKJPX0qv6oBtLgH6VviFNUon3h8KS6uUIRM27jN6MqHmqj65vyR0ZTXb8TG4Q
         r7mL2cURiQ7Raj/DWUJk15RnqhUcIqQpmxv8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FcohW2Uz9LiHmR52lLLSD+rd6+blYhTzEReGsgOY0RU=;
        b=If6Yy/WG9nDMI3btoOcRWkoByru1J/uEioLVk1xf7jKmxaGCYepkHhjkxiMS68GLrT
         DLwvCVuALspvb+1zmpXyBcjRB4KauPH/GuBlm6Jryas3qWQU2nJioZmKbtLQZqt5HsAe
         bdSPvGc1OZuBZ3vgXBDfYCgmnGnt9eW6xUMvAxZN8nqklDMc+50dLrVTqDP+plYtd0Oa
         gsN/SxUI+Vy0J0EriwtbdWI4W9oKNP1Ni6PzE2tmuHU/e7GB4TrMQ6oa2RTeVd5jjERJ
         zsSZt/DxatDuruS/0+BzpEVGXTrBzftytyxlyvmMus6dVzJTiwrd30m4saFwP/dZ0KHy
         Zt5Q==
X-Gm-Message-State: AHQUAuYHdYHbm/3j4Efvy8ePAP/+GGa3cdrVWb4aJA0ApnKFFYjCC2wv
        slV4IhDLSmazxBaV0cRxQkiz0syjQEg=
X-Google-Smtp-Source: AHgI3Ia9fx3F4nyTwBExAARR93vcj8TNadRjI+lnp8mQFoZ1s3FOdqhnm42ckeMX5X28BOmMM+Q8tQ==
X-Received: by 2002:a2e:5b11:: with SMTP id p17mr16630099ljb.37.1550601834129;
        Tue, 19 Feb 2019 10:43:54 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id t19-v6sm4583983lje.23.2019.02.19.10.43.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 10:43:52 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id z25so10539750ljk.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 10:43:52 -0800 (PST)
X-Received: by 2002:a2e:8510:: with SMTP id j16mr16944141lji.2.1550601832208;
 Tue, 19 Feb 2019 10:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com> <20190219111802.1d6dbaa3@gandalf.local.home>
In-Reply-To: <20190219111802.1d6dbaa3@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Feb 2019 10:43:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
Message-ID: <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 8:18 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > So it would be good to not just say "user or kernel", but actually say
> > what *kind* of kernel access it expects.
>
> Note, kprobes are a different kind of beast. I've used kprobes to probe
> userspace information as well as kernel. Heck, I could see someone
> even using kprobes to probe IO memory to check if a device is doing
> what they expect it's doing.

Note that even if that is the case, you _need_ to special "user vs
kernel" information.

Because the exact same address might exist in both.

Right now I think that only happens on sparc32, but vendors used to
have that issue on x86-32 too (if they had the 4G:4G patches).

> Basically, a kprobe is mostly used for debugging what's happening in a
> live kernel, to read any address.

My point is that "any address" is not sufficient to begin with. You
need "kernel or user".

Having a flag for what _kind_ of kernel address is ok might then be
required for other cases if they might not be ok with following page
tables to IO space..

          Linus
