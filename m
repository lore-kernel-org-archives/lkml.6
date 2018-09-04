Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F8DC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8B92073D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 19:31:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HxYmwMoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8B92073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbeIDX5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 19:57:30 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35777 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbeIDX5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 19:57:30 -0400
Received: by mail-wr1-f67.google.com with SMTP id j26-v6so5171435wre.2;
        Tue, 04 Sep 2018 12:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q8ouDdafIQ/yknlD0lc89RRtBiGiXMBHOVr1zYj7mgE=;
        b=HxYmwMoy8OC6VovGuyUKTLZBdUM/JlXr8qBSandBjECVPWjwWFKicVGJD8bLx8u1tX
         ObpWhQV6BFuWbQUuOw5MnyawcE2iju+sZsdvwzhiuzoIkaVUnWY9So2PgGNQy7dswJsy
         JqWsIqzhBpMziwdzWUX3rQxWnqLYb7I+aQ90gAjJ6w23sn/fqm1Q8pAudAjnHowedqAD
         +1EWTlZX9RMAYul0RNs8EHel5JEGLLt6rXVc1zUtdGMlGjcEIh1sQA1S1eX7w/iCcjAQ
         MY1qLAL5Tq8mbhsuIj2Hc8V+mtHztDLiFSIhyvG6s5m87dYunnhvS3iTzkaEtDp+iCb8
         gtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q8ouDdafIQ/yknlD0lc89RRtBiGiXMBHOVr1zYj7mgE=;
        b=TcEme3OTlXcqpKMgSE2dC2jDsisTObqPXsUiIag4S72c8uVbwJTwvosTcyoVZsOBz1
         wEZTWi+nvkLforZu/avfW769huMupHEFzzrW487jkl1+FUYNUHzqB1a/0+cVcLKDI8pc
         FxOwYlWO7MlqZLpu4w9xP6qt/B5cYX3bG8p5xZExB9ixeOSBCZsU2S/GtacHdZ9nQ9+Y
         egV7gT8eY0szNb0bvHxHQ/+Fu4hC9+goFNxGWxtlq4mZU0SwpjLprYhF67JFeYa0+ZFZ
         ONzXlq2mMSZRawZC/uwCWV6lmzMjHwoRSXHuBjuJt21vtsbGRaLyMxpIIQR6JhXjp4qU
         dOaw==
X-Gm-Message-State: APzg51BO2Z4ks5EhCoAzorDLJAk+5zbKVQExgBsfb9AAfDrenbZEgVgW
        aAeIyXQYcAqedm72D6eJQPRE91eJL0xPxZllq04=
X-Google-Smtp-Source: ANB0VdZVksYiZcsGEsDdY6MsLtWgPc1r5/pjZNUVLdlGLEqgDySdbRTSkuHiuabnkVyN1HCnGoocX6jtP+sawmZJJk8=
X-Received: by 2002:adf:db51:: with SMTP id f17-v6mr23413768wrj.212.1536089455789;
 Tue, 04 Sep 2018 12:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <1534945703-4730-1-git-send-email-abel.vesa@nxp.com>
 <1534945703-4730-4-git-send-email-abel.vesa@nxp.com> <20180824074011.lufm653imkf6fyd3@pengutronix.de>
 <20180828105821.gbd7tba7uvmeeqcx@fsr-ub1664-175> <CAHQ1cqEsHoF0ZFY5+CpQFJ+b3sKd3yJPvmRZMAbaa9+Xzhe3=g@mail.gmail.com>
 <20180904131341.ef7tvt6hvtkkpdhw@fsr-ub1664-175>
In-Reply-To: <20180904131341.ef7tvt6hvtkkpdhw@fsr-ub1664-175>
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
Date:   Tue, 4 Sep 2018 12:30:44 -0700
Message-ID: <CAHQ1cqFPUm5xnWGto5wRz2dMzxdWe4tAJwe0SxySmfnnkf9_Bg@mail.gmail.com>
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

