Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEA4C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2B1020651
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 13:55:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pRtGyIda"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730109AbfAONzu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 08:55:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:33552 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729099AbfAONzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 08:55:49 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FDtUgR096889;
        Tue, 15 Jan 2019 07:55:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547560530;
        bh=M4E9szcMy2s/1G1NcDsPyh7e/Ea7sPKwxtbQVHhwljQ=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pRtGyIdaRglXIN7p6XoRFmsBFfVsG5AQvr0cYrZxdQusWrTu7n/iTsIszAOSsbo6r
         y+tH8HFY2sy/49gUoBffBaYNFVyyk3RC9hLpz175dHEzxDCN0ZGvqHPyC8BvcSk6VJ
         pUkOA+Q/SXsR+Ecnz0SuLSHf28dVmVAvvztcPiT0=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FDtU8R119636
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 07:55:30 -0600
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 07:55:29 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 07:55:29 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FDtTtW025526;
        Tue, 15 Jan 2019 07:55:29 -0600
Date:   Tue, 15 Jan 2019 07:54:57 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Lokesh Vutla <lokeshvutla@ti.com>
CC:     <marc.zyngier@arm.com>, Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC PATCH v4 13/13] soc: ti: am6: Enable interrupt controller
 drivers
Message-ID: <20190115135457.2x6huvgtth2yjhhq@kahuna>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-13-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181227061313.5451-13-lokeshvutla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:43-20181227, Lokesh Vutla wrote:
> Select all the TISCI dependent interrupt controller drivers
> for AM6 SoC.
> 
> Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
>  drivers/soc/ti/Kconfig | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 7640490c2a6a..145b701a3d96 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -5,6 +5,11 @@ if ARCH_K3
>  
>  config ARCH_K3_AM6_SOC
>  	bool "K3 AM6 SoC"
> +	select MAILBOX
> +	select TI_MESSAGE_MANAGER
> +	select TI_SCI_PROTOCOL
> +	select TI_SCI_INTR_IRQCHIP
> +	select TI_SCI_INTA_IRQCHIP

Sorry for joining the party late.. but just 2 cents for thought..

Is'nt imply better than select here? for a very tiny kernel, it is
possible to boot kernel up and TISCI and mailbox could be modules as
well.. I know it is a theoretical concept, but it may be helpful (esp
during pre-silicon time frame, at least during start, I usually start
with almost everything other than the CPU cores and PSCI disabled).
there is not much you can do with it ofcourse, but it helps me with a
clean start.


>  	help
>  	  Enable support for TI's AM6 SoC Family support
>  
> -- 
> 2.19.2
> 

-- 
Regards,
Nishanth Menon
