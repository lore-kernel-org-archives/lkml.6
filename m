Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72725C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:39:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB1B208E7
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544060342;
	bh=o4bOxBc3/RpN5Q/XLLq4S054I3d8KZ5XKytIr7MDJdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gc8B3GgA2N0Bb09Ktt8pXQRL8sIUw0El+00K25ce+g4v35WCeDEcQQB3Lr96bwR0/
	 mkkheuvG8CWHfcnEJ1qMWwpjaO972BFkHwynG7VZxjjQbE2jV1RreySj3Z6b7tBQOu
	 Y6rCaRglx8Q4RsIo0QiheJzxifSBwjLlrVkR5QbI=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB1B208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbeLFBjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 20:39:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:36846 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727670AbeLFBjB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 20:39:01 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0F320892;
        Thu,  6 Dec 2018 01:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544060340;
        bh=o4bOxBc3/RpN5Q/XLLq4S054I3d8KZ5XKytIr7MDJdc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uhp202b7f0jY+xyzwPSRsOhjF+2GdqwqveVAUV62CK5+KzF+mGkFxzxbEOtRuhVe8
         n4kZKeXiAGuSSULLtUIzZVCQtJyYE2WpA3etB7BeTkUebW4MbB6Cqm6/bJUUEwdCRT
         eZTBPlg3gzR2aMSVx9M5X8wySzD9SEqSdQGvyNqQ=
Date:   Thu, 6 Dec 2018 09:38:19 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH 7/9] ARM: dts: imx7d-pico: Extend peripherals support
Message-ID: <20181206013818.GU3987@dragon>
References: <20181202212520.16650-1-otavio@ossystems.com.br>
 <20181202212520.16650-8-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181202212520.16650-8-otavio@ossystems.com.br>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2018 at 07:25:18PM -0200, Otavio Salvador wrote:
...
> +&uart6 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart6>;
> +	assigned-clocks = <&clks IMX7D_UART6_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_OSC_24M_CLK>;
> +	fsl,uart-has-rtscts;

Use uart-has-rtscts instead.

> +	status = "okay";
> +};
> +
> +&uart7 { /* Bluetooth */
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart7>;
> +	assigned-clocks = <&clks IMX7D_UART7_ROOT_SRC>;
> +	assigned-clock-parents = <&clks IMX7D_PLL_SYS_MAIN_240M_CLK>;
> +	fsl,uart-has-rtscts;

Ditto

> +	status = "okay";
> +};

Shawn
