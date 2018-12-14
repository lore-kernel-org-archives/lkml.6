Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD303C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0508F208C1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 21:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544824406;
	bh=mqO3YP3eHsgRkD/KZQMsIg8V+7AaFLxrKnPCGddnhbc=;
	h=In-Reply-To:Subject:To:References:From:Cc:Date:List-ID:From;
	b=dTP+OpQRGCKASJQ8g4GY8MS7HRsOEEPLk1yUV2INgZKMnIncvzYb/FBuKq/pqhGCc
	 ggVUfek81INDQJYVrRkwNTGv001vemX7tjl+qNI+SS/yDGJkmFoKkeojr0YH4+S4N+
	 I+hUN7F4ozkQB0tABwufOTbCCTXaLPvhtCCRifHI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731331AbeLNVxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 16:53:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731209AbeLNVxW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 16:53:22 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA609208C3;
        Fri, 14 Dec 2018 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544824401;
        bh=mqO3YP3eHsgRkD/KZQMsIg8V+7AaFLxrKnPCGddnhbc=;
        h=In-Reply-To:Subject:To:References:From:Cc:Date:From;
        b=ipkZ8D/xEXJU6RQvm07gthzb73fYC+vXJx4N70i+C0I76369MVx+2LL9y+baclhkz
         AQtv/Lv5p1MsDHvIPOuLVoynof99rXnCdNVqUEGdX6BuWe41tI0DkgAstMBqfFcfX6
         89Yc6C1x6x9TUKSEMR/J/7EwItZd5dHIkeChV484=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20181205195050.4759-5-robh@kernel.org>
Subject: Re: [PATCH] clk: Use of_node_name_eq for node name comparisons
To:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20181205195050.4759-5-robh@kernel.org>
Message-ID: <154482440058.19322.10903668758246014018@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Tero Kristo <t-kristo@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Date:   Fri, 14 Dec 2018 13:53:20 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Rob Herring (2018-12-05 11:50:21)
> Convert string compares of DT node names to use of_node_name_eq helper
> instead. This removes direct access to the node name pointer.
>=20
> For instances using of_node_cmp, this has the side effect of now using
> case sensitive comparisons. This should not matter for any FDT based
> system which all of these are.
>=20
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: Tero Kristo <t-kristo@ti.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-renesas-soc@vger.kernel.org
> Cc: linux-clk@vger.kernel.org
> Cc: linux-omap@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied to clk-next

