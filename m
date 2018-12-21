Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CAAC43612
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B56862192C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 21:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545428415;
	bh=hynrE5OrFjQ3nV3qTSBh0BJ5Job7ybFJw0px9idDxFY=;
	h=Subject:Cc:To:From:In-Reply-To:References:Date:List-ID:From;
	b=YGi+BHtYV19GLJfo3j9CrvS4ynQJJI6wRr3X8u40o0Vpdzrhc7oo/SK3bb43cXvPo
	 BVZvmEGc0m8m+dPg8hOpGtbNdQawvtreRlUxtn6YXdsEfZrUHCMnZgN0GpA7rg/T2o
	 68uYt6qeAEf74unteOY6nKrj3Y0Fq2Ro6QSlUknE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390576AbeLUVkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 16:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733050AbeLUVkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 16:40:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96DF621920;
        Fri, 21 Dec 2018 21:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545428413;
        bh=hynrE5OrFjQ3nV3qTSBh0BJ5Job7ybFJw0px9idDxFY=;
        h=Subject:Cc:To:From:In-Reply-To:References:Date:From;
        b=oUn8FI27tZekiibrHxHLuiNDXnJYWggEiiIiibygl9qAqBTcOYwz+SOJTpId+kJIw
         /4EP8gtwMKknlSlEwhaXyWoae068b0Ysg4/QOnBsb48HMhvOMQ4JNFoqbT+czTOtOU
         zDwiHTv7RcMAk9X+rR/m2+cgzBP9/Men5VfzY81g=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 01/13] clk: qcom: gcc: limit GPLL0_AO_OUT operating frequency
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, andy.gross@linaro.org,
        david.brown@linaro.org, will.deacon@arm.com,
        mturquette@baylibre.com, jassisinghbrar@gmail.com,
        vkoul@kernel.org, niklas.cassel@linaro.org, sibis@codeaurora.org,
        georgi.djakov@linaro.org, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        enric.balletbo@collabora.com, jagan@amarulasolutions.com,
        olof@lixom.net, amit.kucheria@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jorge Ramirez <jorge.ramirez-ortiz@linaro.org>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
User-Agent: alot/0.8
References: <1545039990-19984-1-git-send-email-jorge.ramirez-ortiz@linaro.org> <1545039990-19984-2-git-send-email-jorge.ramirez-ortiz@linaro.org> <e97d9050-effc-56d7-0f9b-768df90dd73a@codeaurora.org> <6814777f-1e5f-bd99-db63-a0050dcdd930@linaro.org> <874ce15d-67f5-8e55-8b62-73071fe6ae06@codeaurora.org> <20181221192823.GA9704@minitux> <94b12f58-b586-6b4b-6c0c-b4adad80d7b0@linaro.org>
Message-ID: <154542841268.13075.13095552962351570142@swboyd.mtv.corp.google.com>
Date:   Fri, 21 Dec 2018 13:40:12 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jorge Ramirez (2018-12-21 11:45:28)
> On 12/21/18 20:28, Bjorn Andersson wrote:
> >
> > Perhaps there's a better way to define that this particular clock
> > hardware can change rate, but in this implementation it must not?
>=20
> the initialization for this particular PLL on this particular platform=20
> is wrong
> as the interface does not apply to the platform needs even though it is an
> alpha_pll
>=20
> if the VCO is not an option -even though it reflects the platform=20
> constrains-
> I would suggest nullifying the alpha_pll_ops that do not apply to this=20
> platform:
> ie: set_rate, round_rate set to null in the probe.
>=20
> allowing the interface calls (ops) to go through to later on make them fa=
il
> based on some setting would be fundamentally wrong IMO
>=20

We have clk_alpha_pll_postdiv_ro_ops so maybe just add another set of
those for the alpha_pll itself?=20

