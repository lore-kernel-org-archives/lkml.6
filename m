Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3538BC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 04:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED5FC20663
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 04:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550983101;
	bh=I0rIrmSR60dc4ryKHi9UYHHUli44sWLiycj03ohpd+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kZfZY1QSVpCjoU67Fz5bL7aUw3jg15eXPWm7N768MYNlNb86n2sj5UPo4EUcTFa0V
	 lwaCjMH1BWcNqYcKxkh1QteI2qfRp9365YtlBQCm35Fj4howBrxsgN1Q7MkQ8sHi3W
	 eH0VDE0nQ+G+qvOD5xtSI7Q6xMDgpXwBFDtyVUsg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728073AbfBXEiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 23:38:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:52428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727800AbfBXEiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 23:38:18 -0500
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E026F20880
        for <linux-kernel@vger.kernel.org>; Sun, 24 Feb 2019 04:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550983098;
        bh=I0rIrmSR60dc4ryKHi9UYHHUli44sWLiycj03ohpd+c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NNAPEBEIAJC8eTAxFxBCHnRQHdJm9KRdYhH0m0aFw0Q0mRAgoDfJj5c6WLAUGg8JR
         ivhY51HQNZ/3eLNH3JREuJiUZouz9uBqM/a/0FfMAF3Oqo1Of6HniUsIZ7v/vMbt7q
         B25Pj78fks2wdk3fEYmTJIBfQHyoh7cFuONF+HYw=
Received: by mail-wm1-f44.google.com with SMTP id o10so542290wmc.1
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 20:38:17 -0800 (PST)
X-Gm-Message-State: AHQUAuaeUaHAvkRzKLZ47HDNaI9mvQcy9IOglYbmSifiKgpcqwe5Zxqp
        Thw5t+4mKSU0klJULyy7eMLHuRdxNNSOSjZzcXSyEQ==
X-Google-Smtp-Source: AHgI3Ib7eF9uWq07Ff84G4koH/5CVCAnE5BEwxAsQ/8yZ6o1XdUuzkTJFQF5Zny2pGPut7XIKE5TQwzJBCQ1jjz0/PU=
X-Received: by 2002:a1c:7906:: with SMTP id l6mr6549894wme.83.1550983096320;
 Sat, 23 Feb 2019 20:38:16 -0800 (PST)
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
In-Reply-To: <20190223194421.725a03fd@oasis.local.home>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 23 Feb 2019 20:38:03 -0800
X-Gmail-Original-Message-ID: <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
Message-ID: <CALCETrVDMhpA-oJnpuEP2j21aK5ZosW2PNskVDxm4MSR6Afqug@mail.gmail.com>
Subject: Re: [PATCH 1/2 v2] kprobe: Do not use uaccess functions to access
 kernel memory that can fault
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Changbin Du <changbin.du@gmail.com>,
        Jann Horn <jannh@google.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 4:44 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Sat, 23 Feb 2019 12:47:46 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> > Since kprobes handler runs in IRQ context, we can not use access_ok() in it.
> > (only on x86 + CONFIG_DEBUG_ATOMIC_SLEEP=y)
>
> Is it really IRQ context or exception context? That is, one
> (interrupts) happen for any task, but exceptions happen because of the
> software that is executed (like a breakpoint). Although you can have a
> kprobe trigger in an interrupt handler (where user access wouldn't make
> sense anyway). But there should be no problem with user access from an
> exception handler.
>

Can we just get rid of this might_sleep()?  access_ok() doesn't sleep
as far as I know.
