Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CFBAC46465
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61F442086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 23:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwnUZgM5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61F442086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727534AbeKHI7L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 03:59:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:48240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726982AbeKHI7L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 03:59:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 482A82086C;
        Wed,  7 Nov 2018 23:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541633191;
        bh=U1g63ixgNDwd1nxsTsKnzcyh7pqfemURLukjBaXsymA=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=iwnUZgM5jVhfEqFAEtUEuwTjOxpN/RZziE0hmkizND/z5qah/PkJqk8wlkMhPdBZm
         ObgpW8tDiGl60Cni0KzLxVCsRMFVy+XqH3A30m7Tgy9e/6YSOjTz09KB9GAxkAsCK6
         Tm2L6fbQMlHPvb/ohDDgxAV4vstD/2hLKr0AJyP8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "mturquette@baylibre.com" <mturquette@baylibre.com>,
        Andy Tang <andy.tang@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <VI1PR04MB433328F4F568ED75019B2091F3C40@VI1PR04MB4333.eurprd04.prod.outlook.com>
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20181031074616.24412-1-andy.tang@nxp.com>
 <154152509666.88331.15573532526011434275@swboyd.mtv.corp.google.com>
 <VI1PR04MB433328F4F568ED75019B2091F3C40@VI1PR04MB4333.eurprd04.prod.outlook.com>
Message-ID: <154163319056.88331.16892071193758893138@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH v3] clk: qoriq: add more chips support
Date:   Wed, 07 Nov 2018 15:26:30 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andy Tang (2018-11-06 16:52:19)
> Hi Stephen,
> =

> > -----Original Message-----
> > From: Stephen Boyd <sboyd@kernel.org>
> > Sent: 2018=E5=B9=B411=E6=9C=887=E6=97=A5 1:25
> > To: Andy Tang <andy.tang@nxp.com>; mturquette@baylibre.com
> > Cc: linux-clk@vger.kernel.org; linux-kernel@vger.kernel.org; Andy Tang
> > <andy.tang@nxp.com>
> > Subject: Re: [PATCH v3] clk: qoriq: add more chips support
> > =

> > Quoting Yuantian Tang (2018-10-31 00:46:16)
> > > diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c index
> > > 4c30b6e..5baa9e0 100644
> > > --- a/drivers/clk/clk-qoriq.c
> > > +++ b/drivers/clk/clk-qoriq.c
> > > @@ -1418,12 +1418,23 @@ static void __init clockgen_init(struct
> > > device_node *np)
> > >
> > >  CLK_OF_DECLARE(qoriq_clockgen_1, "fsl,qoriq-clockgen-1.0",
> > > clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_2,
> > > "fsl,qoriq-clockgen-2.0", clockgen_init);
> > > +CLK_OF_DECLARE(qoriq_clockgen_b4420, "fsl,b4420-clockgen",
> > > +clockgen_init); CLK_OF_DECLARE(qoriq_clockgen_b4860,
> > > +"fsl,b4860-clockgen", clockgen_init);
> > >  CLK_OF_DECLARE(qoriq_clockgen_ls1012a, "fsl,ls1012a-clockgen",
> > > clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_ls1021a,
> > > "fsl,ls1021a-clockgen", clockgen_init);
> > > CLK_OF_DECLARE(qoriq_clockgen_ls1043a, "fsl,ls1043a-clockgen",
> > > clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_ls1046a,
> > > "fsl,ls1046a-clockgen", clockgen_init);
> > > CLK_OF_DECLARE(qoriq_clockgen_ls1088a, "fsl,ls1088a-clockgen",
> > > clockgen_init);  CLK_OF_DECLARE(qoriq_clockgen_ls2080a,
> > > "fsl,ls2080a-clockgen", clockgen_init);
> > > +CLK_OF_DECLARE(qoriq_clockgen_p2041, "fsl,p2041-clockgen",
> > > +clockgen_init); CLK_OF_DECLARE(qoriq_clockgen_p3041,
> > > +"fsl,p3041-clockgen", clockgen_init);
> > > +CLK_OF_DECLARE(qoriq_clockgen_p4080, "fsl,p4080-clockgen",
> > > +clockgen_init); CLK_OF_DECLARE(qoriq_clockgen_p5020,
> > > +"fsl,p5020-clockgen", clockgen_init);
> > > +CLK_OF_DECLARE(qoriq_clockgen_p5040, "fsl,p5040-clockgen",
> > > +clockgen_init); CLK_OF_DECLARE(qoriq_clockgen_t1023,
> > > +"fsl,t1023-clockgen", clockgen_init);
> > > +CLK_OF_DECLARE(qoriq_clockgen_t1040, "fsl,t1040-clockgen",
> > > +clockgen_init); CLK_OF_DECLARE(qoriq_clockgen_t2080,
> > > +"fsl,t2080-clockgen", clockgen_init);
> > > +CLK_OF_DECLARE(qoriq_clockgen_t4240, "fsl,t4240-clockgen",
> > > +clockgen_init);
> > =

> > Some of these compatibles aren't documented. What happened to the
> > binding patch to add more compatible strings?
> Nothing happened. Binding patch will be merged to PowerPC tree soon. But =
it will take time to
> get to mainline tree or your tree.
> =


Ok. So I'll just merge this patch into clk-next then. Thanks!

