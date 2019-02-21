Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF2EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80A6206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550781842;
	bh=aYnFFmXLyANkyDAEUKoU2Y4kZLe0/hIBctTEbqGIZ10=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=y+FYCYmY5/45Z9PtrF3DSWuLHikmaEg0jrE277xRtzI79aYQXTMnaj+mNgQr0NzC7
	 DpBXpwuvS7Kv2ouifbodFVZgm/AkOGE7Twu22PIAhM6U9kSJcVmHJegSe7Mi8AFSMP
	 wzuF7rTik/qAsFiDffvnmSU71l/gwckKxcBPrbW4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbfBUUoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:44:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:45040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUUoA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:44:00 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61A3220836;
        Thu, 21 Feb 2019 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550781839;
        bh=aYnFFmXLyANkyDAEUKoU2Y4kZLe0/hIBctTEbqGIZ10=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=2WKyPsoGLoFnfQUpKCFoF0yTT4l9QdgMVZE+P25+34meDzoY/QPN+ALQCd+hOmNU4
         RdPBVGSwFy+FkZD1vDS3hlZEOr8p13QaacL5MszKdpKQJcCxULVOqVHAERdwyqcRbA
         5OpBLgzZn67p1UfPNByYJyQkzL6muWFsqyiCMStE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RESEND] clk: imx: Refactor entire sccg pll clk
Message-ID: <155078183858.77512.8460627918889845210@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550481854-14338-1-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550481854-14338-1-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jacky Bai <ping.bai@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>
Date:   Thu, 21 Feb 2019 12:43:58 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-02-18 01:24:33)
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

