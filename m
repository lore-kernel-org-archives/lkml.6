Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9FD62098A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:18:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OGA1CVwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9FD62098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbeIYBVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:21:47 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:46408 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730681AbeIYBVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:21:47 -0400
Received: by mail-io1-f65.google.com with SMTP id y12-v6so18494904ioj.13;
        Mon, 24 Sep 2018 12:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=EhO0/3mSuRoG627z5xnGrgaF/Hb/lTjMYfYD0g75Ctg=;
        b=OGA1CVwi5MLh5ynp02rtK5I3KmZNhfrQlwOR84lNthjcDgQdmiVZmdIup5K9qHozws
         cHAoHj/995/3Vd+mH/5KqWwZrYxMMPax9jnTrz1Rc14BM1A9d1anyEN5SUWKmsbIqYXb
         a7l8kYPfyJAr1FSy8FhNK6zhBWT3nseiJJNyv/4l/d+ATq6soG9H2Uw7bYHGYAxIYPHi
         /MlqShHqVRUT8sEHH+oYmAYZyuudwzXrqhmqaRVwlw9bWn8z3rOTMhacu33tZPfwu0U+
         xcL/IeEXbn8jFsbKouo+HFyEEXhJ0Z14FoiWyooK7As6NmRG/VQAlLFZkjMD2NEPUErm
         996g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=EhO0/3mSuRoG627z5xnGrgaF/Hb/lTjMYfYD0g75Ctg=;
        b=UHqImH5WP2xJTGqPdJWlEno2BWSOWR+CM/n3DWkg6TYughdVq7Rp0AoHqrvpRArlz/
         0wrsSOCSp2GLrPEJbOSEVndqethWprcadOMbu02Prr+tmBK1b4RrlFDhIBlOOOJ7ai8Y
         cfhhVG021wyZbpFUq9Pq2T/HxIEmHBCX3mZsiBIdKdLRbqQ3M+Me51CfAQpvzZMxjKHg
         mI9aP2aQhZUppzTpgsoFEZJqXWQuaOC49kM8g6w6o70LszUreQLaJyGAmnm/wNAZD6jJ
         uZ4Kr7YzbFxMsMUM6/CrQQHfNeC2GLjIoR62vG0Gv4Nw3vdVu7x0mHJq8OSjf4yq+7i2
         ITlQ==
X-Gm-Message-State: ABuFfojvPpnOnoY2uddyBtnDQVhIft+2tfBbzl5Y1rnPPKJSn9se2OxU
        RhP/v8EUQdldALnap1wOnA==
X-Google-Smtp-Source: ACcGV608xHdv4lb81rTCjm8iIulQ5hl9ByRnHT0VjlJkIsE6RrnhWYXTP9DXZG567Sj35HRBvh5Dog==
X-Received: by 2002:a6b:b955:: with SMTP id j82-v6mr251545iof.158.1537816688484;
        Mon, 24 Sep 2018 12:18:08 -0700 (PDT)
Received: from r (CPE1cabc0918a93-CM1cabc0918a90.cpe.net.cable.rogers.com. [99.229.26.117])
        by smtp.gmail.com with ESMTPSA id o127-v6sm2754852itg.24.2018.09.24.12.18.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Sep 2018 12:18:07 -0700 (PDT)
Date:   Mon, 24 Sep 2018 15:18:04 -0400
From:   r yang <decatf@gmail.com>
To:     Peter De Schrijver <pdeschrijver@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: tegra: Return the exact clock rate from
 clk_round_rate
Message-ID: <20180924191804.GA20060@r>
References: <20180921220149.17136-1-decatf@gmail.com>
 <20180924080803.GF7636@tbergstrom-lnx.Nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180924080803.GF7636@tbergstrom-lnx.Nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 11:08:03AM +0300, Peter De Schrijver wrote:
> On Fri, Sep 21, 2018 at 06:01:49PM -0400, ryang wrote:
> > The current behavior is that clk_round_rate would return the same clock
> > rate passed to it for valid PLL configurations. This change will return
> > the exact rate the PLL will provide in accordance with clk API.
> > 
> > Signed-off-by: ryang <decatf@gmail.com>
> > ---
> >  drivers/clk/tegra/clk-pll.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/tegra/clk-pll.c b/drivers/clk/tegra/clk-pll.c
> > index 17a058c3bbc1..36014a6ec42e 100644
> > --- a/drivers/clk/tegra/clk-pll.c
> > +++ b/drivers/clk/tegra/clk-pll.c
> > @@ -595,7 +595,12 @@ static int _calc_rate(struct clk_hw *hw, struct tegra_clk_pll_freq_table *cfg,
> >  		return -EINVAL;
> >  	}
> >  
> > -	cfg->output_rate >>= p_div;
> > +	if (cfg->m == 0) {
> > +		cfg->output_rate = 0;
> 
> I think a WARN_ON() is appropriate here. the input divider should never be 0.
> 
> Peter.
> 

Should it return -EINVAL (or some error) too? _calc_rate is also in the
clk_set_rate code path. I think we want to avoid programming the
register to 0 input divider all together?

> > +	} else {
> > +		cfg->output_rate = cfg->n * DIV_ROUND_UP(parent_rate, cfg->m);
> > +		cfg->output_rate >>= p_div;
> > +	}
> >  
> >  	if (pll->params->pdiv_tohw) {
> >  		ret = _p_div_to_hw(hw, 1 << p_div);
> > -- 
> > 2.17.1
> > 
