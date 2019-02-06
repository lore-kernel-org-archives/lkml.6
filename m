Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04D0BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C73CD218D4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549479912;
	bh=ZemIRr87mympofqI890c43n5tJ0wMqXKtody80aXefg=;
	h=To:In-Reply-To:Subject:References:From:Date:List-ID:From;
	b=eh6IClwffIsfF+jw3Rr4AO4njLaR5ZwnCaTDQrTn+GgilMfTmr5KnXIqgBanBDsnV
	 3DSCx5gNdJUAz1CWG0KXx1zJBqEbzIajbpyd3LCoGDM4Obw8gslBOSy9FClQFStjv+
	 GqqWzyjJ+o8jDOzcyxHc0XA6e9VhWTBzB76kPjlY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfBFTFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 14:05:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726558AbfBFTFJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 14:05:09 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F1FD2186A;
        Wed,  6 Feb 2019 19:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549479909;
        bh=ZemIRr87mympofqI890c43n5tJ0wMqXKtody80aXefg=;
        h=To:In-Reply-To:Subject:References:From:Date:From;
        b=p15U12WOtgy22aGvOYLQNlxQ1xH4+RObL7wE3aBFhY9SdtCScEF/MDzdIMgNL6r2k
         YR7qvpEMPXuF+lxD1qiz4siHucR73AtS/fp7bGNU0fAoK1aarI5EqMv9/abYwsCHLn
         uqZHE92esHGjN7ookCADXONeM8Wi79i50ad0+naA=
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
In-Reply-To: <05409aafa108c77b2b878ed9663717c4b4a183ca.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v7 2/3] clk: clk-max77686: Clean clkdev lookup leak and use devm
Message-ID: <154947990848.115909.478174902516192562@swboyd.mtv.corp.google.com>
References: <cover.1544177090.git.matti.vaittinen@fi.rohmeurope.com> <05409aafa108c77b2b878ed9663717c4b4a183ca.1544177090.git.matti.vaittinen@fi.rohmeurope.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 06 Feb 2019 11:05:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matti Vaittinen (2018-12-07 03:10:15)
> clk-max77686 never clean clkdev lookup at remove. This can cause
> oops if clk-max77686 is removed and inserted again. Fix leak by
> using new devm clkdev lookup registration. Simplify also error
> path by using new devm_of_clk_add_hw_provider.
>=20
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Applied to clk-next

