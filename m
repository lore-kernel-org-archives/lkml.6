Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F016C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:51:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9419220656
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 13:51:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="heRH/4zs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbeLNNvm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 08:51:42 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:38671 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729641AbeLNNvl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 08:51:41 -0500
Received: by mail-lj1-f196.google.com with SMTP id c19-v6so4968002lja.5
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 05:51:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dlmYwFqsFKEhToSsQ1LUA9jrnhFmIOjpJeXcfmDTZ8I=;
        b=heRH/4zsQNkfOf5Lu99kSp+OEMc+fb3xHxDEqCn/enStD+FHNhQaoiNAqet/1SaEJE
         G8whmtBhhFxc2likBgLVdezXKvnQQOLdLsv2Hn65TZLTvjvKJnDTKn4NHRE8SC0Vw5DJ
         MvSFaXXK24DN9Aii1QuvEPdcKoYiXugRBx7BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dlmYwFqsFKEhToSsQ1LUA9jrnhFmIOjpJeXcfmDTZ8I=;
        b=AXprBbjRmwdeR+/YO5MMMlKQXpmLXdyABDNfQjDpjwTk3PsjekTb4/hrbNZmiias3K
         YlacKo3+SownX4SW0qtrp7ncrcV6kOpmYaGKfbrvQL0pjRbeoQk1WMwThfE6rYhDYwDL
         sBAILIngzuCESdFQbYio6GFEp/1hD7MwE/q4v+LtED6cTRcacJV7v+wxaRJexF+e7mbJ
         QnnPnmMjzxvWrDLApEDD/e8ztBBqwgX8nREUMxm//1a1bavYaTkVeuwFLCeiLqCHKxLt
         juH2R6z5kSfziIBUeABuqjGTSCQFkE5E9tLIIi79fH/E/WJxxvpbI8KlBV5jjTioC5N9
         7Mpw==
X-Gm-Message-State: AA+aEWZUcLvLUtnewDNf6j51PS1yLS82zRJc9a6PB122tYl+u0WbVIh4
        gffE7VvBkwgI1v6ro/gPMA/8c5BfdKFBHrpmqdCSfw==
X-Google-Smtp-Source: AFSGD/UIYxzEHcmqrF1bTlFMrvxP41XRvK32oZDKiDd8KAEippNYYWFpTYtLDqlhF9JZum65Cm7qrV+1Le8xKrZsWbA=
X-Received: by 2002:a2e:710a:: with SMTP id m10-v6mr1907528ljc.66.1544795499422;
 Fri, 14 Dec 2018 05:51:39 -0800 (PST)
MIME-Version: 1.0
References: <20181129170312.23625-1-thierry.reding@gmail.com>
 <20181129170312.23625-4-thierry.reding@gmail.com> <CACRpkdbuRJ+UAoZkZNtWNzrF2+_0h-ibkTaDXWcPe70yJCx+5w@mail.gmail.com>
 <20181214133636.GA23379@ulmo>
In-Reply-To: <20181214133636.GA23379@ulmo>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 14 Dec 2018 14:51:27 +0100
Message-ID: <CACRpkdb55-U_9rBK0wvcBk-eof3hzDmPc2YSXNuzEhw-cZGrRA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] gpio: tegra186: Rename flow variable to type
To:     "thierry.reding@gmail.com" <thierry.reding@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-tegra@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 2:36 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> On Fri, Dec 14, 2018 at 02:34:43PM +0100, Linus Walleij wrote:
> > On Thu, Nov 29, 2018 at 6:03 PM Thierry Reding <thierry.reding@gmail.com> wrote:
> >
> > > From: Thierry Reding <treding@nvidia.com>
> > >
> > > The IRQ core code refers to the interrupt type by that name, whereas the
> > > term flow is almost never used. Some GPIO controllers use the term
> > > flow_type, but it is most consistent to just go with the IRQ core
> > > terminology.
> > >
> > > Signed-off-by: Thierry Reding <treding@nvidia.com>
> >
> > Patch applied.
> >
> > No need to wait for genirq or other changes to apply this.
>
> The genirq patch was acked by both Thomas and Marc. Were you waiting for
> anything else on the rest of this series?

Yeah I had some comments on patch 1 (sorry for slowness ...)
but it's something I think you can fix up and test in 30 min.

Yours,
Linus Walleij
