Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5618AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1654220842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:48:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ALZLex/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbfBYQsu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:48:50 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:43074 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728070AbfBYQsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:48:50 -0500
Received: by mail-vk1-f194.google.com with SMTP id e131so2247909vkf.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:48:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvOHXtUgt00mBm+4MIe3X8bSf3BnIl1oM2Qzn8BwD34=;
        b=ALZLex/+sIl5DKs0M8oEj5J4aAIfIB4+MEE6m4AH76wZWruVO4taEib0qCkVkffraD
         OpmmQvsu44e1NolR/o9dCJQ7P4e5DW4ceYgGkkWRgEHocxdy+3uimLEBUAn7+ZzdcZNz
         g1kPv3nCgeGYTN+2/TqysNMXoDGk6bRa0v3W8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvOHXtUgt00mBm+4MIe3X8bSf3BnIl1oM2Qzn8BwD34=;
        b=sQaxS8+SloRkcKkQ6kSIPPGYkCy/Sd1gs0kvUqwc3Ps23ajeXb0lXzS7DiW5hpkd7X
         9gdBfW9XJrXWoFhtTJakHB26YNJTqHorgo6p5TyCMHvVRGegRtZdD5lhkEB0cEVuHJ+D
         LHlax3OD3cT6xgvxqqB+xe8ivUIxCDWAwImUjv9mUG/geKpbO7OTgh2EXMtLTUdVvZOl
         LqR25IbVaG+uI81kTeL8N3S0K52uRKCTKfIWjTqqUssfX77yVB3zIMX7i7QwRXq2O3nt
         ONpIK9UAElGTIZk49pTa8FICONveOxQtOlnJtgAwr3sXkHs6Ak838KkKViRC9aw65d/F
         K2fA==
X-Gm-Message-State: AHQUAuYb5jtR+AFUcvYxRTU+bH3PssgHonTXsyxD/XwZm9gqdTsPYyTX
        M23KnD6tzpmUkeuWP+mVbdzDvjIDnNY=
X-Google-Smtp-Source: AHgI3IZuQ3k9v8DxfKqSkHsxUqa6JKJeUGgzirFWxhuphuycWhWvMdP/5X2gNguQrY5h614b1k1DhA==
X-Received: by 2002:a1f:ccc4:: with SMTP id c187mr9459000vkg.90.1551113328251;
        Mon, 25 Feb 2019 08:48:48 -0800 (PST)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com. [209.85.222.46])
        by smtp.gmail.com with ESMTPSA id b7sm1430835uaq.3.2019.02.25.08.48.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Feb 2019 08:48:46 -0800 (PST)
Received: by mail-ua1-f46.google.com with SMTP id z11so8951682uaa.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 08:48:46 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr9959613vsq.48.1551113326187;
 Mon, 25 Feb 2019 08:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
 <20190220094926.0ab575b3@gandalf.local.home> <20190222172745.2c7205d62003c0a858e33278@kernel.org>
 <20190222173509.88489b7c5d1bf0e2ec2382ee@kernel.org> <CAHk-=whNf_n1WXWW+ugAVeL5ZK0GcEP3cTYocju1nS85VtMjjQ@mail.gmail.com>
 <20190223124746.d021973004c7c892c3b3fde1@kernel.org> <20190223194421.725a03fd@oasis.local.home>
 <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
In-Reply-To: <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 25 Feb 2019 08:48:34 -0800
X-Gmail-Original-Message-ID: <CAGXu5j+4g0YRkbZ7mq-3Zgc7aWCU-hx6+G_onW+DdK+mYcqPDA@mail.gmail.com>
Message-ID: <CAGXu5j+4g0YRkbZ7mq-3Zgc7aWCU-hx6+G_onW+DdK+mYcqPDA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 8:38 PM Andy Lutomirski <luto@kernel.org> wrote:
>
> On Sat, Feb 23, 2019 at 4:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> >
> > On Sat, 23 Feb 2019 12:47:46 +0900
> > Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > > Since kprobes handler runs in IRQ context, we can not use access_ok() in it.
> > > (only on x86 + CONFIG_DEBUG_ATOMIC_SLEEP=y)
> >
> > Is it really IRQ context or exception context? That is, one
> > (interrupts) happen for any task, but exceptions happen because of the
> > software that is executed (like a breakpoint). Although you can have a
> > kprobe trigger in an interrupt handler (where user access wouldn't make
> > sense anyway). But there should be no problem with user access from an
> > exception handler.
> >
>
> Can we just get rid of this might_sleep()?  access_ok() doesn't sleep
> as far as I know.

We do need to be aware of the userfaultfd case of getting held by
userspace in the middle of a copy_*_user()... that's a whole other
problem.

-- 
Kees Cook
