Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753326AbeDRXbs convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 19:31:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:51826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753050AbeDRXbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 19:31:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 647B120853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Amit Nischal <anischal@codeaurora.org>,
        Manu Gautam <mgautam@codeaurora.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <23b9ca5a-b708-f142-9906-3f3eadd8c26a@codeaurora.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>
References: <1522761761-15262-1-git-send-email-anischal@codeaurora.org>
 <1522761761-15262-4-git-send-email-anischal@codeaurora.org>
 <152393708031.51482.15076025836699678476@swboyd.mtv.corp.google.com>
 <f563532b5c43960a61ae12a37a131be8@codeaurora.org>
 <23b9ca5a-b708-f142-9906-3f3eadd8c26a@codeaurora.org>
Message-ID: <152409430571.51482.3690471838803727777@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 3/3] clk: qcom: Add Global Clock controller (GCC) driver for
 SDM845
Date: Wed, 18 Apr 2018 16:31:45 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Manu Gautam (2018-04-18 09:38:41)
> Hi Amit,
> 
> 
> On 4/18/2018 6:33 PM, Amit Nischal wrote:
> >>> +       /* Disable the GPLL0 active input to MMSS and GPU via MISC registers */
> >>> +       regmap_update_bits(regmap, 0x09ffc, 0x3, 0x3);
> >>> +       regmap_update_bits(regmap, 0x71028, 0x3, 0x3);
> >>
> >> I think we'll have to throw in the pipe clk branch stuff in here too?
> >> And then drop the pipe clks from the driver?
> >
> > All the USB pipe clocks would be taken care. The PCIE pipe branch
> > clocks would have to be explicitly disabled so as to retain the
> > memory logic. Otherwise, it would lead to memory corruption in case
> > the external source is directly disabled without disabling the branch clock. 
> 
> PHY driver is same for both USB and PCIE and both PHYs use pipe_clk.
> If there is indeed some limitation and pipe_clk cant be left enabled
> always then I will suggest to not change pipe_clk handling for USB as well.
> 

Right. This is concerning if we have a half way solution.

Just to clarify my understanding, are you saying that the pcie pipe clks
are also tied to the memory logic and so toggling them on/off is used to
reset the memories inside the phy? Or the memories inside the
controller? What is the pipe clk clocking in these cases?
