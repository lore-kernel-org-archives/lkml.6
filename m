Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 976BDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CE482087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 18:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DOQC7DHF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730190AbfA3Str (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 13:49:47 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:39890 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfA3Str (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 13:49:47 -0500
Received: by mail-yw1-f65.google.com with SMTP id k188so236642ywa.6;
        Wed, 30 Jan 2019 10:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ilGGv8BmpVWoi8q/TeyaEakPNC6kHARNHOa6QvJfDQs=;
        b=DOQC7DHFBVoJJqQGmZh0w53An+NW8++s3TS6pNP7udD4GHJKM9M5XufL/mYadvOp26
         4dIwvlGj3uqn2ewlLiKuG50yKMIueOG6EZhz3ofk6t5Cj+lbLtuQppsNJX3D+6lSz1BZ
         q9gOdjWYLiV+FH19qsT3XGNkgB7irxRWK8mzuPxZxVQXn2A6NRIHCRMJTvvLr5kWtwuQ
         4OWACnfkfXUpy2zmRWLmpI738mtlDjGjpt6KS9PpaM6PlW7TZBRdgr4yOQi3EP3qXul1
         i71okvihbeIVs6geHOieBBPjNe5g6BuUwnv3cOGbMb8mS4PmNtcrlSi7zjOjJK29Q1za
         zWdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ilGGv8BmpVWoi8q/TeyaEakPNC6kHARNHOa6QvJfDQs=;
        b=F2r1hxGv2wQliK8zteLlt8OgLX0fuBXvATaa8LP1hvCtiKCmlfZFVTfEdb7mHS9Vj7
         OGHhV/ekVq6V3EFMumVlkIh9/1UlKZChdHX88C5Tvhc1aNDZ/b/dmgXrmP2LJxZTQh3e
         LL8pip9XvLwUT1tCjCWhprzCmfvSM245AXs3Gqx3q/CXnIVwT3pcQINRmf7ugiqOtbyy
         WmOWqrDB5WQKXn/qQpgo1b7Caup6r20pO1YfAaC9cKEu1F2km36oZ21GnQhV4AApm9jL
         fh2pxlwE/h6IIE7H0Zz/G5DAsv+s9fZf9DmmBUJlAdD8gWbsBs4LTikJ6e4wITyOdkVE
         XeXQ==
X-Gm-Message-State: AJcUukdr9NLlRtICbrJrrB6hzy6c8YvYlct5fsx0FIJ4BkE6NqO92Z6p
        WKyNUGm1aawNM+Hg3WXOTKKrlh+aFWhXqfinXF0=
X-Google-Smtp-Source: ALg8bN6dZUlEKy8q0WLx1mMmfmgSUyMjOUsd0K2+fL3jbnXQ0ly9+x3IbiTlakUg6bwkimoaiVbj2KKCytgSNeBgsWM=
X-Received: by 2002:a81:54:: with SMTP id 81mr30879180ywa.404.1548874185793;
 Wed, 30 Jan 2019 10:49:45 -0800 (PST)
MIME-Version: 1.0
References: <20190129113131.751891514@linuxfoundation.org> <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
In-Reply-To: <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 30 Jan 2019 20:49:34 +0200
Message-ID: <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        ltp@lists.linux.it, open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        chrubis <chrubis@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 30, 2019 at 2:55 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Tue, 29 Jan 2019 at 17:19, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.14.97 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patc=
h-4.14.97-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm, x86_64, and i386.
>
> NOTE:
> -----
> LTP upgrade to 20190115 and fanotify01, fanotify09 and readahead02 tests =
failed
>
> fanotify01 failed on hikey and dragonboard410c arm64 boards all kernel ve=
rsions
> fanotify01.c:256: FAIL: got event: mask=3D2 (expected 20) pid=3D2756 fd=
=3D9
> https://bugs.linaro.org/show_bug.cgi?id=3D4261
>
> fanotify09 failed on arm64 devices running 4.14 version kernel
> fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
> https://bugs.linaro.org/show_bug.cgi?id=3D4271
>

fanotify09 was added a new regression test case for commit
  b469e7e47c8a: fanotify: fix handling of events on child sub-directory

That commit was backported to v4.19. As I wrote in "backport hint", the bug
exists in older kernels, but fix does not apply cleanly to older kernels.

Thanks,
Amir.
