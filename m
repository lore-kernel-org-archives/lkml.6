Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AD9C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4279B20866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 15:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GXf7Rwu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4279B20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbeKLAwf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:52:35 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:35955 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728331AbeKLAwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:52:35 -0500
Received: by mail-it1-f196.google.com with SMTP id w7-v6so9863757itd.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 07:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KdKYPchVfzxjkO0ND5MdF2IByIaiZMeiSZQ8D1af/as=;
        b=GXf7Rwu2lUlmTeFAiD/eV0M//Ruw4xkJWIf2F2bislGO3Vk3jBsUauiiPs3YnhEOLh
         XKKSX9fVbaAIrfshahskSccXmA54fWpFhXhH3BiulFod7EiQQUtbQSb85xlIq8N/p8g5
         6NjZhl3HoWGSQJzX7jBmLpykYcpy3ExgLF6KbflfhMW/WvDmAYY/t9JHe4X5pzqj7ysV
         UGtFI+H9Gl3X1zvgnMzvXUKOHJgVVMQq98UtnpFzjvPbce+kLoxUkX7CqMC/s45SvnzQ
         ViN/DnUp2pBvl9CraaL1Oy5psbjGeF3IQ9Me36Z8ihDgQnyaILzK8KHkuu2IAMS8IVI+
         hxXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KdKYPchVfzxjkO0ND5MdF2IByIaiZMeiSZQ8D1af/as=;
        b=IgCcxzQoHGrxtINAHSW9VJzYiJw+W6yQhWcIQw3kaQEJkMl97P12tOUlWcejL/WK+A
         f69hTlLr5QsLfEtN7YWRtA4rv2X2Xh2FnbUEXVymkpJI/AbdHpfk5x3CAk8kknfhhrAm
         S7BEvcW2/G4+JW+wLTHGVR5fLrqDCuLLuHSLFKefUETYw3PnFwY2QKPzJ3ICFslSBFwq
         5NZfW1hJvZvlATaXNdW4gjM0n2uXubxZW8oQI+9Zx1yRPtwyi0s86XU/Bg4w/81twKQS
         TEIHpkU1UXdEFI/w9zbs56KQx3UXZ4EB9UzOHJBSo6ewItwGQwJzWaGREmuFgbVSQigN
         VFqg==
X-Gm-Message-State: AGRZ1gJSN8nLUhDRmhrkFCMxQzJRKRi8ppqxcd799ObFcybb5XMlggJt
        vdZRX4E7jBvL3cxJdkSW7OzNNqm/glADYvBW+bQ=
X-Google-Smtp-Source: AJdET5cSWqZpR9n4rVDOY9TvC9qJVxmhQYCTmJofQ2pcUZ+ocfI+RuNs3nnbHPMKPEFkQc9k9dMeNZkws8p+YTBwecQ=
X-Received: by 2002:a24:5e93:: with SMTP id h141-v6mr9175242itb.103.1541948627020;
 Sun, 11 Nov 2018 07:03:47 -0800 (PST)
MIME-Version: 1.0
References: <20181107022156.GA254567@google.com> <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
 <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
 <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
 <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is> <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
In-Reply-To: <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Sun, 11 Nov 2018 17:03:29 +0200
Message-ID: <CAJ1xhMWh15L62wv+bKMzvEUEvLbj-PTZQ0g=AzY3BzkvfikzBQ@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     sky@genki.is
Cc:     schwab@linux-m68k.org, briannorris@chromium.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        dianders@chromium.org, Guenter Roeck <linux@roeck-us.net>,
        lists@nerdbynature.de, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 4:48 PM Alexander Kapshuk
<alexander.kapshuk@gmail.com> wrote:
>
> On Sat, Nov 10, 2018 at 10:12 PM Genki Sky <sky@genki.is> wrote:
> >
> > Hi Andreas,
> >
> > On Sat, 10 Nov 2018 11:42:11 +0100, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > > On Nov 10 2018, Genki Sky <sky@genki.is> wrote:
> > > > On Fri, 9 Nov 2018 10:34:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
> > > >> +          git_status="$(git --no-optional-locks status -uno --porcelain 2>/dev/null)"
> > > >> +          if [ $? -eq 0 ]; then
> > > >> +                  if echo "$git_status" | grep -qv '^.. scripts/package'; then
> > > >
> > > > Shouldn't this be:
> > > >
> > > >     if printf '%s' "$git_status" | grep -qv '^.. scripts/package'; then
> > > >
> > > > I.e., use printf not echo? Because of echo introducing a newline.
> > >
> > > The input to grep should be a text file, thus should end with a newline.
> >
> > Ah okay, thanks. I guess GNU grep was being lenient. Well then, I
> > think the line at least needs to be changed to:
> >
> >         if [ -n "$git_status" ] && echo "$git_status" | grep -qv '^.. scripts/package'; then
> >
> > I'm just trying to say that in the proposed patch, if git doesn't
> > print anything, the echo adds a newline that wasn't there before. This
> > causes the grep -qv to exit with status 0 (because there's at least
> > one line that doesn't contain '^.. scripts/package'). Meaning it will
> > print dirty.
>
> Piping the output of the git command to grep and using the return status
> of grep as the test condition within the if block, would be sufficient
> to determine whether or not '-dirty' should be printed.
>
> Sample run:
> % if git --no-optional-locks \
>         status -uno --porcelain \
>         2>/dev/null |
>         grep -qv '^.. scripts/package'
> then
>         printf '%s' -dirty
> fi
> %

To improve the readability, the git command may be stored in a variable
and substituted into a command within the if block like so:

% cmd='git
--no-optional-locks
status
-uno
--porcelain'

% if $cmd 2>/dev/null | grep -qv '^.. scripts/package'; then
        printf '%s' -dirty
fi
%
