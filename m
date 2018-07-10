Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35794C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:50:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9F9B208E8
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 15:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9F9B208E8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934388AbeGJPuo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 11:50:44 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:42419 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934353AbeGJPum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 11:50:42 -0400
Received: by mail-vk0-f66.google.com with SMTP id t4-v6so12619024vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 08:50:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bH2023NQ4pY4zXS1VBWOo9nohWx10f+d0JK4SapALNE=;
        b=kn81hMMu/82vkTH57QyUYIEBWNPzyaHaV4W4/fGOC/1WBQRDIMDJHAOGXCMykievdu
         IG69uXrTfy1om6mmU18m3NHfdRE5XeBMcoSMd1Q53YvYukqJi0bB8/vDpzvIaCmKpiYH
         jaUDZGKlo5cLAChjV6v5cOXFMXoj/BZgixog1kNMR5EtINM7y4enFeIrVFLQQtzFpLeB
         Ywzqh80wTyPo/3WRWzwpMuKh9gtNDdwrCXZx99KE7r80oA8MHHpxWAuDCLmK7bhynHu5
         Wy2qEOst9fvB1lDrExDsQoB4wsNDjHHE2X+6DZus1VPQymKFjl+KgzouqepAdCB+ogY1
         /Gdg==
X-Gm-Message-State: APt69E1dFggLBLu5UB9ktaLLYC3a6tre/i9Dy2y+JJ/TvgPbJYWomQVT
        lxV+v2PjTfxFL5CVFHbgKjvRIL/AYYG48kjbkCk=
X-Google-Smtp-Source: AAOMgpfheX0IaKPTwyjnM1vvbs02nN3xgi5JdseuR3SiCzAcWSlWTPFrCJUeG1+xvRIYqEKXvdViwB7eQwtRINird1I=
X-Received: by 2002:a1f:f44f:: with SMTP id s76-v6mr14258307vkh.125.1531237841920;
 Tue, 10 Jul 2018 08:50:41 -0700 (PDT)
MIME-Version: 1.0
References: <20180710121014.31119-1-geert+renesas@glider.be>
 <e4e25250dbea658f25dcf10504f3147731b5d2e9.camel@perches.com>
 <CAMuHMdV34P+2=-Myfzdv1-+4m2_cTHQcQO80fZ5Ai+G9J6X0kA@mail.gmail.com> <9c95ae2b06524a6638f26d61d7efe4afc86f877b.camel@perches.com>
In-Reply-To: <9c95ae2b06524a6638f26d61d7efe4afc86f877b.camel@perches.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 10 Jul 2018 17:50:30 +0200
Message-ID: <CAMuHMdV29UV6qrN8RhSJqh+yYevsOD0UERvYqHBhh8rRn8CXsA@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: Require author Signed-off-by
To:     Joe Perches <joe@perches.com>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>, jgg@mellanox.com,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linus Walleij <linus.walleij@linaro.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Jul 10, 2018 at 5:28 PM Joe Perches <joe@perches.com> wrote:
> On Tue, 2018-07-10 at 17:07 +0200, Geert Uytterhoeven wrote:
> > On Tue, Jul 10, 2018 at 4:34 PM Joe Perches <joe@perches.com> wrote:
> > > On Tue, 2018-07-10 at 14:10 +0200, Geert Uytterhoeven wrote:
> > > > Print an error if none of the Signed-off-by lines cover the patch
> > > > author.
> > >
> > > []
> > > > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> > >
> > > []
> > > > @@ -13,6 +13,7 @@ use POSIX;
> > > >  use File::Basename;
> > > >  use Cwd 'abs_path';
> > > >  use Term::ANSIColor qw(:constants);
> > > > +use MIME::Words 'decode_mimewords';
> > >
> > > Is this a typically installed perl module?
> > > If so, what perl version installed it by default?
> >
> > I don't know. At least my Ubuntu 16.04LTS and 18.04LTS systems had it
> > installed.
> > It does not seem to be part of the core modules, cfr.
> > https://perldoc.perl.org/index-modules-M.html
> >
> > I've tried using MIME::QuotedPrint instead, but then we need to parse
> > =?UTF-8?q? ourselves, as decode_qp() only transforms the actual
> > quoted printable bits in side the encoded From: address.
>
> I'd looked too and couldn't find it from 5.10 forward,
> so I'd prefer not requiring that module.

"that module" = MIME::Words?
So I can use MIME::QuotedPrint?

> Also, the From: line is also an email header and I don't
> believe it should be used author information in the
> same way as a patch From: line.
>
> So likely the
>
> +# Check the patch for a From:
> +               if ($line =~ /^\s*From: (.*)/i) {
>
> should be "if ($in_commit_log && $line =~ /^\s*From: (.*)/) {

That doesn't work. The "From:" line in the email body is only added by
git-send-email when it detects the "From:" line in the patch differs from
user.email in git-config.
It is not present in patches generated by git-format-patch.

So to work for both the sending ("From:" in email header only) and
receiving ("From:" in email header, to be overridden by "From:" in email
body) side, the $in_commit_log check must not be present.

> with some regex or function to remove the MIME encoded word.

I guess I can do that.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
