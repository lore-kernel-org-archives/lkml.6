Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557BAC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E2DC2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rOWpEpNg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E2DC2075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbeIESL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 14:11:26 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:38666 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbeIESL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 14:11:26 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w85DecSI025176;
        Wed, 5 Sep 2018 08:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536154838;
        bh=dkt8JdM0LOiZ5JRkEiDvnKCpH/fnSWWzVsvhT+rMSIE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=rOWpEpNgPPRI/86pNMJROQssUJPD3rMdhoKVzD4LXeEsa7iKW8CDC4DpPdX5OKQui
         fudVMxghI4ncL59kcUETWRSG8k5/Cu3r1vSdcS/Yye3aMDssmE8NNV5LDyK4ec7Q7V
         SeLJRTvzfs4bh0k1utgItxmKdV4EjvRj3HJbyjNs=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85Decmo028135;
        Wed, 5 Sep 2018 08:40:38 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 5 Sep
 2018 08:40:38 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 5 Sep 2018 08:40:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w85DebFm020966;
        Wed, 5 Sep 2018 08:40:38 -0500
Date:   Wed, 5 Sep 2018 08:40:37 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Tero Kristo <t-kristo@ti.com>
CC:     Tony Lindgren <tony@atomide.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <devicetree@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, Vignesh R <vigneshr@ti.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
Message-ID: <20180905134037.szkh3wnugrtnrrfh@kahuna>
References: <20180905111738.8280-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180905111738.8280-1-kishon@ti.com>
User-Agent: NeoMutt/20170714-126-deb55f (1.8.3)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11:17-20180905, Kishon Vijay Abraham I wrote:
> AM65 has two PCIe controllers and each PCIe controller has '2' address
> spaces one within the 4GB address space of the SoC and the other above
> the 4GB address space of the SoC (cbass_main) in addition to the
> register space. The size of the address space above the 4GB SoC address
> space is 4GB. These address ranges will be used by CPU/DMA to access
> the PCIe address space. In order to represent the address space above
> the 4GB SoC address space and to represent the size of this address
> space as 4GB, change address-cells and size-cells of interconnect to 2.
> 
> Since OSPI has similar need in MCU Domain Memory Map, change
> address-cells and size-cells of cbass_mcu interconnect also to 2.
> 
> Fixes: ea47eed33a3fe3d919 ("arm64: dts: ti: Add Support for AM654 SoC")
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Vignesh R <vigneshr@ti.com>
> ---
> Changes from v2:
> Added Fixes tag.

Thanks.
Acked-by: Nishanth Menon <nm@ti.com>

Tero: Could we take this for v4.20 ? While this is a bug fix, I think
it might be better in v4.20 window since it will help provide a clean merge
of follow on nodes.

-- 
Regards,
Nishanth Menon
