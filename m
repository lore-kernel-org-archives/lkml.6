Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E719C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2CF6208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 08:29:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2CF6208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729725AbeGaKIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:08:21 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35901 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbeGaKIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:08:21 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so12967355lji.3;
        Tue, 31 Jul 2018 01:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=85gcoFQHtyO7OqtRdDr1CISGZDAMXVdmWKkPHOGAw20=;
        b=KnjBFcloCvUnQtMVhK98X8vFJ/tuWsDulqU0XG594LvzQDL2fUORthDwkksWsXb5Qf
         kUpRrlrEWAiYJkl5XndEyY/P5Q8w2oOsjYlQEbsWLRBKEQOZ9cnjxnPfW8b1hANB9S5F
         b2DNCxwmHPK/7uMydJWkzeEWelNnT70uufVBT+YLPrkRgWYsHEdgeNwvhnK4fzCqrKyy
         1mhwZuAHcHG0eUAZPMMKjxEhTNwKtbw4ZfHWrOCJAzMcnvmSncRJTR1OlVZd0cdfYhZO
         sVDvWUhk08rLBJOMXz30CSEKmbgEA+6xkcwKz0zW/hivNW5OvTCDesRNLLp8kNUaKJin
         vjzQ==
X-Gm-Message-State: AOUpUlEoLoq/eFd6RIgj0YF0kvTeM5+SsOIySUl6L/baHjMFFQ+OI4r/
        B33Ad4cCL/X5rYKfT0JtwBI=
X-Google-Smtp-Source: AAOMgpcNbJaq9AWhYj5jU/3Q0z6GLwq8ygRy19u0upNB/Dc14RApMAJ/NEi/SOG4oZRt97jBJoykxQ==
X-Received: by 2002:a2e:7014:: with SMTP id l20-v6mr16180889ljc.141.1533025747251;
        Tue, 31 Jul 2018 01:29:07 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id g2-v6sm1892972lfb.52.2018.07.31.01.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 01:29:06 -0700 (PDT)
Date:   Tue, 31 Jul 2018 11:28:58 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>, robh+dt@kernel.org
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>, broonie@kernel.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180731073023.GA2956@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
 <152997029783.143105.16692843405899913246@swboyd.mtv.corp.google.com>
 <20180626081319.GA2118@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180626081319.GA2118@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2018 at 11:13:19AM +0300, Matti Vaittinen wrote:
> On Mon, Jun 25, 2018 at 04:44:57PM -0700, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-06-12 01:23:54)
> > > On Tue, Jun 12, 2018 at 12:44:11AM -0700, Stephen Boyd wrote:
> > > > Quoting Matti Vaittinen (2018-06-04 06:19:13)

[snip]

> > > > > +       if (rval) {
> > > > > +               dev_err(&pdev->dev, "failed to register clkdev for bd71837");
> > > > > +               goto err_clean_provider;
> > > > > +       }
> > > > > +
> > > > > +       platform_set_drvdata(pdev, c);
> > > > > +
> > > > > +       return 0;
> > > > > +
> > > > > +err_clean_provider:
> > > > > +       of_clk_del_provider(pdev->dev.parent->of_node);
> > > > > +err_out:
> > > > > +       return rval;
> > > > > +}
> > > > > +
> > > > > +static int bd71837_clk_remove(struct platform_device *pdev)
> > > > > +{
> > > > > +       if (pdev->dev.parent->of_node)
> > > > > +               of_clk_del_provider(pdev->dev.parent->of_node);
> > > > 
> > > > Use devm so this can go away. Or is devm not used because the parent
> > > > of_node is the provider? That's annoying.
> > > 
> > > What would be the correct workaround for this?
> > 
> > Smash the clk driver into the overall PMIC node. That should work. Or
> > possibly assign the same of_node to the child device when creating it?
> > I'm not sure if that causes some sort of problem with DT code though, so
> > it would be good to check with Rob H if that's a bad idea or not.
> 
> 1. Assign MFD node to subdevice node in MFD when creating the cells.
> 2. Assign parent->of_node to dev.of_node in clk subdevice.
> 3. Create devm_of_clk_add_hw_provider_w_node() which does something
> like (not compiled pseudo) code below
> 
> int devm_of_clk_add_hw_provider_w_node(struct device *dev,
> 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> 					      void *data),
> 			struct device_node *of_node,
> 			void *data)
> {
> 	struct device_node **ptr;
> 	int ret;
> 	ptr = devres_alloc(devm_of_clk_release_provider, sizeof(*ptr),
> 			   GFP_KERNEL);
> 	if (!ptr)
> 		return -ENOMEM;
> 
> 	*ptr = of_node;
> 	ret = of_clk_add_hw_provider(of_node, get, data);
> 	if (!ret)
> 		devres_add(dev, ptr);
> 	else
> 		devres_free(ptr);
> 
> 	return ret;
> }
> EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider_w_node);
> 
> int devm_of_clk_add_hw_provider(struct device *dev,
> 			struct clk_hw *(*get)(struct of_phandle_args *clkspec,
> 					      void *data),
> 			void *data)
> {
> 	return devm_of_clk_add_hw_provider_w_node(dev, get, dev->of_node,
> 						  data);
> }
> EXPORT_SYMBOL_GPL(devm_of_clk_add_hw_provider);

just a friendly reminder, what's your opinion on adding this kind of
function (devm_of_clk_add_hw_provider_w_node)? or solutions 1/2? And are these options safe what comes to
reference counting of of_nodes?

Best regards
	Matti Vaittinen
