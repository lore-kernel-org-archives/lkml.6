Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A86C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 828472082D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QW17o3oO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 828472082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbeLDIYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:24:54 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47828 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbeLDIYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:24:53 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wB48Ol3d011304;
        Tue, 4 Dec 2018 02:24:47 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1543911887;
        bh=JG2F6XvoKEitfctbKdtUAdofVt4T0jOX7yAo/KKx1Q0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QW17o3oOMcixQZvZLgUSxdfOsZz49SXCVH39vRK+UMN8gcWgNZpGIzklE5UURFcvK
         OXK7l9jrJ1nrumPIvNq8LK8iDGYhIwR7CDyy2hJEhDMqn4QjBOjxH1ZnAc0daFNsSw
         YZELz4DMWlR4Gl16wywCuVa7at6uH9d1CcRnBWQY=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wB48Olhc003453
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Dec 2018 02:24:47 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Tue, 4
 Dec 2018 02:24:47 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Tue, 4 Dec 2018 02:24:47 -0600
Received: from [172.24.190.215] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wB48OjDu018789;
        Tue, 4 Dec 2018 02:24:46 -0600
Subject: Re: [PATCH v2 0/3] Tuning Fixes for sdhci-omap
To:     Adrian Hunter <adrian.hunter@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>
CC:     <ulf.hansson@linaro.org>, <kishon@ti.com>
References: <20181121103357.3448-1-faiz_abbas@ti.com>
 <3f64fb93-ecdd-d439-1001-be8117f63990@intel.com>
From:   Faiz Abbas <faiz_abbas@ti.com>
Message-ID: <492f4851-8068-d20b-68e8-ece0fa493b05@ti.com>
Date:   Tue, 4 Dec 2018 13:57:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <3f64fb93-ecdd-d439-1001-be8117f63990@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21/11/18 4:53 PM, Adrian Hunter wrote:
> On 21/11/18 12:33 PM, Faiz Abbas wrote:
>> The following patches fix tuning related errors in the
>> sdhci-omap driver.
>>
>> v2:
>> Added Fixes and stable tags for patch 1.
>> Re-enable DCRC in patch 1 only if it was enabled before
>> Squashed patches 2 & 3
>>
>> Faiz Abbas (3):
>>   mmc: sdhci-omap: Fix DCRC error handling during tuning
>>   mmc: sdhci-omap: Add platform specific reset callback
>>   mmc: sdhci-omap: Remove redundant structure assignments
>>
>>  drivers/mmc/host/sdhci-omap.c | 36 ++++++++++++++++++++++++++---------
>>  1 file changed, 27 insertions(+), 9 deletions(-)
>>
> 
> Acked-by: Adrian Hunter <adrian.hunter@intel.com>

Gentle ping.

Thanks,
Faiz

