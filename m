Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF42C433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E2DE20893
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 19:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ld8uwkS9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E2DE20893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727281AbeH1XE2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 19:04:28 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:40677 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbeH1XE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 19:04:28 -0400
Received: by mail-it0-f65.google.com with SMTP id h23-v6so3971620ita.5;
        Tue, 28 Aug 2018 12:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fTMj6o52t9v/CBkuX7E2VOEUUHactDHCDYD2MvRLt94=;
        b=ld8uwkS9XrrZBAlaNBJdVh8m1wF56DA5L8bo/uOiO9q9QqSM/y2XWgiFTfsiSj7A59
         8b9VvXGYJ22xpSBThyw0Tskds4yzGpYD+fkBp9/ZGtbSQihN+VdMnSbdcHsdkEMC7ggy
         PTczwcxphY2c2h6hctuf9QVRsqJ9f4U2Saco0/02SiQyhFum/6DQpfAVfCy/z6FB8MNA
         /Pj2YlKgex+EGmdbE0C6bYivXc+0/jer1ZkJ/IzcDhwoxUwmZUgKSwEr7xAf2mhelGhU
         YVIJEz66l+uoXzAviT23k1VaovFeYX5ekHaj/GnmVieQ7ZII5DzSQ8JiqfYKXCHacjyD
         dH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fTMj6o52t9v/CBkuX7E2VOEUUHactDHCDYD2MvRLt94=;
        b=dSjfEo4YihyD0ZAxWicN9Vsn7E43QxyCrzYVKew9km7IOAadsIhodhXriCciI9x+My
         1aBUP/vudgG3rfrt9z6EXovLiLZxcyM4yjwOSzqQY0SD5g4AdM8VETZujo1naxvTRe2P
         chk/57eLDjIRX+FfNGNCURWuhLcQN31qb6PB1LWxf81dPKy7+EAbLQZahk5M1IrRD+kR
         EiujpKYZbBh5JYXjvwK8cP6gVHX7W+cmQpzUTRwDd0n3mlS1Nq0Cl2q3rilUbHk4VcGb
         KwWainO5HnGWxzCMIx6t0Ro1pcc9ACOz1S+6fmHeOI9jW3ED+1WL5A/VXBBowWfGwXLU
         cmWA==
X-Gm-Message-State: APzg51A4F0DUd7SR2GI7HdqLtqKErLvF7l46jWZ52le62uc+z6RuYp0D
        yyTJN50gRptnwtl73NCuYlx+WL3Ah2Xf+4KvxBE=
X-Google-Smtp-Source: ANB0VdZQ4a6fD72WC+GBpO902G/deLYM1GreaOSZke3RVDHlXBU1QgP5zihgETqEaQz5iIUkMFoPk14yC08agT4pZ9U=
X-Received: by 2002:a24:e47:: with SMTP id 68-v6mr2855600ite.23.1535483485436;
 Tue, 28 Aug 2018 12:11:25 -0700 (PDT)
MIME-Version: 1.0
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
 <1534945703-4730-4-git-send-email-abel.vesa@nxp.com> <20180824074011.lufm653imkf6fyd3@pengutronix.de>
 <20180828105821.gbd7tba7uvmeeqcx@fsr-ub1664-175>
In-Reply-To: <20180828105821.gbd7tba7uvmeeqcx@fsr-ub1664-175>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 28 Aug 2018 12:11:13 -0700
Message-ID: <CAHQ1cqEsHoF0ZFY5+CpQFJ+b3sKd3yJPvmRZMAbaa9+Xzhe3=g@mail.gmail.com>
Subject: Re: [PATCH v6 3/5] clk: imx: add SCCG PLL type
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, sboyd@kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, abelvesa@linux.com,
        linux-imx@nxp.com, Shawn Guo <shawnguo@kernel.org>,
        linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 3:58 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On Fri, Aug 24, 2018 at 09:40:11AM +0200, Sascha Hauer wrote:
> > +Cc Andrey Smirnov who made me aware of this issue.
> >
> > On Wed, Aug 22, 2018 at 04:48:21PM +0300, Abel Vesa wrote:
> > > From: Lucas Stach <l.stach@pengutronix.de>
> > >
> > > The SCCG is a new PLL type introduced on i.MX8. Add support for this.
> > > The driver currently misses the PLL lock check, as the preliminary
> > > documentation mentions lock configurations, but is quiet about where
> > > to find the actual lock status signal.
> > >
> > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > ---
> > > +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
> > > +                       unsigned long parent_rate)
> > > +{
> > > +   struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> > > +   u32 val;
> > > +   u32 divf;
> > > +
> > > +   divf = rate / (parent_rate * 2);
> > > +
> > > +   val = readl_relaxed(pll->base + PLL_CFG2);
> > > +   val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
> > > +   val |= (divf - 1) << PLL_DIVF1_SHIFT;
> > > +   writel_relaxed(val, pll->base + PLL_CFG2);
> > > +
> > > +   /* FIXME: PLL lock check */
> >
> > Shouldn't be too hard to add, no?
>
> Added to the next version which I intend to send today.
>
> >
> > > +
> > > +   return 0;
> > > +}
> > > +
> > > +static int clk_pll1_prepare(struct clk_hw *hw)
> > > +{
> > > +   struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> > > +   u32 val;
> > > +
> > > +   val = readl_relaxed(pll->base);
> > > +   val &= ~(1 << PLL_PD);
> > > +   writel_relaxed(val, pll->base);
> >
> > pll->base + PLL_CFG0 please.
>
> Same as above.
>
> >
> > > +static const struct clk_ops clk_sccg_pll1_ops = {
> > > +   .is_prepared    = clk_pll1_is_prepared,
> > > +   .recalc_rate    = clk_pll1_recalc_rate,
> > > +   .round_rate     = clk_pll1_round_rate,
> > > +   .set_rate       = clk_pll1_set_rate,
> > > +};
> > > +
> > > +static const struct clk_ops clk_sccg_pll2_ops = {
> > > +   .prepare        = clk_pll1_prepare,
> > > +   .unprepare      = clk_pll1_unprepare,
> > > +   .recalc_rate    = clk_pll2_recalc_rate,
> > > +   .round_rate     = clk_pll2_round_rate,
> > > +   .set_rate       = clk_pll2_set_rate,
> > > +};
> >
> > So these are two PLLs that share the same enable register. Doing the
> > prepare/unprepare for only one PLL can lead to all kinds of trouble.
> > Finding a good abstraction the properly handles this case with the
> > clock framework is probably also not easy.
> >
> > I could imagine we'll need to track the enable state on both PLLs and
> > only if both are disabled we disable it in hardware.
> >
> > With the current code we disable the PLLs when all consumers are
> > reparented to pll1, which probably has bad effects.
> >
>
> So it took me a while to understand exactly why this needs to stay like it is.
>

IMHO this means that, if nothing else, all of the below should be
documented in code as a comment, otherwise simpletons like me are
going to continue stumbling over it and wondering what's going on.

> The PLL1 is never used by any device, instead it is used as a source for PLL2.
>
> But because the interlink between the two of them is too complicated,
> the PLLs 1 and 2 need to be separate clocks.
>

Can you go a little bit more into detail as for why PLL1 needs to be
exposed in the first place and can't just be dealt with behind the
scenes as a part of PLL2 abstraction? Are there use-cases where the
rates of the two are going to be adjusted individually in Linux?

Thanks,
Andrey Smirnov
