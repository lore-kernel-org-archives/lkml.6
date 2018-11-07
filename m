Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E66C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7347B20862
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="0cQ87MPg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7347B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lixom.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbeKHDGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 22:06:47 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:38868 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeKHDGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 22:06:47 -0500
Received: by mail-lf1-f67.google.com with SMTP id p86so12105739lfg.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 09:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=kxiK8t8nrB5BiFSgCypjx4FyMuciPUXkoznEtv5DHSo=;
        b=0cQ87MPgW9Gze993K84WEuJVFgT406flsSE+gadrtkJwsGYqKVNEylVayvPzQ3nBd8
         3JZj7R5jwThpv3WzHwdPS9k5Dj9vrp1nyMersYlp+i8udzVJg9QlHl+FonyAxtDTnIDX
         zhoZEdsnLkCekz1tC4XmResoHTKM4Qvpgz4dc4TRmGYlLyUzf3M2tiqwnoYVefOmeO6c
         jKlEuOhpYFdKHNvNqVzCn9bUoECooGrk31mg+4bDKkrTCBnsoB2KFXXDE4cEo/xG7Q0D
         /tvo4wrjCd3mU/f2AXhyGpugB/yuPqiQUs9br89I5b2Gp5sJMkB5ULzXJ+CgTTZiUyG1
         O0HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=kxiK8t8nrB5BiFSgCypjx4FyMuciPUXkoznEtv5DHSo=;
        b=ehieKwqYXbOHVby/b8+NLdjH4XOCEHlmLzEAedZDAR1Pw/Bjbl4Px0FW46JqmeyGmS
         IwFCseGkxYe20Z3VqudPxe4iZKCxvQHx41WhstXwONvRGxzNg+Ix1VuDZMgKT3uHtndD
         oyxDmjmA1XOtWU/wHyTfAz9Q8Yfao8Cp47bb9fuZCdpBOfX0N5fv6Jm7NLpfuhYJ0AFZ
         rXzcLjn8zW2tp/EAgU4FYEdVSw4fabu+cTwD27Lhi/JHthXioRuYKeB99zjkfmnK1RGe
         lBlwRIEB6FPZ+1PIXQsnbW/Ar2XImNNKYPea+eiSZYA4iorVmItmdzTjtZa6oInE8Kor
         YRnA==
X-Gm-Message-State: AGRZ1gKDZEHrwlyPof9tcUxbmEmFZKVAF8iJROl6o6p5xnanEVOpIRHu
        FXJPQyy6sTlNMaoR6C7DuEyzWXfOA0BgAlQiio3YKQ==
X-Google-Smtp-Source: AJdET5c6P8Vo0JzLVQlX1ep8j/8CXkS86Sc+cS09nfgrkap+T6xoMh+ceRmnF4pE1LeAYUOAemhS5uAO6VpvL5XS0PE=
X-Received: by 2002:a19:df41:: with SMTP id q1mr707154lfj.25.1541612122240;
 Wed, 07 Nov 2018 09:35:22 -0800 (PST)
MIME-Version: 1.0
References: <CAOesGMgVPsK9YsV2nGoBptWwtHYv=3yMytLx2_tF_ujS5c5p3Q@mail.gmail.com>
 <20181107171723.GI9919@thunk.org>
In-Reply-To: <20181107171723.GI9919@thunk.org>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 7 Nov 2018 09:35:09 -0800
Message-ID: <CAOesGMheCcvDQCd+7fyh4yOk4BYDfm2QRqsdawqA_fg8s9YYEQ@mail.gmail.com>
Subject: Re: [TECH TOPIC] SoC maintainer group
To:     Theodore Tso <tytso@mit.edu>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Russell King <rmk@armlinux.org.uk>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Kevin Hilman <khilman@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 7, 2018 at 9:17 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Tue, Nov 06, 2018 at 02:16:27PM -0800, Olof Johansson wrote:
> >
> > Olof Johansson (arm-soc)
> > Arnd Bergmann (arm-soc)
> > Kevin Hilman (arm-soc)
> > Mike Turquette (clk)
> > Stephen Boyd (clk)
> > Linus Walleij (pinctrl + more)
> > Mike Brown (gpio/regmap + more)
>
> Could the poeple listed on this list please list potential schedule conflicts?
>
> I'm going to assume we should avoid: Andriod uConf, RISC-V uConf,
> Device Tree uConf.  What are other potential conflicts.  I'm going to
> guess this might be "interesting" to schedule.  :-)

Yeah, apologies for adding a bunch of cross-coordination this late too.

It's likely going to be conflict-ridden no matter what we do. RISC-V
and DT are the main conflicts, Android probably has a bit less.

Tuesday afternoon looks least conflict-y when I squint at the
schedule, or Thursday afternoon (but ideally not overlapping with
Daniel's DRM/gitlab session).



-Olof
