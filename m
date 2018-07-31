Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F86C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB86120857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 09:05:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB86120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbeGaKpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 06:45:01 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:42623 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729485AbeGaKpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 06:45:01 -0400
Received: by mail-lj1-f194.google.com with SMTP id f1-v6so13031801ljc.9;
        Tue, 31 Jul 2018 02:05:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FgzWi46WpfLB+PSiihEHOfj0GWI5tGycFpZqthbWlLA=;
        b=IMHyBQYNHHJdmg/13+fbYf3MSa+xSUJ6wTW+UiCQ/t69N8hdRNjEAZ7vIRsvNsVLEO
         qx5mhR/YPKCYLDNGOsU1siPvGNfDzKOhZgnxGUyMtAr6B3zq/FNoneGd4shjhRZSVt5b
         TQyszfjf8M0OOZJRa50IelAFuaSbtSvMZwOIA7gy0fJdsBhj9l7apT5Wgu4G9vkJt4b8
         IE1UI80TCq/4puWLF0jSqm6yABjXaASK4+IjWXVDzFp0puTWf7Mexcf5QyhAobm/G637
         b5khFf4SFFP+XoPAhpSYNZCbPYaG/liD3FI7XsxrAA13X5LVKbxCUtu4EGBCOOP/6lAF
         je9A==
X-Gm-Message-State: AOUpUlFX67mQOcwGtxKyV5a9aTSojjCvX5T5WuTaJF1gMCO4qdtsB25S
        VginE7bnTStyjgCy4C6/R3M=
X-Google-Smtp-Source: AAOMgpcE7DN8fuaoyd0z/qhWeZk/y1AdXs17CiSCQXre/QbiKUWm/4k2OBGQ6ik7GO/hHMV2zQtc+g==
X-Received: by 2002:a2e:429c:: with SMTP id h28-v6mr15272561ljf.67.1533027939739;
        Tue, 31 Jul 2018 02:05:39 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id o4-v6sm2470115ljc.67.2018.07.31.02.05.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 02:05:39 -0700 (PDT)
Date:   Tue, 31 Jul 2018 12:05:36 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>, broonie@kernel.org,
        lee.jones@linaro.org, lgirdwood@gmail.com, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mikko.mutanen@fi.rohmeurope.com,
        heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v5 4/4] clk: bd71837: Add driver for BD71837 PMIC clock
Message-ID: <20180731090536.GB2956@localhost.localdomain>
References: <cover.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <d99c8762b0fbbcb18ec4f4d104191364c0ea798c.1528117485.git.matti.vaittinen@fi.rohmeurope.com>
 <152878945117.16708.12422348324182290971@swboyd.mtv.corp.google.com>
 <20180612082354.GG20078@localhost.localdomain>
 <20180613130338.GH20078@localhost.localdomain>
 <152997038474.143105.3390705878521933864@swboyd.mtv.corp.google.com>
 <20180627084000.GE2118@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180627084000.GE2118@localhost.localdomain>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Again,

On Wed, Jun 27, 2018 at 11:40:00AM +0300, Matti Vaittinen wrote:
> Hello Stephen,
> 
> On Mon, Jun 25, 2018 at 04:46:24PM -0700, Stephen Boyd wrote:
> > Quoting Matti Vaittinen (2018-06-13 06:03:38)
> > > On Tue, Jun 12, 2018 at 11:23:54AM +0300, Matti Vaittinen wrote:
> > > > 
> > > > I see. This makes sense. I need to verify from HW colleagues whether
> > > > this chip has internal oscillator or not. I originally thought we have
> > > > on-chip oscillator - but as you say, we do have XIN pin in documentation.
> > > > So now I am not sure if the test board I have contains oscillator driving
> > > > the clk on PMIC - or if the PMIC has internal oscillator. I'll clarify this.
> > > 
> > > It really turned out that the PMIC just acts as a clock buffer. So I do
> > > as you suggested and add lookup for parent clock to the driver. I
> > > planned to do it so that if no parent is found from DT - then we assume
> > > the 32.768KHz clock (as described in documentation). Eg, something along
> > > the lines:
> > > 
> > >         init.parent_names = of_clk_get_parent_name(pdev->dev.parent->of_node, 0);
> > >         if (init.parent_names) {
> > >                 init.num_parents = 1;
> > >         } else {
> > >                 /* If parent is not given from DT we assume the typical use-case with
> > >                  * 32.768 KHz oscillator for RTC (Maybe we could just error out here?)
> > >                  */
> > >                 c->rate = BD71837_CLK_RATE;
> > >                 bd71837_clk_ops.recalc_rate = &bd71837_clk_recalc_rate;
> > >         }
> > 
> > You can also add a clk directly in this driver in that case there isn't
> > one in DT with the rate and name of your choosing. Then the logic is the
> > same and we don't need a c->rate variable.
> 
> So you mean that I should use clk_hw_register_fixed_rate and create new
> clk if parent is not found? Isn't this a bit of an overkill? Downside is
> that then we do need remove/cleanup functionality for deleting this
> parent clock - and I didn't find devm support for fixed clock. Furthermore
> I guess that since it is parent, it can't be removed before child is removed.
> 
> Or did you mean something else but creating a fixed rate clock as parent
> here?

I would be grateful for any tips on how to proceed. Should I

1. Really create a fixed rate clock - and build cleanup sequence myself
2. Keep this simple and fail if no parent is found using of_clk_get_parent_name

Best regards
    Matti Vaittinen
