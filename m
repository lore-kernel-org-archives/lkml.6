Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F4EC004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF22D2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 08:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVRFUlbi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF22D2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJXRT2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 13:19:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeJXRT2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 13:19:28 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A7EF207DD;
        Wed, 24 Oct 2018 08:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540371135;
        bh=+bFruUkpSs5HzSBZq9gNVoM/MGctyz5wG2/ZHVUTtn0=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=TVRFUlbilT7S4CQwsItCIpf0eTNKdfuOl+m/YR7Kt0Rv3ijA5yJKYzWj9uJvUq11j
         +Y4gRYUdzzTTV5UZoEpZ9CfYTb9D7DZ28sC0+XnarMi6US4ZuNQjkMHgkZ5R28bZfx
         nZgy6mRyW/FOrvdABCgpYz4qi5gq/vVQ26ch0Wt8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Icenowy Zheng <icenowy@aosc.io>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181023155727.9383-1-jagan@amarulasolutions.com>
Cc:     Jagan Teki <jagan@amarulasolutions.com>
References: <20181023155727.9383-1-jagan@amarulasolutions.com>
Message-ID: <154037113470.53599.9820023879508838050@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/4] clk: sunxi-ng: Enable DE2_CCU for SUN8I and SUN50I
Date:   Wed, 24 Oct 2018 01:52:14 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jagan Teki (2018-10-23 08:57:24)
> Allwinner SoC like SUN8I and SUN50I has DE2 CCU so enable them
> as default.
> =

> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> ---
> Changes for v5:
> - remove DRM dependency =

> Changes for v4, v3:
> - none
> Changes for v2:
> - Enable for MACH_SUN8I
> =

>  drivers/clk/sunxi-ng/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> =

> diff --git a/drivers/clk/sunxi-ng/Kconfig b/drivers/clk/sunxi-ng/Kconfig
> index 826674d090fd..99cf8103474c 100644
> --- a/drivers/clk/sunxi-ng/Kconfig
> +++ b/drivers/clk/sunxi-ng/Kconfig
> @@ -63,6 +63,8 @@ config SUN8I_V3S_CCU
>  =

>  config SUN8I_DE2_CCU
>         bool "Support for the Allwinner SoCs DE2 CCU"
> +       default MACH_SUN8I || (ARM64 && ARCH_SUNXI)
> +       depends on MACH_SUN8I || (ARM64 && ARCH_SUNXI)

Why do we need 'depends on'? That isn't described in the commit text.

