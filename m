Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 980E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14F782081D
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 02:55:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="RaxJyx+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14F782081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727567AbeKIMea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 07:34:30 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:25838 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbeKIMea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 07:34:30 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id wA92tl7w014637
        for <linux-kernel@vger.kernel.org>; Fri, 9 Nov 2018 11:55:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com wA92tl7w014637
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1541732148;
        bh=dBnlxv4harASQLYXrbyfH8uI/xrMQOx3T9+9ggt3B0g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RaxJyx+CZOigvZZhtc1pO+ZoaXi7KCNPY2TIXDARTle6h04iyKsYazUMy00OiK+ee
         5/gIP/gRqKut+/vT+2IwpHvhFrTm2CFU1gwXU6/bdV2UNUzC9ov8pRF1YpogaPYpc0
         TnfiarHkMsGV4DeQ3xNPz7lNCanLbH+9IEjISBvlE6OzTEBd0vPzvXL1o8fK/U9ljp
         Qv8/lXSueUBZpd36undLKB5IvXWR/5EwL+tNDc1u7HbzEV827Wvq03J5HqFU+tsF6D
         +0na85x1+05rWsY/FGQGQvEDQ6+AMJqvrKsbO4MfcFoBX9GQk1ranjqGE81vPigtde
         HiAaIzofYJe7A==
X-Nifty-SrcIP: [209.85.217.54]
Received: by mail-vs1-f54.google.com with SMTP id g68so216751vsd.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Nov 2018 18:55:48 -0800 (PST)
X-Gm-Message-State: AGRZ1gKcCMnMQTCJKqTM+B1ikQdPF/R+6Dp+DtiOxvA4ANCvNnlZp4mk
        fr24Z6ng4NZvpAXVWpTkvSTI/SBLvRfdjMEJU+c=
X-Google-Smtp-Source: AJdET5e5fVMzq/IQg5UzSzfnXDtzQBkHieV7Y3Nnd1P6a1pJ+ZXeVb/97PL6VJLbC3tN0m6zlp9YDvXLNeJNGWGHqq0=
X-Received: by 2002:a67:f1d6:: with SMTP id v22mr3054083vsm.181.1541732146834;
 Thu, 08 Nov 2018 18:55:46 -0800 (PST)
MIME-Version: 1.0
References: <1541527838-4585-1-git-send-email-linux@roeck-us.net>
 <20181106.192305.406697677@genki.is> <20181107022156.GA254567@google.com>
 <alpine.DEB.2.21.999.1811061845161.5308@trent.utfs.org> <CA+ASDXPMMXCBN6PU8qzRm579sC9VBdwnxZdZwRdPY1cBUP8oGQ@mail.gmail.com>
 <20181107184435.GA168339@google.com> <20181107.204358.257636196@genki.is> <20181107205514.GB12273@roeck-us.net>
In-Reply-To: <20181107205514.GB12273@roeck-us.net>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Fri, 9 Nov 2018 11:55:10 +0900
X-Gmail-Original-Message-ID: <CAK7LNATr-PgQn8OmPX835zS_mJdMnAw4odRX-+UdWJimgs++Rw@mail.gmail.com>
Message-ID: <CAK7LNATr-PgQn8OmPX835zS_mJdMnAw4odRX-+UdWJimgs++Rw@mail.gmail.com>
Subject: Re: [PATCH] Revert "scripts/setlocalversion: git: Make -dirty check
 more robust"
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Genki Sky <sky@genki.is>, Brian Norris <briannorris@chromium.org>,
        Christian Kujau <lists@nerdbynature.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 8, 2018 at 5:58 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Nov 07, 2018 at 12:43:58PM -0800, Genki Sky wrote:
> > On Wed, 7 Nov 2018 10:44:37 -0800, Brian Norris <briannorris@chromium.org> wrote:
> > > On Tue, Nov 06, 2018 at 08:00:36PM -0800, Brian Norris wrote:
> > > > On a different tangent: how about the --no-optional-locks (see
> > > > git(1))? Will this get you your "up-to-date" result without writing to
> > > > the .git directory? I've only read the documentation, but not tested
> > > > it.
> >
> > This option definitely seems to be what we want, good find.
> >
> > > Unfortunately, --no-optional-locks is new as of git 2.14. Dunno how new
> > > of a git we expect people to use.
> >
> > Hmm, I'm not sure who can speak to this.
> >
> > Though if it's too recent, then based on earlier discussion, it sounds
> > like something like this (hack) might work best:
> >
> >   [ -w .git ] &&
> >           touch .git/some-file-here 2>/dev/null &&
> >           git update-index --refresh --unmerged >/dev/null
> >   if git diff-index --name-only HEAD | ...
>
> I do not think it is a good idea to create a random file in the .git directory
> under any circumstance, and much less so if an output directory was specified,
> no matter if the path is read-only or not. I also still think that it is a
> bad idea to touch the source tree if an output directory was specified.
> It defeats the purpose of specifying an output directory.


I agree.
We should avoid any write attempt to the source tree for any reason.



> Ubuntu 16.04 ships with git version 2.7.4.
>
> Guenter



-- 
Best Regards
Masahiro Yamada
