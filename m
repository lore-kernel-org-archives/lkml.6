Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7B9BC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7116E20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 08:25:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jk368l5Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7116E20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727509AbeKKSNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 13:13:00 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:33689 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 13:13:00 -0500
Received: by mail-vs1-f68.google.com with SMTP id p74so3453293vsc.0
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 00:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=VHcMal053iY1si/FR52u6YhGXz7e+lO/js4vmvP0hWE=;
        b=jk368l5Yv1IvALlHmcTi9DxOA1Wt265ShOLlw2HnASIzH37B3am3rsggZNRgYXSO02
         PaQpxcbYtXDeU1QQb4+dmBd6l2XYSeM3KwgLUn1BvyhXWUNslU+6yXFVCzKe06ZxJutw
         OGXp4SHatfHw3WHlTOmPAd+J7e2U2Fvev9usYiGjzb2FNlDVuRDsObsL5tT66QmSagrm
         km4YapzPzcazlhGyZcOyNU90+Syng041R+USDSKqA3PvjY3w7WR1zq60OiLdGBP5zVAM
         nTun0WN3YtLbsNo/CFP2CUpQ9tOwok0kru1eVX4ah8WTpXXuOBJEWqZXhj564QeDVemb
         SuyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=VHcMal053iY1si/FR52u6YhGXz7e+lO/js4vmvP0hWE=;
        b=AUNu87Anhwr1hSMgEZG4SSdxLfD9f0FGMrqWdcFUlTycmXAf1sdbAVsy3UAUbOz67O
         nQllKsSJanxkW8MOVK1hkYkepFRhWWHHhpHgiJlNAfb0gz/Zd6fr5S5POXUH5fHi/0gg
         HrvhW6V/0CwDYKMYQI0o82SLOFWFnGs2DrFuYKcxfFa0B7aoBdGqNqa9lFpoICanMHk3
         rHdQ1qSoBzz0HBJva/YKZOKbwu89QmsbEk1xtShH8dLe2/BQ/JFGe5gtqBdwdPn65C0X
         dlph/Jp89419jhmICP8v7g2rxBMqEC5D7OLLHItXab7HrXr6IJVi2qwG9LfdCK115LVC
         ntHA==
X-Gm-Message-State: AGRZ1gIE2T4MBwpnz2QbMDD5WqdJ5Eq/vIGaV8UDVDqdX4DYyng9ofHA
        0A2InmvtZ28YcxZOoBLywW51/5rhVvcFE2Tfut6xHw==
X-Google-Smtp-Source: AJdET5dCAqzZM5NeXVuSFDUY80eCk3LEZOqdqCvlXWjSb+3i0OgvMfyCw0bYMQoD6ZVI/lgoUZf1Q8GJ/k/BQAHnFEM=
X-Received: by 2002:a67:6cc1:: with SMTP id h184mr6439343vsc.149.1541924703893;
 Sun, 11 Nov 2018 00:25:03 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 11 Nov 2018 00:25:03
 -0800 (PST)
In-Reply-To: <20181111081725.GA30248@1wt.eu>
References: <CAKOZuesB4R=dCz4merWQN0FSCGrXmOgUUr4ienSbStBJguNv8g@mail.gmail.com>
 <bbc12da5-830e-99a7-95e3-d9da42947dc9@gmail.com> <20181111081725.GA30248@1wt.eu>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 11 Nov 2018 00:25:03 -0800
Message-ID: <CAKOZuesi79-4J8bXU2bTY4876DOtL0K4A_Sr=6XsDD8dESPQbw@mail.gmail.com>
Subject: Re: Official Linux system wrapper library?
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Joel Fernandes <joelaf@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Florian Weimer <fweimer@redhat.com>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 11, 2018 at 12:17 AM, Willy Tarreau <w@1wt.eu> wrote:
>
> On Sun, Nov 11, 2018 at 07:55:30AM +0100, Michael Kerrisk (man-pages) wrote:
> > [1] https://sourceware.org/
>
>
> Bah, after all, this
>
> wipes quite a bit of the shame I feel every time I do something to
>
> bypass it :-/
>
>
> The sad thing is that the energy wasted arguing in the bug above could
>
> have been better spent designing and implementing a generic solution
>
> to expose syscalls without depending on glibc's politics anymore.
>
>
> Willy
>
> bugzilla/show_bug.cgi?id=6399 is a
> >     longstanding example.
>
> This one was a sad read and shows that applications will continue to
> suffer from glibc's prehistorical view on operating systems

Yes. I'm really not sure what glibc's current policies are meant to
accomplish. They don't serve any useful purpose. There seems to be
this weird subtext that glibc has leverage to change OS design, and it
really doesn't. It's a misplaced idealism and ends up just hurting
everyone.

>
> Seeing comments suggesting an application should open
> /proc/$PID makes me really wonder if people actually want to use slow
> and insecure applications designed this way.

That's a separate point. Yes, gettid should have a wrapper, but *also*
we should have an FD-based interface to processes, because outside
specialized contexts (e.g., parent-child waiting), the traditional
Unix process API really is impossible to use safely. But that's a
separate ongoing discussion.
