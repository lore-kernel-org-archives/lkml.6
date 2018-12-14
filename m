Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2949C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393912098A
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tWR+VrTq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730052AbeLNOMA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:12:00 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35857 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726554AbeLNOL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:11:59 -0500
Received: by mail-ed1-f67.google.com with SMTP id f23so5077743edb.3;
        Fri, 14 Dec 2018 06:11:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lOHfZAhHLVpxi/tMQLzkDV/TIgSG0ZS7mbtAEjInM2A=;
        b=tWR+VrTqybd0uVGRyW5uPuxi/51ijeGmBVaN8Uq/9XdIydPiX8MYkJKaikuzX+Q+If
         VD7ve2GvuSGiuo80t/SvbOZ3C5HCOxcXIhMfIkG8Luq32ead3eYDfVcAELiT351DK80p
         MO32VvUH1UipcKwMFeVCLmyDsLeBr58EDus9LcnbyHGAY+iJQmuGpqFCM65y77abuSyx
         2Q1FG1n/YXZuiWFsrFDXoVCcEBhhVWUcQavqqPua6S7S5MwW5S36Br11VYV4CLTb+gNQ
         eM1osuJUdqzCKi8aPizB4ihPNMUHXahAgrSyjzXCt35B2N6XNVHavNDooGcXlxOt2HqO
         11Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lOHfZAhHLVpxi/tMQLzkDV/TIgSG0ZS7mbtAEjInM2A=;
        b=tUL22A1VAHJcYobfzYF2sbnarzn7XqtxhEtIsg4GUPYelXmHpFKswcdW0a4IaJcHrz
         oIZgCACkoD1hV4fIZeavn8POQvnJbwsKiHbGoLNxHL1t+Gbqk6oQqmaJVPTqwOb5nn+B
         7AafEhVC2CNOoWccUGs4Lp3zBbdFd0TbyzwpPwTucmnnzDWLEvMxxyh0O6mLI67T0S7E
         /nzSlDEOp3OFd3zsKJjMqYo5pXdmtCeTZHw6v6+rf/8sUjiGj64H9kxl7KW2mJMCC5o+
         De1TJSPgk6OM4i0E3fwnVMwy7rfaNU+i/CJ6dPuKsViOKlWmHrcSF2ztilc67MXHozV7
         d/kQ==
X-Gm-Message-State: AA+aEWa6g0URqG6nUeD2CeAtcr6kzGgep48IyU66QcQw0VR3VkJKe2gs
        2UKj5ifzQHRA0HNZw9XlHQoStiln8YtSBqXEEu0=
X-Google-Smtp-Source: AFSGD/XeDodsmoR5pS6Lgq1o5XT4tgeJBwzJcbyfjFmTcDcnx3zYZA19TxkEbnmtjSqc862ho+XTYebzeK1KH4SjPMs=
X-Received: by 2002:aa7:d9d6:: with SMTP id v22mr3139376eds.265.1544796717889;
 Fri, 14 Dec 2018 06:11:57 -0800 (PST)
MIME-Version: 1.0
References: <1544717789-27388-1-git-send-email-abel.vesa@nxp.com>
 <CAEnQRZC+frwbcdA657v5SB_u1z=FaOFOFrQxuNXsWNrDgnPzGA@mail.gmail.com>
 <AM0PR04MB4211C143F6BEDD5716E746AA80A00@AM0PR04MB4211.eurprd04.prod.outlook.com>
 <20181214010101.GA13243@dragon>
In-Reply-To: <20181214010101.GA13243@dragon>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Fri, 14 Dec 2018 16:11:45 +0200
Message-ID: <CAEnQRZB_fEeASWsBye0HSn=tUBe31DugO42f3Z1GNYR4PNHXWQ@mail.gmail.com>
Subject: Re: [PATCH] clk: imx: Make the i.MX8MQ CCM clock driver CLK_IMX8MQ dependant
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Aisheng Dong <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 3:02 AM Shawn Guo <shawnguo@kernel.org> wrote:
>
> On Thu, Dec 13, 2018 at 04:51:18PM +0000, Aisheng Dong wrote:
> > [...]
> >
> > > > --- a/drivers/clk/imx/Makefile
> > > > +++ b/drivers/clk/imx/Makefile
> > > > @@ -34,5 +34,6 @@ obj-$(CONFIG_SOC_IMX6SX) += clk-imx6sx.o
> > > >  obj-$(CONFIG_SOC_IMX6UL) += clk-imx6ul.o
> > > >  obj-$(CONFIG_SOC_IMX7D)  += clk-imx7d.o
> > > >  obj-$(CONFIG_SOC_IMX7ULP) += clk-imx7ulp.o
> > > > -obj-$(CONFIG_SOC_IMX8MQ) += clk-imx8mq.o
> > > >  obj-$(CONFIG_SOC_VF610)  += clk-vf610.o
> > > > +
> > > > +obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
> > >
> > > Nit: Do we want to keep CONFIG_ sorted?
> >
> > IMHO It might be okay to make MX8 (ARM64) a new group to start
> > To get a clear separation. (Slightly not sorted due to VF610)
> > Anyway, it leaves to Stephen to make the judge.
>
> I think Daniel is suggesting that we put CONFIG_CLK_IMX8MQ prior to
> CONFIG_SOC_IMX1, so that all CONFIG_CLK_xxx options go before
> CONFIG_SOC_xxx and the list is still naturally alphabetically sorted.

Yes, that's correct.
