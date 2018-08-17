Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A87C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0889D2187A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 08:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pDcytIiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0889D2187A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeHQLHd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 07:07:33 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:34984 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbeHQLHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 07:07:33 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w7H84LWh084255;
        Fri, 17 Aug 2018 03:04:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1534493061;
        bh=aKnH5j2GBRZVuhNggUydsymHqqdF9C95gqucesJnYNs=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=pDcytIiG8FSyvq5tObS1XbCAs9owjefI7JLouqeqNuGoRF+Ojg4P2XvsaTkpu0UpV
         x0jZYZuafJuPXG5zxanuq0XtovBFCav+w+pAzvCUvxzzmtKNzEIHIsOOXmHXXEN/K3
         JcK6RcCVxgHGyfVg+y62i0HSHsenlvYo0ww5AKrI=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7H84LSS031217;
        Fri, 17 Aug 2018 03:04:21 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 17
 Aug 2018 03:04:21 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 17 Aug 2018 03:04:21 -0500
Received: from [172.24.190.172] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w7H84GTf010450;
        Fri, 17 Aug 2018 03:04:17 -0500
Subject: Re: [PATCH] remoteproc/davinci: Use %zx for formating size_t
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        <linux-remoteproc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Suman Anna <s-anna@ti.com>,
        David Lechner <david@lechnology.com>
References: <20180817004919.10805-1-bjorn.andersson@linaro.org>
 <CAMRc=Mcz9Ha_Jj=236d7Mp=abCUKs6oh9b9sW0uOGzQu1ROJ2g@mail.gmail.com>
From:   Sekhar Nori <nsekhar@ti.com>
Message-ID: <c60f6fae-6798-346f-d2ec-e3cc13489199@ti.com>
Date:   Fri, 17 Aug 2018 13:34:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAMRc=Mcz9Ha_Jj=236d7Mp=abCUKs6oh9b9sW0uOGzQu1ROJ2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 August 2018 01:09 PM, Bartosz Golaszewski wrote:
> 2018-08-17 2:49 GMT+02:00 Bjorn Andersson <bjorn.andersson@linaro.org>:
>> da8xx_rproc_mem size is of type size_t, so use %zx to format the debug
>> print of it to avoid a compile warning.
>>
>> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>> ---
>>  drivers/remoteproc/da8xx_remoteproc.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
>> index e230bef71be1..d200334577f6 100644
>> --- a/drivers/remoteproc/da8xx_remoteproc.c
>> +++ b/drivers/remoteproc/da8xx_remoteproc.c
>> @@ -226,7 +226,7 @@ static int da8xx_rproc_get_internal_memories(struct platform_device *pdev,
>>                                 res->start & DA8XX_RPROC_LOCAL_ADDRESS_MASK;
>>                 drproc->mem[i].size = resource_size(res);
>>
>> -               dev_dbg(dev, "memory %8s: bus addr %pa size 0x%x va %p da 0x%x\n",
>> +               dev_dbg(dev, "memory %8s: bus addr %pa size 0x%zx va %p da 0x%x\n",
>>                         mem_names[i], &drproc->mem[i].bus_addr,
>>                         drproc->mem[i].size, drproc->mem[i].cpu_addr,
>>                         drproc->mem[i].dev_addr);
>> --
>> 2.18.0
>>
> 
> Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> 
> Can you also pick up this patch[1] for v4.19? David Lechner already
> has a patch queued for v4.20 that depends on this one.

Looks like Bjorn added it to next yesterday.

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b2201ee554a5811f569f31280b0079e7d6177606

Thanks,
Sekhar
