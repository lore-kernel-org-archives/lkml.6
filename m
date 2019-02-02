Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B1C3C282D8
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE1821872
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 00:06:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="UIHkcKYP";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="P4bLU5cw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbfBBAF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 19:05:58 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46178 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbfBBAF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 19:05:58 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id CAB816047C; Sat,  2 Feb 2019 00:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549065956;
        bh=6Pyzj/XoYH40zrlt347z3+ZeABa5iaGgC3epqFVDeTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UIHkcKYPfFpCS6tiV8ypREmvopRQlEgDcwEKhRGkUq7ItgdPVuuWBKL/kNhGm3DZS
         OFAP0aGIafTjkUiE0e3P9t/JEGkqGNO1GaeFhp2lc85DWb8Xa3VlDPOQFyODgsaPiL
         9unOltoD4NIc0eNov2lWOIwovu7WkrL/gwOAVQ30=
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id D8CB56047C;
        Sat,  2 Feb 2019 00:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1549065955;
        bh=6Pyzj/XoYH40zrlt347z3+ZeABa5iaGgC3epqFVDeTQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P4bLU5cwejfBg6cYahhecltb9iECZUa4lV28a1urekhyTPjO5YE7GCkHbtSgcZdpJ
         hxX3KpB+h+dCf4HQRM98ntL8Xijwv/p/Kd5cviSLOIFD4SCOoDjEDFeVSxBi8fyt0w
         AsJ0DiceziyYllVbDT18cjPHCJhoEuU6KYAVpQdY=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 01 Feb 2019 16:05:55 -0800
From:   chandanu@codeaurora.org
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port
 clocks
In-Reply-To: <154083859263.98144.15690571729193618604@swboyd.mtv.corp.google.com>
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
 <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
 <3c4cccca-2c5c-927f-f471-2bbbd71b4155@codeaurora.org>
 <9c359e26-3708-14b6-f22a-fb529446d325@codeaurora.org>
 <154083859263.98144.15690571729193618604@swboyd.mtv.corp.google.com>
Message-ID: <c7440ea58b65150ed333bf6bba2d30c3@codeaurora.org>
X-Sender: chandanu@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Stephen,

On 2018-10-29 11:43, Stephen Boyd wrote:
> Quoting Taniya Das (2018-10-28 03:34:55)
>> Hello Stephen,
>> 
>> On 2018-10-19 16:04, Taniya Das wrote:
>> > Hello Stephen,
>> >

/snip

>> >>> +static struct clk_rcg2 disp_cc_mdss_dp_crypto_clk_src = {
>> >>> +       .cmd_rcgr = 0x2154,
>> >>> +       .mnd_width = 0,
>> >>> +       .hid_width = 5,
>> >>> +       .parent_map = disp_cc_parent_map_1,
>> >>> +       .freq_tbl = ftbl_disp_cc_mdss_dp_crypto_clk_src,
>> >>> +       .clkr.hw.init = &(struct clk_init_data){
>> >>> +               .name = "disp_cc_mdss_dp_crypto_clk_src",
>> >>> +               .parent_names = disp_cc_parent_names_1,
>> >>> +               .num_parents = 4,
>> >>> +               .flags = CLK_GET_RATE_NOCACHE,
>> >>
>> >> Why?
>> >>
>> >>> +               .ops = &clk_rcg2_ops,
>> >>> +       },
>> >>> +};
>> >>> +
>> >>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] = {
>> >>> +       F(162000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>> >>> +       F(270000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>> >>> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>> >>> +       F(810000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
>> >>
>> >> Are these in kHz? They really look like it and that's bad. Why do we
>> >> need them at all? Just to make sure the display driver picks these
>> >> exact
>> >> frequencies? It seems like we could just pass whatever number comes in
>> >> up to the parent and see what it can do.
>> >>
>> >
>> > Let me check back the reason we had to make this change.
>> 
>> We will need this flag since we reset/power-down the PLL every time we
>> disconnect/connect the DP cable or during suspend/resume. Only with 
>> this
>> flag, the calls to the PLL driver are properly called.
> 
> What does this mean? I wanted to know about the weird frequencies 
> listed
> above, and why it can't be done without a frequency table and direct
> rates passed up to the parent.
> 

/snip


>> >>
>> >>> +static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
>> >>> +       .halt_reg = 0x2044,
>> >>> +       .halt_check = BRANCH_HALT,
>> >>> +       .clkr = {
>> >>> +               .enable_reg = 0x2044,
>> >>> +               .enable_mask = BIT(0),
>> >>> +               .hw.init = &(struct clk_init_data){
>> >>> +                       .name = "disp_cc_mdss_dp_link_intf_clk",
>> >>> +                       .parent_names = (const char *[]){
>> >>> +                               "disp_cc_mdss_dp_link_clk_src",
>> >>> +                       },
>> >>> +                       .num_parents = 1,
>> >>> +                       .flags = CLK_GET_RATE_NOCACHE,
>> >>
>> >> Why?
>> >>
>> >
>> > It was a requirement, but let me get back on this too.
>> >
>> I had a discussion with the Display Port teams and below is the 
>> requirement,
>> 
>> This flag is required since we reset/power-down the PLL every time 
>> they
>> disconnect/connect the DP cable or during suspend/resume.
>> Only with this flag, the calls to the PLL driver properly.
> 
> Ok. So that explains the get rate nocache flag. Can you please add a
> comment that explains that these clk registers here are lost across
> suspend/resume of the display device? It really sounds like these
> display clks are inside of the display power domain and thus they lose
> their state across the display power domain power down. It would be
> better if we could properly implement suspend/restore for these clk
> registers across suspend/resume of the display device so that we don't
> need this nocache flag and the display code can work together with the
> clk code here to restore the frequency to the clk.


We already handle the suspend/restore for these clk registers
in Dp PLL domain. Without the "NOCACHE_FLAG", and if we are requesting 
the same clock rate
for any of the clocks, the set_rate call never reaches the DP PLL Ops.

I am not clear on what you are suggesting for removing the 
"NOCACHE_FLAG" for
the DisplayPort clocks. Are you suggesting design changes in DP PLL 
driver or in dispcc-driver?
Can you please provide more details?

thanks
Chandan

> 
> Is it really the case that the rcg here is always selecting a 
> particular
> PLL and doing a div-1? Because that is very simple then to just write
> that setting again on genpd restore.
