Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D94BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AB420645
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gQfQUknh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11AB420645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbeK1L5B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:57:01 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:50605 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbeK1L5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:57:00 -0500
Received: by mail-it1-f193.google.com with SMTP id z7so1745667iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 16:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tTxHwPhct+EriMZHwjdh36dzC86VWLyLGH7ytrdyE5Q=;
        b=gQfQUknhXl+YMvyv86Ul9LaJ5CyO2LYnQ+ir7PoPq6Ye3x7BqGRYceXlyclVd2iYTU
         jRl1KJsY14jNEne9hjBqde/DhFDdR6ri5NTD8jrA7lqyewL3TQOMckE1gu2MU+Te/Npr
         +AHaUpot5pc1bEmg6qpW5UZpWmUgaKUc2UjHnF5fz8pHjkngJeZTS7UxO00qk5G0M5LB
         a07CRgCGFKwSYNsnPwqwUjbEggHdBNtCSIugMo+haNCcO1aa/sUHwucaAb0Omx4Gxfww
         zK6sUTCp0l5dcwR0C199JpjFiiDBw0wpAcbmRCBHC+pLUlC8ndiEbw1a912piNaw4Prp
         dFNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTxHwPhct+EriMZHwjdh36dzC86VWLyLGH7ytrdyE5Q=;
        b=CuYMCKXBJMAmqJ/VUSmrYfEjnPHNasJF/YOVcCEWz0zwgcg0cae0+xzqivfVGMwTuy
         +5S6NEfaAo4KtUACEINH3sRJ/7EwtMGzyACT7oMwPaK2ItEfLnRX/JT4QilipqrznWG8
         EJCz0RUa42c6p9JfFcDO3FAJk1RTiw2z8dhLgxjx2EzAC4KLDUUjHsp9EDMZgL0m1UfK
         gKwmkUdyV5nMjAtL7nO+NtK86vCraFkuNZKa1O43sXdXxYqlN41F95OGEyo0HTSXob/n
         4s19OAeCluH7FLSGlwi+UnCwCw0sqlvbB5S8JAtz5NXEj7+JwIezzJRuio0Q3vrYYd8m
         Puew==
X-Gm-Message-State: AA+aEWaDKLbLPytsVeZmPoBQJlYqcbCT90SoDf0YU3Ewg9miyipqmtrF
        7MHeiAaXEpv4hryqC8Xo39epyXzKfa8iBRHDbb8=
X-Google-Smtp-Source: AFSGD/XweRgf3ob8lXNZMoEt7TYcxfSzHO+m7vX423fp85fB1uEAiysy2xg6MTwIEeIl7bnrzjRgg5QY1Zgy5xSu0BQ=
X-Received: by 2002:a02:5184:: with SMTP id s126mr25221956jaa.12.1543366637143;
 Tue, 27 Nov 2018 16:57:17 -0800 (PST)
MIME-Version: 1.0
References: <20181119154334.18265-1-tiny.windzz@gmail.com> <c9c572ed-05a1-cec9-97e9-2b66cb58afcc@intel.com>
 <CAGXu5jJuHQOi3C7_xH7Fo2H-=EmzKkwAPWmWPOUNb0WWMTLnJQ@mail.gmail.com>
In-Reply-To: <CAGXu5jJuHQOi3C7_xH7Fo2H-=EmzKkwAPWmWPOUNb0WWMTLnJQ@mail.gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Wed, 28 Nov 2018 08:57:30 +0800
Message-ID: <CAEExFWtUgY3Y7grG8AUiieUXNuj3+EZvJi-P7-W_x5vjXft1+Q@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/dump_pagetables: Change to use DEFINE_SHOW_ATTRIBUTE
 macro
To:     Kees Cook <keescook@chromium.org>
Cc:     dave.hansen@intel.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 6:50 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Mon, Nov 19, 2018 at 9:06 AM, Dave Hansen <dave.hansen@intel.com> wrote:
> > On 11/19/18 7:43 AM, Yangtao Li wrote:
> >> -static const struct file_operations ptdump_curusr_fops = {
> >> -     .owner          = THIS_MODULE,
> >> -     .open           = ptdump_open_curusr,
> >> -     .read           = seq_read,
> >> -     .llseek         = seq_lseek,
> >> -     .release        = single_release,
> >> -};
> >> +DEFINE_SHOW_ATTRIBUTE(ptdump_curusr);
> >
> > FWIW, I rather dislike this conversion and the DEFINE_SHOW_ATTRIBUTE()
> > approach in general.  It makes it basically impossible to go from
> > ptdump_curusr to ptdump_open_curusr without opening up the macro and
> > reverse-engineering it.
> >
> > My test is that for these macros to be sane, I need to be able to find
> > "ptdump_open_curusr" by grepping for "ptdump_curusr".  This fails the test.
>
> Er, "ptdump_curusr" matches the generated name "ptdump_curusr_show",
> is that what you mean?
>
> > I don't think saving a few lines of code is worth the obfuscation.
>
> This is the standard boilerplate for attributes, though. I'd be nice
> to drop all the copy/pasted code...
>
> --
> Kees Cook
I also think that we should delete the duplicate code which doesn't
make much sense.

MBR,
Yangtao
