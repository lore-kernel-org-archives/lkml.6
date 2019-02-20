Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C936C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D78BE2147A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550691823;
	bh=ARqgtVHMVHqoKzK50c6mPQgay3OjCWt1M3TOPwIENDs=;
	h=Subject:References:From:In-Reply-To:To:Cc:Date:List-ID:From;
	b=fSATbrHAWIfu12IjhGfMW7hgHHWo+kXAif7kk9DHxORcxr8f4z29uZSWOOOvTqZ3E
	 BTbWT/GRoNh2BEDwEKZHzovu3djAzJgSSGCOkdP/ZAzuoBL0VbsxyBjVY0bU8vFMqK
	 Cin4VnhUsJAJx6ttQKFaLg4KL5KF6m7+5bztV9n0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbfBTTnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 14:43:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbfBTTnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 14:43:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A9E20855;
        Wed, 20 Feb 2019 19:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550691821;
        bh=ARqgtVHMVHqoKzK50c6mPQgay3OjCWt1M3TOPwIENDs=;
        h=Subject:References:From:In-Reply-To:To:Cc:Date:From;
        b=sIR1d0n/HDSEazxAv8zsq9dlpEwbNyEi5RXBTRgubDzYjAYL9enJsvC9JiuPvfVRn
         PqnfKHlny7JYoVahqEkYP8pB9VrHYJ2ypxHCgSwEurnY780GpqhtGGWLHp34PJ6HXk
         WV8vm/yMKVtQG+o9TyPAqPNV73yGtfMR9xA7wAdo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] clk: at91: fix masterck name
Message-ID: <155069182090.77512.6031671349879787129@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
References: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20190208144059.29861-1-alexandre.belloni@bootlin.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Date:   Wed, 20 Feb 2019 11:43:40 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alexandre Belloni (2019-02-08 06:40:59)
> The master clock is actually named masterck earlier in the driver. Having
> "mck" in the parent list means that it can never be selected.
>=20
> Fixes: 1eabdc2f9dd8 ("clk: at91: add at91sam9x5 PMCs driver")
> Fixes: a2038077de9a ("clk: at91: add sama5d2 PMC driver")
> Fixes: 084b696bb509 ("clk: at91: add sama5d4 pmc driver")
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---

Applied to clk-fixes

