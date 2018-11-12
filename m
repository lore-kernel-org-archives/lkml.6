Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18497C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9958216FD
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 06:13:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2ciTpBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9958216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731656AbeKLQFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 11:05:15 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39007 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731284AbeKLQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 11:05:15 -0500
Received: by mail-wr1-f68.google.com with SMTP id b13so7883872wrx.6;
        Sun, 11 Nov 2018 22:13:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NBzeJlNt+4+zAhCw7vpM9sZu7A4HeMp6+OxHXTpIUu4=;
        b=e2ciTpBsL0miE5pVvqgsRMF5cBI1h33jvFidBwg+c6JF9jdY3c+QgnoiYijjI+7u3i
         WJbbFuIOwF5XZaJNlTsCLFhp2iNtQRYPRY1tg1DJ2fLao8k2x8E+052zV8WKWE1Wo20m
         yoJtNJ/Uz9d1OAXyxv14AtSpbb6BJKoeeGfz/L9kEsnWbd6Azm0kckNg+T9dkR3tTcTd
         0+HLzCsEJ4xtG7/UixHHjwlM3JoxSIkk9lImuJOS1RTjvyZ/3ysxHl/iQhS7lcjHhTTb
         e/W9hYZ/tjHHxTrUELb1SCrC95VqcVBv/movr7gDIRqqiaJzuU9DtQ7OVzvb5UY/rKSj
         Ns1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NBzeJlNt+4+zAhCw7vpM9sZu7A4HeMp6+OxHXTpIUu4=;
        b=AUQmqSuNlC4u1JascpDd7oiEVn3hXcC36Kd4r9tjmE8Tp8xOjA+orgdijJHdDwkPNt
         QRFhWMDPhPDBQ9FfU0q3d7OtpPftDjQazrOZMZCP2UJDhydYizi2YDDb/aT4wozpZxdt
         88AfhYQHQmaAyIB6944SRqLhdKJca9k3I5EfMelA2owvvDI+x5AaJxBLVhPGwnRkHSSm
         NF3lcTHo7r1HHuPn+8RTgwiDrDI/jQm/w9BL7sD7leWP9QL+dppR/jJa6cIOu7NwlGt6
         DD4KVSVxRh6m7tyLQJNKgx+pYlp/mgEhJwQaqfWrMfLP1nEW6vO3kWXAtSY4iJr8tdCA
         GYVQ==
X-Gm-Message-State: AGRZ1gJuHqSHdh1v0OhqQeaFgvh3gJXkWgdGhLAOSqW58+fO2E18LeW3
        hz1158jOzFoR99BWeqUSpiXq/G8e
X-Google-Smtp-Source: AJdET5e7F+kunYgppJdkan6dNMvZiGQISEuj+mQxiGZRMUyOnccw0OswCQGmnqgaTeyTFtIO9o4QeQ==
X-Received: by 2002:adf:a599:: with SMTP id g25-v6mr16982708wrc.188.1542003206762;
        Sun, 11 Nov 2018 22:13:26 -0800 (PST)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id 64-v6sm6741180wml.22.2018.11.11.22.13.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Nov 2018 22:13:26 -0800 (PST)
Date:   Mon, 12 Nov 2018 07:13:24 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Olof Johansson <olof@lixom.net>
Cc:     Tony Lindgren <tony@atomide.com>, guillaume.tucker@collabora.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
Subject: Re: [GIT PULL] ARM: SoC fixes
Message-ID: <20181112061324.GA28680@Red>
References: <20181107171023.zoo6qox5eewy3pmk@localhost>
 <CAHk-=whF7kBo49-BFTUc-by+HB_0qNw_=+d24TydO2mYwwsWMQ@mail.gmail.com>
 <CAOesGMg3uHJ7YB95skjcVK39kudAGGjKo6909d--LDZmqeE1HA@mail.gmail.com>
 <20181108154926.GI56134@atomide.com>
 <CAOesGMje+-R4Qbtgtj2AvNK+=Q3Rqbo=n8Q2DV4SG9wOv3Kj_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMje+-R4Qbtgtj2AvNK+=Q3Rqbo=n8Q2DV4SG9wOv3Kj_w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 10, 2018 at 10:09:19AM -0800, Olof Johansson wrote:
> On Thu, Nov 8, 2018 at 7:49 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > * Olof Johansson <olof@lixom.net> [181107 09:28]:
> > > On Wed, Nov 7, 2018 at 9:17 AM Linus Torvalds
> > > <torvalds@linux-foundation.org> wrote:
> > > >
> > > > On Wed, Nov 7, 2018 at 9:10 AM Olof Johansson <olof@lixom.net> wrote:
> > > > >
> > > > > ARM: SoC fixes
> > > >
> > > > Pulled.
> > > >
> > > > > I was a bit too trigger happy to enable PREEMPT on multi_v7_defconfig,
> > > > > and it ended up regressing at least BeagleBone XM boards.
> > > >
> > > > Odd. Did it hit some "may_sleep()" test in a driver that is hidden by
> > > > preempt being off? Otherwise I don't see how/why preempt should fail
> > > > in a board-specific manner..
> > >
> > > The board hangs early during boot and the usual way of collecting
> > > early console doesn't seem to work when attempted (I haven't tried
> > > personally).
> > >
> > > It's one of the major non-SMP platforms covered by tests. I'd be
> > > surprised if it turns out to be truly _board_ specific (and rather
> > > specific to OMAP3), but we don't have enough data yet. Chances are it
> > > either shuffles some timing around or indeed hits a may_sleep() test
> > > somewhere.
> > >
> > > (I just realized I might have missed to attribute Guillaume in the
> > > revert patch. Sorry about that).
> >
> > Looks like we're missing the stdout-path for earlycon, maybe try
> > with the following patch? I can't find my Beagleboard-xm right now,
> > time to clean-up a bit I guess.
> >
> > At least omap3-evm, logicpd-torpedo and n900 all boot with PREEMPT.
> 
> To follow up on this, it turned out to be an issue where the kernel
> outgrew the location it was loaded to, and overwrite the device tree
> on decompression. So, not a code issue.
> 
> It's a known fragile aspect on some of the u-boot setups, and
> something I've been hit by myself on my farm a few times.
> 
> Still, for now we'll keep PREEMPT off until next merge window.
> 

Hello

Note that CONFIG_PREEMPT cause some errors also on sun8i-a83t-bananapi-m3
Already reported https://lkml.org/lkml/2017/12/29/139

Regards
