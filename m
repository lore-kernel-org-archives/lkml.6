Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75085C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D46C2075C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 18:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550858782;
	bh=HDQIAG1kif7slV37LL0UhZcwKgc6WEavtUhc3s3O4hU=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=IHcD/hRhonIWe5FSknWe3zhn0rvSuyPTV/skBAuzuo+t3AV8RIanMaj5lL5KXWanb
	 H6/M65Lou/On2B8v6QXFLal+LzoQ90HY1xjpmncZ1ZSs2D1lvS0F9o5A1zHZJvNFE3
	 2KjcvL2Yj5tLHw74dP6cvNIAqAQFGQTChwamRoNY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727583AbfBVSGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 13:06:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:43938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbfBVSGU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 13:06:20 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5562070D;
        Fri, 22 Feb 2019 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550858780;
        bh=HDQIAG1kif7slV37LL0UhZcwKgc6WEavtUhc3s3O4hU=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=D2/TVk4c1tUtyJI3ZqBBGpKETWUL6tWKBniQfFEZwU6VN6R2niCqK/Mj/Cj3viLfj
         U2GYHG3fkt1efCumgJOQzL9j/Yft+ICzwk32mVkrFhk0Qw+JeyeP8jCZ2Pha1w0TXz
         HedanfiHSyj5sO3PJW3Zumtc/HsgD31+/7p4B6i8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 07/14] clk: qcom: hfpll: register as clock provider
Message-ID: <155085877912.77512.282683582779131155@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <1548700381-22376-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1548700381-22376-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1548700381-22376-8-git-send-email-jorge.ramirez-ortiz@linaro.org>
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
Date:   Fri, 22 Feb 2019 10:06:19 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez-Ortiz (2019-01-28 10:32:54)
> Make the output of the high frequency pll a clock provider.
> On the QCS404 this PLL controls cpu frequency scaling.
>=20
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

