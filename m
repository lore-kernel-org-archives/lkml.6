Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB5AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8D921920
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 22:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="GZ1ouaNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403814AbeLUW5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 17:57:33 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43190 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392193AbeLUW5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 17:57:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so6080664lji.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AYnSPgQrUKFm8qMBlc9X79d5wgZQUGMC7qSuUVJiHB0=;
        b=GZ1ouaNZpu9t9mAsgS9RJnHiRZDmTbu88zrN6Cz/D3cpis1HvdbZyJUZHgeKoc78CG
         xXSx0E0OcA/kpaD0U7zaLEx/si9LdLx3O70aYfvFgtcIp7aTpj02N9nbfCQrovAq4Npd
         yYzu6SdK4tzMZJrG4MmymBSnqLPDYOibrb6yQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AYnSPgQrUKFm8qMBlc9X79d5wgZQUGMC7qSuUVJiHB0=;
        b=gNyPHQQ2U3Xgt0k2rLPIvRZ6RoE8kb4Mqp7WaSubB+BOyqf32vFOCv2M8wNIyiPwsD
         0W2W2YFP4PQOANvI5to7f/w10KN8acDz0deVj6VzAIICotIwdi2WUvDM/UKeXY5cn0gb
         LBoWGvRLwVbdugl6bk1W193NEldFKfQbrzzR3p5GIoz9DfyABr0+xqPtVyEwTkuWccxQ
         B+nKvPgf8uZUo47f5v/LpOCiXoc4RQADOsGeLpJu9X3nxh0zVIuV34BbuhiGZvGeEgCv
         UcndEy6GOyI4BP5SrqOS6gQ9KUNqQfWG8cimoteJgsZwmHr5yoBjGTxercM+qbv23RVT
         yhcg==
X-Gm-Message-State: AA+aEWYNPdT8eKHrDigvZi1q41X5twe6llO9BukJyk0Tib2eDuKVA0xB
        poxc4MCKcQ6jNXc9mQgmtX8aMfdh4TA=
X-Google-Smtp-Source: ALg8bN6Aech1kMjJNWf45DI5siecZ8us6ogDiQELNzqcfYy8/Hb4B2nOIAzCTYzyLj7N12lsfr47KQ==
X-Received: by 2002:a2e:974a:: with SMTP id f10-v6mr3051252ljj.61.1545433050964;
        Fri, 21 Dec 2018 14:57:30 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c203sm5074780lfe.95.2018.12.21.14.57.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Dec 2018 14:57:29 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id t18-v6so6084665ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 14:57:29 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr2914084lji.133.1545433049165;
 Fri, 21 Dec 2018 14:57:29 -0800 (PST)
MIME-Version: 1.0
References: <20181221175618.968519903@goodmis.org> <20181221175659.208858193@goodmis.org>
 <CAHk-=wg_sR-UEC1ggmkZpypOUYanL5CMX4R7ceuaV4QMf5jBtg@mail.gmail.com>
 <20181221144054.20bdeb33@gandalf.local.home> <CAHk-=wgSvRhj6KNRdn9gbK9RJVAswdtKSNjAxdf9O9vn04T5XQ@mail.gmail.com>
 <20181221153526.5e6055ca@gandalf.local.home> <CAHk-=wjtkvFUuRNZU67KccuUKYHw=pYoDMQJ_9OVDFxOwmK9zQ@mail.gmail.com>
 <20181221155513.11450ca6@gandalf.local.home> <CAHk-=wjaNWzXSW9XT-Z=9OF=5+2ft6UqjoUgaWeEWx8PUmS9xg@mail.gmail.com>
 <20181221174816.0ed7af47@gandalf.local.home>
In-Reply-To: <20181221174816.0ed7af47@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 21 Dec 2018 14:57:13 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgSovEz3gy56q0bhOMVt9Rx5ooq97KmY=XX37_JdE+4pQ@mail.gmail.com>
Message-ID: <CAHk-=wgSovEz3gy56q0bhOMVt9Rx5ooq97KmY=XX37_JdE+4pQ@mail.gmail.com>
Subject: Re: [for-next][PATCH 23/24] string.h: Add strncmp_prefix() helper macro
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Tom Zanussi <zanussi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2018 at 2:48 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > Your patch actually had them, but in the body of your email you did
> >
> > > #define have_prefix(str, prefix) ({ \
> > >       const char *__pfx = (const char *)prefix; \
> >
> > which is just completely wrong.
> >
> > Considering your _old_ patch had the exact same bug, I really think
> > you need to start internalizing the whole "macro arguments *have* to
> > be properly protected" thing.
>
> Well, there's less with assignments that can go wrong than with other
> code. That is, there's little that can happen with "int x = arg;" where
> arg is the macro paramater to cause something really nasty.

What's wrong, Steven?

The assignment is entirely irrelevant.

The problem is the cast.

A type cast has a very high priority, and so if you do

    (const char *)prefix

it breaks completely if you might have something like"a+6" as the argument.

Think about what if "a" is of type "unsigned long", for example?

                   Linus
