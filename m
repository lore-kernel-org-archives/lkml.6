Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1062C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1DA820BF2
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 10:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DA820BF2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeGLKOX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 06:14:23 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:38259 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeGLKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 06:14:22 -0400
Received: by mail-vk0-f68.google.com with SMTP id b77-v6so16026699vkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 03:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGrO5/9lqJoS1Sw18dA6wsOk+ouM92yCPFyUc1rFJMk=;
        b=NlE8bDrNA8ymYLElIP3WlhXPqEec2VDZyZuQVWCxMWgP6t9RoB4DmExDU8ZBEFsUHi
         adsFltsczQdqmRVyKC0mlmG7b1kDAKhts6CLzDl6ICrB7CvDOHK+0PC01mQ6kgVb+VOf
         8+W3QTTKtwQb1xoeAF5Nt7xq9MiRskZDLn9/gK+nPpinHNelVHXG6eiyL235XIycB61x
         v/erg14KtoUsz7KjaW0qUTDaVPjHCE8Q988nbzMFnImTY4dSNC91EIDXozx5tGvPZVfI
         7ud8Z8uYqDbPYoZO1J9cvIzlU7ZyAaTAcL83SdB5r1rx+IjkII631weNlQXfXc4vKWLn
         VuZg==
X-Gm-Message-State: AOUpUlHPP5U+cMl7O74ZlqFqhl4be6f8eQ/CvWtejbdbr04F1jwGZ+U5
        0CRHbcyRyJmG/lfa6IIWeICMzJmytU4N/X+jaMs=
X-Google-Smtp-Source: AAOMgpcGJldfV5ACI6gxDNiaiVRJnIq8LUnHie/bSGtmFBebweDtzsaEFeKlDavWBOb/uifN9abQnvWd7FUpdZrn9ek=
X-Received: by 2002:a1f:8355:: with SMTP id f82-v6mr780949vkd.3.1531389930290;
 Thu, 12 Jul 2018 03:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180711151003.6768-1-geert+renesas@glider.be>
 <cd7a7d241252bbb6588448ed7f27d51811025c63.camel@perches.com>
 <CAMuHMdXJeeaZQHqYp+q+L4FSRNusavDjtN8A_K-koiHGGGEFXw@mail.gmail.com> <2fe72b18d3a3aa782529e112e07a0eb8d7cf2cc1.camel@perches.com>
In-Reply-To: <2fe72b18d3a3aa782529e112e07a0eb8d7cf2cc1.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 12 Jul 2018 12:05:18 +0200
Message-ID: <CAMuHMdVtv7_hV2wkS43fn9jTcwP8Xr84TULJRFPnM4u0v2ZJxw@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: Warn if missing author Signed-off-by
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Wed, Jul 11, 2018 at 7:24 PM Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-07-11 at 19:07 +0200, Geert Uytterhoeven wrote:
> > On Wed, Jul 11, 2018 at 6:20 PM Joe Perches <joe@perches.com> wrote:
> > > On Wed, 2018-07-11 at 17:10 +0200, Geert Uytterhoeven wrote:
> > > > Print a warning if none of the Signed-off-by lines cover the patch
> > > > author.
> > > >
> > > > Non-ASCII quoted printable encoding in From: headers and (lack of)
> > > > double quotes are handled.
> > > > Split From: headers are not fully handled: only the first part is
> > > > compared.
> > >
> > > []
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > >
> > > []
> > > > +# Check the patch for a From:
> > > > +             if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > > > +                     $author = encode("utf8", $1);
> > > > +                     $author =~ s/"//g;
> > > > +             }
> > > > +
> > > >  # Check the patch for a signoff:
> > > >               if ($line =~ /^\s*signed-off-by:/i) {
> > > >                       $signoff++;
> > > >                       $in_commit_log = 0;
> > > > +                     if ($author ne '') {
> > > > +                             my $l = $line;
> > > > +                             $l =~ s/"//g;
> > > > +                             if ($l =~ /^\s*signed-off-by: \Q$author\E/i) {
>
>         if (/^\s*signed-off-by:\s*\Q$author\E/i)

Dropping the "$l =~" doesn't fly.
The "\s*" part does work.

> > > > +                                 $authorsignoff = 1;
> > > > +                             }
> > > > +                     }
> > > >               }
> > >
> > > I don't see the point of removing the quotes.
> >
> > If the name contains a dot (e.g. "David S. Miller"), it must be protected
> > by double quotes in the From: email header, but that is usually not the case
> > in the Sob line.
>
> Right.
> It seems it's unusual for SOBs to use quotes around names.

But it does happen from time to time.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
