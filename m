Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6780C0044C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A259920840
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 22:13:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WKGrRspm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A259920840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbeKJH4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 02:56:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:48236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726181AbeKJH4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 02:56:17 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BB4420818;
        Fri,  9 Nov 2018 22:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541801623;
        bh=++ST7u4ku3mIOY+ZGK2Q3yUOH63WpqXYgYk8sc9TOTU=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=WKGrRspmzKwptXaJAEpuWaxA3tYet5zumdrCTdGUSJ9jD8NJJm5VomjgOUuTgE79k
         mK79wq1BJTxblU0ocHxBEXyxMV6LYaxU4H72clOohXUGCnIQ+gpSFziLV3fpnTjbIf
         VPTeHhu4k2uqkVtkBrQD8qwoikPdKxO1lOCitZb0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh@kernel.org>, Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181109175105.GW12092@vkoul-mobl>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181109095054.13924-1-vkoul@kernel.org>
 <154178353645.88331.795912528906051068@swboyd.mtv.corp.google.com>
 <20181109174816.GV12092@vkoul-mobl> <20181109175105.GW12092@vkoul-mobl>
Message-ID: <154180162264.88331.6677984637578512693@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: gcc: Fix board clock node name
Date:   Fri, 09 Nov 2018 14:13:42 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2018-11-09 09:51:05)
> On 09-11-18, 23:18, Vinod Koul wrote:
> > On 09-11-18, 09:12, Stephen Boyd wrote:
> > > Quoting Vinod Koul (2018-11-09 01:50:54)
> > > >  drivers/clk/qcom/gcc-qcs404.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > =

> > > > diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-q=
cs404.c
> > > > index e4ca6a45f313..ef1b267cb058 100644
> > > > --- a/drivers/clk/qcom/gcc-qcs404.c
> > > > +++ b/drivers/clk/qcom/gcc-qcs404.c
> > > > @@ -265,7 +265,7 @@ static struct clk_fixed_factor cxo =3D {
> > > >         .div =3D 1,
> > > >         .hw.init =3D &(struct clk_init_data){
> > > >                 .name =3D "cxo",
> > > > -               .parent_names =3D (const char *[]){ "xo_board" },
> > > > +               .parent_names =3D (const char *[]){ "xo-board" },
> > > =

> > > We have xo_board used everywhere else in drivers/clk/qcom/ so this ma=
kes
> > > me concerned. Wouldn't a better answer be to add clock-output-names to
> > > the xo-board DT node and have arm-soc merge that through. I mostly wa=
nt
> > > to keep things consistent here so that if we need to inject an xo_boa=
rd
> > > clk into the system then we can do so generically instead of making it
> > > per-platform. Of course, if we're never going to have this problem on
> > > qcs404 then it will be fine to start differing here. So I'm leaning
> > > towards merge this patch, just please ack my concern here and tell me=
 it
> > > won't be a problem and I'll be happy to merge to clk-fixes.
> > =

> > So this is a warning from DT compiler and triggered with W=3D12, I
> > see tons of examples using "_" in node names. Clearly someone realized
> > it (Rob ?) added a warning for it.
> > =

> > As you rightly thought, qcs404 will be okay as we are starting out and =
following
> > few conventions so keeping this saner :)
> > =

> > > BTW, can you also specify a 'clocks' property in the GCC node and send
> > > the xo_board node there? In fact, we should do that for every GCC node
> > > in the tree. Care to do that and also add sleep_clk to each clock
> > > controller node that uses it? This is useful to do so that we can more
> > > easily see where clocks are going between clock controller nodes.
> > =

> > I agree that it makes sense to add the property in gcc node. I will add
> > this in my list and chase if after my current task completes, if that is
> > fine by you
> > =


Ok. Thanks for checking. Applied to clk-fixes. =


