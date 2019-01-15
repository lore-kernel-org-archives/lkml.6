Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063D3C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5E9520675
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="gVoo8cR1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730486AbfAOOmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:42:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42150 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfAOOmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:42:16 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FEfuiT088359;
        Tue, 15 Jan 2019 08:41:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547563316;
        bh=z6ivnjzqL7Qk7XE0eIEH7tBIccSSvV8fcvcgefP5OUE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=gVoo8cR1r/WSrtGoBYdoZzi9JF+LF+2Ro72Nhkbstzti+A5nVzEFG0XLacqqzzwS6
         I8RJ/xuj6f7begg/wZrc5eSQQHJVdbs/BwEO1xPIA4SDG18ONcqcl6sydGd7bpZL7S
         n+gpuYPRoxMOgmTqb2hS7IQFYlqgnDWvSlzkxMa4=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FEfuhe075478
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 08:41:56 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:41:56 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:41:56 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FEfuP5013832;
        Tue, 15 Jan 2019 08:41:56 -0600
Date:   Tue, 15 Jan 2019 08:41:23 -0600
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
Subject: Re: [RFC PATCH v4 10/13] soc: ti: Add MSI domain support for K3
 Interrupt Aggregator
Message-ID: <20190115144123.3lmt4qqi5y5ssiym@kahuna>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-10-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20181227061313.5451-10-lokeshvutla@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:43-20181227, Lokesh Vutla wrote:
> With the system coprocessor managing the range allocation of the
> inputs to Interrupt Aggregator, it is difficult to represent
> the device IRQs from DT.
> 
> The suggestion is to use MSI in such cases where devices wants
> to allocate and group interrupts dynamically.
> 
> Create a MSI domain bus layer that allocates and frees MSIs for
> a device.
> 
> APIs that are implemented are:
> - inta_msi_create_irq_domain() that creates a MSI domain
> - inta_msi_domain_alloc_group_irqs() that creates MSIs for the
>   specified device and source indexes. All these are expected to
>   be grouped by the parent interrupt controller to MSI domain.
> - inta_msi_domain_free_group_irqs() frees the grouped irqs.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> ---
> 
> - May be the same functionaly can be included in platform msi. But I would
>   like to get a feedback on the approach.
> 
>  drivers/soc/ti/Kconfig             |   6 +
>  drivers/soc/ti/Makefile            |   1 +
>  drivers/soc/ti/k3_inta_msi.c       | 193 +++++++++++++++++++++++++++++
>  include/linux/irqdomain.h          |   1 +
>  include/linux/msi.h                |   6 +
>  include/linux/soc/ti/k3_inta_msi.h |  22 ++++
>  6 files changed, 229 insertions(+)
>  create mode 100644 drivers/soc/ti/k3_inta_msi.c
>  create mode 100644 include/linux/soc/ti/k3_inta_msi.h

Did we miss maintainer file?

-- 
Regards,
Nishanth Menon
