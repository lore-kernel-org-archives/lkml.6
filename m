Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AF7C43610
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:22:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D1821780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 17:22:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfOdmSlH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71D1821780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731867AbeKNDV5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 22:21:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:52130 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731146AbeKNDV4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 22:21:56 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 56ED721780;
        Tue, 13 Nov 2018 17:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542129774;
        bh=vZhvqOak6WTAXHko8GeYMgawCiBuRApYB8oH8AFHFO0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=lfOdmSlHVFcQctGrJoL5gsBs9WrW+SXwMVZCsZFZ/zZsPlGPkxwLbRJC3jakXaS6G
         M0+D4RB7ssDqRKe9g9VV10zIwojbx8Yg+WJJwtT502fVGpXXaYaZskqkOQufs8A24J
         eQwvF0tyCT75mbuyTbleOG3GT0o5OStjWgjO7A4M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <c3bf03cd-ef87-a005-8536-d8739f53f2a5@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181109095054.13924-1-vkoul@kernel.org>
 <c3bf03cd-ef87-a005-8536-d8739f53f2a5@codeaurora.org>
Message-ID: <154212977367.88331.1550842985008389721@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: qcom: gcc: Fix board clock node name
Date:   Tue, 13 Nov 2018 09:22:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-10 18:12:28)
> Hello Vinod,
> =

> On 11/9/2018 3:20 PM, Vinod Koul wrote:
> > Device tree node name are not supposed to have "_" in them so fix the
> > node name use of xo_board to xo-board
> > =

> > Fixes: 652f1813c113 ("clk: qcom: gcc: Add global clock controller drive=
r for QCS404")
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> > =

> > Steve: RobH pointed this on DTS patches, would be great if you can pick=
 this
> > as a fix
> > =

> >   drivers/clk/qcom/gcc-qcs404.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs40=
4.c
> > index e4ca6a45f313..ef1b267cb058 100644
> > --- a/drivers/clk/qcom/gcc-qcs404.c
> > +++ b/drivers/clk/qcom/gcc-qcs404.c
> > @@ -265,7 +265,7 @@ static struct clk_fixed_factor cxo =3D {
> >       .div =3D 1,
> >       .hw.init =3D &(struct clk_init_data){
> >               .name =3D "cxo",
> > -             .parent_names =3D (const char *[]){ "xo_board" },
> > +             .parent_names =3D (const char *[]){ "xo-board" },
> >               .num_parents =3D 1,
> >               .ops =3D &clk_fixed_factor_ops,
> >       },
> > =

> =

> This fixed clock needs to be removed, once the RPM<->SMD clocks are =

> added. Why not have this clock part of the device Tree?
> =


If the clk needs to be removed at some point, then putting it into DT
instead of leaving it in the driver is the wrong direction to take. We
don't want to have to change DT as often as we change driver code.

