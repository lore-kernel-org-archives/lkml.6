Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BF5C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F5E20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 09:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LkuIjJYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F5E20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbeKTU1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 15:27:36 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:46871 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726107AbeKTU1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 15:27:35 -0500
Received: by mail-lf1-f66.google.com with SMTP id f23so867919lfc.13
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 01:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l1aXOe8O8JAT/r3b/fcHFbIJbYGE4HWaiWXOnwYcHGA=;
        b=LkuIjJYP46v+GXFQHfw8PK7oJfxfCLmAgq4qgkYjAKdAIXME+5vadsny2GK0rRFrDW
         E4lb5GUOl/B/ChDwelUhZ82OLiqb6IYN04o1jh1sZh7RK14Nuu84RSuMCPCdcXos86QC
         thFpF9+ML5pzLEfx1t3sl+Oxba7I29mj8lpnw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l1aXOe8O8JAT/r3b/fcHFbIJbYGE4HWaiWXOnwYcHGA=;
        b=AgCC6H3Be7AXKKVlVfQR52w3hc0VnP6Rb91Q3PIWWz8qUN6ntJFDBHdIr0P6uZSNNN
         iblB23eQmj3z1uAu/nYtgMMIU9/FHbkOJiHQVRDGYKukJtZB+cgb2+2rk9FjBdy5wKpp
         hGOgDrMi+U24gzY9HvWVqT9Oy5HmQj9si3CM2NryqLxOSjjAgqvTYx9Ta+hyfDR3QqXi
         misj9VdFBTOJ6ZPPPRExz+cz8Wy03cWka0T0/UK6gtxUZPWjJwSgkvkpk4qwoyphDTMi
         D4ah48kl90PphO4X96w3aBiS9u7wT+va7GWKqithXOnXJmkDKwFhSLD9unAQbW9DWkDi
         gv2w==
X-Gm-Message-State: AGRZ1gIubqCgvPOS/JLwzlbGUSWuBnfa5SQAaIN2vsUAYH6HLkwR8X5f
        cDFPB/GZXyXPSIJhiozPZW4e59v3yWcxFxd+qkuA8g==
X-Google-Smtp-Source: AJdET5ce5ZhwAEAbf4zyA10wso4u+D698Kk0hkLvt3/X17wnNsSiSFxir8KydF/D3FcTs5leDp2dqOHOvilWXXXW4vs=
X-Received: by 2002:a19:c801:: with SMTP id y1mr722147lff.53.1542707957289;
 Tue, 20 Nov 2018 01:59:17 -0800 (PST)
MIME-Version: 1.0
References: <cover.1542589838.git.fthain@telegraphics.com.au>
 <c235d0b21a648d329668f1ab436161c09d96e875.1542589838.git.fthain@telegraphics.com.au>
 <CACRpkdZdJDYaOi1HeMiS2hkjOf0gjQphGXy-Ka+m=1LbDCXPfA@mail.gmail.com> <alpine.LNX.2.21.1811201925020.258@nippy.intranet>
In-Reply-To: <alpine.LNX.2.21.1811201925020.258@nippy.intranet>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 20 Nov 2018 10:59:05 +0100
Message-ID: <CACRpkdYOyU_43ExoB0bm2MB+kP4nAPik27Mw4oMDiUTZeODMgw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 10/14] m68k: mac: Convert to clocksource API
To:     fthain@telegraphics.com.au
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, funaho@jurai.org,
        schwab@linux-m68k.org, Arnd Bergmann <arnd@arndb.de>,
        schivers@csc.com.au, Thomas Gleixner <tglx@linutronix.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        schmitzmic@gmail.com, John Stultz <john.stultz@linaro.org>,
        linux-m68k@lists.linux-m68k.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 10:00 AM Finn Thain <fthain@telegraphics.com.au> wrote:

> If you use one timer as a clock event device and the other as a
> clocksource, there are no timers left to run the existing
> timer_interrupt() handler. So this arrangement would require
> GENERIC_CLOCKEVENTS=y, right?

I think so, yes.

> Then, wouldn't all relevant platforms have to support
> GENERIC_CLOCKEVENTS=y, if a single binary was to support all of those
> platforms?

Good point. I wonder of there is a path forward where we
could have peaceful GENERIC_CLOCKEVENTS and
!GENERIC_CLOCKEVENTS co-existence.

Yours,
Linus Walleij
