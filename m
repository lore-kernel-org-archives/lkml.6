Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC4DBC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D94520671
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="Gxr9Wi3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D94520671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amarulasolutions.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbeGYVrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:47:16 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33164 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730423AbeGYVrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:47:16 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so8616436wrp.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jul 2018 13:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=phSUQFuBbdUi8hjSvRfqL4RjwjPOnV/3VqakYKt6mNQ=;
        b=Gxr9Wi3+ypZGUs4MInzaN1CY0FhtXkETpVkUPQoLvtpa+LWbioDKr208L1WuSEcvB9
         MZ9+Lhuf1+2Fop8wj/8PYqS12gPx+OACU3wE8T5v71VhMoPdXd52KFAxQ/m+egMAw1uv
         mg7XqoeI5/8x8Xy9vKA9Ctz+lbe92WOU22hn0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=phSUQFuBbdUi8hjSvRfqL4RjwjPOnV/3VqakYKt6mNQ=;
        b=pAsBDjt5gwXmiB0N0OPVxx4g6K+MXp/H+5qA86T+ImkA5bt6tYYmgHw0s+i9ylg1GU
         AZOeO8glwSEcgY2MLrttNrYKNg1UTFD3TCyIglPjMjspTKp7kTAgScGkRrd+Zm0lv+Kv
         +mOIR080v/B5hqMPJ4Kei+F+pNnM8ke/Ffu5/0SGQhiohMw0sP1jEYcP6366nGwYRgd1
         rFRUCAGYIW6vNkZNtnWkKYIJn086VAxPNX11ARjJVVb3b9RYNKO4QhQXCnSYsz7cJA9T
         7hn9cRo/tndanCaqiQ2F5c1j3tfbn7bhFPb84aAkx7pGeE1ogBF3+lbBB8vu9BwzyWXz
         TE0A==
X-Gm-Message-State: AOUpUlHp/2EWGhuDHBo16Sed+dF4X+IwC/XRQpRpNEDgGehOhbfzFem6
        qel2Iz11YvZqcdOHWyyx8K7r2op1muiz8dirCpjl01IG
X-Google-Smtp-Source: AAOMgpfDGxuzcP5Pm6UBzySWrhLpfTgywXnmr2ZccNIfTIhB6ivCHzXCcQSmKitCep4mxjOa9Lhil1fksPZCRDBvI0Y=
X-Received: by 2002:adf:f188:: with SMTP id h8-v6mr16463714wro.214.1532550836023;
 Wed, 25 Jul 2018 13:33:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:93a7:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 13:33:55
 -0700 (PDT)
In-Reply-To: <20180725200205.GA29594@amd>
References: <20180725200205.GA29594@amd>
From:   Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Date:   Wed, 25 Jul 2018 22:33:55 +0200
Message-ID: <CAOf5uwkyPoDT8TZe9V24p+nQMiee9XfD=943xwx0ThGi9_cPng@mail.gmail.com>
Subject: Re: Droid 4: suspend to RAM?
To:     Pavel Machek <pavel@ucw.cz>
Cc:     kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Sebastian Reichel <sre@kernel.org>, nekit1000@gmail.com,
        mpartap@gmx.net, Merlijn Wajer <merlijn@wizzup.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel

On Wed, Jul 25, 2018 at 10:02 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
> I have two big problems with droid 4. #1 is that it lost 2 SMS.. and I
> have no idea why. Second is power consumption -- it seems to be rather

Depend how do you set the SMS buffering using CNMI if I remember. Modem
has 1024bytes of memory most of the time that can buffer more then 1 sms.
Modem rise a irq when they receive a call or sms, or you an use the serial but
omap family can loose the first char coming from the serial so you can lost the
sms because parsing fail

> high even before modem (and thus USB) is enabled.
>
> Interestingly, CyanogenMod and Jolla seem to have higher power
> consumption than stock operating system.
>
> (My Linux can survive for 10 hours, stock system could survive for 4
> days if I'm not mistaken).
>
> I thought I would experiment with suspend to RAM.. and it indeed
> seemed to suspend ok, but I could not wake it up. Do I need to set up
> wakeup with button somehow? Is suspend to RAM required for good power
> consumption?

Sorry but pm subsystem has debug mode that you can test in a easy way.
You can even wakeup by any rtc alarm easily.

Michael

>
> Best regards,                                                           Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html



-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
