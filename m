Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752908AbeBFTAq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 14:00:46 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:33852 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeBFTAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 14:00:37 -0500
X-Google-Smtp-Source: AH8x224gb8mcfIIMQRtcm5u0exFRuFjg565AuOyH48U+aK+gwH6roHFpgNOPmPj8WTXJQq3gXtTW2g==
Date: Tue, 6 Feb 2018 11:00:34 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rajendra Nayak <rnayak@codeaurora.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>, andy.gross@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: sdm845: Add serial console support
Message-ID: <20180206190034.GK9465@builder>
References: <20180125163216.29018-1-rnayak@codeaurora.org>
 <20180125163216.29018-3-rnayak@codeaurora.org>
 <20180126221808.GE28313@codeaurora.org>
 <086251c4-b012-236c-33e2-9cab551a4594@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <086251c4-b012-236c-33e2-9cab551a4594@codeaurora.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 29 Jan 00:18 PST 2018, Rajendra Nayak wrote:
> On 01/27/2018 03:48 AM, Stephen Boyd wrote:
> > On 01/25, Rajendra Nayak wrote:
> >> diff --git a/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> new file mode 100644
> >> index 000000000000..b97f99e6f4b4
> >> --- /dev/null
> >> +++ b/arch/arm64/boot/dts/qcom/sdm845-pins.dtsi
> >> @@ -0,0 +1,32 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Copyright (c) 2018, The Linux Foundation. All rights reserved.
> >> + */
> >> +
> >> +&tlmm {
> > 
> > I'm not the maintainer, but I find this approach to the pins
> > really annoying. I have to flip to another file to figure out how
> > a board has configured the pins. And we may bring in a bunch of
> > settings that we don't ever use on some board too. Why can't we
> > put the settings in the board file directly?
> 
> I was just keeping it consistent with how things are for other
> qualcomm platforms. I can move this to the board dts if no one else
> sees any issues.
> 

What we decided recently for 8916 (at least) was that we define the
functional properties in the soc dtsi and add the electrical properties
in the board dts(i).

I fully agree with Stephen on this one, but as you say we're keeping the
pinconf in separate files for the other platforms/boards.


I'll prepare and bring some new guidelines to our Thursday meeting and
we can decide what to do based on that.

Regards,
Bjorn
