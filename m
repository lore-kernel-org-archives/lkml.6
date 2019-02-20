Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BCAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB77320880
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 13:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ao/ncPEp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbfBTN57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 08:57:59 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39381 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbfBTN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 08:57:58 -0500
Received: by mail-ot1-f68.google.com with SMTP id n8so40224564otl.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 05:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l3c4PBiPrkHLJwBRfGMxxIyhSBE+yNF7yecRj9yip/k=;
        b=ao/ncPEp1pT9vsEMpLnrXniXvcSPL7qwz6mYstVxLj8J46Hvs1QPSNVje+wXpfVHxf
         8gtSr/B2VQN6PM9qI6HJ5464sZEoLWe3KLgDGdABo7lPhoqiaCZeDvLUW8o067tEiAcB
         Ho076rDPADcbppZG/ap8EubHeGF9peQq8uEQAB+5LUCt26LOpNAMrgibCklhDpdgAoVK
         9rKrUVpfDAB3Yc+bRqf1mqbqv1yvoM6pcw34kt6uliS86N0W+XEEcoeh3wA20ee4wBBY
         020v6QZg+CiwDacXuY3tHJmz0DvlobpD+pZsQkfOBOzSFMMv8vBkUkqaAw5rKnaF8/jI
         MyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l3c4PBiPrkHLJwBRfGMxxIyhSBE+yNF7yecRj9yip/k=;
        b=G71Ysd+QzsVAqG7NfizkcJnRzpBe34vRtTrKQwNJIY4ByuzkjtOPnHfef0qQYZKiIa
         XDwh8wEP+5X4v7ZMX6d8EtKspVMzVhr7aG7jDC7etjIXGWHLeujwVcVrxzHsjjiSW149
         1kNwBD8K0Fi/mADqY4o8b7KQCP/QHnRey+ttOSBZ8sW9btYu8t/ePTWfwwWtprDsMfhY
         06t19YD8I8Gdi2zNZTqvH8/z56wyHh1kLpDnqXWWc88s/jPMzq3r/1CEPYJR+VQmv8Kv
         D5eADA6kULZZSwjCU2DJ/XJzAFr4jA7v1W4v71VxofzpVDijmB2Zj87EPyNnWy+2J4f9
         IDWQ==
X-Gm-Message-State: AHQUAuaAahiGR55TWBa48x87n8CDTmdvbrSY857yGB2/xDlcjmnnhyQu
        z4eYwBGyqLy5jcR3a0Ez/Rh4kFK0ro7TzIQ+BvXKaw==
X-Google-Smtp-Source: AHgI3IZp6b1DIeaZgfv0uK7HX5VZJP59KPGRZuPrDsh0qF+ASl9dihd9lFY8uHXo0CF3cEETPZA+2XMJ7RaJe1ktP7U=
X-Received: by 2002:a05:6830:14d6:: with SMTP id t22mr22548390otq.255.1550671077164;
 Wed, 20 Feb 2019 05:57:57 -0800 (PST)
MIME-Version: 1.0
References: <20190215174712.372898450@goodmis.org> <20190215174945.557218316@goodmis.org>
 <CAHk-=wjP4bEYCFaKZVG4kLWmYBctyfsW9jjhC91tiTk9WwB8Rg@mail.gmail.com>
 <20190215171539.4682f0b4@gandalf.local.home> <300C4516-A093-43AE-8707-1C42486807A4@amacapital.net>
 <20190215191949.04604191@gandalf.local.home> <CAHk-=wgJzNp0R3cVhjBPHTR4X9sOvHdqK4UVFfbsOKQ6L=A_eQ@mail.gmail.com>
 <CAHk-=wh9XrOykA5J9RQ7zaBio-S_D+1AE+rGnBYWSd==pCXh+w@mail.gmail.com>
 <20190219111802.1d6dbaa3@gandalf.local.home> <CAHk-=wgTuK3kAduP-gr10vykT1uG=B2VpdffvmyBuTQ1UxPpMg@mail.gmail.com>
 <20190219140330.5dd9e876@gandalf.local.home> <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
In-Reply-To: <20190220171019.5e81a4946b56982f324f7c45@kernel.org>
From:   Jann Horn <jannh@google.com>
Date:   Wed, 20 Feb 2019 14:57:31 +0100
Message-ID: <CAG48ez0e5b0qmW1kMVEYDKvxn=-FkfRw=0KXUm5_R3aAGU-LJA@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 9:10 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> On Tue, 19 Feb 2019 14:03:30 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > > > Basically, a kprobe is mostly used for debugging what's happening in a
> > > > live kernel, to read any address.
> > >
> > > My point is that "any address" is not sufficient to begin with. You
> > > need "kernel or user".
> > >
> > > Having a flag for what _kind_ of kernel address is ok might then be
> > > required for other cases if they might not be ok with following page
> > > tables to IO space..
> > >
> >
> > Good point. Looks like we should add a new flag for kprobe
> > trace parameters, that tell kprobes if the address is expected to be
> > user or kernel. That would be good regardless of the duplicate
> > meanings, as we could use copy_from_user without touching KERNEL_DS, if
> > the probe argument specifically states "this is user space". For
> > example, when probing do_sys_open, and you want to read what path string
> > was passed into the kernel.
> >
> > Masami, thoughts?
>
> Let me ensure what you want. So you want to access a "string" in user-space,
> not a data structure? In that case, it is very easy to me. It is enough to
> add a "ustring" type to kprobe events. For example, do_sys_opsn's path
> variable is one example. That will be +0(+0(%si)):ustring, and fetcher
> finally copy the string using strncpy_from_user() instead of
> strncpy_from_unsafe(). (*)
[...]
> (*) BTW, there is another concern to use _from_user APIs in kprobe. Are those
> APIs might sleep??

If you want to access userspace without sleeping, and ignore data in
non-present pages, you can do `pagefault_disable(); err =
__copy_from_user_inatomic(...); pagefault_enable();`. (Actually, maybe
the kernel should have a helper for that...)
