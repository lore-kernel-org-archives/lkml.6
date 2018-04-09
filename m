Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753725AbeDIDWw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 23:22:52 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:40920 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeDIDWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 23:22:47 -0400
X-Google-Smtp-Source: AIpwx4+s9XGUJsrGMqX+KQSySj713vzLDc9vPFQMX+Qr4pBnsTDGAJGH5Gk2tjJuOwcTe+8AZf4BJA==
Date: Mon, 9 Apr 2018 08:52:43 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Stephen Boyd <swboyd@chromium.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        ulf.hansson@linaro.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] PM / OPP: Add dev_pm_opp_get_of_node()
Message-ID: <20180409032243.GA7671@vireshk-i7>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-2-rnayak@codeaurora.org>
 <152310602935.180276.13934458024242240384@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152310602935.180276.13934458024242240384@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-04-18, 06:00, Stephen Boyd wrote:
> Quoting Rajendra Nayak (2018-03-15 21:08:18)
> > From: Viresh Kumar <viresh.kumar@linaro.org>
> > 
> > This adds a new helper to let the power domain drivers to access
> > opp->np, so that they can read platform specific properties from the
> > node.
> > 
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> > ---
> 
> Are there two versions of this patch floating around?

Yeah, I will carry this patch in my series now going forward.

> >  drivers/opp/of.c       | 19 +++++++++++++++++++
> >  include/linux/pm_opp.h |  5 +++++
> >  2 files changed, 24 insertions(+)
> > 
> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> > index 21265af55117..b17715bc3c0a 100644
> > --- a/drivers/opp/of.c
> > +++ b/drivers/opp/of.c
> > @@ -736,3 +736,22 @@ struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev,
> >         return opp;
> >  }
> >  EXPORT_SYMBOL_GPL(of_dev_pm_opp_find_required_opp);
> > +
> > +/**
> > + * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
> > + * @opp:       opp for which DT node has to be returned for
> > + *
> > + * Return: DT node corresponding to the opp, else 0 on success.
> > + *
> > + * The caller needs to put the node of_node_put() after using it.
> 
> put the node with of_node_put()

Fixed it up, thanks.

-- 
viresh
