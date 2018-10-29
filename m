Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F85ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39C6208E3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 18:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c52Ze7da"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39C6208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbeJ3Cyd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:54:33 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:33889 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726532AbeJ3Cyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:54:32 -0400
Received: by mail-qt1-f194.google.com with SMTP id z2-v6so10372855qts.1;
        Mon, 29 Oct 2018 11:04:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3iDI9uNcgbd4WeSkgPK2jFWjSLsx2JhiA7S0p38mNzw=;
        b=c52Ze7daZNSqDKJB3rUMiggb7JxImdR+XlDvq5IAA1DKf80aTS9crO9F9GKpt6oLqP
         jiZP19FMVUwcfl+dJxuAwMqNH7tuYP2EAKjP+gIOEr9px8g7ohWnSAPaCW1aVw28C3+G
         075tjn8+X8XEdz7Vb5ZvNToSz2+W38z0CPNkmm06Y9r+yGGOnltf3MhlIbMl2Hm4U6mF
         Ou+QDKPm4JZeV7efn13KeIn0v5a3/D/D7RRKFr/0X6b6mQHsjcVn3aU6XW06iWLGQXB9
         ERVMtS+NTBfa5mOpq7ltvdKy768NUQTZZxOMGSXIn6nK4bLfpJa6o3jZtbqumpexnmvu
         9AIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3iDI9uNcgbd4WeSkgPK2jFWjSLsx2JhiA7S0p38mNzw=;
        b=SVbNqOe3Wrd55WixSQFDCLWlUEsa5hPLOUyW4kmmKgAbgkcKQ5UnU2c+GPjefNxqtW
         jtTJwAdjuT3xKw+stMsapU8C1AmT3q4vr04tERJvptIjnia46GHKtakBVRAGZu1qkDBE
         euatNoKJ4Vm37oIfSfOFhVWxj0z8ESY/+Mp5kPwuwiSZtVSd9IcrEod9VcIwmIEAjWy+
         cZvf4756ShnsD6qbmAa5+bmJ7Qs65zSZXQbz/HIV7JFAKm1f+dao9tZqiMhg62RQi8wE
         uVjugtgnY9RC1CXlm2vX5X7XLEKeftfidTe/4teEtDNnHgkJ5/mHHs7LmfXYN8Ol06oJ
         fGYw==
X-Gm-Message-State: AGRZ1gJe3/C59dTrSLCFKd5cGYHdEbBgLTS1sSR/RsH17vZ2ScAR/FG7
        dLtMYZ72oilsm3b7lj1vc6Xfc3Xd1YxuJKWefLU=
X-Google-Smtp-Source: AJdET5ek3GpN8qjoV09qYCcDvP4Zle5MprTtp99IDbXtUm5Wl1KbhJTFQcJUz8UC7FmkcQlgrxJ0m2SZrIiWx4Re47A=
X-Received: by 2002:aed:3e56:: with SMTP id m22-v6mr4345349qtf.99.1540836289189;
 Mon, 29 Oct 2018 11:04:49 -0700 (PDT)
MIME-Version: 1.0
References: <20181025232517.ywnw54qibemosjws@picard> <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
 <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
In-Reply-To: <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 20:04:38 +0200
Message-ID: <CAHp75VctdBE-GM60udJawBCXdmoOqZn4N=kFWz5GLHzjPG2iQQ@mail.gmail.com>
Subject: Re: Regression found (Stop-marking-clocks-as-CLK_IS_CRITICAL)
To:     Stephen Boyd <sboyd@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     duffydack73@gmail.com, Hans de Goede <hdegoede@redhat.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Johannes Stezenbach <js@sig21.net>,
        Carlo Caione <carlo@endlessm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 7:52 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> Cc: Pierre as well.
>
> On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
> >
> > Quoting Dean Wallace (2018-10-25 16:25:17)
> > > I have found a regression in 4.18.15 that means I lose sound on my old
> > > Toshiba Chromebook 2 (Swanky).  My system details are:-
> > >
> > > Toshiba Chromebook (Swanky)
> > > MrChromebox UEFI coreboot
> > > Arch Linux running latest alsa/pulseaudio
> > >
> > > Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
> > > output I mean, the card is still detected, the module loaded, all apps
> > > showing sound is being playing, but no actual audible sound comes
> > > through.  Upgraded to 4.18.16 same issue.
> > >
> > > Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
> > > clk: x86: Stop marking clocks as CLK_IS_CRITICAL
> > > "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
> > > devices not being able to reach S0i3 greatly decreasing their battery
> > > drain when suspended."
> > >
> > > I reverted it and compiled 4.18.16 and have sound back again.  Could
> > > this be looked into, with possibility of fix.
> > >
> >
> > Thanks for the bug report. I'm adding some people involved in the commit
> > you mention is causing audio regressions. The best plan is to probably
> > revert the commit from the 4.18 linux stable tree. Or there may be
> > another patch missing that would be useful to make this backported patch
> > work. Hopefully Hans or Andy knows.
>
> Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
> I have a feeling that the problem can be fixed by properly handling
> clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
> better than me.

Looking to sound/soc/intel/boards/cht_bsw_rt5672.c I see no
suspend-resume hooks. Perhaps, adding them like in the commit
ac8bd9e13be2 ("r8169: Disable clk during suspend / resume") would
help.

Btw, what the drivers are in use for the machine you have? It's better
you run alsa-info.sh or alike to collect necessary information along
with output of `lsmod`, `dmesg`, etc.

-- 
With Best Regards,
Andy Shevchenko
