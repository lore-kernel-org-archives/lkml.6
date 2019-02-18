Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB006C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80C7C21872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 13:38:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qKoNlwCc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731130AbfBRNi3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 08:38:29 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39636 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729863AbfBRNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:38:29 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IDcL81108709;
        Mon, 18 Feb 2019 07:38:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550497101;
        bh=O2Ngd/EkZl30AhJzB4W4SRuWcLF7RsbS6QfEfk+DNhY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=qKoNlwCcNwii1XoSy+1oepM8SXqc88dRrVM4+eOPOz4/yd2WWfUCFA38rerA+/Rja
         NJdgYzhAQXRz4VgBEDZSAg/76CSa1XXcMtGnSfP02+Z0wsp0t3c3tCnC3Mk8xBTZzI
         SMZNHzLhNlTpNBD5rId1xKdWsh1RIMv1O3Kv+xEE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IDcKXa109904
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 07:38:20 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 07:38:20 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 07:38:20 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IDcGB1012991;
        Mon, 18 Feb 2019 07:38:17 -0600
Subject: Re: [PATCH v2 3/8] dt-bindings: sdhci-omap: Add properties for using
 external dma
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215192033.24203-4-faiz_abbas@ti.com>
 <20190215200718.GB15711@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <2aa0f7e4-c880-ee88-2e88-dc2c3187f0c9@ti.com>
Date:   Mon, 18 Feb 2019 19:11:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215200718.GB15711@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 16/02/19 1:37 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [190215 19:18]:
>> From: Chunyan Zhang <zhang.chunyan@linaro.org>
>>
>> sdhci-omap can support both external dma controller via dmaengine
>> framework as well as ADMA which standard SD host controller
>> provides.
> 
> Care to describe here also how to configure things for ADMA and
> instead of DMA? Just leave out dmas property?
> 

That's correct. If dmas property is populated, then use external DMA.
Otherwise use ADMA/SDMA depending on what you read from the CAPS register.

Thanks,
Faiz
