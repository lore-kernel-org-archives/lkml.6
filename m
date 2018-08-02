Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C715DC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 820B8208B0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 03:46:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 820B8208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbeHBFfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:35:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10608 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726042AbeHBFfI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:35:08 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 097F3D4FB405C;
        Thu,  2 Aug 2018 11:46:00 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 11:45:55 +0800
Message-ID: <5B627E71.5020600@huawei.com>
Date:   Thu, 2 Aug 2018 11:45:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
CC:     "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "fthain@telegraphics.com.au" <fthain@telegraphics.com.au>,
        "schmitzmic@gmail.com" <schmitzmic@gmail.com>,
        "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>
Subject: Re: [PATCH] scsi:NCR5380: remove same check condition in NCR5380_select
References: <1533179408-20631-1-git-send-email-zhongjiang@huawei.com> <c99a75a2905c1eef50f94ccc0871c36af431e21a.camel@wdc.com>
In-Reply-To: <c99a75a2905c1eef50f94ccc0871c36af431e21a.camel@wdc.com>
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/2 11:26, Bart Van Assche wrote:
> On Thu, 2018-08-02 at 11:10 +ACs-0800, zhong jiang wrote:
>> The same check condition is redundant, so remove one of them.
>>
>> Signed-off-by: zhong jiang <zhongjiang+AEA-huawei.com>
>> ---
>>  drivers/scsi/NCR5380.c +AHw- 3 +ACs---
>>  1 file changed, 1 insertion(+ACs-), 2 deletions(-)
>>
>> diff --git a/drivers/scsi/NCR5380.c b/drivers/scsi/NCR5380.c
>> index 90ea0f5..2ecaf3f 100644
>> --- a/drivers/scsi/NCR5380.c
>> +ACsAKwAr- b/drivers/scsi/NCR5380.c
>> +AEAAQA- -999,8 +ACs-999,7 +AEAAQA- static struct scsi+AF8-cmnd +ACo-NCR5380+AF8-select(struct Scsi+AF8-Host +ACo-instance,
>>  
>>  	/+ACo- Check for lost arbitration +ACo-/
>>  	if ((NCR5380+AF8-read(INITIATOR+AF8-COMMAND+AF8-REG) +ACY- ICR+AF8-ARBITRATION+AF8-LOST) +AHwAfA-
>> -	    (NCR5380+AF8-read(CURRENT+AF8-SCSI+AF8-DATA+AF8-REG) +ACY- hostdata->id+AF8-higher+AF8-mask) +AHwAfA-
>> -	    (NCR5380+AF8-read(INITIATOR+AF8-COMMAND+AF8-REG) +ACY- ICR+AF8-ARBITRATION+AF8-LOST)) +AHs-
>> +ACs-	    (NCR5380+AF8-read(CURRENT+AF8-SCSI+AF8-DATA+AF8-REG) +ACY- hostdata->id+AF8-higher+AF8-mask)) +AHs-
>>  		NCR5380+AF8-write(MODE+AF8-REG, MR+AF8-BASE);
>>  		dsprintk(NDEBUG+AF8-ARBITRATION, instance, "lost arbitration, deasserting MR+AF8-ARBITRATE+AFw-n");
>>  		spin+AF8-lock+AF8-irq(+ACY-hostdata->lock);
> Has this patch been tested?
 I check the issue by doubletest.cocci. Just review the code by myself. Maybe I miss something else.
 please tell let me know if you any objection.

 Thanks
 zhong jiang
> Thanks,
>
> Bart.
>
>
>


