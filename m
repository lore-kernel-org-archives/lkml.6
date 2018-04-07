Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751804AbeDGNAd (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 09:00:33 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40929 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751494AbeDGNAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 09:00:31 -0400
X-Google-Smtp-Source: AIpwx4/cn51aQ8SQnCuiVvESVjScmrj8i0OpeeAgiaIevBzJy4ejxuf1zbsFselF+UlqZtx6mAFTDw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Rajendra Nayak <rnayak@codeaurora.org>, andy.gross@linaro.org,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org
From: Stephen Boyd <swboyd@chromium.org>
In-Reply-To: <20180316040824.21472-2-rnayak@codeaurora.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>
References: <20180316040824.21472-1-rnayak@codeaurora.org>
 <20180316040824.21472-2-rnayak@codeaurora.org>
Message-ID: <152310602935.180276.13934458024242240384@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/7] PM / OPP: Add dev_pm_opp_get_of_node()
Date: Sat, 07 Apr 2018 06:00:29 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w37D0e3Y020229

Quoting Rajendra Nayak (2018-03-15 21:08:18)
> From: Viresh Kumar <viresh.kumar@linaro.org>
> 
> This adds a new helper to let the power domain drivers to access
> opp->np, so that they can read platform specific properties from the
> node.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> ---

Are there two versions of this patch floating around?

>  drivers/opp/of.c       | 19 +++++++++++++++++++
>  include/linux/pm_opp.h |  5 +++++
>  2 files changed, 24 insertions(+)
> 
> diff --git a/drivers/opp/of.c b/drivers/opp/of.c
> index 21265af55117..b17715bc3c0a 100644
> --- a/drivers/opp/of.c
> +++ b/drivers/opp/of.c
> @@ -736,3 +736,22 @@ struct dev_pm_opp *of_dev_pm_opp_find_required_opp(struct device *dev,
>         return opp;
>  }
>  EXPORT_SYMBOL_GPL(of_dev_pm_opp_find_required_opp);
> +
> +/**
> + * dev_pm_opp_get_of_node() - Gets the DT node corresponding to an opp
> + * @opp:       opp for which DT node has to be returned for
> + *
> + * Return: DT node corresponding to the opp, else 0 on success.
> + *
> + * The caller needs to put the node of_node_put() after using it.

put the node with of_node_put()
