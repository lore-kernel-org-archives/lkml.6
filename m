Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B850C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5764E2080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 06:41:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5764E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726752AbeJ3PeI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 11:34:08 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42379 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726154AbeJ3PeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 11:34:07 -0400
Received: by mail-oi1-f193.google.com with SMTP id h23-v6so9419489oih.9
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 23:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=f2k/yfiwRh0oquoDWFb2ghnZxfqu7I7KDftKKhXWutw=;
        b=UDvgzG74xPZpUbm9UyohiKgAf6jCM7f/muG397RekNsx1RQigHKcAvguznFXJj1ZRf
         4jPBVnSHTvMeDxmiW+XGQPNMgCFULieP/NrxpWH1wyhSimw/VBswPf3f7Zrn2ABqx8Wj
         wHdJfwAqpfIAdYuqgRpl3auIWfbbnauR1xGqnSF9lLDQmMc04pB71pwbgsZsvCsYatnK
         HMpXtuzlcUuZuLarBF/h9vboA5xvBzwBVHprZCsGXGFT9m2ckUH99Qg7l/UwtCfN8wBV
         7E5ahb1u6ZAFNDCSaT1slvn8LsV17uNI/KJatyyL4xOdM6Yb3scDgUrLRwNiB41p3SbR
         O/eA==
X-Gm-Message-State: AGRZ1gLfIEa8ukUROXUBLCPcIjlWmPHdo0aDzteVPBAfhCuhILfuAuOJ
        uRtUsQzu5iH/2YSdfX8VXKGSyANpkoSakvzhwak=
X-Google-Smtp-Source: AJdET5ei9dIGqsslx/A5s+p/KHyyPzoGHwAp8Alq8xo6fcSPSwGws0UlXBNLq6+JCXYWgMa11zQNW3ubMR/XSfHQ9M8=
X-Received: by 2002:aca:e24f:: with SMTP id z76-v6mr10819150oig.95.1540881714502;
 Mon, 29 Oct 2018 23:41:54 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com>
 <20222492.cP35YpYkb6@merkaba> <4455424.Ie6G2e0T9V@merkaba>
In-Reply-To: <4455424.Ie6G2e0T9V@merkaba>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 30 Oct 2018 07:41:42 +0100
Message-ID: <CAJZ5v0h60mhj-rjVkOo=RH5UyQpF-v8Qdj0NCn3V1ao4vaXPYQ@mail.gmail.com>
Subject: Re: [REGRESSION 4.19-rc2] sometimes hangs with black screen when
 resuming from suspend or hibernation (was: Re: Linux 4.19-rc2)
To:     martin@lichtvoll.de
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 5:49 PM Martin Steigerwald <martin@lichtvoll.de> wrote:
>
> This regression is gone with 4.19-rc8.

Thanks for the update!


> Martin Steigerwald - 11.09.18, 09:53:
> […]
> > Linus Torvalds - 02.09.18, 23:45:
> > > As usual, the rc2 release is pretty small. People are taking a
> >
> > With 4.19-rc2 this ThinkPad T520 with i5 Sandybrdige sometimes hangs
> > with black screen when resuming from suspend or hibernation.  With
> > 4.18.1 it did not. Of course there have been userspace related updates
> > that could be related.
> >
> > I currently have no time to dig into this and on this production
> > laptop I generally do not do bisects between major kernel releases.
> > So currently I only answer questions that do not require much time to
> > answer.
> >
> > For now I switched back to 4.18. If that is stable – and thus likely
> > no userspace component is related –, I go with 4.19-rc3 or whatever
> > is most recent version to see if the issue has been fixed already.
> >
> > % inxi -z -b -G
> > System:    Host: […] Kernel: 4.18.1-tp520-btrfstrim x86_64 bits: 64
> > Desktop: KDE Plasma 5.13.5
> >            Distro: Debian GNU/Linux buster/sid
> > Machine:   Type: Laptop System: LENOVO product: 42433WG v: ThinkPad
> > T520 serial: <filter>
> >            Mobo: LENOVO model: 42433WG serial: <filter> UEFI [Legacy]:
> > LENOVO v: 8AET69WW (1.49 )
> >            date: 06/14/2018
> > […]
> > CPU:       Dual Core: Intel Core i5-2520M type: MT MCP speed: 2990 MHz
> > min/max: 800/3200 MHz
> > Graphics:  Device-1: Intel 2nd Generation Core Processor Family
> > Integrated Graphics driver: i915 v: kernel
> >            Display: x11 server: X.Org 1.20.1 driver: modesetting
> > resolution: 1920x1080~60Hz
> >            OpenGL: renderer: Mesa DRI Intel Sandybridge Mobile v: 3.3
> > Mesa 18.1.7
> > […]
> > Info:      Processes: 322 Uptime: 16m Memory: 15.45 GiB used: 3.12 GiB
> > (20.2%) Shell: zsh inxi: 3.0.22
> >
> > Thanks,
> > Martin
> >
> > > breather after the merge window, and it takes a bit of time for bug
> > > reports to start coming in and get identified.  Plus people were
> > > probably still on vacation (particularly Europe), and some people
> > > were at Open Source Summit NA last week too. Having a calm week was
> > > good.
> > >
> > > Regardless of the reason, it's pretty quiet/ The bulk of it is
> > > drivers (network and gpu stand out), with the rest being a random
> > > collection all over (arch/x86 and generic networking stands out,
> > > but there's misc stuff all over).
> > >
> > > Go out and test.
> > >
> > >              Linus
> > >
> > > ---
> […]
> --
> Martin
>
>
