Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE037C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE933217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551204565;
	bh=MalEI9AY4Y/lho68rO7QHAD5Yp5TvsZQXjlzR1sv20g=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=bNCilywM0PvdD9vQD51JNqm3vbiquqDOOEMyVJhh7H80hkNLt0tvM/2qI699LFU5V
	 o5iXSDS8Umt1uwspydPC0mtwVFHUwT3SBSqDpZRQ/JAbcKh7WPoPiCLNGSBvJkwoLv
	 8Htli74FXD+lMcWMwale59x62U0RkCqjBs203J2g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbfBZSJY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:09:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbfBZSJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:09:24 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E55D206B8;
        Tue, 26 Feb 2019 18:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551204563;
        bh=MalEI9AY4Y/lho68rO7QHAD5Yp5TvsZQXjlzR1sv20g=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=cgCIy9er+0cLpv/pqFMEkg/ppnJvpB+ctidOVRaUpmAnHlt2hapu2RHuGTYqAKOZD
         0KlrEsZbjiMB9y1kdyTw+GD924mow06LOVCprwDKkyYx/dZI8y0hWkt7UIZsHJ8l7M
         7SVR5ZWKilwwNLY4XIOfXLkJGLwYy4ZsF5ieagKM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <155120456259.260864.486515032059106989@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: Re: [PATCH v2] clk: imx: Refactor entire sccg pll clk
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550855235-31528-1-git-send-email-abel.vesa@nxp.com>
Date:   Tue, 26 Feb 2019 10:09:22 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-02-22 09:07:32)
> Make the entire combination of plls to be one single clock. The parents u=
sed
> for bypasses are specified each as an index in the parents list.
> The determine_rate does a lookup throughout all the possible combinations
> for all the divs and returns the best possible 'setup' which in turn is u=
sed
> by set_rate later to set up all the divs and bypasses.
>=20
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Tested-by: Lucas Stach <l.stach@pengutronix.de>
> Acked-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next

