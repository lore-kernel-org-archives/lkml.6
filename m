Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751346AbeDEXRo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 19:17:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750786AbeDEXRm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 19:17:42 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C212075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Evan Green <evgreen@chromium.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <65abfb98-802a-d7aa-5213-9fcd531b18d9@codeaurora.org>
Cc: sboyd@codeaurora.org, mturquette@baylibre.com,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>, okukatla@codeaurora.org,
        anischal@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, collinsd@codeaurora.org
References: <1522304274-18989-1-git-send-email-tdas@codeaurora.org>
 <1522304274-18989-2-git-send-email-tdas@codeaurora.org>
 <CAE=gft6-FggNjP0nj6XrLN1rQqnep_PHHWg2fiRUrM8ZBf36Sg@mail.gmail.com>
 <65abfb98-802a-d7aa-5213-9fcd531b18d9@codeaurora.org>
Message-ID: <152297026107.143116.8868825918169537109@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Thu, 05 Apr 2018 16:17:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-04-02 03:33:26)
> 
> > 
> >> +
> >> +#include "common.h"
> >> +#include "clk-regmap.h"
> >> +
> >> +#define CLK_RPMH_ARC_EN_OFFSET 0
> >> +#define CLK_RPMH_VRM_EN_OFFSET 4
> >> +#define CLK_RPMH_VRM_OFF_VAL 0
> >> +#define CLK_RPMH_VRM_ON_VAL 1
> >> +#define CLK_RPMH_APPS_RSC_AO_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
> >> +                                        BIT(RPMH_ACTIVE_ONLY_STATE))
> >> +#define CLK_RPMH_APPS_RSC_STATE_MASK (BIT(RPMH_WAKE_ONLY_STATE) | \
> >> +                                     BIT(RPMH_ACTIVE_ONLY_STATE) | \
> >> +                                     BIT(RPMH_SLEEP_STATE))
> >> +struct clk_rpmh {
> >> +       const char *res_name;
> >> +       u32 res_addr;
> >> +       u32 res_en_offset;
> >> +       u32 res_on_val;
> >> +       u32 res_off_val;
> >> +       u32 state;
> >> +       u32 aggr_state;
> >> +       u32 last_sent_aggr_state;
> >> +       u32 valid_state_mask;
> >> +       struct rpmh_client *rpmh_client;
> >> +       unsigned long rate;
> >> +       struct clk_rpmh *peer;
> >> +       struct clk_hw hw;
> > 
> > I believe this member should go at the beginning of the structure. At least
> > that's what everyone else seems to do, and that's what the clk.txt
> > documentation seems to ask for.
> >
> 
> Yes I missed that, would update it in the next patch series.

Where is the documentation asking for that? There isn't any place that
clk_hw should be in a structure. container_of() can figure it out all
the time, and that macro is preferred instead of plain casts from one
type to another because it provides slightly more type safety.
