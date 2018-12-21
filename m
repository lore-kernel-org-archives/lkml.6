Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D38C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9B4A21906
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 09:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbeLUJYw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 04:24:52 -0500
Received: from mail.bootlin.com ([62.4.15.54]:54454 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbeLUJYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 04:24:50 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id F11F120763; Fri, 21 Dec 2018 10:24:47 +0100 (CET)
Received: from localhost (lfbn-1-17122-186.w86-248.abo.wanadoo.fr [86.248.186.186])
        by mail.bootlin.com (Postfix) with ESMTPSA id C0C5620747;
        Fri, 21 Dec 2018 10:24:47 +0100 (CET)
Date:   Fri, 21 Dec 2018 10:24:47 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "amit.kucheria@linaro.org" <amit.kucheria@linaro.org>,
        "ezequiel@collabora.com" <ezequiel@collabora.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH V5 2/4] rtc: add i.MX system controller RTC support
Message-ID: <20181221092447.GM2188@piout.net>
References: <1545295872-20169-1-git-send-email-Anson.Huang@nxp.com>
 <1545295872-20169-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545295872-20169-3-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/2018 08:56:16+0000, Anson Huang wrote:
> i.MX8QXP is an ARMv8 SoC which has a Cortex-M4 system controller
> inside, the system controller is in charge of controlling power,
> clock and secure rtc etc..
> 
> This patch adds i.MX system controller RTC driver support,
> Linux kernel has to communicate with system controller via MU
> (message unit) IPC to set/get RTC time and other alarm functions,
> since the RTC set time needs to be done in secure EL3 mode (required
> by system controller firmware) and alarm functions needs to be done
> with general MU IRQ handle, these depend on other components which
> are NOT ready, so this patch ONLY enables the RTC time read.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> ChangeLog since V4:
>     - Add dependency on IMX_SCU to avoid compile error when IMX_SCU is NOT enabled;
>     - Use dev_err instead of pr_err;
>     - Remove unneccssary different errors check in imx_scu_get_handle which is already done in API.
> ---
>  drivers/rtc/Kconfig      |  7 ++++
>  drivers/rtc/Makefile     |  1 +
>  drivers/rtc/rtc-imx-sc.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 99 insertions(+)
>  create mode 100644 drivers/rtc/rtc-imx-sc.c
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
