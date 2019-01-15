Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1E53C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C261520657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="co9VSJ0/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730293AbfAOOFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:05:50 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50312 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727060AbfAOOFt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:05:49 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FE5Oph002503;
        Tue, 15 Jan 2019 08:05:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547561124;
        bh=peA5Y3S5lzMHrlqAIVzaXCVj5lbvtbwMS+pHxRRHHNM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=co9VSJ0/2RfAijiphs3vwaDY+lkLjJziFoHMT5wFC1Du2LUBFfc4ZnAscGehT/NXN
         SEBoONCcYdU43AfKjz4hngJkVElXcYlVX/jlnLesug44vXvDP0FOD0vob0WTNrYZB1
         Yueu5iNXrM+ZrDSJQf4ohVPH3sLB31GHNe98p7+g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FE5Ou6038046
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 08:05:24 -0600
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:05:24 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:05:24 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FE5ONR022804;
        Tue, 15 Jan 2019 08:05:24 -0600
Date:   Tue, 15 Jan 2019 08:04:51 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <t-kristo@ti.com>
CC:     Lokesh Vutla <lokeshvutla@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>, <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH v4 12/13] irqchip: ti-sci-inta: Add support for
 Interrupt Aggregator driver
Message-ID: <20190115140451.fnmvqm5kcfgt7rh2@kahuna>
References: <20181227060829.5080-1-lokeshvutla@ti.com>
 <20181227061313.5451-1-lokeshvutla@ti.com>
 <20181227061313.5451-12-lokeshvutla@ti.com>
 <9efbb01b-2ef9-13e7-f871-8db2c92844ee@ti.com>
 <50da7038-9b1c-6910-2cf1-78fa98ddc3bd@ti.com>
 <ad43911d-78b2-6ed0-31c2-8361b5f4911f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ad43911d-78b2-6ed0-31c2-8361b5f4911f@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14:38-20190115, Tero Kristo wrote:
[...]
> 
> The mentioned failure only happens with a specific .config. Not sure what is
> the actual Kconfig that masks the failure though, but anyway it looks like
> interrupt.h gets included via some indirect path with arm64 defconfig making
> it pass.

I am able to reproduce the build fail as well:
.config: -> Notice that all v8 arch other than K3 is disabled, expert
mode is enabled and few ancillary "optimization" of config
	  https://pastebin.ubuntu.com/p/w5t9Wvp2jJ/
Here is what I did:
 git checkout next-20190115
 wget -O inta.mbox https://lore.kernel.org/patchwork/series/377815/mbox/
 git am inta.mbox
 I put the above .config as my .config
 make oldconfig
 make drivers/irqchip/irq-ti-sci-inta.o

I got the exact failure as well..
 https://pastebin.ubuntu.com/p/JzFXGz7Gh9/

I agree with peter than this should be fixed. randconfig would have
caught this anyways.. I did'nt bother looking further in the config to
figure out why the side effect, but glad it got caught early enough.

Thanks Peter.

Lokesh, I know you are out this week, will appreciate if you could post
a v5 once you are back?

-- 
Regards,
Nishanth Menon
