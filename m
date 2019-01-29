Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A245C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AE19214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 03:39:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="EfO7juve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727383AbfA2Djw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 22:39:52 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:57286 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbfA2Djw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 22:39:52 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0T3dg2l029127;
        Mon, 28 Jan 2019 21:39:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548733182;
        bh=AkXydaiGtrwDktN8Esjpx2/m1Iim9UVtxue7Gz0mdKk=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=EfO7juvesTlSid2IL3ZNmgQsKOUikfs3pFr9ESrWJYAy3XMHKeSsY33b6mpQnvmTp
         i6WIHmGfK4NY+tcEzEvwCpZiJI6PPuHZfOCkGP3eQX8Wz4FUKiFkYwv0zjRJRZ2im+
         3YYpf3zuKHP55JmYC2y5GV+GCRZIDFOqqy76pkBs=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0T3dgKh036495
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 21:39:42 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 28
 Jan 2019 21:39:41 -0600
Received: from dflp33.itg.ti.com (10.64.6.16) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 28 Jan 2019 21:39:41 -0600
Received: from [172.24.191.45] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0T3ddLP019454;
        Mon, 28 Jan 2019 21:39:40 -0600
Subject: Re: linux-5.0-rc3, ti-soc-thermal: unmet dependencies Kconfig warning
To:     Tony Lindgren <tony@atomide.com>,
        Randy Dunlap <rdunlap@infradead.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        <linux-omap@vger.kernel.org>,
        Eduardo Valentin <edubezval@gmail.com>
References: <8baafd04-eda0-778d-84d2-7ccc1d07db6b@infradead.org>
 <20190128163433.GY5720@atomide.com>
From:   Keerthy <j-keerthy@ti.com>
Message-ID: <6c970fca-35ea-f327-3f77-9b61c37554d5@ti.com>
Date:   Tue, 29 Jan 2019 09:09:45 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190128163433.GY5720@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/19 10:04 PM, Tony Lindgren wrote:
> Hi,
> 
> * Randy Dunlap <rdunlap@infradead.org> [190126 06:54]:
>> Hi,
>>
>> FYI, I'm seeing this Kconfig warning in 5.0-rc3:
> 
> Thanks for reporting it.
> 
>> WARNING: unmet direct dependencies detected for TI_SOC_THERMAL
>>   Depends on [n]: THERMAL [=y] && (ARCH_HAS_BANDGAP || COMPILE_TEST [=n]) && HAS_IOMEM [=y]
>>   Selected by [m]:
>>   - MMC_SDHCI_OMAP [=m] && MMC [=m] && MMC_SDHCI_PLTFM [=m] && OF [=y]
>>
>>
>> Maybe there is already a patch for this?
> 
> Keerthy can you please take a look at this issue?

https://lore.kernel.org/patchwork/patch/1030366/

This is fixed. It is in the linux-next already.

> 
> Regards,
> 
> Tony
> 

