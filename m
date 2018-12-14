Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EA5FC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 293E620879
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544751649;
	bh=/gSiA2Gkx2E9oWtiyY/A0VSuOD1fUOWydXg0c+8sMEY=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=LiGAyiMhdThNYlXQhBD114ouvJ0i6m8kHMMGmUp/FYZHN+yXgMVbSSXheS/ISZHBW
	 h8FdpX4lNoJ9dVPd302wmiczhGRZBQwkTuNQKQaoex4GSKG231op28XCZ1t91zEntN
	 Qh9icP65k3k0PyrMBJ26uOsLvTk43prgBLVJzBIc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 293E620879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbeLNBks (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 20:40:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:35508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728130AbeLNBkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 20:40:47 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CB4120811;
        Fri, 14 Dec 2018 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544751647;
        bh=/gSiA2Gkx2E9oWtiyY/A0VSuOD1fUOWydXg0c+8sMEY=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=I1u00QRqpWv7e8qNNfyf20IF3Sxn2wfmaUTbSlbSn1ZLPKS63QGiSm+Ngkr5rLwsa
         TSj4pZzrZNw+i2hqYn6jBPXqSF9hl7RApevpgFGM8hAVF7sFKUvGkmKRreXrtUqAMH
         oSIOPOT070UNj0KexVu3hcS9jChZho9AiQBuTBEs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181214010101.GA13243@dragon>
Subject: Re: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ dependant
To:     Aisheng Dong <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com> <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com> <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com> <20181214010101.GA13243@dragon>
Message-ID: <154475164638.19322.6542937629598212543@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Daniel Baluta <daniel.baluta@gmail.com>,
        Abel Vesa <abel.vesa@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Date:   Thu, 13 Dec 2018 17:40:46 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2018-12-13 17:01:02)
> On Thu, Dec 13, 2018 at 04:51:18PM +0000, Aisheng Dong wrote:
> > [...]
> >=20
> > > > --- a/drivers/clk/imx/Makefile
> > > > +++ b/drivers/clk/imx/Makefile
> > > > @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
> > > >  obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
> > > >  obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
> > > >  obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
> > > > -obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o
> > > >  obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
> > > > +
> > > > +obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
> > >=20
> > > Nit: Do we want to keep CONFIG_ sorted?
> >=20
> > IMHO It might be okay to make MX8 (ARM64) a new group to start
> > To get a clear separation. (Slightly not sorted due to VF610)
> > Anyway, it leaves to Stephen to make the judge.
>=20
> I think Daniel is suggesting that we put CONFIG_CLK_IMX8MQ prior to
> CONFIG_SOC_IMX1, so that all CONFIG_CLK_xxx options go before
> CONFIG_SOC_xxx and the list is still naturally alphabetically sorted.
>=20

Fine by me. Please resend this patch with the final decision.

