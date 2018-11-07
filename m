Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3760DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1E782089A
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:01:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1E782089A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731325AbeKHCch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:32:37 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58392 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbeKHCch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:32:37 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wA7H0WxA110520;
        Wed, 7 Nov 2018 11:00:32 -0600
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wA7H0W7S040399
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 7 Nov 2018 11:00:32 -0600
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Wed, 7 Nov
 2018 11:00:31 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Wed, 7 Nov 2018 11:00:32 -0600
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id wA7H0S3M025400;
        Wed, 7 Nov 2018 11:00:29 -0600
Subject: Re: [PATCH v2 0/2] i2c-omap: Enable i2c-omap driver for AM654 SoCs
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     Rob Herring <robh+dt@kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Menon, Nishanth" <nm@ti.com>,
        Peter Rosin <peda@axentia.se>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>
References: <20180928052557.21663-1-vigneshr@ti.com>
 <09a6b1d4-f8f4-ea90-f361-bd3a92088430@ti.com> <20181028223450.GK1882@kunai>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <c664348b-bb5b-9cba-6ed5-040014515477@ti.com>
Date:   Wed, 7 Nov 2018 22:31:24 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181028223450.GK1882@kunai>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/18 4:04 AM, Wolfram Sang wrote:
> On Sat, Oct 20, 2018 at 01:23:40PM +0530, Vignesh R wrote:
>>
>>
>> On 28-Sep-18 10:55 AM, Vignesh R wrote:
>>> Couple of patches to enable i2c-omap driver to be used with TI's new
>>> AM654 platforms.
>>>
>>>
>>> Vignesh R (2):
>>>   dt-bindings: i2c-omap: Add new compatible for AM654 SoCs
>>>   i2c: busses: Kconfig: Enable I2C_OMAP for ARCH_K3
>>>
>>>  Documentation/devicetree/bindings/i2c/i2c-omap.txt | 8 ++++++--
>>>  drivers/i2c/busses/Kconfig                         | 2 +-
>>>  2 files changed, 7 insertions(+), 3 deletions(-)
>>>
>>
>> Gentle ping...
> 
> Maintainer tags are missing. Tony is listed for this driver on OMAP2+.
> Is this his realm? Do we need a specific maintainer for this driver?
> 

I think this driver needs a separate entry, will send a patch adding my
name as reviewer for this driver.

-- 
Regards
Vignesh
