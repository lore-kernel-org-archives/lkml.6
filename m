Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B62AC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C7121906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 19:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BOKUMEAI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391591AbeLUT22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 14:28:28 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41650 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbeLUT22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 14:28:28 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so3019942pfi.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 11:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=/4zLhrrDI5tXqdZs1MGr4wpX9qBajD53lBxnddDIVbg=;
        b=BOKUMEAIPk1XCHxFx8C5wm4LuY4O0wV7h70hAiCXYn6ET5eMcEVpebCaycAOCblFFZ
         JNgy2qG2R9VUOZ8k6Vt+urat+15dOvg8zOEYHBhLNTFX6+wM/V/DMkkNhaP7d6p5e4Qc
         qPTEzLaQxuq7I26vMztJiwG6H36K2WQMa6+ew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=/4zLhrrDI5tXqdZs1MGr4wpX9qBajD53lBxnddDIVbg=;
        b=JcjM0UJNbq0YJtCQkLSCMbrxO1nE9PJCeQBKhtdTcNbMKO9wn7sjq05PokyPPbmQq2
         NCvwB4SWaSURSLDeBOQBz5ovh4FaVDWgFDJTnIumFp7cXHgu9bR1APapaQVf2payQZHo
         ovcbAqio59nAjziYKXlJseyb6wzc6JCUEFzp9p/05TTpyzq9d9i3qxUC+N054DZbAK7t
         jgV8JikxBu2fPrQ67qV0NHIvRMxwcO/HULEmS8pXE8xMYcbuWgcdz9Xu33qosdfcD1O+
         mCSrW7Z0PaAmQt8WfC1syULehuR2lZxkbxJdS9Fkw0xtTgDMeNIB044f6c1fcRS3bnZo
         8KhA==
X-Gm-Message-State: AA+aEWZV0LLSls2pMmjkulaEuG7c3/15qnGp3SnRag0AKFxteI4PNNDu
        Ie3qnrpc9HjFWjIxEMbUpAJ0oA==
X-Google-Smtp-Source: AFSGD/VuBnDH+QkDsswEVpvWSgHa7hGCdfYV5lOToWBZI3irxqoRGNebG3ierYuA7DoLeQG5lzmz1Q==
X-Received: by 2002:a62:d148:: with SMTP id t8mr3913888pfl.52.1545420507345;
        Fri, 21 Dec 2018 11:28:27 -0800 (PST)
Received: from minitux (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q195sm28046252pgq.7.2018.12.21.11.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 21 Dec 2018 11:28:25 -0800 (PST)
Date:   Fri, 21 Dec 2018 11:28:23 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Taniya Das <tdas@codeaurora.org>
Cc:     Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>, robh+dt@kernel.org,
        mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, sboyd@kernel.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating
 frequency
Message-ID: <20181221192823.GA9704@minitux>
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org>
 <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org>
 <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 21 Dec 09:58 PST 2018, Taniya Das wrote:

> Hello,
> 
> On 12/21/2018 6:06 PM, Jorge Ramirez wrote:
> > On 12/21/18 12:19, Taniya Das wrote:
> > > 
> > > 
> > > On 12/17/2018 3:16 PM, Jorge Ramirez-Ortiz wrote:
> > > > Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> > > > specifications.
> > > > 
> > > > Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > > Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> > > > Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> > > > ---
> > > >   drivers/clk/qcom/gcc-qcs404.c | 6 ++++++
> > > >   1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/clk/qcom/gcc-qcs404.c
> > > > b/drivers/clk/qcom/gcc-qcs404.c
> > > > index 64da032..833436a 100644
> > > > --- a/drivers/clk/qcom/gcc-qcs404.c
> > > > +++ b/drivers/clk/qcom/gcc-qcs404.c
> > > > @@ -304,10 +304,16 @@ static struct clk_alpha_pll gpll0_out_main = {
> > > >       },
> > > >   };
> > > >   +static const struct pll_vco gpll0_ao_out_vco[] = {
> > > > +    { 800000000, 800000000, 0 },
> > > > +};
> > > > +
> > > >   static struct clk_alpha_pll gpll0_ao_out_main = {
> > > >       .offset = 0x21000,
> > > >       .regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
> > > >       .flags = SUPPORTS_FSM_MODE,
> > > > +    .vco_table = gpll0_ao_out_vco,
> > > > +    .num_vco = ARRAY_SIZE(gpll0_ao_out_vco),
> > > 
> > > Could you please help as to why this is required? This is a fixed
> > > PLL and we do not require a VCO table for it.
> > 
> > Hi Taniya,
> > 
> > this patch - the additional information that it provides about the
> > hardware - helps to select the right parent clock for a given frequency.
> > 
> > On the qcs404 this clock is one of the two parent clocks of the apcs
> > clock controller (the other one being the high frequency pll)
> > When cpufreq sets a target frequency, there is an iteration through the
> > list of parents to select the one that delivers the best match.
> > 
> > When attempting to set the clock for an alpha_pll, the operation does a
> > sanity check to validate that the requested frequency is in fact
> > reachable using the vco range: trying to set a value that is not in
> > range will fail.
> > 
> > This patch makes sure that its range is explicitly defined.
> > 
> > It also helps making sure there are no rounding issues when setting its
> > value: without it the clock was being read at 799MHz
> > 
> > 
> 
> If the PLL is being read as 799MHz it would because not all the 40 bits of
> the ALPHA_VAL being programmed by the bootloaders(which are the original
> owners of this PLL). So we should go with the way they are being set by
> bootloaders and read by HLOS driver.
> 
> And a VCO range you have considered is wrong from a PLL perspective. As
> these are fixed PLLs and VCO range really does not matter here, so please
> drop this change.
> 

The problem here is that the PLL should be fixed at 800MHz, but the
alpha PLL is defined such that it can change. So when the mux-div is
looking for a suitable parent and divider for our CPU clock it concludes
that the best way to reach certain frequencies is to change the rate of
GPLL0.

Adding the vco_table limits the available frequencies for GPLL0 in
QCS404, without modifying the implementation of the alpha PLL.

Perhaps there's a better way to define that this particular clock
hardware can change rate, but in this implementation it must not?

Regards,
Bjorn
