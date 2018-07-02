Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98289C6778A
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:51:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4185F24176
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 02:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Xw3t2ptK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4185F24176
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933003AbeGBCvK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 22:51:10 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34460 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753046AbeGBCvH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 22:51:07 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id w622oxLM033272;
        Sun, 1 Jul 2018 21:50:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1530499859;
        bh=yxrmbTUTEcDIz5DSxopZ1GqvXKuR3v7gKRSqRQZBPq4=;
        h=Subject:To:References:CC:From:Date:In-Reply-To;
        b=Xw3t2ptK2Cf1w2SKTBF1JwUppIsmxP3HskcWSF9o62UXdjt+KCjDFEMYcWSLlju5Y
         8Bbv0Tlvsv4oMQg8Fk2XNpKG6gBzTwuBk2PXdZ5uji5/+KFhcsMlfk4ZMJBLbyp1YZ
         iSTQ5jb+2XXqUM/xGEsaLjnnkWTNe9ISnA1X1goE=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w622ox6I021934;
        Sun, 1 Jul 2018 21:50:59 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Sun, 1 Jul
 2018 21:50:58 -0500
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Sun, 1 Jul 2018 21:50:58 -0500
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w622otZa028587;
        Sun, 1 Jul 2018 21:50:56 -0500
Subject: Re: [PATCH RESEND 0/3] K2G: mmc: Update mmc dt node to use
To:     Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
References: <20180622101617.11157-1-kishon@ti.com>
 <7199d72f-9980-c700-6ebe-3f8927b64f62@ti.com>
 <10adb1c9-9b10-e1e7-7076-25b0c68c99f1@oracle.com>
CC:     <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <00a3d968-ff2b-9703-fe43-7c39e43e16b8@ti.com>
Date:   Mon, 2 Jul 2018 08:20:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <10adb1c9-9b10-e1e7-7076-25b0c68c99f1@oracle.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Saturday 30 June 2018 04:29 AM, Santosh Shilimkar wrote:
> On 6/27/2018 9:15 PM, Kishon Vijay Abraham I wrote:
>> Santosh,
>>
>> On Friday 22 June 2018 03:46 PM, Kishon Vijay Abraham I wrote:
>>> Update mmc dt node to use sdhci-omap binding instead of omap_hsmmc
>>> binding.
>>>
>>> I've also updated keystone_defconfig to enable CONFIG_MMC_SDHCI_OMAP.
>>> Everyone who use a custom .config should also enable
>>> CONFIG_MMC_SDHCI_OMAP for MMC to work.
>>
>> Can this series be merged?
>>
> Applied. Sorry for missing it in earlier batch.

Thanks Santosh.

-Kishon
