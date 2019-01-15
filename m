Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C55DC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EDD20866
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:30:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hnjvYWC4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730410AbfAOOa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 09:30:26 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:39858 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbfAOOa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 09:30:26 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0FEULhW107461;
        Tue, 15 Jan 2019 08:30:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1547562621;
        bh=u+0A9ra6HbEV0+gtRGluL/UpmwxpXHi6otB4YmdSGGc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=hnjvYWC4fvAGSuWvX21msCTRFH9MrWGQ0az/sxZCaZej7dyMiwsbZaOlPljSN3flj
         frEEN7QIRYHdufMRajQ+5aFmggMrVXjOWgEPCNidVSUaC6OukcxI8X2Z7TdUUhfbKK
         Qf4AoH7FU6ExO66yC7LhMoOWb2Ae0BZkz6vdmmnY=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0FEULer113773
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Jan 2019 08:30:21 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 15
 Jan 2019 08:30:21 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 15 Jan 2019 08:30:20 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0FEUKGI029469;
        Tue, 15 Jan 2019 08:30:20 -0600
Date:   Tue, 15 Jan 2019 08:29:48 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Faiz Abbas <faiz_abbas@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <t-kristo@ti.com>
Subject: Re: [PATCH v2 0/2] Support for eMMC in AM65x-evm
Message-ID: <20190115142948.3fq2i6vav7jn4ulq@kahuna>
References: <20190110073355.3382-1-faiz_abbas@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190110073355.3382-1-faiz_abbas@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13:03-20190110, Faiz Abbas wrote:
> The following patches add eMMC support on TI's AM65x-evm.
> 
> v2:
>  1. The SD card node is under debug for some usecases.
>     Only upstreaming eMMC support for now.
>  2. Rebased to latest mainline.
>  3. Removed status = "disabled" from dtsi patch
>  4. Fixed node name to not include '_'s
> 
> Faiz Abbas (2):
>   arm64: dts: ti: k3-am654: Add Support for MMC/SD
>   arm64: dts: ti: k3-am654-base-board: Add MMC/SD support

Once the $subject changes in the above two patches (should be emmc
instead of MMC/SD):

Acked-by: Nishanth Menon <nm@ti.com>

> 
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 13 ++++++++++
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
>  2 files changed, 38 insertions(+)
> 
> -- 
> 2.19.2
> 

-- 
Regards,
Nishanth Menon
