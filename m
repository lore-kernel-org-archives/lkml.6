Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC4FC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D9A320C0D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D9A320C0D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbeGKRMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:12:47 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:37648 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389992AbeGKRMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:12:46 -0400
Received: by mail-vk0-f65.google.com with SMTP id h22-v6so14809538vke.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 10:07:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UC9/qETyV+mXG1xgquCRXQydBNoDkTHznoX7G0t65Qs=;
        b=XdbuUYYwVBAdrTtGDl39adKWq8mxRuaBmG3WruYMWY8lRq0SHIzJemY+W/IFygbbaL
         KRwU1pavc5PmG1wxMmq+QGbe6ysULma3UKx7YiS0jx3ifaDvbp+g+eAeLJ8au2snjd9k
         7g4YHT8GZ6lt9OSurGwIaR03sUoKBBZRyAp6rTtQq8XQr8UGnP+5L7yaisb8R/0t39rk
         d9SFN/Sd3RRSz9BVFz1wXBhO2xycGrS3+mWLY+UeF4nQDiTp0mEnUPzAhWdFld3Ynms2
         fWih6S/HfPj1FuPDXNMPnP3luBjhMaTPrwzGUlKrPolM5Xr0KJjOm1qiPcYZVGKtA90T
         8a0Q==
X-Gm-Message-State: APt69E29+kWUuwVLThjfsB7qEler+PHTQb0McugbV3wsnBpiWiq850qC
        ApCXeU0DcYHEMj1hYXLeojo4pITy+UAi0B8KB5zWlu3t
X-Google-Smtp-Source: AAOMgpf7Y9TTZEf1F0IDQPH18DqEcFMTUS6AzMqup1fvNA1R8SSSDLiUmVQa62Elaygkcqj4PDIK/s7EfsyMmWS44m8=
X-Received: by 2002:a1f:f44f:: with SMTP id s76-v6mr16974950vkh.125.1531328851349;
 Wed, 11 Jul 2018 10:07:31 -0700 (PDT)
MIME-Version: 1.0
References: <20180711151003.6768-1-geert+renesas@glider.be> <cd7a7d241252bbb6588448ed7f27d51811025c63.camel@perches.com>
In-Reply-To: <cd7a7d241252bbb6588448ed7f27d51811025c63.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 11 Jul 2018 19:07:19 +0200
Message-ID: <CAMuHMdXJeeaZQHqYp+q+L4FSRNusavDjtN8A_K-koiHGGGEFXw@mail.gmail.com>
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

On Wed, Jul 11, 2018 at 6:20 PM Joe Perches <joe@perches.com> wrote:
> On Wed, 2018-07-11 at 17:10 +0200, Geert Uytterhoeven wrote:
> > Print a warning if none of the Signed-off-by lines cover the patch
> > author.
> >
> > Non-ASCII quoted printable encoding in From: headers and (lack of)
> > double quotes are handled.
> > Split From: headers are not fully handled: only the first part is
> > compared.
> []
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > +# Check the patch for a From:
> > +             if (decode("MIME-Header", $line) =~ /^From:\s*(.*)/) {
> > +                     $author = encode("utf8", $1);
> > +                     $author =~ s/"//g;
> > +             }
> > +
> >  # Check the patch for a signoff:
> >               if ($line =~ /^\s*signed-off-by:/i) {
> >                       $signoff++;
> >                       $in_commit_log = 0;
> > +                     if ($author ne '') {
> > +                             my $l = $line;
> > +                             $l =~ s/"//g;
> > +                             if ($l =~ /^\s*signed-off-by: \Q$author\E/i) {
> > +                                 $authorsignoff = 1;
> > +                             }
> > +                     }
> >               }
>
> I don't see the point of removing the quotes.

If the name contains a dot (e.g. "David S. Miller"), it must be protected
by double quotes in the From: email header, but that is usually not the case
in the Sob line.

> If the name and email address don't exactly match,
> why shouldn't it be reported?

It's still the same email address.

> >  # Check if MAINTAINERS is being updated.  If so, there's probably no need to
> > @@ -6487,9 +6503,14 @@ sub process {
> >               ERROR("NOT_UNIFIED_DIFF",
> >                     "Does not appear to be a unified-diff format patch\n");
> >       }
> > -     if ($is_patch && $has_commit_log && $chk_signoff && $signoff == 0) {
> > -             ERROR("MISSING_SIGN_OFF",
> > -                   "Missing Signed-off-by: line(s)\n");
> > +     if ($is_patch && $has_commit_log && $chk_signoff) {
> > +             if ($signoff == 0) {
> > +                     ERROR("MISSING_SIGN_OFF",
> > +                           "Missing Signed-off-by: line(s)\n");
> > +             } elsif (!$authorsignoff) {
> > +                     WARN("NO_AUTHOR_SIGN_OFF",
> > +                          "Missing Signed-off-by: line by patch author\n");
>
> Perhaps better to show the From: line author
>
>                 "Missing 'Signed-off-by:' from nomimal patch author '$author'\n");

OK.

> Another somewhat frequent Signed-off-by: defect pattern
> is to have a lower-case name or no name at all used.
>
> Perhaps it'd be useful to add some checks like
> a single word for a name and all lower-case names:
>
> e.g.:
>         Signed-off-by: joe perches <joe@perches.com>
>
> emits
>
> Unusual lower case name: 'joe perches <joe@perches.com>'
>
> and
>         Signed-off-by: root <root@mydomain.net>
> and
>         Signed-off-by: Root <root@mydomain.net>
> and
>         Signed-off-by: root@mydomain.net
>
> all emit that a single or missing name is unusual.

Perhaps. But adding email addresses is not the topic of this patch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
