Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095ADC6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B362080A
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqYgeKID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0B362080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbeJaB2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbeJaB2J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:28:09 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D79B2080A;
        Tue, 30 Oct 2018 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540917237;
        bh=zqQnAEYkuxDKvM8f3wzIaFjVEVx39n54TXoc8cC1WkE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=qqYgeKIDbDpKX+Y1MB+K3aSw2hBQ5uwUX74dK6+U3aBFar80CFSBZylrpVnYy+N/G
         ZRvmPdFIhBGWkjk42P/aoglubV1Cjchgrg+aX5GTjjCTlat+PV0IIctIvCEcMKakCO
         N/xi9E/gJ8Dryc/p46uRvtGyO9VwmuvvQ9TudhVY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <f3e40308-d2dd-cce9-4b19-3af419841bc1@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        chandanu@codeaurora.org, linux-arm-msm-owner@vger.kernel.org
References: <1539093467-12123-1-git-send-email-tdas@codeaurora.org>
 <1539093467-12123-3-git-send-email-tdas@codeaurora.org>
 <153911726378.119890.5522594539667887860@swboyd.mtv.corp.google.com>
 <3c4cccca-2c5c-927f-f471-2bbbd71b4155@codeaurora.org>
 <9c359e26-3708-14b6-f22a-fb529446d325@codeaurora.org>
 <154083859263.98144.15690571729193618604@swboyd.mtv.corp.google.com>
 <f3e40308-d2dd-cce9-4b19-3af419841bc1@codeaurora.org>
Message-ID: <154091723693.98144.6979314028521443413@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 2/2] clk: qcom : dispcc: Add support for display port clocks
Date:   Tue, 30 Oct 2018 09:33:56 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-10-29 23:01:44)
> On 10/30/2018 12:13 AM, Stephen Boyd wrote:
> > Quoting Taniya Das (2018-10-28 03:34:55)
> >> On 2018-10-19 16:04, Taniya Das wrote:
> >>> On 10/10/2018 2:04 AM, Stephen Boyd wrote:
> >>>> Quoting Taniya Das (2018-10-09 06:57:47)
> >>>>> diff --git a/drivers/clk/qcom/dispcc-sdm845.c
> >>>>> b/drivers/clk/qcom/dispcc-sdm845.c
> >>>>> index 0cc4909..6d3136a 100644
> >>>>> --- a/drivers/clk/qcom/dispcc-sdm845.c
> >>>>> +++ b/drivers/clk/qcom/dispcc-sdm845.c
> >>>>> +       },
> >>>>> +};
> >>>>> +
> >>>>> +static const struct freq_tbl ftbl_disp_cc_mdss_dp_link_clk_src[] =
=3D {
> >>>>> +       F(162000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >>>>> +       F(270000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >>>>> +       F(540000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >>>>> +       F(810000, P_DP_PHY_PLL_LINK_CLK,   1,   0,   0),
> >>>>
> >>>> Are these in kHz? They really look like it and that's bad. Why do we
> >>>> need them at all? Just to make sure the display driver picks these
> >>>> exact
> >>>> frequencies? It seems like we could just pass whatever number comes =
in
> >>>> up to the parent and see what it can do.
> >>>>
> >>>
> >>> Let me check back the reason we had to make this change.
> >>
> >> We will need this flag since we reset/power-down the PLL every time we
> >> disconnect/connect the DP cable or during suspend/resume. Only with th=
is
> >> flag, the calls to the PLL driver are properly called.
> > =

> > What does this mean? I wanted to know about the weird frequencies listed
> > above, and why it can't be done without a frequency table and direct
> > rates passed up to the parent.
> >
> =

> OOps, my bad :(.
> =

> We added these changes to handle higher clock rates. These rates when =

> greater than 4.3Ghz cannot be represented in 32bit variables. For DP, we =

> already have 5.4G and 8.1GHz freq for VCO clock. We will need these Khz =

> freq list in clock driver.
>   Let me check if they can do something like the byte/pixel clocks of =

> display.

Well then we really should just throw away the freq table here and have
rcg ops that pass the frequency up to the display PLL. Also, those
numbers look like gigabits per second (Gbit/s) for the DP spec which
isn't exactly the same as a clk frequency. What frequency does the PLL
run at for these various DP link speeds?

