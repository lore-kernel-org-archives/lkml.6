Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38ABC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C601223D0
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 19:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8RHWX2e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C601223D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbeKNFPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 00:15:11 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55902 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNFPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 00:15:11 -0500
Received: by mail-it1-f193.google.com with SMTP id o19so10864210itg.5
        for <linux-kernel@vger.kernel.org>; Tue, 13 Nov 2018 11:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dh+rjCM32ehGaFSxkcnS1rCN5Fcj+0J/RO/nokDH0wc=;
        b=o8RHWX2eJDuujK6wBnGT094q6678wNqe2YyKwFi994ozGAq4sKD3X6B7gHUtgFTqgz
         wbEV05VfUXu0UQRs3aFHjgL7DFRSHZZOzZzg1NEAK7c9zQSjyhO11BUeTJ2Kzx2vl+Z/
         nZa2dgf0OGk06otj9ZZVAr6sLgBPsII7A2jLtjQg6mHf4JEgwL5vbBzikUJYWwl73Mda
         pDCABEFWGPylmA4TZpWkvvJhwPbQV3GlkUhNtlMXkcb9dHC7HiQadxJ6n1w8MQufS9Yv
         F1TOpoluwXHfX9YUKEVQoGMaUY3WkEdIhbulCFPVgoluQBzuKeSR64VvSYFJKgfHym1+
         nUMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dh+rjCM32ehGaFSxkcnS1rCN5Fcj+0J/RO/nokDH0wc=;
        b=rQG/1wqLMjIaAPodtFW3DdwO6FUfsVeoX094gufPaA90illFQ23xiAkF46tCUeDVkw
         7BMN6U7jrr891lm/5Btf2qhAG6cAY8rKoneytxFH83w9B/RDt+HJ92DpFjh8wKM5UwYq
         EPV/GSKsWj7RDSLAqZhqYJ6+ApeOQZzEW1hJMg1bWmZgqcmE1RpXwGQmtsZhIPaSJSsc
         EAatZ1I5knD5rjxxk0OUGT017Rn8XH5g7VzeOLTmzEAKNgYVBxa9WG41lLfL8OXzsCW2
         n8i/89T6GRZqBGd/6F0jgoLaLiTm6Vxe/AUuuKbtS6Ado+bRW8UsdLyUxMABrlyau3Xs
         JTrQ==
X-Gm-Message-State: AGRZ1gJivmr5YZ+oiXip/bxvKsUKj/aMN/BV47VwbDrnU1I1qmYOXHCy
        ggvAT2jff1lGMzRNYc3PBrn/DXcP/j8cGBUuDD0=
X-Google-Smtp-Source: AJdET5dZCt8sZQRNkhr4frdBeK1in497l6fcrfOE6Q8URCaB38jt/j+XQR+AXF179tTYiH5wBUeggFlfFj6RrEK21sc=
X-Received: by 2002:a02:a0c9:: with SMTP id i9-v6mr6019537jah.116.1542136541251;
 Tue, 13 Nov 2018 11:15:41 -0800 (PST)
MIME-Version: 1.0
References: <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
 <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is> <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
 <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
 <20181113000938.GA16783@google.com> <CAJ1xhMVFt6bYgwY+N5VoFXNpm5kS1j_HV8-ZS8SkavNgZx1HOg@mail.gmail.com>
 <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
In-Reply-To: <CA+ASDXPcYp_joFeyGQ7TXFBSK-7i6bNFzaA1z=YYSDEjyMABdg@mail.gmail.com>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Tue, 13 Nov 2018 21:15:26 +0200
Message-ID: <CAJ1xhMW-zStA0yrxn6nWGE2CAhjky9-obOCz6=dqf-M0vr4OPQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     Brian Norris <briannorris@chromium.org>
Cc:     sky@genki.is, schwab@linux-m68k.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 13, 2018 at 8:32 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Alexander,
>
> On Tue, Nov 13, 2018 at 12:36 AM Alexander Kapshuk
> <alexander.kapshuk@gmail.com> wrote:
> >
> > On Tue, Nov 13, 2018 at 2:09 AM Brian Norris <briannorris@chromium.org> wrote:
> > >
> > > On Mon, Nov 12, 2018 at 10:42:26AM +0200, Alexander Kapshuk wrote:
> > > > An even simpler approach would be:
> > > >
> > > > {
> > > >         git --no-optional-locks status -uno --porcelain 2>/dev/null ||
> > > >         git diff-index --name-only HEAD
> > > > } | grep -qv scripts/package &&
> > > >         printf '%s' -dirty
> > > >
> > > > Sample run:
> > > > cmd
> > > > sh: cmd: command not found
> > > >
> > > > {
> > > >         cmd 2>/dev/null ||
> > > >         date
> > > > } | grep -q 2018 &&
> > > >         printf '%s' ok
> > > > ok
> > >
> > > You lose accuracy here, because now you're skipping any line that
> > > contains 'scripts/package', which would include, e.g., paths like
> > >
> > >   tools/some/other-scripts/package
> > >
> > > Maybe if the grep expression were more like this?
> > >
> > >   grep -qv '^\(.. \)\?scripts/package'
> > >
> > > I think it'd be safe enough to ignore paths that start with two
> > > characters and a space, like:
> > >
> > > xy scripts/package
> > > x/ scripts/package
> > >
> > > Brian
> >
> > Thanks for your input.
> > I've found the following grep command, that uses extended regular
> > expressions, to work as required:
>
> Is there any good reason you switched to extended? It looks like my
> (basic regex) grep was equivalent.
>
> > {
> >         echo hello
> >         echo scripts/package
> >         echo '.. scripts/package'
> >         echo tools/some/other-scripts/package
> > } | grep -Ev '^(.. )?scripts/package'
> >
> > [Output]
> > hello
> > tools/some/other-scripts/package
> >
> > If the participants of this email exchange consider the proposed
> > implementation as fitting the bill,
> >
> > {
> >         git --no-optional-locks status -uno --porcelain 2>/dev/null ||
> >         git diff-index --name-only HEAD
> > } | grep -Eqv '^(.. )?scripts/package' &&
> >         printf '%s' -dirty
> >
> > Was the original committer of the patch proposed here,
> > https://lkml.org/lkml/2018/11/10/55, going to take it in, and resend it
> > as v2 of the patch, or did you want me to submit the patch instead?
> > I would be happy with either way.
>
> I can submit it. I expect Masahiro-san would prefer a proper v2 patch
> for review, given how much would change from my v1.
>
> And this time, I'll actually test it with a non-dirty tree! (Of
> course, my tree is naturally dirty when developing the patch, but I
> missed testing post-commit...)
>
> Brian

Hi Brian,

Thanks for taking my proposed patch in and submitting it.

I went with the ERE because, in my opinion, the pattern looks
'cleaner' without having the metacharacters like '()?' escaped.
EREs are POSIX-compatible, so should be supported by any POSIX-compliant shell.

Your non-ERE version does generate the same output as my ERE one. So
it just boils down to one's personal preference.

Thanks.
