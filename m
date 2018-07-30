Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17A613F6DFF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BE6620892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 11:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BE6620892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728746AbeG3NEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 09:04:34 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:35930 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726876AbeG3NEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 09:04:34 -0400
Received: by mail-vk0-f68.google.com with SMTP id y9-v6so5525692vky.3;
        Mon, 30 Jul 2018 04:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3yAlJiZFtPivrii6SbBduoD+85v8djIZ34SRnXRIcoM=;
        b=itqwyjOfR7adX+Aq1WPxNWh4JQocqqda4aMKQJ14/INE5vUc7t4sSKyJ5eo7XanSHw
         k2kVurortcgNyPmujSqceGbthRH++KsFEftUXLW6b5JRIv85QtrtswZh8AQY0MaWT0Su
         peuo+lGZx9Q1swOWufxHWcLEQDQsenOmAIc7TynU42WnjtO7/VjFf6ZCKTlBfBD+ef1i
         y6V+WXme+vzKClHsqkahYj6VrqRIN7g/sMfz8RMpLGy/muSIfjEPbqiLtT9Nun4dDBt8
         04OuNxf2LOIEIDFJ2rI0DgrmIHp35NRjdx5hV7LrL1D6GaMt5gFiuo9RLmhFDjnVIvDS
         NtPg==
X-Gm-Message-State: AOUpUlFLyrXY01GiyC/eBHLQnylF+c1cwnCagejSg+xMjB9lSSYu84Pg
        kjXySvaZ11XtQrkRXgr3QpJLD+BVMuUqY3uIsLc=
X-Google-Smtp-Source: AAOMgpcOd+MctXmQRPFgl70vLOqFjIvZ+bOsxek2m6SCBLJIJXjsn/7cvxpKByWG1F03SZ1RxDvjXi3LN5bkbwW7hyc=
X-Received: by 2002:a1f:bc06:: with SMTP id m6-v6mr5067089vkf.10.1532950201890;
 Mon, 30 Jul 2018 04:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <1532939768-7018-1-git-send-email-phil.edworthy@renesas.com>
 <1532939768-7018-2-git-send-email-phil.edworthy@renesas.com>
 <CAMuHMdUWWb7uyiG6NdRaJxM0X4JfioWx=o9J7jD18rgiTz1m4w@mail.gmail.com> <c82487a125591c14e66ba56dc3202aa0093f0aba.camel@linux.intel.com>
In-Reply-To: <c82487a125591c14e66ba56dc3202aa0093f0aba.camel@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Jul 2018 13:29:49 +0200
Message-ID: <CAMuHMdWXfS9gFxOq5nvJWx2KMOae5_c8Lb0omeE3P9yjyYZ7gA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] clk: Add of_clk_get_by_name_optional() function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Phil Edworthy <phil.edworthy@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Simon Horman <horms@verge.net.au>,
        linux-clk <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Mon, Jul 30, 2018 at 12:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Mon, 2018-07-30 at 10:55 +0200, Geert Uytterhoeven wrote:
> > On Mon, Jul 30, 2018 at 10:36 AM Phil Edworthy
> > <phil.edworthy@renesas.com> wrote:
>
> > > +struct clk *of_clk_get_by_name_optional(struct device_node *np,
> > > +                                       const char *name)
> > > +{
> > > +       if (!np)
> > > +               return ERR_PTR(-ENOENT);
> >
> > Shouldn't this return NULL?
> > Or let __of_clk_get_by_name() handle that (cfr. above)?
> >
> > Hmm, of_clk_get_by_name() has a similar check, while the current
> > __of_clk_get_by_name() already handle np == NULL, too.
>
> This check is needed to prevent NULL pointer dereference below.

Thank, I had missed that unexpected detail.

> > > +
> > > +       return __of_clk_get_by_name(np, np->full_name, name, true);
> > > +}

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
