Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8821C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EB32145D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 00:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSkyD7Dm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EB32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeIYGOQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 02:14:16 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40941 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbeIYGOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 02:14:16 -0400
Received: by mail-yw1-f68.google.com with SMTP id z143-v6so8622368ywa.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 17:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oLF8IV6E6+XPP1dkFE/J+bDR0a8FlenM1TQYZFAO6I4=;
        b=oSkyD7Dmpcwk913Pk3askHT825u+TErxVWbuBSrgGVHgdII1QmyDUZzRSqpzXB610F
         3QmD7Cxz6+Q/Bv/LFasyLD72WAsoVWNPKoXDtAwO4VHVPX8K8SQHxjehpmcFO8QdcVLn
         RhBLb48Bf6XlAvUcmOl/1lNtp6WcGqA3MOgkJ76OdWL8mI30jCPCr6+bOzuGED/PIcRu
         IYXK2iAv8XKRPP3P/oO1B3mhIqRSXB+PHh3gWyIj4hJHoCriD/IHcE0bdhIpcByVeELh
         qPIplnMpv590f2inQYfOFaFv3h33/9vNWSWCh2B2ugHzDIkhzjq9zr3B544ONrsESDe8
         dUOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oLF8IV6E6+XPP1dkFE/J+bDR0a8FlenM1TQYZFAO6I4=;
        b=fH+AVDYTvx4SXbj1JzbFySZRC8PMUrxw8Hj8XRCuaAqbqYz0aLBMTH8QnW6x5cz1XF
         2XKUqRuBTxbauPaqZDNlqFyTMH4/p+RQE7sSEwfaAx8FyP+ah80KU1Vm8X7cVQwJE3Xt
         /bNw0TMZymbQDgWTTV2iSkDcR4KDnYglUc6S6X6xokqM7aXEemii5Ol2E0nckCG52tfR
         VmNU9lIUWTA1qBLwg8HwkZVvHebz/IG5G/TQBEeN2G2jWbXsVkh+HYSlJpsAfrrfteIE
         rLVYyodUyYux1McD8tdc93qet00PiOu244nuxjneItAvaxGkfFMXvkK6RQ0r1vw5uL/S
         mpCg==
X-Gm-Message-State: ABuFfoj8ls8Q63cJnNmVWimkho33kAxY6bn4IkorVBxXIdtiy8hGob6o
        x70rGi88kiv7rzxgtgCI8DVeX5GgUR3i/cVYJmE=
X-Google-Smtp-Source: ACcGV62mFGbGFXTPWJpku3PojdoSKIG3B0wMcNXHiO8tQmNDhyUzjlAgT0kgLjlfY8pDsESylAlqWU0l4NFW4WzwZ7o=
X-Received: by 2002:a81:3887:: with SMTP id f129-v6mr606095ywa.46.1537834172145;
 Mon, 24 Sep 2018 17:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <20180912035352.11191-1-diego.viola@gmail.com> <CA+ToGPGSOsLpbOvjjb22B510qkNefdsUSiFTYON7c=oh0s8vcA@mail.gmail.com>
 <CANiq72m_X1U+NVf1VQuUcCi9-dERrCG3Y3tueRGbOpPd5u+a0g@mail.gmail.com> <CAFLxGvxZmuXb6KbGggQf4y1_Tkv=Ri3PuE4Jnfwbs1VuA9z2QQ@mail.gmail.com>
In-Reply-To: <CAFLxGvxZmuXb6KbGggQf4y1_Tkv=Ri3PuE4Jnfwbs1VuA9z2QQ@mail.gmail.com>
From:   Diego Viola <diego.viola@gmail.com>
Date:   Mon, 24 Sep 2018 21:09:20 -0300
Message-ID: <CA+ToGPG-z0GOka6EMruqTto64cpCZaSaTwA3A97-vgN9OKFSJg@mail.gmail.com>
Subject: Re: [PATCH TRIVIAL] Punctuation fixes
To:     richard.weinberger@gmail.com
Cc:     miguel.ojeda.sandonis@gmail.com, corbet@lwn.net,
        linux-kernel@vger.kernel.org, trivial@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 23, 2018 at 5:59 AM Richard Weinberger
<richard.weinberger@gmail.com> wrote:
>
> On Sun, Sep 23, 2018 at 3:00 AM Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> >
> > Hi Diego,
> >
> > A few things, since it looks like this is your first patch.
>
> git log...
>
> > On Sat, Sep 22, 2018 at 5:56 PM, Diego Viola <diego.viola@gmail.com> wrote:
> > > On Wed, Sep 12, 2018 at 12:54 AM Diego Viola <diego.viola@gmail.com> wrote:
> > >>
> > >> Signed-off-by: Diego Viola <diego.viola@gmail.com>
> > >> ---
> > >>  CREDITS     | 2 +-
> > >>  MAINTAINERS | 2 +-
> > >>  Makefile    | 2 +-
> > >>  3 files changed, 3 insertions(+), 3 deletions(-)
> > >>
> > >> diff --git a/CREDITS b/CREDITS
> > >> index 5befd2d71..b82efb36d 100644
> > >> --- a/CREDITS
> > >> +++ b/CREDITS
> > >> @@ -1473,7 +1473,7 @@ W: http://www.linux-ide.org/
> > >>  W: http://www.linuxdiskcert.org/
> > >>  D: Random SMP kernel hacker...
> > >>  D: Uniform Multi-Platform E-IDE driver
> > >> -D: Active-ATA-Chipset maddness..........
> > >> +D: Active-ATA-Chipset maddness...
> >
> > I think the extra dots is what was intended here :)
>
> Diego, I know you can do better. :-)
> How about running linux-next and hunting down regressions?
> I think we suggested this already on IRC.

OK. I'll do that after I'm done with the documentation.

>
> --
> Thanks,
> //richard

Thanks,
Diego
