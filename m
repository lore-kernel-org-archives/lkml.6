Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38CBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE94206BA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dvoBj9Lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730465AbeLNRqw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:46:52 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33963 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729341AbeLNRqw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:46:52 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so1803711pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N374BbMHCPku8eJQVFB2xDbFPUi2I0IjzRvA4zLa0no=;
        b=dvoBj9LvyCWQIE8Z0emHVuw0fe9rAgTlgyjXJzCZ1DxiO/FUqKNEXW4PRpoW00qJAQ
         qFnYDMLLWTYoZTjkTxmr12ev02Xv0mnuz5i1ZijHcosJOxRK3jIZUTUUxicly6eHMRx5
         ioCOsJ3jz6nflnB3X/2xds4Roly2YSrqC2nMsCmANrzNaLJQTzgTYkBletl5PpNkeubR
         y+00e4rFGDJ1j9bAico1Maxj0vkcrx5EyHJlXUfOEA9FrNzgycee+9kPJdQXo5NOMp95
         ZP265zKvfH+MPkQ2Oy4MUi6LKLYm9r4voRRJ1EgRKPF4m91+6B7pfjXsNz8xGqmFjs7T
         jMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N374BbMHCPku8eJQVFB2xDbFPUi2I0IjzRvA4zLa0no=;
        b=iuAColL6zFy8fx46HKuC8txIirhxrhJMayg1MsKoIZ/WokbMoPNkpYhb9YqVjr0N/5
         R6WtxRnhI3lu+Zq7VWoULKDIhYEK1Rg3FzRxGgSHXbUDz20llKAJcVl8H55x3q6v9vrR
         dyQW6wSb1IvzBSQxnU3L37TVo9i1kk9XYEQi7lFZPauzmWFg25aMrqrWr29xQf/DE8cR
         5wwMG0+MlEPIPNr4NJazl5iteirM/WwqU+x0/m8Qy4AbYfsoQU0aWa0NfKWfqc0KzjjE
         kANGOKfAapn8gKOOLRo5LLN4fDjOhNn1RISAntjU/41qcP+KS1ysmhUt2M18nBk7WK7k
         LPTQ==
X-Gm-Message-State: AA+aEWaI6oTNORskAtiLhlMDqPWdh9lNYusq0iQnpUFr5CvtORWQmadd
        tZMoRbZqallzTccIFLliqGkJRkHD9SafKtHWkhhP/A==
X-Google-Smtp-Source: AFSGD/VeW+Rv/isFYcGe0LlNQ9YHNtbN13yf2cqEaq25EKY2dx47SaSmX1w4qbbB+O1HePzSzawxppQFXb5gDoEM0KE=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr3600440pgf.302.1544809610665;
 Fri, 14 Dec 2018 09:46:50 -0800 (PST)
MIME-Version: 1.0
References: <20181214141433.466991-1-liuxiaozhou@bytedance.com> <CANiq72ndmEBLm_0A6iKXta1rVhYgsaHBL6QE+UFa7xFt8xdzTA@mail.gmail.com>
In-Reply-To: <CANiq72ndmEBLm_0A6iKXta1rVhYgsaHBL6QE+UFa7xFt8xdzTA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 14 Dec 2018 09:46:39 -0800
Message-ID: <CAKwvOdmF2rx-A=chY70pvDVHEacRT5Mh9KVbL=pLy4O7jHTNMQ@mail.gmail.com>
Subject: Re: [PATCH v3] Compiler Attributes: don't pollute userspace with
 macro definitions
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     liuxiaozhou@bytedance.com,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        paul.burton@mips.com, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 8:06 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Fri, Dec 14, 2018 at 3:16 PM Xiaozhou Liu <liuxiaozhou@bytedance.com> =
wrote:
> >
> > Macros 'inline' and '__gnu_inline' used to be defined in compiler-gcc.h=
,
> > which was (and is) included entirely in (__KERNEL__ && !__ASSEMBLY__).
> > Commit 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutu=
ally
> > exclusive") had those macros exposed to userspace, unintentionally.
> >
> > Then commit a3f8a30f3f00 ("Compiler Attributes: use feature checks
> > instead of version checks") moved '__gnu_inline' back into
> > (__KERNEL__ && !__ASSEMBLY__) and 'inline' was left behind. Since 'inli=
ne'
> > depends on '__gnu_inline', compiling error showing "unknown type name
> > =E2=80=98__gnu_inline=E2=80=99" will pop up, if userspace somehow inclu=
des
> > <linux/compiler.h>.
> >
> > Other macros like __must_check, notrace, etc. are in a similar situatio=
n.
> > So just move all these macros back into (__KERNEL__ && !__ASSEMBLY__).
> >
> > Note:
> >   1. This patch only affects what userspace sees.
> >   2. __must_check (when !CONFIG_ENABLE_MUST_CHECK) and noinline_for_sta=
ck
> >      were once defined in __KERNEL__ only, but we believe that they can
> >      be put into !__ASSEMBLY__ too.
> >
> > Acked-by: Nick Desaulniers <ndesaulniers@google.com>
> > Signed-off-by: Xiaozhou Liu <liuxiaozhou@bytedance.com>
>
> Thanks Xiaozhou, picked into compiler-attributes with a slightly
> modified title (since it is not about compiler attributes this time),
> and let's see if there is any problem with it in linux-next.
>
> Nick: I kept your Ack, even if it is a different patch. Let me know if
> you don't want to Ack this version.

Doubled-acked-by: Nick Desaulniers <ndesaulniers@google.com>
(I recognize it's always ambiguous whether to carry forward sign-offs
when a patch set changes)
--=20
Thanks,
~Nick Desaulniers
