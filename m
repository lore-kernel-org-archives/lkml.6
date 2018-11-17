Return-Path: <SRS0=6aQE=N4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F71C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0AD20815
	for <linux-kernel@archiver.kernel.org>; Sat, 17 Nov 2018 16:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0AD20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbeKRC2d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 21:28:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:33868 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726065AbeKRC2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 21:28:33 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wAHGApF5104482;
        Sat, 17 Nov 2018 10:10:51 -0600
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wAHGApIB022209
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 17 Nov 2018 10:10:51 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Sat, 17
 Nov 2018 10:10:51 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Sat, 17 Nov 2018 10:10:51 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wAHGApd4026481;
        Sat, 17 Nov 2018 10:10:51 -0600
Date:   Sat, 17 Nov 2018 10:10:31 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Vignesh R <vigneshr@ti.com>
CC:     Tero Kristo <t-kristo@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/4] AM654: Add pinmux support
Message-ID: <20181117161031.tedf2hvkhwd4f2kd@kahuna>
References: <20181113060111.16374-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181113060111.16374-1-vigneshr@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:31-20181113, Vignesh R wrote:
> Add pinmux definitions and pinctrl regions for AM654 SoCs
> and enable uart and i2c.
> 
> v2:
> Add only minimum needed macros in dt-bindings include file
> New patches to illustrate pinmux using uart and i2c
> 
> 
> Tero Kristo (1):
>   arm64: dts: ti: k3-am65: Add pinctrl regions
> 
> Vignesh R (3):
>   dt-bindings: pinctrl: k3: Introduce pinmux definitions
>   arm64: dts: ti: am654-base-board: Add pinmux for main uart0
>   arm64: dts: ti: k3-am654-base-board: Add I2C nodes
> 
>  MAINTAINERS                                   |  1 +
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 60 +++++++++++++
>  arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi       | 11 +++
>  arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi    | 19 ++++
>  arch/arm64/boot/dts/ti/k3-am65.dtsi           |  7 ++
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 86 +++++++++++++++++++
>  include/dt-bindings/pinctrl/k3.h              | 35 ++++++++
>  7 files changed, 219 insertions(+)
>  create mode 100644 include/dt-bindings/pinctrl/k3.h

The last patch was a bit sneaky ;)... but there is nothing controversial
in it..

Series: Acked-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
