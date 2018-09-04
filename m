Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A3FC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC82A2086B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 13:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qyzFuAJa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC82A2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbeIDSHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 14:07:33 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:47938 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbeIDSHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 14:07:33 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w84DfgBM062185;
        Tue, 4 Sep 2018 08:41:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536068502;
        bh=QsGteD1wCYVBC4YAKDhItyX/CzEW6FyzuksqpypK8E0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=qyzFuAJa8PwMkOQbu0pAYK/EFsSqcwXVGXbC7I4mRaVLYdMYYrJ4Md4Osr3E1KZs6
         x0VcVZIBIe93TgJ+SSBLg0Sgv+e6yBZdDgTIexaoIGs8du147hSablIgpKbm1YW/bu
         62wtuWbZWFRRsD32n1/uUP0SwXt+Noaj/9fPUUGk=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84Dfgpm006056;
        Tue, 4 Sep 2018 08:41:42 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 4 Sep
 2018 08:41:42 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 4 Sep 2018 08:41:42 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w84DfgOC015444;
        Tue, 4 Sep 2018 08:41:42 -0500
Date:   Tue, 4 Sep 2018 08:41:42 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>
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
Subject: Re: [PATCH v2] arm64: dts: ti: k3-am65: Change #address-cells and
 #size-cells of interconnect to 2
Message-ID: <20180904134142.npoxfimfsllmxdwb@akan>
References: <20180903095235.13853-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180903095235.13853-1-kishon@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:22-20180903, Kishon Vijay Abraham I wrote:

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

Please add Fixes

Vignesh, Sekhar, Tony,

Do we agree this is the right way to go forward? if yes, please
ack.


-- 
Regards,
Nishanth Menon
