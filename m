Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB4DC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:16:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC93A2175B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 12:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZwFWuuYa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfBFMQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 07:16:50 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49738 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfBFMQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 07:16:50 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x16CGmVe038384;
        Wed, 6 Feb 2019 06:16:49 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1549455409;
        bh=kc0SHLaRXX3PtDuPeGUUQe6Va4CURH3WyWemSLy/i2E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZwFWuuYaZ7w3uAQBvDS+D+RlpXUUoc7DTg4C4w+JvVTxY/1emZLh0ii8tBkaXfGsN
         fP9J9nHwX7mROPucxJDGJMD2sJEYIifEwjlpS9OKkZJFrODvyupkTM5baSPp2nn+Xv
         EPz7zPj6IKYr1GWJSWCloNDR2YBRRgxJnwx39p+4=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x16CGmuZ082360
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Feb 2019 06:16:48 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 6
 Feb 2019 06:16:48 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 6 Feb 2019 06:16:48 -0600
Received: from [172.24.190.233] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x16CGkEv030778;
        Wed, 6 Feb 2019 06:16:47 -0600
Subject: Re: [PATCH] phy: bcm-sr-pcie: Change operation when PIPEMUX=1
To:     Scott Branden <scott.branden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>
CC:     <linux-kernel@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        Qingmin Liu <qingmin.liu@broadcom.com>
References: <20190204190745.93170-1-ray.jui@broadcom.com>
 <ff198f05-41bb-2c4e-6d28-7a4c0960646e@broadcom.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1575bf5c-7dff-6884-b2a2-5dcb5de4debd@ti.com>
Date:   Wed, 6 Feb 2019 17:46:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <ff198f05-41bb-2c4e-6d28-7a4c0960646e@broadcom.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/02/19 12:51 AM, Scott Branden wrote:
> Looks good.
> 
> On 2019-02-04 11:07 a.m., Ray Jui wrote:
>> From: Qingmin Liu <qingmin.liu@broadcom.com>
>>
>> When PIPEMIX=1, change the operation from 2x8 EP to 1x8 EP + 1x8 RC.
>>
>> Signed-off-by: Qingmin Liu <qingmin.liu@broadcom.com>
>> Signed-off-by: Ray Jui <ray.jui@broadcom.com>
> Acked-by: Scott Branden <scott.branden@broadcom.com>

merged, thanks.

-Kishon
>> ---
>>   drivers/phy/broadcom/phy-bcm-sr-pcie.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/phy/broadcom/phy-bcm-sr-pcie.c
>> b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
>> index c10e95f86de5..96a3af126a78 100644
>> --- a/drivers/phy/broadcom/phy-bcm-sr-pcie.c
>> +++ b/drivers/phy/broadcom/phy-bcm-sr-pcie.c
>> @@ -78,8 +78,8 @@ struct sr_pcie_phy_core {
>>   static const u8 pipemux_table[] = {
>>       /* PIPEMUX = 0, EP 1x16 */
>>       0x00,
>> -    /* PIPEMUX = 1, EP 2x8 */
>> -    0x00,
>> +    /* PIPEMUX = 1, EP 1x8 + RC 1x8, core 7 */
>> +    0x80,
>>       /* PIPEMUX = 2, EP 4x4 */
>>       0x00,
>>       /* PIPEMUX = 3, RC 2x8, cores 0, 7 */
