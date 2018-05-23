Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754367AbeEWHh3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 03:37:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:50038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753992AbeEWHh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 03:37:27 -0400
Date: Wed, 23 May 2018 13:07:23 +0530
From: Vinod <vkoul@kernel.org>
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Ohad Ben-Cohen <ohad@wizery.com>,
        Sricharan R <sricharan@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Rohit kumar <rohitkr@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [RFC PATCH 5/5] remoteproc: qcom: Introduce Hexagon V5 based
 WCSS driver
Message-ID: <20180523073723.GF20991@vkoul-mobl>
References: <20180523052054.19025-1-bjorn.andersson@linaro.org>
 <20180523052054.19025-6-bjorn.andersson@linaro.org>
 <20180523060516.GD20991@vkoul-mobl>
 <20180523065815.GZ14924@minitux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523065815.GZ14924@minitux>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 23:58, Bjorn Andersson wrote:
> On Tue 22 May 23:05 PDT 2018, Vinod wrote:
> 
> > On 22-05-18, 22:20, Bjorn Andersson wrote:
> > 
> > > +static int q6v5_wcss_reset(struct q6v5_wcss *wcss)
> > > +{
> > > +	int ret;
> > > +	u32 val;
> > > +	int i;
> > > +
> > > +	/* Assert resets, stop core */
> > > +	val = readl(wcss->reg_base + QDSP6SS_RESET_REG);
> > > +	val |= Q6SS_CORE_ARES | Q6SS_BUS_ARES_ENABLE | Q6SS_STOP_CORE;
> > > +	writel(val, wcss->reg_base + QDSP6SS_RESET_REG);
> > > +
> > > +	/* BHS require xo cbcr to be enabled */
> > > +	val = readl(wcss->reg_base + QDSP6SS_XO_CBCR);
> > > +	val |= 0x1;
> > > +	writel(val, wcss->reg_base + QDSP6SS_XO_CBCR);
> > 
> > As commented on previous patch, it would help IMO to add a modify() wrapper
> > here which would perform read, modify and write.
> > 
> 
> Iirc the code ended up like this because a lot of these operations ended
> up being line wrapped and harder to read using some modify(reg, mask,
> val) helper. That said, the function isn't very pretty in it's current
> state either...

Agreed :) and i thought modify make help it make better

> One of the parts of the RFC is that this sequence is a verbatim copy
> from the qcom_q6v5_pil.c driver for 8996, so if we find this duplication
> suitable I would prefer that we keep them the same.
> 
> 
> The alternative to duplicating this function is as Sricharan proposed to
> have the qcom_q6v5_pil.c be both a driver for both the single-stage
> remoteproc and the two-stage (load boot loader, then modem firmware).
> 
> > Looking at the patch, few other comments would be applicable too, so would be
> > great if you/Sricharan can update this
> > 
> 
> I agree, the primary purpose of this patch was rather to get feedback on
> the structure of the drivers, I do expect this to take another round
> through the editor to get some polishing touches. Sorry if this wasn't
> clear from the description.

Since Sricharan replied to comments, I though they would be fixed. Yeah this is
fine from RFC..

-- 
~Vinod
