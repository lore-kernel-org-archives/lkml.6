Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbeEJSqE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:46:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:51956 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750881AbeEJSqC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:46:02 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180413203336.134364-1-evgreen@chromium.org>
Cc: Evan Green <evgreen@chromium.org>
References: <20180413203336.134364-1-evgreen@chromium.org>
Message-ID: <152597796114.138124.13981585478071012245@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: Base rcg parent rate off plan frequency
Date: Thu, 10 May 2018 11:46:01 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4AIkApt005227

Quoting Evan Green (2018-04-13 13:33:36)
> _freq_tbl_determine_rate uses the pre_div found in the clock plan
> multiplied by the requested rate from the caller to determine the
> best parent rate to set. If the requested rate is not exactly equal
> to the rate that was found in the clock plan, then using the requested
> rate in parent rate calculations is incorrect. For instance, if 150MHz
> was requested, but 200MHz was the match found, and that plan had a
> pre_div of 3, then the parent should be set to 600MHz, not 450MHz.
> 
> Signed-off-by: Evan Green <evgreen@chromium.org>
> ---

Applied to clk-next

This problem is ancient so I tagged it with Fixes for all the stable
trees.
