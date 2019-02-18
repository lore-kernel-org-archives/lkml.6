Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0651FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E3D2070B
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ArSkVbj1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731901AbfBROqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:46:46 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:44168 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730509AbfBRNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 08:46:15 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1IDk1h0065360;
        Mon, 18 Feb 2019 07:46:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1550497561;
        bh=EiFzKaseb2qRdh2TMJa9809wwVz6VCcZEKHyoDAgxHU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ArSkVbj1asf651ZMTou+3QK7Yv0LGnoqaWwOnRP6ZydURB3IiRJpLp84bNUJGOv/3
         mp/NhNMZ/FhAqb9NiZBDrcTda7kQaOJjqy/QVKNeeOPk9soJUIBOlFOdO8Q8Evujmz
         G38sbYV0oLA7vOe9OhNKcfXFyJ2mYBfhatv+rhDE=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1IDk1s2043513
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Feb 2019 07:46:01 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 18
 Feb 2019 07:46:00 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 18 Feb 2019 07:46:00 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1IDjvDI023094;
        Mon, 18 Feb 2019 07:45:57 -0600
Subject: Re: [PATCH v2 0/8] Port am335 and am437 devices to sdhci-omap
To:     Tony Lindgren <tony@atomide.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>, <kishon@ti.com>,
        <zhang.chunyan@linaro.org>
References: <20190215192033.24203-1-faiz_abbas@ti.com>
 <20190215200244.GA15711@atomide.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <0c3b5570-c5ec-46c8-2548-8049100661d3@ti.com>
Date:   Mon, 18 Feb 2019 19:19:13 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215200244.GA15711@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 16/02/19 1:32 AM, Tony Lindgren wrote:
> * Faiz Abbas <faiz_abbas@ti.com> [190215 19:17]:
>> The following add driver patches for porting TI's am335x and am437x
>> devices to the sdhci-omap driver.
>>
>> This involves adding external DMA support to sdhci (first 3 patches from
>> Chunyan) plus some miscellaneous patches to take care of deviations of
>> the controllers from the sdhci model.
> 
> Good to see this happening :)
> 
> I think am437x should have also the ADMA as it's mostly
> omap4 based? See the old omap4 ADMA series at [0] below.
> 
> Are you seeing any improvment in SDIO card read/write speeds
> between external DMA and ADM BTW

am437 is using dmaengine even in the old omap_hsmmc driver. I haven't
tried to enable ADMA in am437x.

Thanks,
Faiz
