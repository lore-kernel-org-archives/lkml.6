Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF8DC04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BA9208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544038865;
	bh=c06hqMnM00NOPeTCT27KnLTKJd29CYg7xBJXvl/L2lE=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=pNK/Ui0SfGfpLj+nxtB4MwqI57U11Mxth+8VdLz+aivVuqYwf83CeutuU0BKZpADs
	 /crCJeIZ/TG60KBhwPclHFqLt/eaOkiqYxTLKdrDbWqz07qyouE7Sb+VoUEdET/q04
	 Z2uLvPBCF5Zx/HuLi+9bPOcEaPMcURndJWGmykuQ=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BA9208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728422AbeLETlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:41:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727523AbeLETlD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:41:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B219220892;
        Wed,  5 Dec 2018 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544038862;
        bh=c06hqMnM00NOPeTCT27KnLTKJd29CYg7xBJXvl/L2lE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=OGo1uSUsl+FQCjMfP6uueQvHzEFP2KH3k0mwdEURqihz+w3PKZXjW21X5wWIcmKDY
         yfjzL+KOupCXFQKVxBfR3YGZsTCFp/O1XoGG6mQv2bIKyCctIuwdc8fhJ7UfQN/kLT
         Tl9Q1nDuA20eeTCi6i+dLSc3TdOow8Fm0Mx5L4XA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Aisheng DONG <aisheng.dong@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>, dl-linux-imx <linux-imx@nxp.com>
References: <1542200198-3017-1-git-send-email-aisheng.dong@nxp.com>
 <154386550302.88331.785218354920872757@swboyd.mtv.corp.google.com>
 <AM0PR04MB42111FFF525D6EC5D785692380AF0@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154403886196.88331.15597466595875847820@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: RE: [PATCH V6 0/9] clk: add imx7ulp clk support
Date:   Wed, 05 Dec 2018 11:41:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng DONG (2018-12-03 17:29:29)
> > -----Original Message-----
> > From: Stephen Boyd [mailto:sboyd@kernel.org]
> > Sent: Tuesday, December 4, 2018 3:32 AM
> > To: Aisheng DONG <aisheng.dong@nxp.com>; linux-clk@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> > mturquette@baylibre.com; shawnguo@kernel.org; Anson Huang
> > <anson.huang@nxp.com>; Jacky Bai <ping.bai@nxp.com>; dl-linux-imx
> > <linux-imx@nxp.com>; Aisheng DONG <aisheng.dong@nxp.com>
> > Subject: Re: [PATCH V6 0/9] clk: add imx7ulp clk support
> > =

> > Quoting A.s. Dong (2018-11-14 05:01:31)
> > > This patch series intends to add imx7ulp clk support.
> > >
> > > i.MX7ULP Clock functions are under joint control of the System Clock
> > > Generation (SCG) modules, Peripheral Clock Control (PCC) modules, and
> > > Core Mode Controller (CMC)1 blocks
> > >
> > > The clocking scheme provides clear separation between M4 domain and A7
> > > domain. Except for a few clock sources shared between two domains,
> > > such as the System Oscillator clock, the Slow IRC (SIRC), and and the
> > > Fast IRC clock (FIRCLK), clock sources and clock management are
> > > separated and contained within each domain.
> > >
> > > M4 clock management consists of SCG0, PCC0, PCC1, and CMC0 modules.
> > > A7 clock management consists of SCG1, PCC2, PCC3, and CMC1 modules.
> > >
> > > Note: this series only adds A7 clock domain support as M4 clock domain
> > > will be handled by M4 seperately.
> > >
> > =

> > I got:
> > =

> > drivers/clk/imx/clk-pllv4.c:152:15: warning: symbol 'imx_clk_pllv4' was=
 not
> > declared. Should it be static?
> > drivers/clk/imx/clk-pfdv2.c:166:15: warning: symbol 'imx_clk_pfdv2' was=
 not
> > declared. Should it be static?
> > drivers/clk/imx/clk-divider-gate.c:174:15: warning: symbol
> > 'imx_clk_divider_gate' was not declared. Should it be static?
> > drivers/clk/imx/clk-composite-7ulp.c:22:15: warning: symbol
> > 'imx7ulp_clk_composite' was not declared. Should it be static?
> > =

> > which I can fix easily by throwing in clk.h into each file.
> =

> Thanks, I will double check it when I back to office.
> =


No worries, I fixed it up and merged to clk-next.

