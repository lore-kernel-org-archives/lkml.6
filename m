Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE6DC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70A2A208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544821721;
	bh=hBN2kRGRaEr+8zBYH1/8ut64YGGop3KGEzpl+XBABJI=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=L1Nj48CgIlYGCtvjHM5QD9+nicVH2alunbc4nS+dX9OagU1W6Qu3IsfXo3ieAdmyD
	 k2TCAMJEY6VZbMI3vZKw4KJAjw/Bngdf94xaVCfeOBCy3wQnCP03HptXQPbnRUebt4
	 MgOdfEquP4nEiFpbfhsPZaYcaxqIM8a8xzNCrl7c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731056AbeLNVIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:08:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730734AbeLNVIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:08:39 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F242B2086D;
        Fri, 14 Dec 2018 21:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544821719;
        bh=hBN2kRGRaEr+8zBYH1/8ut64YGGop3KGEzpl+XBABJI=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=HNaIE7il73me2oyVypptVfQ9A6jsJK5TpDSShu4Gel9kMvmprxJySwpwcZ68Q22tj
         Z4UQnLxjkYaqbhEFcVJIzlJIl99vB6I+mWiskJvO24My2Siehkk+MgA0BJqjIDqCVs
         XWkc3QxBwbJFLAAuleOWSv5GTeHQtqZRnHP9+/wg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Subject: Re: [PATCH 0/3] clk: imx: Make all the parent_names arrays be const pointers
To:     Abel Vesa <abel.vesa@nxp.com>, Aisheng Dong <aisheng.dong@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
References: <1544801400-18951-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <154482171780.19322.123667425822315496@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Date:   Fri, 14 Dec 2018 13:08:37 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-12-14 07:30:08)
> This is mainly to shut up the checkpatch.pl script warnings about the
> "static const char *" needing to be "static const char * const".
>=20
> Abel Vesa (3):
>   clk: imx: Make parent_names const pointer in composite-8m
>   clk: imx: Make parents const pointer in mux wrappers
>   clk: imx8mq: Make parent names arrays const pointers
>=20

I still see warnings though so there seems to be some more work to do.

drivers/clk/imx/clk-imx8mq.c:401:89: warning: passing argument 5 of 'imx_cl=
k_mux2' discards 'const' qualifier from pointer target type [-Wdiscarded-qu=
alifiers]
  clks[IMX8MQ_CLK_GPU_SHADER_SRC] =3D imx_clk_mux2("gpu_shader_src", base +=
 0x8200, 24, 3, imx8mq_gpu_shader_sels,  ARRAY_SIZE(imx8mq_gpu_shader_sels)=
);

