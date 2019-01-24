Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C74AC282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39DA621872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 08:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JdGD3Z7o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfAXIKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 03:10:16 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56696 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726199AbfAXIKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 03:10:15 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0O8A49h099682;
        Thu, 24 Jan 2019 02:10:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548317404;
        bh=nmlwrTBXW64ZPlXQdFP+YjWL0kWaAkTKk/ABJsJIwo8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JdGD3Z7o/8/efEp3z4ON9lSGHxmQgXpgeBAR5o5wSK7U6QEmwHX3qLcywh2u0djD9
         0nM3TVSm2ezDKcFc6DIOhYqhOdXP77pX8r1GFobgfwwO8OY4i88gcAU/XzsylXj1bR
         aJyG7tXwZtYR2M7pt0xq8T5PAmXy8F+QWmEn/4Pk=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0O8A4C0106863
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 24 Jan 2019 02:10:04 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 24
 Jan 2019 02:10:04 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 24 Jan 2019 02:10:04 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0O8A1tY006223;
        Thu, 24 Jan 2019 02:10:02 -0600
Subject: Re: [PATCH v3 0/2] Support for eMMC in AM65x-evm
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <mark.rutland@arm.com>, <robh+dt@kernel.org>, <nm@ti.com>,
        <t-kristo@ti.com>
References: <20190117094424.7683-1-faiz_abbas@ti.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <d75a123b-9e97-a3d1-1e3c-41ef6942dffb@ti.com>
Date:   Thu, 24 Jan 2019 13:43:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190117094424.7683-1-faiz_abbas@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 17/01/19 3:14 PM, Faiz Abbas wrote:
> The following patches add eMMC support on TI's AM65x-evm.
> 
> v3:
>  1. Fixed patch titles to only include eMMC
>  2. Added dma-coherent to the sdhci0 node.
> 
> v2:
>  1. The SD card node is under debug for some usecases.
>     Only upstreaming eMMC support for now.
>  2. Rebased to latest mainline.
>  3. Removed status = "disabled" from dtsi patch
>  4. Fixed node name to not include '_'s
> 
> Faiz Abbas (2):
>   arm64: dts: ti: k3-am654: Add Support for eMMC host controller
>   arm64: dts: ti: k3-am654-base-board: Add eMMC Support
> 
>  arch/arm64/boot/dts/ti/k3-am65-main.dtsi      | 14 +++++++++++
>  .../arm64/boot/dts/ti/k3-am654-base-board.dts | 25 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
> 

Gentle ping.

Thanks,
Faiz
