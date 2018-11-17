Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F5DEC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5120825
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:06:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="LiD65H8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC5120825
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbeKRCXM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:23:12 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39594 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726128AbeKRCXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:23:12 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAHG5Mv1041550;
        Sat, 17 Nov 2018 10:05:22 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1542470722;
        bh=qqWYE5Xu3Fd1BGSiTO266lzPduTFEGf/75030QRoWZ0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LiD65H8gU9PEojqvP7GWKEyCQgAjev6dhcGrK1zMqThlw6X15xdJ6UayX0IVgSOVv
         MbBm9gr3p398o2zjxE0WUSR4wm61SUIyyuuBoWsCBOKaLciLo3K+phxVEE7bpkVKYz
         5ixq5gs+T2A9YmhtRIVvdQY8qwMLmGn/9UNlxNHw=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAHG5MJR117856
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 17 Nov 2018 10:05:22 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 17
 Nov 2018 10:05:22 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 17 Nov 2018 10:05:22 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAHG5Mg9019321;
        Sat, 17 Nov 2018 10:05:22 -0600
Date:   Sat, 17 Nov 2018 10:05:02 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions
Message-ID: <20181117160502.dhlqbx5qnmdp5iog@kahuna>
References: <20181113060111.16374-1-vigneshr@ti.com>
 <20181113060111.16374-2-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181113060111.16374-2-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:31-20181113, Vignesh R wrote:
> The dt-bindings header for TI K3 AM6 SoCs define a set of macros for
> defining pinmux configs in human readable form, instead of raw-coded
> hex values.
> 
> Signed-off-by: Vignesh R <vigneshr@ti.com>
> ---
>  MAINTAINERS                      |  1 +
>  include/dt-bindings/pinctrl/k3.h | 35 ++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/k3.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fa45ff36fde9..1574ad6d7ead 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2204,6 +2204,7 @@ S:	Supported
>  F:	Documentation/devicetree/bindings/arm/ti/k3.txt
>  F:	arch/arm64/boot/dts/ti/Makefile
>  F:	arch/arm64/boot/dts/ti/k3-*
> +F:	include/dt-bindings/pinctrl/k3.h
>  
>  ARM/TEXAS INSTRUMENT KEYSTONE ARCHITECTURE
>  M:	Santosh Shilimkar <ssantosh@kernel.org>
> diff --git a/include/dt-bindings/pinctrl/k3.h b/include/dt-bindings/pinctrl/k3.h
> new file mode 100644
> index 000000000000..463d845a9b36
> --- /dev/null
> +++ b/include/dt-bindings/pinctrl/k3.h
> @@ -0,0 +1,35 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * This header provides constants for pinctrl bindings for TI's K3 SoC
> + * family.
> + *
> + * Copyright (C) 2018 Texas Instruments Incorporated - http://www.ti.com/
> + */
> +#ifndef _DT_BINDINGS_PINCTRL_TI_K3_H
> +#define _DT_BINDINGS_PINCTRL_TI_K3_H
> +
> +#define PULLUDEN_SHIFT		(16)
> +#define PULLTYPESEL_SHIFT	(17)
> +#define RXACTIVE_SHIFT		(18)
> +
> +#define PULL_DISABLE		(1 << PULLUDEN_SHIFT)
> +#define PULL_ENABLE		(0 << PULLUDEN_SHIFT)
> +
> +#define PULL_UP			(1 << PULLTYPESEL_SHIFT | PULL_ENABLE)
> +#define PULL_DOWN		(0 << PULLTYPESEL_SHIFT | PULL_ENABLE)
> +
> +#define INPUT_EN		(1 << RXACTIVE_SHIFT)
> +#define INPUT_DISABLE		(0 << RXACTIVE_SHIFT)
> +
> +/* Only these macros are expected be used directly in device tree files */
> +#define PIN_OUTPUT		(INPUT_DISABLE | PULL_DISABLE)
> +#define PIN_OUTPUT_PULLUP	(INPUT_DISABLE | PULL_UP)
> +#define PIN_OUTPUT_PULLDOWN	(INPUT_DISABLE | PULL_DOWN)
> +#define PIN_INPUT		(INPUT_EN | PULL_DISABLE)
> +#define PIN_INPUT_PULLUP	(INPUT_EN | PULL_UP)
> +#define PIN_INPUT_PULLDOWN	(INPUT_EN | PULL_DOWN)


Thanks for reducing the combinations down to the minimum needed. We can
worry about the DS and isolation bits when we have a real user for them.

Acked-by: Nishanth Menon <nm@ti.com>

Tero: v4.21-rc1 perhaps ?

-- 
Regards,
Nishanth Menon
