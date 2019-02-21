Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C91EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFEA82075C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 14:28:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OlypJojq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBUO2l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 09:28:41 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:45193 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfBUO2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 09:28:41 -0500
Received: by mail-oi1-f193.google.com with SMTP id t82so1518091oie.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 06:28:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=926hIetHQPpxRqS+x1Be0Xqwmc7Zk1dsRoJ1K4FmIok=;
        b=OlypJojqPyGFVqKduO5g6zZ62N2Qb1RAxt+Dh4R2qERXmIi2fNXMCCHmXDlMw6k/94
         9R7LAmWyVtdxXhZrM0ZxVkopbDbt9CVveiimcsckJ0XvyUMtWR0vaqVL7pi4L6yfaTvT
         DzZ7EMN8Gbho1VcqjEsCtsFC/iuk/p7QTaVyQP7k45qbSFicqUE51daG9ebky0J3SKry
         6+218azpLvkbLAaVD+nFDpWk+8xnQ9m9CwEwUsUodv1yLnQcO9qZcYe+his7zvX+RT7+
         UnWw8Kqa7yN5cT5kT4apJbtzeabA8a9xQmICyycBmJ8t2JrHaf1020paJ9/WMohhiZdo
         qMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=926hIetHQPpxRqS+x1Be0Xqwmc7Zk1dsRoJ1K4FmIok=;
        b=gOFrcnzwj6lRV4gPKBNyN+DFQmg5KxaiXVF3nEA7r4q3QN5XTbMR+n7z/GORLMl97b
         rqs5OCq8XW3FwLoYI+asr/n/JpfY1YiW5nrGb+jLThPd7tU9ZlSZxxr3jsJZby5x0U9w
         eD1ZFlilsv/WNGplh1yFl9nnqRpRGhUD6Y7RvNuYUSOZAofym2TX+rvnLtqCXijxuFTR
         SbQES2elrydAH4s5hhvuygPF+gHQD3taGAJkrnKYCqchNfjQOQj1YM39+Xy1UvdUThOh
         4ASjq6XgEuFIMfrbOoOBCvqzF9332UFYhyLblRuiDOpyW+73cd7C8CmAYMwWB/0bKkz2
         uKAg==
X-Gm-Message-State: AHQUAuYuGVMuW0d4QkdfAk1bLVrLMjsEbG2X/6AHcN7ljekozd1TB1O8
        p7zUxXYpw0RxGarPZoIZxj/sxHheFeBCSC46k2NrLw==
X-Google-Smtp-Source: AHgI3IZJpa9wzKYTAeqCzQ/8etNcJO6Ej+w6KjPWUypiV2Jp6SIkF4hTlyRtr7Yme2MDK3kCH9DNfNt9s/6tbrSxHuQ=
X-Received: by 2002:aca:cc4d:: with SMTP id c74mr9817358oig.157.1550759319977;
 Thu, 21 Feb 2019 06:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20190218232308.11241-1-tobin@kernel.org> <20190218232308.11241-6-tobin@kernel.org>
 <CAG48ez0utQJjoJW69OwGiuH1EQtcD939-5u71ruD_1nr0eJK0g@mail.gmail.com> <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
In-Reply-To: <CAGXu5jKeS3bkTSXEw2nsjrWoqhbkDZD4C=PdYTHMtM0GNk6tSg@mail.gmail.com>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 21 Feb 2019 15:28:13 +0100
Message-ID: <CAG48ez34MMBfTzQFxj2o5brYDrUS89_gvX9=SnpWZ+TjMUV-BQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] lib: Fix function documentation for strncpy_from_user
To:     Kees Cook <keescook@chromium.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Daniel Micay <danielmicay@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 2:05 AM Kees Cook <keescook@chromium.org> wrote:
> On Mon, Feb 18, 2019 at 4:52 PM Jann Horn <jannh@google.com> wrote:
> > AFAICS the byte_at_a_time loop exits when max==0 is reached, and then
> > if `res >= count` (in other words, if we've copied as many bytes as
> > requested, haven't encountered a null byte so far, and haven't reached
> > the end of the address space), we return `res`, which is the same as
> > `count`. Are you sure?
>
> Oh, whew, there is only 1 arch-specific implementation of this. I
> thought you meant there was multiple implementations.

Not sure what you're talking about. Are you talking about
implementations of strncpy_from_user()?


csky: custom strncpy_from_user() calls custom __do_strncpy_from_user,
which is a macro containing a big asm() block.


h8300:
;;; long strncpy_from_user(void *to, void *from, size_t n)
strncpy_from_user:
mov.l er2,er2
bne 1f
sub.l er0,er0
rts
[...]


mips:
static inline long
strncpy_from_user(char *__to, const char __user *__from, long __len)
{
long res;

if (eva_kernel_access()) {
__asm__ __volatile__(
"move\t$4, %1\n\t"
"move\t$5, %2\n\t"
"move\t$6, %3\n\t"
[...]


unicore32:
ENTRY(__strncpy_from_user)
mov ip, r1
1: sub.a r2, r2, #1
ldrusr r3, r1, 1, ns
bfs 2f
stb.w r3, [r0]+, #1
cxor.a r3, #0
[...]


and so on.

> So, generally speaking, I'd love to split all strncpy* uses into
> strscpy_zero() (when expecting to do str->str copies), and some new
> function, named like mempadstr() or str2mem() that copies a str to a
> __nonstring char array, with trailing padding, if there is space. Then
> there is no more mixing the two cases and botching things.
