Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D2CC46464
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 928C620883
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 17:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGXxi+fV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 928C620883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389685AbeKGDCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 22:02:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:47608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388987AbeKGDCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 22:02:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CDD1E2086A;
        Tue,  6 Nov 2018 17:35:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541525751;
        bh=7GDQwXVsWNVrGABvJr1R1Q76OLK8+sQa7Idl3lxQtlg=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=YGXxi+fVpXPKcGrh8UkomC4gHRKPzbJ1ccCg1X1PX6cE3sn9VssKE6Aci2aH+jdeZ
         Y2QzmTrDU1oz8o4gKcyJ58D9g+m4mOaf+37A/cNcMxTa+bIyw18xJ3gXItU/myzw2Z
         ohvfzHHVuByRBHbsnAzexXUjQp66wUB7fKK7QDK4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1539910863-2352-1-git-send-email-Anson.Huang@nxp.com>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1539910863-2352-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <154152575127.88331.11571189328688525045@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2] clk: imx7d: remove UART1 clock setting
Date:   Tue, 06 Nov 2018 09:35:51 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-10-18 18:05:36)
> There are clock assignments in all i.MX7D dtb files for UART1,
> below is the example in imx7d-sdb.dts, so setting UART1 clock
> in clock driver is NOT necessary, actually, module clocks setting
> should be done in module driver.
> =

> &uart1 {
>         pinctrl-names =3D "default";
>         pinctrl-0 =3D <&pinctrl_uart1>;
>         assigned-clocks =3D <&clks IMX7D_UART1_ROOT_SRC>;
>         assigned-clock-parents =3D <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
>         status =3D "okay";
> };
> =

> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next

