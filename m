Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D38C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621062089F
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 17:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="E1JfCbQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbfBQRli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 12:41:38 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:42030 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBQRli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 12:41:38 -0500
Received: by mail-vs1-f68.google.com with SMTP id b20so8339244vsl.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6PgdSNnQzlX/eTUtXBJn/6MFVTF8DobJiNsBHLchxHg=;
        b=E1JfCbQ4VS4MUNs3mLMLvzyNlvw3U2+hosjXJQ1zpVpvqVOvgQZUogvXCCaf6eFL55
         8/3z3bwtFEtaKc+cFAkWDhtxuYCutN5HDThw9+JI8ECTl9eE6t0BiH72ScF6T6NFGJOH
         MhTjBViwpT2BK2pSAmK1/QVOWxjtamus81HB0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6PgdSNnQzlX/eTUtXBJn/6MFVTF8DobJiNsBHLchxHg=;
        b=fzWbsddIPYgtZ9+Jigjkb614NJ9PjyrS8WzAmVmkIxgRsqWDM6Dj3wR3xWmQC82z1w
         TPpVBVM8fjdKmOE2pLEfbZVPPgZmK1fYXw8eavBWJpmGDwT8c9RcmGl5kfqOGDBPW7nt
         SlXCdaqcgUFbLK/EHMgSGgk9D3W3eskoz5GKPQ7NmkAhm5B5YsyQHw3aP0AchFuvx8jj
         gAvSEY9mGYp7qShN6FgDBow1tPVO0c5McdBvsox9odycmHufN0HrME8twXAQs7SEiQRf
         JNhGGcFbwZnimWHPvreZi4NhUgnIsYcgzNZ7qP50BQwepll2zzcDpkL9HsxZDTOkihZm
         XdhQ==
X-Gm-Message-State: AHQUAuYrOvU8LlZ993W385mbQkvTxWCdJ1tI+Nwunc/tCV8NfD9zXA/h
        ONKm4rO/ujRp14bVu7nGtJU3QDyQeeE=
X-Google-Smtp-Source: AHgI3IYvrNiTeykdQVFnLdkbY4ASAbw5XrlYjLQOO4jm0UPmt3V3c5811Lmx7jYI/mGQlghK5lqQYQ==
X-Received: by 2002:a67:2e81:: with SMTP id u123mr4720913vsu.135.1550425296742;
        Sun, 17 Feb 2019 09:41:36 -0800 (PST)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id c185sm4781312vka.24.2019.02.17.09.41.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 09:41:35 -0800 (PST)
Received: by mail-vs1-f43.google.com with SMTP id z18so8350719vso.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Feb 2019 09:41:35 -0800 (PST)
X-Received: by 2002:a67:fa45:: with SMTP id j5mr3015414vsq.48.1550425295175;
 Sun, 17 Feb 2019 09:41:35 -0800 (PST)
MIME-Version: 1.0
References: <20190217090903.GA17600@beast> <CAHk-=wiA00pLq_3DautqfL=Dn9r4Nmjgw+M2ABt-RfCX38xh6g@mail.gmail.com>
In-Reply-To: <CAHk-=wiA00pLq_3DautqfL=Dn9r4Nmjgw+M2ABt-RfCX38xh6g@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Feb 2019 09:41:24 -0800
X-Gmail-Original-Message-ID: <CAGXu5jJrbM+wocY3bA59JDqkKwpptb3PGWFq-RiXrD2cfig2uQ@mail.gmail.com>
Message-ID: <CAGXu5jJrbM+wocY3bA59JDqkKwpptb3PGWFq-RiXrD2cfig2uQ@mail.gmail.com>
Subject: Re: [PATCH v4] exec: load_script: Do not exec truncated interpreter path
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 17, 2019 at 9:30 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Feb 17, 2019 at 1:09 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > +static inline char *next_spacetab(char *first, const char *last)
> > +{
> > +       for (; first <= last; first++)
> > +               if (spacetab(*first))
> > +                       return first;
> > +       return NULL;
> > +}
>
> I think this should be "next_terminator()" and also stop at NUL.
>
> You do check for the NUL case here:
>
> > +               if (!next_spacetab(cp, buf_end) && *buf_end)
> > +                       return -ENOEXEC;
>
> but it means that if there's no space ot tab and it's a short file,
> you pointlessly walk to the end. No?

Yeah, that works. I'll send v5.

-- 
Kees Cook
