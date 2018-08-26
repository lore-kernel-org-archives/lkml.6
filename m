Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83937C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EEA92098B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 14:04:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLKPFqfa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EEA92098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbeHZRqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 13:46:33 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38860 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726478AbeHZRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 13:46:33 -0400
Received: by mail-it0-f66.google.com with SMTP id p129-v6so7415708ite.3;
        Sun, 26 Aug 2018 07:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iPwbEDTPByu5LSTSxhIZyxzfliU7zI5i4FxRIj1eT3s=;
        b=oLKPFqfaCcdQ7TBLlnHTTfxDm26qdDAIDlHVg+jrhpVpuepk9PA7wrc+0v9mnGzBGv
         7nxuVqxq5ne1iWa4xF/FPWZQWsJfsZqyqsr/ti4LGOUROiURzAaPwW2EN7yaAWrMJ+ZP
         GWs8Ofk9sWTA7y7uco1QAdSKPlmNaZqxDTtDi96OG+wlfsqrwiOfJkEIetQh0dGVi1M3
         efuhn7fg7ccjjKN/Hvyf5cJFSTuH9NnSi2InYs1PN6b/riAYMqFSuGuYZAo4nmb61DOa
         fI+hgBVTXHCNQUtGMWNBM6rMp6JANDexNQFx0W2k8pSYN198uF0kD0QpEXOaRDOPbLn3
         xaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iPwbEDTPByu5LSTSxhIZyxzfliU7zI5i4FxRIj1eT3s=;
        b=mUVz9ujly+CxJMq+m+txVXeBpsj60MvqKhzPny+QHvJ5xzOONTZKa0nduiwtITNuVy
         xKz58EW231bYLaDwKpML8fSrAUvybEZVWis4rvIId3Ix1LzNi0iFkEjsi1yKevQZBfNX
         gY5e7vaseDoHpBSyoCCyRfkAXwImetwP4dhGBOvsMKIiFiM9eLHTCjZBvdJlVWh6BZ/o
         E58N+mMNdFaKUo2BBxMC2QYLUF06VVmyEojIYEWMkpWShE9PRjNWG4h+nj1rPPCMX5oR
         WIVZZG+7rBu2nb+8qo1PQxBe1nT0IxVqGXmD4C8z9qEdmF/bojK1VWCNTynpZwLV/Nm1
         JxNw==
X-Gm-Message-State: APzg51D+QCzrdGqMe2Ic1cLjxd9UZjhSBBk5XeVFZ7SFaR1IjfP+TNnO
        F96ZUIkICVskRIQG+f+JtoQuQLWz3WtiGZJH9Q==
X-Google-Smtp-Source: ANB0VdaddUkoF3z7uNCz4IJf8dd9xuHzqSQ4DLvYI+3joaLQD/UtetG9PB5Hi8tSRWwoEqSfSqtx4KfFu7neFysdW0k=
X-Received: by 2002:a02:2a48:: with SMTP id w69-v6mr1298270jaw.106.1535292232934;
 Sun, 26 Aug 2018 07:03:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180823230654.GA11576@embeddedor.com> <CAGXu5jK7VQSo=xsYVp5DPmUgULNt+wopyAXnK20z+LxZtyPfZA@mail.gmail.com>
In-Reply-To: <CAGXu5jK7VQSo=xsYVp5DPmUgULNt+wopyAXnK20z+LxZtyPfZA@mail.gmail.com>
From:   Avi Fishman <avifishman70@gmail.com>
Date:   Sun, 26 Aug 2018 17:03:33 +0300
Message-ID: <CAKKbWA53F-LJhax7OD8jA2VkNAqoRJE21GxdOJwPP5XQANkyzA@mail.gmail.com>
Subject: Re: [PATCH] clk: npcm7xx: fix memory allocation
To:     keescook@chromium.org
Cc:     gustavo@embeddedor.com, Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        mturquette@baylibre.com, sboyd@kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 2:18 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Aug 23, 2018 at 4:06 PM, Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> > One of the more common cases of allocation size calculations is finding
> > the size of a structure that has a zero-sized array at the end, along
> > with memory for some number of elements for that array. For example:
> >
> > struct foo {
> >         int stuff;
> >         void *entry[];
> > };
> >
> > instance = kzalloc(sizeof(struct foo) + sizeof(void *) * count,
> > GFP_KERNEL);
> >
> > Instead of leaving these open-coded and prone to type mistakes, we can
> > now use the new struct_size() helper:
> >
> > instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL);
> >
> > Notice that, currently, there is a bug during the allocation:
> >
> > sizeof(npcm7xx_clk_data) should be sizeof(*npcm7xx_clk_data)
> >
> > Fix this bug by using struct_size() in kzalloc()
> >
> > This issue was detected with the help of Coccinelle.
> >
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Avi Fishman <avifishman70@gmail.com>
>
> -Kees
>
> > ---
> >  drivers/clk/clk-npcm7xx.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/clk/clk-npcm7xx.c b/drivers/clk/clk-npcm7xx.c
> > index 740af90..c5edf8f 100644
> > --- a/drivers/clk/clk-npcm7xx.c
> > +++ b/drivers/clk/clk-npcm7xx.c
> > @@ -558,8 +558,8 @@ static void __init npcm7xx_clk_init(struct device_node *clk_np)
> >         if (!clk_base)
> >                 goto npcm7xx_init_error;
> >
> > -       npcm7xx_clk_data = kzalloc(sizeof(*npcm7xx_clk_data->hws) *
> > -               NPCM7XX_NUM_CLOCKS + sizeof(npcm7xx_clk_data), GFP_KERNEL);
> > +       npcm7xx_clk_data = kzalloc(struct_size(npcm7xx_clk_data, hws,
> > +                                  NPCM7XX_NUM_CLOCKS), GFP_KERNEL);
> >         if (!npcm7xx_clk_data)
> >                 goto npcm7xx_init_np_err;
> >
> > --
> > 2.7.4
> >
>
>
>
> --
> Kees Cook
> Pixel Security



-- 
Regards,
Avi
