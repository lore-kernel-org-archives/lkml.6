Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D96DBC2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A36F3204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 17:53:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qoT1jcCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A36F3204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbeJ3Cmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 22:42:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35062 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728233AbeJ3Cmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 22:42:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id a10-v6so10293650qtp.2;
        Mon, 29 Oct 2018 10:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8hXlu+d0AWorC9/nlJQcqwYpd8wvmsjNLZc7awhfj8=;
        b=qoT1jcCHc1+xsrdl+BDTSLMrwM9jcPjbpt9NkeYzA3GZ9yRqssNEZZ2B6qe8CF1VgC
         OW12O7KTv9tzVnrDVJNXUz9rAKXM619rvslyjPm9pzG7eOsDktL5dnxFQvtG+WGAbflb
         lpF8xCFQj1/QiNT0FSdZ7eyFPACjYM187l+FoVRlHCKc/IOvMGTNIT8no8ps2O8877KT
         e9nj1AoRr98/k/2v7vbYF7GERB1RqtAm/x4+0E8F+ED67H1p6CwXKqsF/KkWTncPgX8w
         vgzsBu3drvR/Hf1aKCwwWCBZdcAL6l/Z9BdVhqAQ3r3EjADWFrJcT8ceqFI+CwyQg4Lw
         KzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8hXlu+d0AWorC9/nlJQcqwYpd8wvmsjNLZc7awhfj8=;
        b=oardvi9KtopyH77npqAItZABx+qYT9wsXNr4zXFrEH9NkeRSxmg/2pmBjTQZns7myj
         fMepIXIF1ShQJJ3SenW9gtRV24xxFktULb4J4JZrwgNe7k4KXsAzK1k5cNBfydvjzpx+
         0Arj43J+l5WXcBCKV7wQHVGnjSPczxC/mT26Mr01L2mo88J6uMB9F6umTn64AubuMzXV
         cNT1Y3WUWGHrK30DTAYEyXtvt4AKGkrHXSAwnMmtjMFN8i63dsqfztt0PAZaDOzylijV
         lrsl66xB/Ux7yuKd3tf5zgtwZ8D+MIyKgtLKzbbonOBV6qnUQUPzX6KYu0DXCYjBVvs/
         do7g==
X-Gm-Message-State: AGRZ1gK4GOxiJ4Ey9Rq8rX523z3FHTQ3BUbfr4XajecFXaM2oZ9CIs90
        7j532lPrc1IPY/evk/rapIUqEVOOEC0SXrSmEmk=
X-Google-Smtp-Source: AJdET5f8NQMlJ9DnE2siWVJxA2nHLp18g4JJGtK1hzxdZGL5smUWtDBh9ONhdJ39ukxygPXsTscpKz4G8Xq+6GD/xdw=
X-Received: by 2002:ac8:2413:: with SMTP id c19-v6mr13533856qtc.194.1540835579714;
 Mon, 29 Oct 2018 10:52:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181025232517.ywnw54qibemosjws@picard> <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
In-Reply-To: <154083512089.98144.9141070901932719147@swboyd.mtv.corp.google.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 19:52:48 +0200
Message-ID: <CAHp75VfnN5tF1Z9+CDDhKFNG5QfCRcGOZeAkpf-5BfCEx16gvg@mail.gmail.com>
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

Cc: Pierre as well.

On Mon, Oct 29, 2018 at 7:48 PM Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Dean Wallace (2018-10-25 16:25:17)
> > I have found a regression in 4.18.15 that means I lose sound on my old
> > Toshiba Chromebook 2 (Swanky).  My system details are:-
> >
> > Toshiba Chromebook (Swanky)
> > MrChromebox UEFI coreboot
> > Arch Linux running latest alsa/pulseaudio
> >
> > Upgraded kernel from 4.18.14 to 4.18.15 and lost all sound output.  By
> > output I mean, the card is still detected, the module loaded, all apps
> > showing sound is being playing, but no actual audible sound comes
> > through.  Upgraded to 4.18.16 same issue.
> >
> > Dug around and found Upstream commit 648e921888ad96ea3dc922739e96716ad3225d7f
> > clk: x86: Stop marking clocks as CLK_IS_CRITICAL
> > "This commit removes the CLK_IS_CRITICAL marking, fixing Cherry Trail
> > devices not being able to reach S0i3 greatly decreasing their battery
> > drain when suspended."
> >
> > I reverted it and compiled 4.18.16 and have sound back again.  Could
> > this be looked into, with possibility of fix.
> >
>
> Thanks for the bug report. I'm adding some people involved in the commit
> you mention is causing audio regressions. The best plan is to probably
> revert the commit from the 4.18 linux stable tree. Or there may be
> another patch missing that would be useful to make this backported patch
> work. Hopefully Hans or Andy knows.

Hans has been investigating S0ix issues on Baytrail and Cherrytrail machines.
I have a feeling that the problem can be fixed by properly handling
clock in ASoC driver(s). Perhaps Hans and Pierre can figure this out
better than me.

-- 
With Best Regards,
Andy Shevchenko
