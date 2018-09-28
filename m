Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB54C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C7182170E
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 05:27:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mbojafY/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C7182170E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbeI1LtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 07:49:24 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54540 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbeI1LtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 07:49:24 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8S5RNBB104699;
        Fri, 28 Sep 2018 00:27:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538112443;
        bh=p1SZM5aS56QGrpqtlxlo0AM9m1s3g1j+Tqi8umoM0Sw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mbojafY/Y2acz4VYzoz/PaiLIJ/SWvewJIQohNqb//3/cS2TXa962QDGzoRFFasKY
         6MxiYJkMq9uIV8bP9ZcuORCGlLD8sD6hrOAc/UdV3KXjIUTmL5cbRJpDZBN8EY9okq
         FOhsiYLt4jY8IQ4ihaDhQEkRQCHxP5mexM8q045o=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5RNQH024726;
        Fri, 28 Sep 2018 00:27:23 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 28
 Sep 2018 00:27:23 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 28 Sep 2018 00:27:23 -0500
Received: from [172.24.190.89] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8S5RLRr008234;
        Fri, 28 Sep 2018 00:27:22 -0500
Subject: Re: [PATCH v4] ARM: dts: dra7: Fix up unaligned access setting for
 PCIe EP
To:     Tony Lindgren <tony@atomide.com>
CC:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180925052151.9537-1-vigneshr@ti.com>
 <20180926172711.GW5662@atomide.com>
From:   Vignesh R <vigneshr@ti.com>
Message-ID: <eb3bb7ba-e32d-aa0f-1877-985ab3d6fe4c@ti.com>
Date:   Fri, 28 Sep 2018 10:58:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926172711.GW5662@atomide.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday 26 September 2018 10:57 PM, Tony Lindgren wrote:
> * Vignesh R <vigneshr@ti.com> [180924 22:25]:
>> Bit positions of PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE and
>> PCIE_SS1_AXI2OCP_LEGACY_MODE_ENABLE in CTRL_CORE_SMA_SW_7 are
>> incorrectly documented in the TRM. In fact, the bit positions are
>> swapped. Update the DT bindings for PCIe EP to reflect the same.
>>
>> Fixes: d23f3839fe97 ("ARM: dts: DRA7: Add pcie1 dt node for EP mode")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vignesh R <vigneshr@ti.com>
>> ---
>>
>> This patch is split from v3 here:
>> https://lore.kernel.org/patchwork/cover/967020/
>> Patch can be applied standalone and has no dependencies on other patches
>> in v3.
> 
> Hmm is this needed for v4.19-rc cycle or can this wait for
> v4.20 merge window?
> 

v4.20 should be fine.


-- 
Regards
Vignesh
