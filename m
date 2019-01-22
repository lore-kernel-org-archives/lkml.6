Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7997EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5197A20879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 13:44:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728634AbfAVNoX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 08:44:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35011 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728439AbfAVNoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 08:44:23 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so14247676qka.2;
        Tue, 22 Jan 2019 05:44:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UuEXWhlhqX926SR0M3TZz6vQubLniE2vzFF0sfzqh8s=;
        b=Oqb1pud+xWTv8wurHovZ0ec6hWh3VI+BaAj7XlowB/YswQ8uIjPp6s1sCUodQW5Os4
         AWp1NEtWB7VRAf/5qV3zHIocZ3nMYBOrB4TvugASDnw2lxPJfjjpIVgBbQPozZJeFTBR
         iMy8yQkturG0DH77ntZsQl356rTmMiF/NoZSODTVvEOCKeodxxTDt2ZmOrFPTH8gexFS
         ztF1Q+rexE88Frsmy3LxsuSSs3cynz7H10Z6z7qpWndP81FiVydX/xIn3aYsWncMC5BM
         hgPyoduC6yQr3vuaB4QFB34g1xBmBgXAZgZLIbdVyg4rDAXR1bZs863mTKp7rqflbIcj
         aubQ==
X-Gm-Message-State: AJcUukfJDAQaQZihc3kpp44BRA36HL9rcD2Jp69M5U6Xm3nQumc9bM6C
        86iGkxqsLQOZtzYBYBM8T4pdONEqy2A/I22ReXOfg7C0
X-Google-Smtp-Source: ALg8bN5IDUy8z9QDGNXJ7vrwZpFf1hBaT5fW3pDaPSInJ/0PHjITn91loHis1GoqO6uTryFfYzGd6vNDP9wi+jmu0jM=
X-Received: by 2002:a37:324a:: with SMTP id y71mr28516365qky.291.1548164661704;
 Tue, 22 Jan 2019 05:44:21 -0800 (PST)
MIME-Version: 1.0
References: <20190121202328.rgrv54lybilsvitu@brauner.io> <da262bd9-1de0-eabb-ee44-e0ee152d15bb@kernel.dk>
 <20190121224811.gbvg22vg4kgg4kbs@brauner.io> <CAK8P3a0ej9NcJM8wXNPbcGUyOUZYX+VLoDFdbenW3s3114oQZw@mail.gmail.com>
 <20190122093146.kmckcgdbvo2e7v3c@brauner.io> <20190122103009.vu2a67kviqhcb3cn@brauner.io>
 <CAK8P3a0EW6ZSMoo6FsRQ=XvyhJe50SR7YtpCtuHcPr=JO3fCtA@mail.gmail.com>
 <20190122105747.6gxvghn7n5dxa65w@brauner.io> <CAK8P3a0HJX6+1vks=ZCqNymLwWFS+Wt5PPuYnLedpMo=aVSwKA@mail.gmail.com>
 <20190122114656.joasjhlpwo3vy7hg@brauner.io> <20190122122419.b7lmm4j25w5cbmcx@brauner.io>
In-Reply-To: <20190122122419.b7lmm4j25w5cbmcx@brauner.io>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 22 Jan 2019 14:44:04 +0100
Message-ID: <CAK8P3a0pzdGHO_CNt26rx0wn38YJrpux9Xtz_dvZWkCw6gDj1w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the pidfd tree with the y2038 tree
To:     Christian Brauner <christian@brauner.io>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 1:24 PM Christian Brauner <christian@brauner.io> wrote:
> On Tue, Jan 22, 2019 at 12:46:56PM +0100, Christian Brauner wrote:
> > On Tue, Jan 22, 2019 at 12:42:44PM +0100, Arnd Bergmann wrote:
> > >
> > > You need to change __NR_syscalls to 425 as well. This will
> > > clearly create a conflict, but then the resolution will be to pick
> > > the correct (a.k.a. highest) number, rather than remembering
> > > to update it manually.
> >
> > Hm, ok. Wasn't sure if that would confuse people.
> >
> > Ok, when I sent my PR I will make a note in the PR that this branch is
> > aligned to create only minimal conflicts with your y2038 branch. The
> > patch carries your ack already so this should be good.

My point was just that __NR_syscalls has to be one more than the highest
syscall number, otherwise we get a build failure on architectures that
create an array of __NR_syscalls entries.

> Arnd, in case you care to take a look
> https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next

Looks good to me.

      Arnd
