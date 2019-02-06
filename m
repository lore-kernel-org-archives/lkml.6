Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBFFC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA2B2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479916;
	bh=ML2vFOb4cvoSl2x2j8/yMf0bXCQpACrQKo5uQ76N2S0=;
	h=To:In-Reply-To:Subject:References:From:Date:List-ID:From;
	b=BQn3o398qam5JP2ai8dmco7nnN/1ZaclJ1RpLitX6U8rEnyD0D2riBFCEAVE2oNMR
	 K6vV5mfP6JHwJ3vqd8tlszQMU/ie2kLSEL4JTIRQyie5MiO+uwojF0BlZ5e9oE7qTX
	 i+++AHlGCsE32qUVZgft7CBjHv7hewPKg5d35Y4I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbfBFTFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:05:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBFTFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:05:12 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E630220B1F;
        Wed,  6 Feb 2019 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479912;
        bh=ML2vFOb4cvoSl2x2j8/yMf0bXCQpACrQKo5uQ76N2S0=;
        h=To:In-Reply-To:Subject:References:From:Date:From;
        b=1GgZuPbjWKXsOnRC9GjD57iZbwA4AhzlL1ZQl9nmQl8/SraEF0uZteFydseXau8xV
         ZQX+Fthp4Xp6FBqsbWy/PTdZC5iRehXLAJc29LI6db12aJ2yajVAQYIys3GaWhpdRs
         2Ai+w1Dp+mDoU7GC6+4+VkHfvtaSZ1qlJfnroRHE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     akshu.agrawal@amd.com, andrew.smirnov@gmail.com,
        b.zolnierkie@samsung.com, corbet@lwn.net, cw00.choi@samsung.com,
        djkurtz@chromium.org, krzk@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, linux@roeck-us.net,
        matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com,
        mturquette@baylibre.com, pavel@ucw.cz, pombredanne@nexb.com,
        rafael.j.wysocki@intel.com, sjhuang@iluvatar.ai, sre@kernel.org,
        vkoul@kernel.org
In-Reply-To: <f40c69fc858cc7ec3cc722c6664d933ea6558fb9.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v7 3/3] clk: clk-st: avoid clkdev lookup leak at remove
Message-ID: <154947991126.115909.9165588104956568526@swboyd.mtv.corp.google.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com> <f40c69fc858cc7ec3cc722c6664d933ea6558fb9.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 06 Feb 2019 11:05:11 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-07 03:10:51)
> Use devm based clkdev lookup registration to avoid leaking lookup
> structures.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---

Applied to clk-next

