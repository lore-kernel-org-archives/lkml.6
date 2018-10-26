Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A416BC6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:43:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DEE520665
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 15:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DEE520665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeJ0AVV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 20:21:21 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:34555 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726113AbeJ0AVV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 20:21:21 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id 5D8703DADE6;
        Fri, 26 Oct 2018 17:43:41 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     Martin Steigerwald <martin@lichtvoll.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [REGRESSION 4.19-rc2] sometimes hangs with black screen when resuming from suspend or hibernation (was: Re: Linux 4.19-rc2)
Date:   Fri, 26 Oct 2018 17:43:40 +0200
Message-ID: <4455424.Ie6G2e0T9V@merkaba>
In-Reply-To: <20222492.cP35YpYkb6@merkaba>
References: <CA+55aFyG0GbDfoghEhAmKBPcZCiPu6CCpPRz9GwjCzLuP_Vv5Q@mail.gmail.com> <20222492.cP35YpYkb6@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This regression is gone with 4.19-rc8.

Thanks,
Martin

Martin Steigerwald - 11.09.18, 09:53:
[…]
> Linus Torvalds - 02.09.18, 23:45:
> > As usual, the rc2 release is pretty small. People are taking a
> 
> With 4.19-rc2 this ThinkPad T520 with i5 Sandybrdige sometimes hangs
> with black screen when resuming from suspend or hibernation.  With
> 4.18.1 it did not. Of course there have been userspace related updates
> that could be related.
> 
> I currently have no time to dig into this and on this production
> laptop I generally do not do bisects between major kernel releases.
> So currently I only answer questions that do not require much time to
> answer.
> 
> For now I switched back to 4.18. If that is stable – and thus likely
> no userspace component is related –, I go with 4.19-rc3 or whatever
> is most recent version to see if the issue has been fixed already.
> 
> % inxi -z -b -G
> System:    Host: […] Kernel: 4.18.1-tp520-btrfstrim x86_64 bits: 64
> Desktop: KDE Plasma 5.13.5
>            Distro: Debian GNU/Linux buster/sid
> Machine:   Type: Laptop System: LENOVO product: 42433WG v: ThinkPad
> T520 serial: <filter>
>            Mobo: LENOVO model: 42433WG serial: <filter> UEFI [Legacy]:
> LENOVO v: 8AET69WW (1.49 )
>            date: 06/14/2018
> […]
> CPU:       Dual Core: Intel Core i5-2520M type: MT MCP speed: 2990 MHz
> min/max: 800/3200 MHz
> Graphics:  Device-1: Intel 2nd Generation Core Processor Family
> Integrated Graphics driver: i915 v: kernel
>            Display: x11 server: X.Org 1.20.1 driver: modesetting
> resolution: 1920x1080~60Hz
>            OpenGL: renderer: Mesa DRI Intel Sandybridge Mobile v: 3.3
> Mesa 18.1.7
> […]
> Info:      Processes: 322 Uptime: 16m Memory: 15.45 GiB used: 3.12 GiB
> (20.2%) Shell: zsh inxi: 3.0.22
> 
> Thanks,
> Martin
> 
> > breather after the merge window, and it takes a bit of time for bug
> > reports to start coming in and get identified.  Plus people were
> > probably still on vacation (particularly Europe), and some people
> > were at Open Source Summit NA last week too. Having a calm week was
> > good.
> > 
> > Regardless of the reason, it's pretty quiet/ The bulk of it is
> > drivers (network and gpu stand out), with the rest being a random
> > collection all over (arch/x86 and generic networking stands out,
> > but there's misc stuff all over).
> > 
> > Go out and test.
> > 
> >              Linus
> > 
> > ---
[…]
-- 
Martin