On Tue, Sep 4, 2018 at 6:13 AM Abel Vesa <abel.vesa@nxp.com> wrote:
>
> On Tue, Aug 28, 2018 at 12:11:13PM -0700, Andrey Smirnov wrote:
> > On Tue, Aug 28, 2018 at 3:58 AM Abel Vesa <abel.vesa@nxp.com> wrote:
> > >
> > > On Fri, Aug 24, 2018 at 09:40:11AM +0200, Sascha Hauer wrote:
> > > > +Cc Andrey Smirnov who made me aware of this issue.
> > > >
> > > > On Wed, Aug 22, 2018 at 04:48:21PM +0300, Abel Vesa wrote:
> > > > > From: Lucas Stach <l.stach@pengutronix.de>
> > > > >
> > > > > The SCCG is a new PLL type introduced on i.MX8. Add support for this.
> > > > > The driver currently misses the PLL lock check, as the preliminary
> > > > > documentation mentions lock configurations, but is quiet about where
> > > > > to find the actual lock status signal.
> > > > >
> > > > > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > > > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > > > ---
> > > > > +static int clk_pll1_set_rate(struct clk_hw *hw, unsigned long rate,
> > > > > +                       unsigned long parent_rate)
> > > > > +{
> > > > > +   struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> > > > > +   u32 val;
> > > > > +   u32 divf;
> > > > > +
> > > > > +   divf = rate / (parent_rate * 2);
> > > > > +
> > > > > +   val = readl_relaxed(pll->base + PLL_CFG2);
> > > > > +   val &= ~(PLL_DIVF_MASK << PLL_DIVF1_SHIFT);
> > > > > +   val |= (divf - 1) << PLL_DIVF1_SHIFT;
> > > > > +   writel_relaxed(val, pll->base + PLL_CFG2);
> > > > > +
> > > > > +   /* FIXME: PLL lock check */
> > > >
> > > > Shouldn't be too hard to add, no?
> > >
> > > Added to the next version which I intend to send today.
> > >
> > > >
> > > > > +
> > > > > +   return 0;
> > > > > +}
> > > > > +
> > > > > +static int clk_pll1_prepare(struct clk_hw *hw)
> > > > > +{
> > > > > +   struct clk_sccg_pll *pll = to_clk_sccg_pll(hw);
> > > > > +   u32 val;
> > > > > +
> > > > > +   val = readl_relaxed(pll->base);
> > > > > +   val &= ~(1 << PLL_PD);
> > > > > +   writel_relaxed(val, pll->base);
> > > >
> > > > pll->base + PLL_CFG0 please.
> > >
> > > Same as above.
> > >
> > > >
> > > > > +static const struct clk_ops clk_sccg_pll1_ops = {
> > > > > +   .is_prepared    = clk_pll1_is_prepared,
> > > > > +   .recalc_rate    = clk_pll1_recalc_rate,
> > > > > +   .round_rate     = clk_pll1_round_rate,
> > > > > +   .set_rate       = clk_pll1_set_rate,
> > > > > +};
> > > > > +
> > > > > +static const struct clk_ops clk_sccg_pll2_ops = {
> > > > > +   .prepare        = clk_pll1_prepare,
> > > > > +   .unprepare      = clk_pll1_unprepare,
> > > > > +   .recalc_rate    = clk_pll2_recalc_rate,
> > > > > +   .round_rate     = clk_pll2_round_rate,
> > > > > +   .set_rate       = clk_pll2_set_rate,
> > > > > +};
> > > >
> > > > So these are two PLLs that share the same enable register. Doing the
> > > > prepare/unprepare for only one PLL can lead to all kinds of trouble.
> > > > Finding a good abstraction the properly handles this case with the
> > > > clock framework is probably also not easy.
> > > >
> > > > I could imagine we'll need to track the enable state on both PLLs and
> > > > only if both are disabled we disable it in hardware.
> > > >
> > > > With the current code we disable the PLLs when all consumers are
> > > > reparented to pll1, which probably has bad effects.
> > > >
> > >
> > > So it took me a while to understand exactly why this needs to stay like it is.
> > >
> >
> > IMHO this means that, if nothing else, all of the below should be
> > documented in code as a comment, otherwise simpletons like me are
> > going to continue stumbling over it and wondering what's going on.
>
> Will try to add proper comment to explain what's happening.
>
> >
> > > The PLL1 is never used by any device, instead it is used as a source for PLL2.
> > >
> > > But because the interlink between the two of them is too complicated,
> > > the PLLs 1 and 2 need to be separate clocks.
> > >
> >
> > Can you go a little bit more into detail as for why PLL1 needs to be
> > exposed in the first place and can't just be dealt with behind the
> > scenes as a part of PLL2 abstraction? Are there use-cases where the
> > rates of the two are going to be adjusted individually in Linux?
> >
>
> Here is the SCCG PLL Block Diagram:
>
> https://www.nxp.com/docs/en/reference-manual/IMX8MDQLQRM.pdf#page=834
>
> Now lets take the System PLL 2 for example. If you follow the hierarchy,
> when you reach the sys2_pll1_out you can see that one of its selectors is
> actually sys1_pll1_ref_sel. Same thing applies to sys3_pll2_out with
> sys2_pll1_ref_sel. This means there is an input reference clock interlinking
> between different System PLLs.
>

Hmm, I am not sure I see how this would prevent you from treating a
PLL pair as a black box, but OTOH, doing that probably wouldn't result
cleaner or simpler code. IMHO, it's unfortunate that PD bit is shared
between the two clocks, but if PLL1 could only be ever connected to
corresponding PLL2, then my concerns were probably misguided and
current implementation is good enough.

Thanks,
Andrey Smirnov
