Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372A8C64EB4
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72962147D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 21:50:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZqXITaeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E72962147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbeK3I52 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 03:57:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:38882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726310AbeK3I51 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 03:57:27 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0C1752146D;
        Thu, 29 Nov 2018 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543528236;
        bh=CSQZ0oJKBdOM2BNQlH009zRFVSc+FKY9DIgf2UlcuRY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ZqXITaePMrAKfvfKB9NRz/r81/kqSM7Tpns3+5zCaUDJvqFj1E5/J1aPUf3E2BapI
         aJCw5jpQMRZoMs7gujmfcyFSa9Dizvq7b1kIYnoSoTFgavupgMpYkQPdDVwSNDqYMn
         +IGywmDGasVEW3UcfASNeMtIhQYxXvUC9s/rk8Dk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     "A.s. Dong" <aisheng.dong@nxp.com>, Abel Vesa <abel.vesa@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1542125975-8448-5-git-send-email-abel.vesa@nxp.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1542125975-8448-1-git-send-email-abel.vesa@nxp.com>
 <1542125975-8448-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <154352823547.88331.2399224127958299834@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v13 4/5] clk: imx: Add imx composite clock
Date:   Thu, 29 Nov 2018 13:50:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-11-13 08:20:00)
> Since a lot of clocks on imx8m are formed by a mux, gate, predivider and
> divider, the idea here is to combine all of those into one composite cloc=
k,
> but we need to deal with both predivider and divider at the same time and
> therefore we add the imx8m_clk_composite_divider_ops and register
> the composite clock with those.
> =

> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> Suggested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---

Applied to clk-next

