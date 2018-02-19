Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeBSRa1 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 12:30:27 -0500
Received: from vern.gendns.com ([206.190.152.46]:50523 "EHLO vern.gendns.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753353AbeBSRaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 12:30:25 -0500
Subject: Re: [v2,7/8] clk: divider: read-only divider can propagate rate
 change
To: Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180214134340.17242-8-jbrunet@baylibre.com>
From: David Lechner <david@lechnology.com>
Message-ID: <f1d4688b-87ce-01df-ab94-72bf20579330@lechnology.com>
Date: Mon, 19 Feb 2018 11:30:38 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180214134340.17242-8-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - vern.gendns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lechnology.com
X-Get-Message-Sender-Via: vern.gendns.com: authenticated_id: davidmain+lechnology.com/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: vern.gendns.com: davidmain@lechnology.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2018 07:43 AM, Jerome Brunet wrote:
> When a divider clock has CLK_DIVIDER_READ_ONLY set, it means that the
> register shall be left un-touched, but it does not mean the clock
> should stop rate propagation if CLK_SET_RATE_PARENT is set
> 
> This is properly handled in qcom clk-regmap-divider but it was not in
> the generic divider
> 
> To fix this situation, introduce a new helper function
> divider_ro_round_rate, on the same model as divider_round_rate.
> 
> Fixes: e6d5e7d90be9 ("clk-divider: Fix READ_ONLY when divider > 1")
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---

Working for me with the davinci clk drivers I am developing.

Tested-By: David Lechner <david@lechnology.com>
