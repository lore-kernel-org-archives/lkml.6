Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AFDC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F622084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 09:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfAXJ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 04:59:31 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40508 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbfAXJ7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 04:59:30 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so4065909edr.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k9uQ4+rEkuZNu7dPprKrGY4T+u4KkrZ5x02o1qzzpUw=;
        b=YIP0PdE5odWd3LdYbObrn44MBNCuVZKp3OkGI3Thl3dy3gZQ0wml4LLXp3l3bh1rIt
         ZeGUtmfk1N9eyflr7qJDznpKUa6lnknONUPkUNCwrvdil1M3XvR9hVLz6FsoCCNaRicb
         p2NrbqecjOx9rkSoPbVW9LJeKwCHhabSC6/CEdUJWI8ja/CC6OgrbYIlwHgNOKe1O+lt
         4TwnFELBn3mt98oI30lIf6OuXSELSX6VfRgfO0MTBZcfzf93j1d3+GcfC9vrQcNvyHgQ
         /70GPFiQfi4KrlL1FWqXKTc4s/SCGG9XgeHeugJ+wbHwoiYaxni05vTB3AFp9tWPhP+U
         TBmQ==
X-Gm-Message-State: AJcUuke40LKUS6ME2TOZSo+So12gyL1enlDHOdoJUoT0UAaXbD+ste4U
        gf/p9kh6ydQYra9e8usAkVaODGJoMKU=
X-Google-Smtp-Source: ALg8bN4mryF1g4Jcs45+VLAZ32vL21rQ/Fs7aVmBYtQ8GN6th3V/wKxfbAMvnue1GXcblPzvf4ydiA==
X-Received: by 2002:a50:8343:: with SMTP id 61mr6078031edh.154.1548323968855;
        Thu, 24 Jan 2019 01:59:28 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com. [209.85.128.41])
        by smtp.gmail.com with ESMTPSA id g21sm11183364edc.63.2019.01.24.01.59.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 01:59:28 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id y139so2387075wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 01:59:28 -0800 (PST)
X-Received: by 2002:a1c:494:: with SMTP id 142mr1906039wme.111.1548323967934;
 Thu, 24 Jan 2019 01:59:27 -0800 (PST)
MIME-Version: 1.0
References: <20190110062207.18787-1-wens@csie.org> <0f9b4bc0-6969-97d3-8ac6-63931ea6db92@linaro.org>
 <CAGb2v65RJ2iwTr1bxXxXAROLtg2a1KP2x36uXpjGs=r38NrM6g@mail.gmail.com> <c00394ec-4817-629d-2a92-e62a7f2d31ab@linaro.org>
In-Reply-To: <c00394ec-4817-629d-2a92-e62a7f2d31ab@linaro.org>
From:   Chen-Yu Tsai <wens@csie.org>
Date:   Thu, 24 Jan 2019 17:59:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v64iSQ-Ga1kCmbwUY1EHS5hSc2dnRJ6-LVOjsqkyaaPXkQ@mail.gmail.com>
Message-ID: <CAGb2v64iSQ-Ga1kCmbwUY1EHS5hSc2dnRJ6-LVOjsqkyaaPXkQ@mail.gmail.com>
Subject: linux-next not picking up latest clockevents/next
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 5:39 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 24/01/2019 09:56, Chen-Yu Tsai wrote:
> > On Thu, Jan 10, 2019 at 5:19 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 10/01/2019 07:22, Chen-Yu Tsai wrote:
> >>> If the clock tree is not fully populated when the timer-sun5i init code
> >>> is called, attempts to get the clock rate for the timer would fail and
> >>> return 0.
> >>>
> >>> Make the init code for both clock events and clocksource check the
> >>> returned clock rate and fail gracefully if the result is 0, instead of
> >>> causing a divide by 0 exception later on.
> >>>
> >>> Fixes: 4a59058f0b09 ("clocksource/drivers/sun5i: Refactor the current code")
> >>> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> >>> ---
> >>
> >> Applied thanks.
> >
> > I'm not seeing this in linux-next, nor the patch
> >
> >     arm64: arch_timer: Workaround for Allwinner A64 timer instability
> >
> > Any idea where these ended up?
>
> Yeah, I have a rough idea. They are now in linux-next via the
> clockevents/next branch.

Thanks, Daniel.

Stephen,

Looks like linux-next is not picking up the latest clockevents/next.

The merge log for linux-next-20190124 shows:

    Merging clockevents/clockevents/next (bd2bcaa565a2 Merge branch
'clockevents/4.21' of
http://git.linaro.org/people/daniel.lezcano/linux into timers/core)
    $ git merge clockevents/clockevents/next

The merged clockevents/next looks outdated compared to

    http://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=clockevents/next

Regards
ChenYu
