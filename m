Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0C0C282DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 308DE20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 08:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbfBAIkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 03:40:47 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:41020 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726665AbfBAIkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 03:40:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id c16so4413232lfj.8;
        Fri, 01 Feb 2019 00:40:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=g8Nn8cm8MH4bDwP0jLK8AviReQWhxX4FZpgV/LsFZsY=;
        b=Rwu4uvtKCf7SPAlAZuDh8GlxoKM7f7qB3xhKxVeluulE635jScOwfu7SGuP7yBNYBK
         CaiCVobrIToO1PC6ih6/9158vGpLLN3noSTD7My8cruXaNJEe1MH8XU8IVzPhtoA51mi
         Qm/+LhqE+4dtfh+VxGxt9gLRpmPsCjdyaKeTPtjWSu6qNZgWaGRUTYWAgRpWlxcaJ2js
         bBSKKMN+5ZmHixtFMptv/1km/ZGtc2PJRY5qipfO7fcfJooXOd+nVZNq/2VxKke5pBAY
         hlsuMVUiXYsFhY8xznlpVT47wAofSk2AH4ybCrYDRmza3L7ywbRZUQHasUOeBW0n9jRt
         GdLQ==
X-Gm-Message-State: AJcUukfZGjxUimQMKdWyNMnHyFVplDbb0qGVPJzc21U4v9HmqVzkd7FD
        7x/MZTaV/USPNuYzg3yUBgI=
X-Google-Smtp-Source: ALg8bN6Nmz3lHJ3DhKu3nfxwFSM037ts91UOX9a13vuzSYgmR/ABG3bePWR9SNQOS/MbFSRajryeow==
X-Received: by 2002:a19:ced3:: with SMTP id e202mr31727905lfg.13.1549010444341;
        Fri, 01 Feb 2019 00:40:44 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id y23-v6sm1177586ljk.95.2019.02.01.00.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 00:40:43 -0800 (PST)
Date:   Fri, 1 Feb 2019 10:40:40 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        mazziesaccount@gmail.com, corbet@lwn.net, cw00.choi@samsung.com,
        krzk@kernel.org, b.zolnierkie@samsung.com, mturquette@baylibre.com,
        pombredanne@nexb.com, sre@kernel.org, vkoul@kernel.org,
        linux@roeck-us.net, pavel@ucw.cz, sjhuang@iluvatar.ai,
        andrew.smirnov@gmail.com, djkurtz@chromium.org,
        akshu.agrawal@amd.com, rafael.j.wysocki@intel.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 0/3] clk: clkdev add managed lookup registrations
Message-ID: <20190201084040.GE23791@localhost.localdomain>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
 <20190131132452.GD23791@localhost.localdomain>
 <20190131152147.tzxabhyhlyy2rwhy@e5254000004ec.dyn.armlinux.org.uk>
 <154896351763.169292.2557542540041822337@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154896351763.169292.2557542540041822337@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:38:37AM -0800, Stephen Boyd wrote:
> Quoting Russell King - ARM Linux admin (2019-01-31 07:21:47)
> > On Thu, Jan 31, 2019 at 03:24:52PM +0200, Matti Vaittinen wrote:
> > > Hello All,
> > > 
> > > On Fri, Dec 07, 2018 at 01:09:00PM +0200, Matti Vaittinen wrote:
> > > > Series adds managed clkdev lookup interfaces and cleans few drivers
> > > > 
> > > > Few clk drivers appear to be leaking clkdev lookup registrations at
> > > > driver remove. The patch series adds devm versions of lookup
> > > > registrations and cleans up few drivers. Driver clean-up patches have
> > > > not been tested as I lack the HW. All testing and comments if
> > > > driver/device removal is even possible for changed drivers is highly
> > > > appreciated. If removal is not possible I will gladly drop the patches
> > > > from series - although leaking lookups may serve as bad example for new
> > > > developers =)
> > > > 
> > > > Changed drivers are:
> > > > clk-max77686 and clk-st
> > > > 
> > > > Please note that the patch #2 requires this change to work correctly:
> > > > https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=clk-next&id=05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> > > 
> > > I guess the dependency mentioned abowe is already in (most) of the
> > > trees. (I can't say for sure as I don't know what is the correct tree
> > > for clkdev - is it linux-arm.git as Russel is maintaining clkdev?
> > 
> > Yes, I'm supposed to be maintaining clkdev, but I'm busy with other
> > stuff (such as reorganising my network, helping people with SFP issues,
> > I'm supposed to be replying to Arend over a brcmfmac issue that has been
> > on-going since Christmas which I haven't yet been able to doing the next
> > test...)
> > 
> > > If yes, then the commit 05502bf9eb7a7297f5fa6f1d17b169b3d5b53570
> > > "clk: of-provider: look at parent if registered device has no
> > > provider info" seems to be sitting in maser branch).
> > 
> > It's there because it's part of the mainline kernel and has been
> > since v5.0-rc1.  So, if you depend on that commit, basing off
> > v5.0-rc1 is probably sane, unless there's something else that
> > conflicts.
> > 
> 
> I can pick up the patches in the clk tree. Clk drivers will be the users
> so it's probably simplest to merge the clkdev patch in clk tree and then
> consumers can be updated at the same time in a patch stack on top of
> that.

This sounds good to me if it is Ok to Russel. Please just let me know if
you want me to rebase (to clk-next?) and resend the series.

> Otherwise, if I can get a stable branch/tag to pile the clk driver
> patches on I can apply them that way and then the clkdev patch can go
> via Russell.

I can for sure go with this approach as well if it has some advantages
to you. Again, please just let me know if I should resend series and if
I should use something else but clk-next as a base.

Br,
	Matti Vaittinen

-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~
