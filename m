Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6055BC43610
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2888420855
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 17:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZPpJsfZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2888420855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeKJDaD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 22:30:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:51896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727995AbeKJDaD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 22:30:03 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB0C820827;
        Fri,  9 Nov 2018 17:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541785704;
        bh=j/wP5JWPPWbWC/Q6hFqgtTDvi4OnZ8ZgnAMFrnlppdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SZPpJsfZx3NpA+HgiCczypsmoM56XedJqJh9XjH3gdyBC5TqG5NqEzXonNCZdgW7w
         2N5Z94iLpOiw23hScgq939VZqro8kjM9CjF3ryMz3c4egoJors9tALhP1kwIliVRen
         qsz/QjbBf51eowuO7aDLb+B5GaVQ6pbeSaA8E2+k=
Date:   Fri, 9 Nov 2018 23:18:16 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>, Rob@vkoul-mobl
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc: Fix board clock node name
Message-ID: <20181109174816.GV12092@vkoul-mobl>
References: <20181109095054.13924-1-vkoul@kernel.org>
 <154178353645.88331.795912528906051068@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <154178353645.88331.795912528906051068@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Add Rob & Bjorn)

Hi Steve,

On 09-11-18, 09:12, Stephen Boyd wrote:
> Quoting Vinod Koul (2018-11-09 01:50:54)
> > Device tree node name are not supposed to have "_" in them so fix the
> > node name use of xo_board to xo-board
> > 
> > Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller driver for QCS404")
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > 
> > Steve: RobH pointed this on DTS patches, would be great if you can pick this
> > as a fix
> 
> Ok.
> 
> > 
> >  drivers/clk/qcom/gcc-qcs404.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> > index e4ca6a45f313..ef1b267cb058 100644
> > --- a/drivers/clk/qcom/gcc-qcs404.c
> > +++ b/drivers/clk/qcom/gcc-qcs404.c
> > @@ -265,7 +265,7 @@ static struct clk_fixed_factor cxo = {
> >         .div = 1,
> >         .hw.init = &(struct clk_init_data){
> >                 .name = "cxo",
> > -               .parent_names = (const char *[]){ "xo_board" },
> > +               .parent_names = (const char *[]){ "xo-board" },
> 
> We have xo_board used everywhere else in drivers/clk/qcom/ so this makes
> me concerned. Wouldn't a better answer be to add clock-output-names to
> the xo-board DT node and have arm-soc merge that through. I mostly want
> to keep things consistent here so that if we need to inject an xo_board
> clk into the system then we can do so generically instead of making it
> per-platform. Of course, if we're never going to have this problem on
> qcs404 then it will be fine to start differing here. So I'm leaning
> towards merge this patch, just please ack my concern here and tell me it
> won't be a problem and I'll be happy to merge to clk-fixes.

So this is a warning from DT compiler and triggered with W=12, I
see tons of examples using "_" in node names. Clearly someone realized
it (Rob ?) added a warning for it.

As you rightly thought, qcs404 will be okay as we are starting out and following
few conventions so keeping this saner :)

> BTW, can you also specify a 'clocks' property in the GCC node and send
> the xo_board node there? In fact, we should do that for every GCC node
> in the tree. Care to do that and also add sleep_clk to each clock
> controller node that uses it? This is useful to do so that we can more
> easily see where clocks are going between clock controller nodes.

I agree that it makes sense to add the property in gcc node. I will add
this in my list and chase if after my current task completes, if that is
fine by you

Thanks
-- 
~Vinod
