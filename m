Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBD2EC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B7720851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="heYEfpao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52B7720851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbeKTScD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:32:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35217 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbeKTScD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:32:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so827486ljb.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 00:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+U2xW/aiz6s/9RZ44gIa5D1ebtAulHh+ewF5Pk7byZE=;
        b=heYEfpao2uxycnUo9K74Iupc9rcdF0KJTzi9LJPVKqovTlLVMDBx9nDtZYHJLxw8zt
         WPLomH88bnldiCoBnZk8rvKoYz+4fBXkZBjCMvea/rdc834RKbKKUVMRvD4hgFIUWu8t
         1UssgMk9wsxSKdKydj/IJW8QfulcK1UOr8h/U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+U2xW/aiz6s/9RZ44gIa5D1ebtAulHh+ewF5Pk7byZE=;
        b=LLO6NNnHdcJ3cH2Hia1nXXTA6uu1rVR38zsSA64Rl0XeH4AyknS7a8D/blrvjlMlsw
         ouXjfImgfVDLSBGk86JMhXpBWKgRhcBbU7w9bheDAlKcqWh3hhWJzbNH3sgUw5aBPijZ
         MzlWoKKge9f/aCrOLo9Xj1YgYhuno2Osf6/Yrr22UXh5x0NeWtXEweUgsAFb/YkvQRNv
         laCgbrs/24S02oN5fU0y7Vg7rN75DQBuBYuWsREKNTO8NW2klNo8zAau5BGqV72b0ngm
         bDhwOFA2/gJ8UW0y1lpIzhxwF4jCQK05GFUgFp+zJ4wwrGPLJczUjn7ii0Y6n7txJYeX
         wB9w==
X-Gm-Message-State: AA+aEWYq34POq1aO25N5Rpz39EvEe46qHc89bw0urUAh/joXrGZuiym/
        CO7bbbRKrSG1hY1Dm4l3A4RmmawVIRtJdBV0rbMvWD86WWg=
X-Google-Smtp-Source: AFSGD/VBi21rLCXu+yWO5V/TCTfpzsMwung41wxjKAbIMfQrhGo+lJyz8XY0uDXKtwPvwUOAXuJzgAXMKrMThRf5/tU=
X-Received: by 2002:a2e:9e03:: with SMTP id e3-v6mr599217ljk.4.1542701053715;
 Tue, 20 Nov 2018 00:04:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au> <8454b0ecaf5be60ab602e795eac4bed69f0102d0.1542589838.git.fthain@telegraphics.com.au>
In-Reply-To: <8454b0ecaf5be60ab602e795eac4bed69f0102d0.1542589838.git.fthain@telegraphics.com.au>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 09:04:01 +0100
Message-ID: <CACRpkdbvNeZRup0R5yzedvChnpLHckjDmNYFjP_QW+JH8DGY+A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 06/14] m68k: amiga: Convert to clocksource API
To:     fthain@telegraphics.com.au
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, schwab@linux-m68k.org,
        Arnd Bergmann <arnd@arndb.de>, schivers@csc.com.au,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 19, 2018 at 2:22 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> Add a platform clocksource by adapting the existing arch_gettimeoffset
> implementation.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changed since v1:
>  - Moved clk_total access to within the irq lock.

Came to think of it, Geert can probably answer to the use cases
for the CIAs in Linux: the Amiga CIA has two counters.

It would make sense to use one as a free-runing clocksource and
the other one as clock event. Then Linux is extremely happy
without any complex workarounds trying to use just one timer
for both jobs.

Is there some specific reason why we can't use both counters
like this, except for legacy? (I am thinking it would be an improvement
on top of Finn's series once they go in.)

Yours,
Linus Walleij
