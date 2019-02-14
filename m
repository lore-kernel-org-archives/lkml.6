Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DEFEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B34C20821
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 16:38:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="THPJ2HCg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439668AbfBNQiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 11:38:54 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46253 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405016AbfBNQiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 11:38:54 -0500
Received: by mail-vs1-f65.google.com with SMTP id n10so3994854vso.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:38:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ayLJXiXvelPmcsTzXKtARiU/ic4/0bzSK2PSIxYKdi8=;
        b=THPJ2HCg2mOBN6tjeJc65frB4x5tqONWjH9jtb7wQc7pk8rUl2f1GkP395wL/rf5xy
         L3VjBi3dhMu3ZKWvVY+ydibB6I98SN+rni8BLarOa0OvnPSF28OUB29UYCv8fTPURHGr
         bZCWPTOkfd31pRDagzP6nmgRBinKP2JWPSIJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ayLJXiXvelPmcsTzXKtARiU/ic4/0bzSK2PSIxYKdi8=;
        b=L5yTARdBGqJYA5PSwvS6SznrU2rNBQgy8D45KmdrEMC/ald3EBAyM2yUWchbVwqySs
         M6jAAEU9XgVZ7V9fwf1I77/NaJTumzahEfg5B5UlkWy+SBftTj2Z6E6WGovO1Jt8cyEn
         ZqUOIoea1+IrJo1S5d2sdCtPQn5c0BSF5xdlVQ9WpIyaSRwDyeuaMnH7QsbgdiRjtLyy
         gzfUVADafzD6XK/c0FQHlALURlxSxuvNAvd3l7m5Z3dWahlF5QvaGX2kldaXKr/DL2X2
         R4HB9nb1+qgmXer95eGv05GY/rDvfwMmwYpaIJVDeVW1ED8aiIOUX9qD2gdnz5s5yFs4
         4oMQ==
X-Gm-Message-State: AHQUAubzcEaJWYoDil/FGLnyqrPOIsk0i8bp1LI7HmyBmepI+OdXmxAF
        BR2vHSrTGy1QFHRaJyZECxKgZvqzKIo=
X-Google-Smtp-Source: AHgI3IYKZrm/aJu30kYGZYILI/c0cd921JLxTvuGopbCvUORooTW3wjXsdgV8dB1disVey5CSeghuA==
X-Received: by 2002:a67:b003:: with SMTP id z3mr2699514vse.200.1550162332721;
        Thu, 14 Feb 2019 08:38:52 -0800 (PST)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id f71sm592263vke.41.2019.02.14.08.38.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Feb 2019 08:38:51 -0800 (PST)
Received: by mail-ua1-f48.google.com with SMTP id d2so2240202ual.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 08:38:51 -0800 (PST)
X-Received: by 2002:a9f:2709:: with SMTP id a9mr2431240uaa.10.1550162330984;
 Thu, 14 Feb 2019 08:38:50 -0800 (PST)
MIME-Version: 1.0
References: <20190214012754.GA17326@beast> <20190214160821.GB19102@redhat.com>
In-Reply-To: <20190214160821.GB19102@redhat.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Thu, 14 Feb 2019 08:38:39 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLb=C=i-jNx6qLuPgGgN=mf0tgpaC6VS8EO6Kac6nnRsA@mail.gmail.com>
Message-ID: <CAGXu5jLb=C=i-jNx6qLuPgGgN=mf0tgpaC6VS8EO6Kac6nnRsA@mail.gmail.com>
Subject: Re: [PATCH] exec: load_script: Allow interpreter argument truncation
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 8:08 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> On 02/13, Kees Cook wrote:
> >
> > While we want to make sure the kernel doesn't attempt to execute a
> > truncated interpreter path, we must allow the interpreter arguments to
> > be truncated. Perl, for example, will re-read the script itself to parse
> > arguments correctly.
>
> Heh. I still think that 8099b047ecc4 does the right thing.
>
> But I can't argue with the fact that it caused the regression, so it should
> be reverted.
>
> > This documents the parsing steps, and will fail to exec if the string was
> > truncated with neither an end-of-line nor any trailing whitespace.
>
> You know, I have already spent 3 hours trying to write something simple and
> clear, but failed. Still trying...

That's why I added comments too. It's kind of a weird bit of parsing,
and has to protect itself from lack of initial NUL-termination. :P

> Nor I can really understand your fix ;) Will try to read it again, just one
> question for now,
>
> >       for (cp = bprm->buf+2;; cp++) {
> > -             if (cp >= bprm->buf + BINPRM_BUF_SIZE)
> > -                     return -ENOEXEC;
> > -             if (!*cp || (*cp == '\n'))
> > +             if (cp == bprm->buf + BINPRM_BUF_SIZE - 1) {
> > +                     truncated = true;
>
> Off-by-one, no? "bprm->buf + BINPRM_BUF_SIZE - 1" is the very last char, it can
> be '\n' or '\0', this should set end_of_interp.

Ah yeah, this bails out one byte too early. As you suggestion, I
should move that test to after the !*cp || *cp == '\n' test, like so:

        for (cp = bprm->buf+2;; cp++) {
                if (!*cp || (*cp == '\n')) {
                        end_of_interp = true;
                        break;
                }
                if (cp == bprm->buf + BINPRM_BUF_SIZE - 1) {
                        truncated = true;
                        break;
                }
        }
        *cp = '\0';

> >                       break;
> > +             }
> > +             if (!*cp || (*cp == '\n')) {
> > +                     end_of_interp = true;
> > +                     break;
> > +             }
>
> so unless I am totally confused you should move this block up before the
> "bprm->buf + BINPRM_BUF_SIZE - 1" check or that check should use
> "bprm->buf + BINPRM_BUF_SIZE".
>
> No?

Moving the block is right, dropping the -1 would be lead to the
post-loop *cp = '\0' writing past the end of the buffer.

With this change, my tests (after gaining an extra byte of available
interp path name) still pass. I'll send a v2...

Thanks!

-- 
Kees Cook
