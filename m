Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 74560C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1662F20020
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MMtczSr7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1662F20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935603AbeFMNDq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:03:46 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38851 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935287AbeFMNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:03:44 -0400
Received: by mail-lf0-f66.google.com with SMTP id i83-v6so3827386lfh.5;
        Wed, 13 Jun 2018 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QEfaVHY0s3/6EHu3ee7WW9ty9IvcWglQzmTFvWkY5AQ=;
        b=MMtczSr7Uanle1OBmVvz7IVlBrtjNeF+BONC5TTi6GHC37Hn+YnjtXied7Y0C9ET6r
         pBkRlXmqfuCfDHIxo8DGKWAxccpBI7HVnSCd9GrJ3nKYvL4jWgDMNQ7l45t8sG5ZPevc
         FgIA4nw7w6eZzukK/XyloVvl7+PJHm1FOgcqepB2A9lqlU0+5/5tTQuwVGw75ZBO0UaR
         WzvCq+qIcwoEHS0MFFUJ079grsbOOtEOZ1wIoMkGGyzh4LQ1AHWewfQVGt05DN0pBsOw
         lkBoOqaxXWT6tKpdtFB3ImzO/9sWx3GGoBspznrSGcdQfyLSxpTdNHq1zsFDohlO/3EB
         RETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEfaVHY0s3/6EHu3ee7WW9ty9IvcWglQzmTFvWkY5AQ=;
        b=ARFC5PxJx1CQV6tYzGZmwO1JCVAz67fzw5ZNbI2qE/ihMLDPAeV82T4gZoitCnA75k
         xAKSBN7pAyv/sT9H5QeA6n4PuptMTMhkrx+vB1ttXO518LUhkHmBuIgGDKBQoNSaqH2a
         u8BS2b/f5FqG66+ZvH77vygRy/NCyo4RAGJIZHiwY3dok/k810Gt76qgD3ztIzysk2EO
         0ntEKuh0d6zhu1od/gGvqTpqYjM06Yq5F8rGeMUQT5xl69ASOv1RnMI1zts1jcl1pCGR
         n9c6CLmd9byzmeyC5W/LhNGwRJX+0AfAKK5+1Zce1yPIOcsmiIW7wHXhD8dmBQaXOj9K
         zfag==
X-Gm-Message-State: APt69E1qPM4DkTLBMRRCjcGiUfkUMoRHcdQBz3CrJPkU2YZQMpOkmux/
        tqs6DNzJlGoJU7DM6/xjyhY=
X-Google-Smtp-Source: ADUXVKJudubA8zJM7m3F94GMF6enYxfQ4fgL38OkscvBmHZPwQJL0O4w5CsJvLuVBLakthF9PHVWxw==
X-Received: by 2002:a19:ef11:: with SMTP id n17-v6mr3305898lfh.66.1528895022461;
        Wed, 13 Jun 2018 06:03:42 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.34])
        by smtp.gmail.com with ESMTPSA id e21-v6sm515779ljj.95.2018.06.13.06.03.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jun 2018 06:03:41 -0700 (PDT)
From:   Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date:   Wed, 13 Jun 2018 16:03:38 +0300
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        broonie@kernel.org, lee.jones@linaro.org, lgirdwood@gmail.com,
        mark.rutland@arm.com, mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180613130338.GH20078@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612082354.GG20078@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 12, 2018 at 11:23:54AM +0300, Matti Vaittinen wrote:
> Hello Stephen,
> 
> Thanks again for the review. I'll do new patch which fixes these issues.
> 
> On Tue, Jun 12, 2018 at 12:44:11AM -0700, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-06-04 06:19:13)
> > > +}
> > > +
> > > +static unsigned long bd71837_clk_recalc_rate(struct clk_hw *hw,
> > > +                                            unsigned long parent_rate)
> > > +{
> > > +       struct bd71837_clk *c = container_of(hw, struct bd71837_clk, hw);
> > > +
> > > +       return c->rate;
> > > +}
> > > +
> > > +static const struct clk_ops bd71837_clk_ops = {
> > > +       .recalc_rate = &bd71837_clk_recalc_rate,
> > > +       .prepare = &bd71837_clk_enable,
> > > +       .unprepare = &bd71837_clk_disable,
> > > +       .is_prepared = &bd71837_clk_is_enabled,
> > > +};
> > > +
> > > +static int bd71837_clk_probe(struct platform_device *pdev)
> > > +{
> > > +       struct bd71837_clk *c;
> > > +       int rval = -ENOMEM;
> > > +       struct bd71837 *mfd = dev_get_drvdata(pdev->dev.parent);
> > > +       struct clk_init_data init = {
> > > +               .name = "bd71837-32k-out",
> > > +               .ops = &bd71837_clk_ops,
> > > +       };
> > > +
> > > +       c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
> > > +       if (!c)
> > > +               goto err_out;
> > > +
> > > +       c->reg = BD71837_REG_OUT32K;
> > > +       c->mask = BD71837_OUT32K_EN;
> > > +       c->rate = BD71837_CLK_RATE;
> > 
> > The PMIC has an 'XIN' pin that would be the clk input for this chip, and
> > the output clk, this driver, would specify that xin clock as the parent.
> > The 'xin' clock would then be listed in DT as a fixed-rate clock. That
> > way this driver doesn't hardcode the frequency.
> 
> I see. This makes sense. I need to verify from HW colleagues whether
> this chip has internal oscillator or not. I originally thought we have
> on-chip oscillator - but as you say, we do have XIN pin in documentation.
> So now I am not sure if the test board I have contains oscillator driving
> the clk on PMIC - or if the PMIC has internal oscillator. I'll clarify this.

It really turned out that the PMIC just acts as a clock buffer. So I do
as you suggested and add lookup for parent clock to the driver. I
planned to do it so that if no parent is found from DT - then we assume
the 32.768KHz clock (as described in documentation). Eg, something along
the lines:

        init.parent_names = of_clk_get_parent_name(pdev->dev.parent->of_node, 0);
        if (init.parent_names) {
                init.num_parents = 1;
        } else {
                /* If parent is not given from DT we assume the typical use-case with
                 * 32.768 KHz oscillator for RTC (Maybe we could just error out here?)
                 */
                c->rate = BD71837_CLK_RATE;
                bd71837_clk_ops.recalc_rate = &bd71837_clk_recalc_rate;
        }

Does this make sense?

Br,
    Matti Vaittinen 
