Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05761C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C81DB20672
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 08:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OPq4lPKv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeLQIZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 03:25:08 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52012 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726700AbeLQIZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 03:25:08 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBH8Omar015191;
        Mon, 17 Dec 2018 02:24:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1545035088;
        bh=vx04N3C4JziSTM0yycYesCRexANe0gUKYVrkn3GpAK0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=OPq4lPKvNtfRqf8sYRKMnhW6xQBt3skk8g2sG3m1q+LwkWy50jlvr6mSKebypwDdU
         IRh/xMlBCW3qMiCBf1AXCs2kfavQvdDrKFNd0Y4fGigFz2B7u7isVtmc9N3EadacTo
         3NCNmkVD9vFAddymBRUXLX/RNzemrVAc7Nu+0zcg=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBH8Omng024423
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 17 Dec 2018 02:24:48 -0600
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 17
 Dec 2018 02:24:48 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 17 Dec 2018 02:24:48 -0600
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBH8OiWU019543;
        Mon, 17 Dec 2018 02:24:45 -0600
Subject: Re: [PATCH v3 0/3] Add driver Support for MMCSD on AM654x
To:     Faiz Abbas <faiz_abbas@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <kishon@ti.com>
References: <20181210183507.9617-1-faiz_abbas@ti.com>
 <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <38fe3521-f029-5e1b-78be-f265c5764a3b@ti.com>
Date:   Mon, 17 Dec 2018 13:54:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <378ace78-7345-8875-f3e7-7cddcaf5e4bc@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/12/18 1:45 PM, Faiz Abbas wrote:
> Hi,
> 
> On 11/12/18 12:05 AM, Faiz Abbas wrote:
>> The following patches add driver support for MMCSD on TI's AM654
>> platforms.
>>
>> Previously I had added the support to sdhci-of-arasan driver with
>> a separate phy driver[1]. Since then it has turned out that tuning
>> operation (for HS200, HS400 and SDR104 speed modes) will require
>> configuration of phy registers. This completely breaks the model of
>> the sdhci-of-arasan driver which relies on a separate driver to
>> configure the phy register space.
>>
>> Because of this, I am creating a new driver with both the sdhci and
>> phy register spaces. This helps me use the phy registers in a future
>> patch that adds tuning support.
>>
>> DT patches will be posted in a separate series.
>>
>> Changes in v3:
>>  1. Removed reference to clk_ahb as its not being used.
>>  2. Added comment for pm_runtime being used for enabling
>>     clocks.
>>
>> Changes in v2:
>>  1. Reset OTAP delay back to default value in init.
>>  2. Improved patch description for patch 2.
>>  3. Minor style fixes.
>>
>> [1] driver and phy patches posted before
>>     https://patchwork.kernel.org/project/linux-mmc/list/?series=26623
>>
>> Faiz Abbas (3):
>>   dt-bindings: mmc: sdhci-am654: Document bindings for the host
>>     controllers on TI's AM654 SOCs
>>   dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for am65
>>   mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
>>
>>  .../devicetree/bindings/mmc/arasan,sdhci.txt  |   4 +
>>  .../devicetree/bindings/mmc/sdhci-am654.txt   |  37 ++
>>  drivers/mmc/host/Kconfig                      |  12 +
>>  drivers/mmc/host/Makefile                     |   1 +
>>  drivers/mmc/host/sdhci-of-arasan.c            |  46 ---
>>  drivers/mmc/host/sdhci_am654.c                | 374 ++++++++++++++++++
>>  6 files changed, 428 insertions(+), 46 deletions(-)
>>  create mode 100644 Documentation/devicetree/bindings/mmc/sdhci-am654.txt
>>  create mode 100644 drivers/mmc/host/sdhci_am654.c
> 
> 
> Gentle ping.

I see these in linux-next. 

aff88ff23512 (Faiz Abbas) 6 days ago  mmc: sdhci_am654: Add Initial Support for AM654 SDHCI driver
7f6e4cc6727d (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-of-arasan: Add deprecated message for AM65
351b766ef2c7 (Faiz Abbas) 6 days ago  dt-bindings: mmc: sdhci-am654: Document bindings for the host controllers on TI's AM654 SOCs

Thanks,
Sekhar
