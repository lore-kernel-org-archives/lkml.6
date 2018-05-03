Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751351AbeECREN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 13:04:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:38422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750947AbeECREJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 13:04:09 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, Taniya Das <tdas@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <d687230c-1178-41e4-d8e3-2c3957affb4a@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1525258277-3478-1-git-send-email-tdas@codeaurora.org>
 <1525258277-3478-3-git-send-email-tdas@codeaurora.org>
 <152527500426.138124.18419525952886399750@swboyd.mtv.corp.google.com>
 <d687230c-1178-41e4-d8e3-2c3957affb4a@codeaurora.org>
Message-ID: <152536704820.138124.12887560717683281434@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 2/2] clk: qcom: clk-rpmh: Add QCOM RPMh clock driver
Date: Thu, 03 May 2018 10:04:08 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w43H4JvL003085

Quoting Taniya Das (2018-05-03 03:33:10)
> Hello Stephen,
> 
> Thanks for review.
> 
> On 5/2/2018 9:00 PM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-05-02 03:51:17)
> >> +               ret = devm_clk_hw_register(&pdev->dev, hw_clks[i]);
> >> +               if (ret) {
> >> +                       dev_err(&pdev->dev, "failed to register %s\n",
> >> +                                       hw_clks[i]->init->name);
> >> +                       goto err;
> >> +               }
> >> +
> >> +               rpmh_clk->dev = &pdev->dev;
> >> +       }
> >> +
> >> +       ret = devm_of_clk_add_hw_provider(&pdev->dev, of_clk_rpmh_hw_get,
> >> +                                     (void *) desc);
> > 
> > Drop the void cast.
> > 
> 
> I see a compiler warning, that is the reason to keep the void cast.
> /include/linux/clk-provider.h:881:5: note: expected ‘void *’ but 
> argument is of type ‘const struct clk_rpmh_desc *’

Ok. Casting away const is not good though. Can you pass a pointer to the
hw_clks array instead?
