Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FA3C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19FAA222A4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:02:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbhKTuFe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394994AbfBNJCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:02:40 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35377 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391656AbfBNJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:02:40 -0500
Received: by mail-lj1-f194.google.com with SMTP id j13-v6so4552190ljc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 01:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V33Nq+ATmwxNloNO/a5OQf11RxpzThlaZGzROrRe//g=;
        b=jbhKTuFeLQswUu//tKTcuQPAC8UL6cmUZdwHq+kGL7gQdcCxGqWMZe0BG5iUKOytMv
         twA41+zdoY/SHXIub4YMGqt0p2rewyUAR/gxezryFrj/WSnJIMhnSBrzNKsIx++Uyfnh
         QUnHnaaPkGcVDuur6QycJB3Fb96BDE7fvT9ZcmoFhV5EJYe9GyR5VRl8f7mrVnptctX7
         zCOlc+cZfb8aV1NK6Ih8x3feo8cgDNybPf/92+MdELEQoxBJfvbcJO9JAkFFSiplsJi8
         yi5QEL4o/4Rp5tMUUZgHZ4JU86AXAc9vfLvsn2ZSVkEFgCU/lqBsu1Uf6Ifiu1WPFVo4
         mKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V33Nq+ATmwxNloNO/a5OQf11RxpzThlaZGzROrRe//g=;
        b=GC1Pj8K2O5GH789W3fDn8U9BiEkOeRkl6c1xNoRXBCDTZga3it9qjC6wXuosA39wpG
         unqE/BnMEPiXJ+eUPKHkmeLLSYYLSH/aoHEJHxiOFjbnWDnGanT6PqHgAz+d46409Z+O
         jvAO8vYvIfoaPKdXUxjKdsAVr+GdMnUHs1zTvoRRcEBGAxSZLCmkEOXA6ZaB0wS950d1
         tFib8Ok3CK9nLY4I9ox0i+X9JkzOO+dWWl7rpISkKpg2bXiNB2dv+HFlZnCh7kdR/wwp
         8q+Z2x2q+J5O5fIJdVwQ4lutXfJpgsLtuwzv8iGKPZ0uVKNHqzakJ+pyAGbNyVJGMBK1
         zfOw==
X-Gm-Message-State: AHQUAuYipHuLPkWd6GYnmc23WiJxpReduzDzDeUXJWCxWholUIJw1/3i
        WdwMgS68YwZPJYwyDGF/0ue2NUQu1gBk8MG0bYv8KA==
X-Google-Smtp-Source: AHgI3IYCzBYwtLKrkZqMreTpUWGHKHCmSX/70xO5b8QY/j0Z6xDgp3cmmRwyPwlDrDk+GKLQFiCVVkJ1JYk8NZrhcxY=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr1568032ljt.107.1550134958143;
 Thu, 14 Feb 2019 01:02:38 -0800 (PST)
MIME-Version: 1.0
References: <20190214013641.9740-1-masneyb@onstation.org> <20190214013641.9740-2-masneyb@onstation.org>
 <CACRpkdbYiwu6Bbd6uMaWUc2AzDZPve5_bq=_9RwRhadaMBf+dQ@mail.gmail.com> <20190214085106.GJ1863@dell>
In-Reply-To: <20190214085106.GJ1863@dell>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Feb 2019 10:02:24 +0100
Message-ID: <CACRpkda3HxVqNdmk7iRrhvafvkCX=JtxqVyNGO5kmo05MSDN+g@mail.gmail.com>
Subject: Re: [PATCH -next 2/3] mfd: pm8xxx: select IRQ_DOMAIN_HIERARCHY in Kconfig
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Brian Masney <masneyb@onstation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 9:51 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Thu, 14 Feb 2019, Linus Walleij wrote:
> > On Thu, Feb 14, 2019 at 2:36 AM Brian Masney <masneyb@onstation.org> wrote:
> >
> > > Select IRQ_DOMAIN_HIERARCHY for pm8xxx in Kconfig since this driver uses
> > > the version 2 IRQ interfaces. IRQ_DOMAIN_HIERARCHY selects IRQ_DOMAIN,
> > > so it can be removed from here.
> > >
> > > Signed-off-by: Brian Masney <masneyb@onstation.org>
> > > ---
> > > Linus: For your ib-qcom-ssbi branch.
> >
> > OK applied it there (might fold it in with the original patch, let's see).
>
> Ah, we're applying patches from different SS without Acks now? ;)

Yeah when fixing onelined bugs I tend to do that sometimes,
usually better to ask forgiveness than permission if -next is broken.

> FWIW:
>
>   Acked-by: Lee Jones <lee.jones@linaro.org>

OK folding it in!

Yours,
Linus Walleij
