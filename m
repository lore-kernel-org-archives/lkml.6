Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68705C4360F
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFDD20836
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550781850;
	bh=CZc1PLgDJqZGD7Q3WsEIWVR483enxgPNJEwBJnuY+TY=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=sNBXXsiWYQ7dRJTHMzgzIob1N2eBNhjYuurb7ao6tN74+eHyiK/niwnXFUOU0JfNS
	 NULHbdd0Z78JzIXGu8cOI/AVyHh7xtES5yS6PfYvzuFbNj6z/YuSPNs+fj88jfQUcV
	 nkjxAtMmGDRHQjrjfUBAUNtZQeGl4A0sXbDdB38k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfBUUoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:44:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:45158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725866AbfBUUoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:44:08 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C68D0206C0;
        Thu, 21 Feb 2019 20:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550781847;
        bh=CZc1PLgDJqZGD7Q3WsEIWVR483enxgPNJEwBJnuY+TY=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=v73vkarhP7gMaHTbqyBkO9axVdbySe45pnFhVA3DKDnZSoYDV9V7sp4zqUtJd97TP
         LLXi5Hfy2Jv5PjeX9hIFnec5QjHOAi7RzpbLjH5uWHHKIwyUyzp0b+IFmPwKBvsCzS
         HJL/5ZEv0aCHR6C5DuOVuKI1XU2AWM9Gg26ZgUB4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 1/3] clk: imx: imx8mq: Fix the rate propagation for arm pll
Message-ID: <155078184707.77512.8417233736352965273@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1550252913-24532-1-git-send-email-abel.vesa@nxp.com> <1550252913-24532-2-git-send-email-abel.vesa@nxp.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550252913-24532-2-git-send-email-abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Angus Ainslie <angus.ainslie@puri.sm>,
        Lucas Stach <l.stach@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Anson Huang <anson.huang@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abel.vesa@nxp.com>
Date:   Thu, 21 Feb 2019 12:44:07 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-02-15 09:48:43)
> The arm pll bypass needs to propagate the rate upwards
> in order for the cpufreq to work.
>=20
> Fixes: b80522040cd3f ("clk: imx: Add clock driver for i.MX8MQ CCM")
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
> ---

Applied to clk-next

