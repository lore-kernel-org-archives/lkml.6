Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C42C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC5882184D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 18:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551204020;
	bh=73yotcdHld+L1e6oBpOPCpusDnidGBSb2ABlfKzMayY=;
	h=To:References:Cc:Subject:From:In-Reply-To:Date:List-ID:From;
	b=tAfzDaMw0hcf8nxjcwCj57IeLd/TK7NfsIZclm8vEUZ3jownPQOUk63Y9+v+YCfP5
	 Mk4uAq6QzDK5+MUTaxxiJKSjAjGN+hpoD2WHa5+MlaAcGccGYf0kbyryGoreKrtj9i
	 Th1rDoR/w92ijN+9fQ755O6GPlKZRPqaBp0Xfy1Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfBZSAT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 13:00:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:36398 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727732AbfBZSAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 13:00:19 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49EB9206B8;
        Tue, 26 Feb 2019 18:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551204018;
        bh=73yotcdHld+L1e6oBpOPCpusDnidGBSb2ABlfKzMayY=;
        h=To:References:Cc:Subject:From:In-Reply-To:Date:From;
        b=s/pSooiOhpPbc9OLbutzInI6b7PNGzVZqhLh4MWd7wSyG18cQoNHnJkEazK00gVTn
         Zj5lQ4W4GsGvy0fBeYg9TuZnI6KMrey9kGk+YC6ZUmbk73B6ZpkgSUV8Yt0dRGsf0t
         dW1kXcK87LjOnEEZ4VV4Bu6DxDjFSHCY49GQBXwk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "agx@sigxcpu.org" <agx@sigxcpu.org>,
        "baruch@tkos.co.il" <baruch@tkos.co.il>,
        "ccaione@baylibre.com" <ccaione@baylibre.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, Jacky Bai <ping.bai@nxp.com>
References: <1550891665-29082-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <155120401746.260864.13314128182651447991@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Cc:     dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V2 1/2] clk: imx8mq: add GPIO clocks to clock tree
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1550891665-29082-1-git-send-email-Anson.Huang@nxp.com>
Date:   Tue, 26 Feb 2019 10:00:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2019-02-22 19:19:03)
> i.MX8MQ has clock gate for each GPIO bank, add them
> into clock tree for GPIO driver to manage.
>=20
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> No change since V1, just drop 1 patch from V1 patch series.

This doesn't apply to clk-imx branch or clk-next. Please rebase and
resend.

