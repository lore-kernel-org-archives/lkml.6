Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D0D2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C92B2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550858856;
	bh=lVBDw95zHZa7dGOBQdWkGmMDmy8OWapPmrDb+KHaBOk=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=VQCD2oPpWkBubBi3DvfgnHFPhOQ7oPEyBOVhZSLZ7SNh1ipM47T06U6XBXG4/p/o9
	 pKTnVO6aGEQZyu9KxezhLVbhYdsQ5V3CziQBozA89xVU8XBqemGYPYgCdsDaOZl+xO
	 5ykrKGj3rX5SJvY51kAS3TpY9v9Y+gkwgQoBYUbk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfBVSHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:07:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:44326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfBVSHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:07:34 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72D5F2070D;
        Fri, 22 Feb 2019 18:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550858853;
        bh=lVBDw95zHZa7dGOBQdWkGmMDmy8OWapPmrDb+KHaBOk=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=k4BBI0l6kg0D10PoOHO+xaFm6akiflggRnImUDKHvPV5OoggLuhgE6qHOqzzLrWjl
         CPB0gwalGaiqiXeIiOaevcX74ws7QLezLjvqlDKiUNLH/gAhZNAU3Mu4NXksVKaHIM
         dH+SuyNmqHR+80n4iFjdLEkiw9uV0SYkiCAZ1+gw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 01/14] clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
Message-ID: <155085885277.77512.880525447229804781@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1548700381-22376-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-2-git-send-email-jorge.ramirez-ortiz@linaro.org>
To:     andy.gross@linaro.org, arnd@arndb.de, bjorn.andersson@linaro.org,
        david.brown@linaro.org, enric.balletbo@collabora.com,
        heiko@sntech.de, horms+renesas@verge.net.au,
        jagan@amarulasolutions.com, jassisinghbrar@gmail.com,
        jorge.ramirez-ortiz@linaro.org, mark.rutland@arm.com,
        mturquette@baylibre.com, olof@lixom.net, robh+dt@kernel.org,
        sibis@codeaurora.org, will.deacon@arm.com
Cc:     vkoul@kernel.org, niklas.cassel@linaro.org,
        georgi.djakov@linaro.org, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, khasim.mohammed@linaro.org
Date:   Fri, 22 Feb 2019 10:07:32 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:48)
> Limit the GPLL0_AO_OUT_MAIN operating frequency as per its hardware
> specifications.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>

Acked-by: Stephen Boyd <sboyd@kernel.org>

> diff --git a/drivers/clk/qcom/gcc-qcs404.c b/drivers/clk/qcom/gcc-qcs404.c
> index 64da032..7de4fcf 100644
> --- a/drivers/clk/qcom/gcc-qcs404.c
> +++ b/drivers/clk/qcom/gcc-qcs404.c
> @@ -304,6 +304,7 @@ static struct clk_alpha_pll gpll0_out_main =3D {
>         },
>  };
> =20
> +

Please remove this stray hunk though.

>  static struct clk_alpha_pll gpll0_ao_out_main =3D {
>         .offset =3D 0x21000,
>         .regs =3D clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
