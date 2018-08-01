Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F3EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A113208A6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 15:18:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+iwfmeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A113208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389931AbeHARFI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 13:05:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:52924 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389694AbeHARFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 13:05:07 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC66B20894;
        Wed,  1 Aug 2018 15:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533136736;
        bh=Kv6orApOo1c5JWYEtZrr7TfvPXUSwRVq2GmeHB2cVXI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=H+iwfmegkyqHeOo8BSKky+EvHU1KD8+nbyYRZ8yXg0w97rDufcAhIhAuZ7OMfcc8P
         A7oXiP3y46WGsYsZGF9HAyrLAMcXi4A6cEbwLEg4VTDkY7Pz1fgEHo6+uG+cnUgX5b
         48sl9MRlLFxy5hhR3BZJ75U50fHjyS/NZFakysHo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Tony Xie <tony.xie@rock-chips.com>, heiko@sntech.de
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1533024029-30273-1-git-send-email-tony.xie@rock-chips.com>
Cc:     linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        alexandre.belloni@bootlin.com, tony.xie@rock-chips.com,
        huangtao@rock-chips.com, devicetree@vger.kernel.org,
        zhangqing@rock-chips.com, linux-kernel@vger.kernel.org,
        xsf@rock-chips.com, linux-rockchip@lists.infradead.org,
        broonie@kernel.org, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        chenjh@rock-chips.com
References: <1533023850-29004-1-git-send-email-tony.xie@rock-chips.com>
 <1533024029-30273-1-git-send-email-tony.xie@rock-chips.com>
Message-ID: <153313673531.17365.8764698693425766723@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 5/5] clk: RK808: add RK809 and RK817 support.
Date:   Wed, 01 Aug 2018 08:18:55 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Tony Xie (2018-07-31 01:00:29)
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 721572a..fc1427c 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -46,11 +46,11 @@ config COMMON_CLK_MAX77686
>           clock.
>  =

>  config COMMON_CLK_RK808
> -       tristate "Clock driver for RK805/RK808/RK818"
> +       tristate "Clock driver for RK805/RK808/RK809/RK817/RK818"
>         depends on MFD_RK808
>         ---help---
> -         This driver supports RK805, RK808 and RK818 crystal oscillator =
clock. These
> -         multi-function devices have two fixed-rate oscillators,
> +         This driver supports RK805, RK809 and RK817, RK808 and RK818 cr=
ystal oscillator clock.
> +          These multi-function devices have two fixed-rate oscillators,

Something got messed up with the indentation here. Please fix.

>           clocked at 32KHz each. Clkout1 is always on, Clkout2 can off
>           by control register.
> =20
