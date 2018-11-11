Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05B4C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6963E20872
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 14:48:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xh0a5Wr/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6963E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbeKLAhm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 19:37:42 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50794 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeKLAhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 19:37:42 -0500
Received: by mail-it1-f196.google.com with SMTP id k206-v6so9241024ite.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 06:48:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zis/jZynlIeU/NB7VQqGY1++TiKZ788KlLvEtfVWkv0=;
        b=Xh0a5Wr/T4ftTq7perkhJAmt4Lc4lcj6ylApfJ6FABhJW10UPh/gilGRHmtUQYsg7o
         Jq57pRPZ785V13rEHDl1JZfh7qLJWG0xaeIRHlw3pk+UnLzXvkO4w977c0YaJyBmOA8r
         oBezzZGxgAB+X9HwTEcilWzPPKKMgGGXESTwBgpZVOJb6GG8jhKxrYXu0WbtQck5oVTc
         0TsSqGU/I5xtiQC2g/NaacwITvI1ljKwJhV/+2qkt5Kqwswym2w7Q9xaRwQuDHJIMZb5
         NxOgboDageQ9cVSFbh1x48WKmhb/gYmZkqZTwtFHQr514bFykeYWln6Il5pcYah51jR6
         0zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zis/jZynlIeU/NB7VQqGY1++TiKZ788KlLvEtfVWkv0=;
        b=pXeBt7jKWbv5PBT9SstVhQQOJ1luhjYErazMq/ufpzbTu5MrgK5vBzYVlTfXBWtJom
         y2ugHj7IgD9tE6EbyoTKcTDti40eN7mysIBfKjRQVu5hclVFHCRHUif6E7XZAl3QyIo8
         kui9fzSslCQFd4GWqJu67y6Lxa4b7TW5x8YXHn6hF9Vl+QkUio8S71Rr78ghzmYtpcqX
         wswFH10rMcOo5bH/thhxoLybin4NZRNgoiNSL/XiNPZ70isUG3siJCHLieFtzehIslsW
         OfEjxFduISnbCIZZ+1c3nAyMApqfU1CrY1S912tJA9rU6OGzE8I25aUQcF5xT3lCrwET
         6aow==
X-Gm-Message-State: AGRZ1gKufUZunbz+0O21PvYg3vsQYJtvbUxbv0iR/2vcDo1fSC4qGS17
        0EL/Hc18lTNTGCWk6+88QD8YoC1LCRwcIWEua60=
X-Google-Smtp-Source: AJdET5ekpuAbwF9AIX1rVXJpWRjRRL99JsK4jYKjUjk4jT0QFF28MiwtiLXUyZdt3QD4SC2aruJR8uOfsFRGioW8flg=
X-Received: by 2002:a24:5e93:: with SMTP id h141-v6mr9129972itb.103.1541947735833;
 Sun, 11 Nov 2018 06:48:55 -0800 (PST)
MIME-Version: 1.0
References: <20181107022156.GA254567@google.com> <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org>
 <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is>
 <20181107205514.GB12273@roeck-us.net> <20181107.210731.330601031@genki.is>
 <CAD=FV=Wcxf7p1DyJdVEqODbc6TdTtbPiLszWCAS1xC6=4kkLbw@mail.gmail.com>
 <CA+ASDXN40pvbZKvsO3Cb8256AQJ3fyQh5TWdT+GDk_ncq11nMw@mail.gmail.com>
 <CAK7LNAR5etb-oJDaxNZbH9-FmC3+hC3A_cwnbuWPQx0maHaDng@mail.gmail.com>
 <20181109183436.GA45531@google.com> <20181110.085826.230851261@genki.is>
 <m24lcpjjss.fsf@linux-m68k.org> <20181110.201050.925673938@genki.is>
In-Reply-To: <20181110.201050.925673938@genki.is>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Sun, 11 Nov 2018 16:48:38 +0200
Message-ID: <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
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

On Sat, Nov 10, 2018 at 10:12 PM Genki Sky <sky@genki.is> wrote:
>
> Hi Andreas,
>
> On Sat, 10 Nov 2018 11:42:11 +0100, Andreas Schwab <schwab@linux-m68k.org> wrote:
> > On Nov 10 2018, Genki Sky <sky@genki.is> wrote:
> > > On Fri, 9 Nov 2018 10:34:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
> > >> +          git_status="$(git --no-optional-locks status -uno --porcelain 2>/dev/null)"
> > >> +          if [ $? -eq 0 ]; then
> > >> +                  if echo "$git_status" | grep -qv '^.. scripts/package'; then
> > >
> > > Shouldn't this be:
> > >
> > >     if printf '%s' "$git_status" | grep -qv '^.. scripts/package'; then
> > >
> > > I.e., use printf not echo? Because of echo introducing a newline.
> >
> > The input to grep should be a text file, thus should end with a newline.
>
> Ah okay, thanks. I guess GNU grep was being lenient. Well then, I
> think the line at least needs to be changed to:
>
>         if [ -n "$git_status" ] && echo "$git_status" | grep -qv '^.. scripts/package'; then
>
> I'm just trying to say that in the proposed patch, if git doesn't
> print anything, the echo adds a newline that wasn't there before. This
> causes the grep -qv to exit with status 0 (because there's at least
> one line that doesn't contain '^.. scripts/package'). Meaning it will
> print dirty.

Piping the output of the git command to grep and using the return status
of grep as the test condition within the if block, would be sufficient
to determine whether or not '-dirty' should be printed.

Sample run:
% if git --no-optional-locks \
        status -uno --porcelain \
        2>/dev/null |
        grep -qv '^.. scripts/package'
then
        printf '%s' -dirty
fi
%
