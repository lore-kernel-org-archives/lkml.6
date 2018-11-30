Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00449C65BAE
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B540B21473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="upjrzB9a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B540B21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbeK3TV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:21:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:40936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726459AbeK3TV1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:21:27 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F9FF206B7;
        Fri, 30 Nov 2018 08:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543565577;
        bh=kOqwzYVQVBEcL/IHDXplx/dAPO3fA55KLJresAk1D4o=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=upjrzB9aEc2eTVOVbmJzMaSBpo48Fb+3esAtyuag7Tfaf41qqy4Fu1YsnZn8a3BIN
         l96xI028gZND5BVfEoDveo4JX5jLtXrMWHMfleVORAF+VQ1/L6ExSikgnmitiEd6nO
         fuAijtqpKjN4+lfxhNnJeeu/i4bbsRG5Udj2k+xU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130072420.GG5278@tuxbook-pro>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181130065259.26497-1-bjorn.andersson@linaro.org>
 <20181130065259.26497-2-bjorn.andersson@linaro.org>
 <154356151361.88331.1298482384404357982@swboyd.mtv.corp.google.com>
 <20181130072420.GG5278@tuxbook-pro>
Message-ID: <154356557630.88331.15462727905875864666@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/3] clk: qcom: gcc-msm8998: Mark hmss_dvm and lpass_at critical
Date:   Fri, 30 Nov 2018 00:12:56 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-29 23:24:20)
> On Thu 29 Nov 23:05 PST 2018, Stephen Boyd wrote:
> =

> > Quoting Bjorn Andersson (2018-11-29 22:52:57)
> > > Keep the two clocks enabled, so that the platform passes
> > > clk_disable_unused().
> > > =

> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  drivers/clk/qcom/gcc-msm8998.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > =

> > > diff --git a/drivers/clk/qcom/gcc-msm8998.c b/drivers/clk/qcom/gcc-ms=
m8998.c
> > > index 9f0ae403d5f5..d89f8e7c2a59 100644
> > > --- a/drivers/clk/qcom/gcc-msm8998.c
> > > +++ b/drivers/clk/qcom/gcc-msm8998.c
> > > @@ -1972,6 +1972,7 @@ static struct clk_branch gcc_hmss_dvm_bus_clk =
=3D {
> > >                 .enable_mask =3D BIT(0),
> > >                 .hw.init =3D &(struct clk_init_data){
> > >                         .name =3D "gcc_hmss_dvm_bus_clk",
> > > +                       .flags =3D CLK_IS_CRITICAL,
> > =

> > Please add a comment about why they're critical. This is a temporary
> > solution?
> > =

> =

> Disabling them in clk_disable_unused() are bad, mkay...

Ugh sad.

> =

> =

> SDM845 marks the equivalent clocks as critical with a comment that they
> must be on for system operation... I'm uncertain what the exact purpose
> of these two clocks are, so I don't have a better explanation right now.
> =


Ok. But does any driver ever want to use it? It may make more sense to
just remove it entirely and not touch it.
