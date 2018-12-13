Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E558C67872
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED17E20870
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 22:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544738653;
	bh=oFbVQf52DmAIyJr+d31487v9PZakzmy0brakd4X3SRk=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=y4u0h7FYgfM+D75Tvz9OF3nxjZld59fMFeoAHUu0nmdejnxep0ICGQi9v9WNYSxKA
	 AIejIB7psGNO3fABeHtYBULTa0Hw8ygVgZMLcy34DVewPFdHbcwdtohKlLdKiDCTNZ
	 oYwW7UewawI0d5Ubz6Rtr28o4uSzlKorT6FMOtXw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED17E20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbeLMWEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 17:04:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:36516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbeLMWEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 17:04:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A38E320811;
        Thu, 13 Dec 2018 22:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544738650;
        bh=oFbVQf52DmAIyJr+d31487v9PZakzmy0brakd4X3SRk=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=dRyPqZxyRpxuNzYDZakK0/cp3yuCvuPdKK91bOinJT3mJ8GV6eqyBzG2Y7ckignJB
         tAKHyRzVnA1GpaA4boOiluc9rjgDF81EJFhN/ZN6sC0dsqCrdClhCsyngdq1z02LZ1
         Z2y7O2/6gcpr/fkyMHrFS9QexgnVl8beKTEY84Tw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Subject: RE: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ dependant
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Daniel Baluta <daniel.baluta@gmail.com>
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com> <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com> <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
Message-ID: <154473864987.19322.9053094167554135382@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Date:   Thu, 13 Dec 2018 14:04:09 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aisheng Dong (2018-12-13 08:51:18)
> [...]
>=20
> > > --- a/drivers/clk/imx/Makefile
> > > +++ b/drivers/clk/imx/Makefile
> > > @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) +=3D clk-imx6sx.o
> > >  obj-$(CONFIG_SOC_IMX6UL) +=3D clk-imx6ul.o
> > >  obj-$(CONFIG_SOC_IMX7D)  +=3D clk-imx7d.o
> > >  obj-$(CONFIG_SOC_IMX7ULP) +=3D clk-imx7ulp.o
> > > -obj-$(CONFIG_SOC_IMX8MQ) +=3D clk-imx8mq.o
> > >  obj-$(CONFIG_SOC_VF610)  +=3D clk-vf610.o
> > > +
> > > +obj-$(CONFIG_CLK_IMX8MQ) +=3D clk-imx8mq.o
> >=20
> > Nit: Do we want to keep CONFIG_ sorted?
>=20
> IMHO It might be okay to make MX8 (ARM64) a new group to start
> To get a clear separation. (Slightly not sorted due to VF610)
> Anyway, it leaves to Stephen to make the judge.
>=20

This is fine to split the two if they're not related. Just have a
comment indicating this.

