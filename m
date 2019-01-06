Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B4C43387
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 925F421B1C
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="D1PNUqd5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfAFBDy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 20:03:54 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:63729 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbfAFBDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 20:03:53 -0500
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x0613nRw025090;
        Sun, 6 Jan 2019 10:03:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x0613nRw025090
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1546736630;
        bh=fNlxsC5GLeowiy56JqO0UNAWSJVAvOAviC4NhKS8ioc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D1PNUqd5ZU4E6MiSMcZGpW7F+ule7FtV2tHD4l4Q+hbsnT6T1P8HaBORR+icFG+WA
         f08ece8Oc+P5fFYGfKWCFPBaMeLp1YQzq5Pz+p8n2LgYQoXjyCR9wuKrQSsEMuJ86q
         QCSnstP6V+/MBU4Vzo8O4jS/0tBUnhk01T+kEv/m0jnCPCOryoyje/+ibKJmNPrvqC
         vbQVG6pZlZ7+KPDoHvZeFCk0f8n8CTuHgownrHWqOFu9A/9fLacnW99yIPhrMBmfth
         I+16oOVQ0ZKiRhdlGrdeXtNgUXF0KBbCPvnqtNpmInSF1Y/l9O+BmzRKDzCLYgJaEx
         i6ysDJ3eCuzzw==
X-Nifty-SrcIP: [209.85.222.48]
Received: by mail-ua1-f48.google.com with SMTP id v24so13138359uap.13;
        Sat, 05 Jan 2019 17:03:50 -0800 (PST)
X-Gm-Message-State: AJcUukeZE9FVxYL/ja94qJX/L8KqhCQtuyoAC9N7mcfA8WUffekcXuY7
        wEtdfdLpr4jpW/sGycT4ACXmkoV8iHMOGE0xooA=
X-Google-Smtp-Source: ALg8bN48T0gzCeQD1LJ/OY1hqMf3V/o7nRyHo+OIFptrMFxtE+//WFesdsMj91UVnStJkRpIOlQZxQ8zK5VtzSk4L+U=
X-Received: by 2002:a9f:3193:: with SMTP id v19mr21467859uad.55.1546736628845;
 Sat, 05 Jan 2019 17:03:48 -0800 (PST)
MIME-Version: 1.0
References: <CAK7LNAQzEHv7Y69xFTPDEhyMP6JX4ghb96UMqMdxYyVyah6-VA@mail.gmail.com>
 <CAHk-=whg49nn5q_2QVMGN0u4rQFBmRKywtqJUSk+5=rBzTk1kg@mail.gmail.com>
 <20190105203906.GA22423@ravnborg.org> <CAHk-=wh0rrLKYOxW6hAVaQ8rFGno7Q=XKrd13mfLXyd__WnTPw@mail.gmail.com>
In-Reply-To: <CAHk-=wh0rrLKYOxW6hAVaQ8rFGno7Q=XKrd13mfLXyd__WnTPw@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Sun, 6 Jan 2019 10:03:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQjCdt1Ts7t=+92YRK_ThhLaE0Af5W-S9yEg1Br2DvmTA@mail.gmail.com>
Message-ID: <CAK7LNAQjCdt1Ts7t=+92YRK_ThhLaE0Af5W-S9yEg1Br2DvmTA@mail.gmail.com>
Subject: Re: [GIT PULL 1/4] Kbuild updates for v4.21
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,


On Sun, Jan 6, 2019 at 5:44 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Jan 5, 2019 at 12:39 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> >
> > Not exactly what you ask for - but we have make V=2
>
> Yeah, that's certainly more convenient than "make --debug".
>
> That said, I was more thinking of not any particular "oh, it's
> recompiling everything" situation (by then it's too late, obviously),
> but if somebody has been looking at tools for finding and maybe
> breaking some of our deeper include chains.
>
> I know it has come up before (the x86 people did the
> <linux/schedule.h> split some years ago) and then it was all manual.
> But I was kind of hoping that maybe some of the kbuild people had
> looked at this?


Sorry, I do not know more information than Sam provided.

I got rid of some unneeded header inclusions in the past,
but my work was also manual.



-- 
Best Regards
Masahiro Yamada
