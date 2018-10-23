Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 155A3C46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7C9B20671
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 08:53:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHXtp8iE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C9B20671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728297AbeJWRQG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 13:16:06 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39002 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727470AbeJWRQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 13:16:05 -0400
Received: by mail-lj1-f193.google.com with SMTP id p1-v6so581441ljg.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Oct 2018 01:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnMVDFgqJXK5osTtEHCfUiFwx2DYbJnT0hVw8Txhymo=;
        b=UHXtp8iEoiiWBOtaDFqnUsO6VGa7vtorLTYXVeaRtEgtJ7Ni/o8TjhWUMXe6LNRpgn
         AXV59Km39Ko70bB5bcI8aH0u9d7xfZUmEJ0VkKNwuLOM9iLIwBQ9dcfgL7M40D0WblPt
         S+rHeZa0Dl3j1LnArfvWHYGRxelMF0peGXGK0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnMVDFgqJXK5osTtEHCfUiFwx2DYbJnT0hVw8Txhymo=;
        b=LwQruRUpwasrcU0BjaV0CovDM+eGwqEbIS5eW2y4KDGi4S9NTuGUZ8WX3iGX9+Xuaw
         RGoFtd3QaTK5OgJ+tb+Rni4goY0LVZ8Jwj9dS5AMc4igYqEM8ZEaDgo5Q/XpfLZwXw6y
         Fb+XyhCA8m7Sstceu/2EMR8ylMr1dRF4AncsL/FefumuUrTQ7FmsMnDIaaPfzy3eK+U4
         lR+tIhJq+g7dAa++6YlqNPZ7RVz95Xs44zmHcnzvPKLOW2lTLeJi5/T9aq8ZpE+GdCc+
         FMAx1yD0BbM72kGA44TZe1UmjudAR3rhqRoHGBrz96wyYFsOKkhMCdUbMFUFXt27Cqox
         Z9Cw==
X-Gm-Message-State: ABuFfohgQ6zfNQTvahSMcoZBrTITVv9YiqoyKnEe2efhtbycSLmbT7/b
        J2kDz+5TsB/GGBkDL5vj0y1mP8xdPpR2urmjViZ4gQ==
X-Google-Smtp-Source: ACcGV60GGJry/+F7rL6UL0B79GfBFAgIEt2WQx9xSV7JLtAqAYfxIPukluXc3pTnBB3VI6EKZNJAxxV7VfcBOYcXvZ4=
X-Received: by 2002:a2e:914e:: with SMTP id q14-v6mr31713326ljg.23.1540284817949;
 Tue, 23 Oct 2018 01:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
In-Reply-To: <CAHk-=wjS6cjjP+fkZWzzrdZ_fZ1F=PrAGcBc57vKCpNyoD73Vw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 23 Oct 2018 10:53:25 +0200
Message-ID: <CACRpkdbi2gqqc271eMgHjD68bqf2mzw8zw+iAhYv2LFajfo-eQ@mail.gmail.com>
Subject: Re: Git pull ack emails..
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Mark Brown <broonie@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 10:41 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> In particular, the issue is that after each pull, I do a build test
> before the pull is really "final", and while that build test is
> ongoing (which takes anything from a few minutes to over an hour when
> I'm on the road and using my laptop), I go on and look at the *next*
> pull (or one of the other pending ones).

So that is how you work, we have mental models about
how the upstream maintainers workflow is done but always
guessed it was something like this, nice to know.

> Comments?

I don't need the ACKs becuase there is just always some reason or
nervousness that make me sit and git pull --ff-only all the time during
the merge window because I worry that something will break on mine
or others machines.

Can't you just tool something that mails automatically after-the-fact?
Greg's "notices" that patch so or so was applied are clearly
auto-generated by a script after he applied and tested a whole
bunch of them, the same should be possible for pull requests
methinks? Just something you run after a workday sealing the
deal.

Linus Walleij
