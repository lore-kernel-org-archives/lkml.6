Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86731C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AC682087F
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 08:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="umrM7U/Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AC682087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728598AbeKLSfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 13:35:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39164 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbeKLSfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 13:35:13 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so12052608itl.4
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 00:43:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwnwzLkwqjgmuGG+Six6aXEDrO9SOqG70d+3LUeliaE=;
        b=umrM7U/Ze+vcZweW7orWobMlCxR9n5t/y70BU9yyNeV8OzmWOVHDJ9WVZU79c8fZr5
         Z0REOv/pEUhIwlo3qGygPBdI0uyAwMoNVArNBfWzipebp6vRKpAZdRDX3qP7OSh2CgHx
         S/v5xl2vpZ2xEhIjjvje9ffRpSJ8MBYqiB1IscW4mokSmgJ09tgXgHtfJQjWw7Xm55o2
         TlTpQK1LSvnjlOJlYQhRMxBYvmW8zpoAoz3/DeB9B/p32yt62auTAVde07GKsR3dBXz0
         3w/wY22TDri4nDaerDFo45ponnfaCBpFjkHPXxapQfBuT4EAZKerKr5dnltbR8rlNyZi
         QxIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwnwzLkwqjgmuGG+Six6aXEDrO9SOqG70d+3LUeliaE=;
        b=r0X1PHHFEHQIGoQk0qrPVrSF6imrdM0bNvzsLC+7Z1ZLAfzwAB2xmOxUuS6Ie0yKMi
         BaJHsOs6iFwo4MAHlk61iQhmuBRH1E/pWWQkZtIzMK1cY7CL2WaCjig35Fzaz/h8KtfF
         gQMBoRWYqBAPxVc+SkZ6aNa9Z4d7NsSonWjIONtFtvC5r9Aqk2T9uqDqvsh0wokLla7L
         AZzpO1ZfBiC5YAN4idbGqn0hf/8KxRO/NAY01z2DYcPkSCX4xtZToq3s71LSHXoHnhHr
         J0Q8r/I7fIOIhvLmKrBsVH7UfEot1gkb/WUxm62zUJcuhsex1fJl1FqVeJJftsaGehg/
         uKgA==
X-Gm-Message-State: AGRZ1gLPEzK6dYBmsRqcdjwb13y3V+kNPoUotABloNahv1EdkLH4CNnK
        9gMYoZeVUw/zoheRaZh0dGyCOCo/VOMg+H4SlJ4=
X-Google-Smtp-Source: AJdET5ezceAa91GwOvkDr22m3WjjcH941HUVdDFx9X+AX5OOKxf9rsAFb4NQEKUyYCiiTlZcMHon49EVmyCP0FsEJXc=
X-Received: by 2002:a24:70ca:: with SMTP id f193-v6mr10611085itc.59.1542012182922;
 Mon, 12 Nov 2018 00:43:02 -0800 (PST)
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
 <CAJ1xhMXDFAdiWMV6ODcJM8bfjs-ddyv8utf6N+Yh7+-Ne-KaHw@mail.gmail.com>
 <20181111.174140.002789201@genki.is> <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
In-Reply-To: <CAJ1xhMUA4GUzeDANqR1WafELmEpE+-V569t7e0xCotTG2Lvbyw@mail.gmail.com>
From:   Alexander Kapshuk <alexander.kapshuk@gmail.com>
Date:   Mon, 12 Nov 2018 10:42:26 +0200
Message-ID: <CAJ1xhMWw8Mi2dubTFNOxhoP6hk+__Qjo-0+9sQbpqP5K-n4mVw@mail.gmail.com>
Subject: Re: [PATCH] scripts/setlocalversion: Improve -dirty check with
 git-status --no-optional-locks
To:     sky@genki.is
Cc:     schwab@linux-m68k.org, Brian Norris <briannorris@chromium.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>, lists@nerdbynature.de,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 9:59 PM Alexander Kapshuk
<alexander.kapshuk@gmail.com> wrote:
>
> On Sun, Nov 11, 2018 at 7:41 PM Genki Sky <sky@genki.is> wrote:
> >
> > Hi Alexander,
> >
> > On Sun, 11 Nov 2018 16:48:38 +0200, Alexander Kapshuk <alexander.kapshuk@gmail.com> wrote:
> > > Piping the output of the git command to grep and using the return status
> > > of grep as the test condition within the if block, would be sufficient
> > > to determine whether or not '-dirty' should be printed.
> > >
> > > Sample run:
> > > % if git --no-optional-locks \
> > >         status -uno --porcelain \
> > >         2>/dev/null |
> > >         grep -qv '^.. scripts/package'
> > > then
> > >         printf '%s' -dirty
> > > fi
> >
> > I don't think this works well for us. We need to check whether
> > --no-optional-locks is available before using the output to determine
> > whether the tree is dirty or not. If it's not available, we have to
> > fall back on diff-index. Let me know if I'm misreading you.
>
> It was I who failed to read the proposed patch in its entirety in the
> first place. I did not get the full picture as a result. My apologies.
>
> Would something like this work for you?
>
> local git_status
> git_status=$(git --no-optional-locks status -uno --porcelain 2>/dev/null)
> test $? -eq 0 ||
>         git_status=$(git diff-index --name-only HEAD)
> if printf '%s' "$git_status"  | grep -qv scripts/package; then
>         printf '%s' -dirty
> fi

An even simpler approach would be:

{
        git --no-optional-locks status -uno --porcelain 2>/dev/null ||
        git diff-index --name-only HEAD
} | grep -qv scripts/package &&
        printf '%s' -dirty

Sample run:
cmd
sh: cmd: command not found

{
        cmd 2>/dev/null ||
        date
} | grep -q 2018 &&
        printf '%s' ok
ok
