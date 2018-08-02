Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91077C43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EB21208DA
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 04:00:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EB21208DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbeHBFtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 01:49:42 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:10216 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbeHBFtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 01:49:42 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 69C52C50A955B;
        Thu,  2 Aug 2018 12:00:32 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Thu, 2 Aug 2018
 12:00:26 +0800
Message-ID: <5B6281D7.5030801@huawei.com>
Date:   Thu, 2 Aug 2018 12:00:23 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Bart Van Assche <Bart.VanAssche@wdc.com>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "aacraid@microsemi.com" <aacraid@microsemi.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "john.garry@huawei.com" <john.garry@huawei.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: [PATCH 2/2] scsi:qlogicfas408: remove the same check in qlogicfas408_detect
References: <1533177901-19514-1-git-send-email-zhongjiang@huawei.com>  <1533177901-19514-3-git-send-email-zhongjiang@huawei.com>  <dc1f8e81007466172d383cc63a4be246c568a2d4.camel@wdc.com>  <5B627AB2.8000101@huawei.com> <2ff30988089f3cbc0d2127dbfaa29955e0449997.camel@wdc.com>
In-Reply-To: <2ff30988089f3cbc0d2127dbfaa29955e0449997.camel@wdc.com>
Content-Type: text/plain; charset="UTF-7"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/8/2 11:52, Bart Van Assche wrote:
> On Thu, 2018-08-02 at 11:29 +ACs-0800, zhong jiang wrote:
>> On 2018/8/2 11:21, Bart Van Assche wrote:
>>> On Thu, 2018-08-02 at 10:45 +ACs-0800, zhong jiang wrote:
>>>> we should not use same check in a expression. just remove one
>>>> of them.
>>>>
>>>> Signed-off-by: zhong jiang <zhongjiang+AEA-huawei.com>
>>>> ---
>>>>  drivers/scsi/qlogicfas408.c +AHw- 3 +ACs---
>>>>  1 file changed, 1 insertion(+ACs-), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/scsi/qlogicfas408.c b/drivers/scsi/qlogicfas408.c
>>>> index 8b471a9..1409ac1 100644
>>>> --- a/drivers/scsi/qlogicfas408.c
>>>> +ACsAKwAr- b/drivers/scsi/qlogicfas408.c
>>>> +AEAAQA- -567,8 +ACs-567,7 +AEAAQA- void qlogicfas408+AF8-setup(int qbase, int id, int int+AF8-type)
>>>>  int qlogicfas408+AF8-detect(int qbase, int int+AF8-type)
>>>>  +AHs-
>>>>          REG1;
>>>> -	return (((inb(qbase +ACs- 0xe) +AF4- inb(qbase +ACs- 0xe)) == 7) +ACYAJg-
>>>> -	       ((inb(qbase +ACs- 0xe) +AF4- inb(qbase +ACs- 0xe)) == 7));		
>>>> +ACs-	return (inb(qbase +ACs- 0xe) +AF4- inb(qbase +ACs- 0xe)) == 7;
>>>>  +AH0-
>>> Does inb() have any side effects?
>>  just redundant. is it necessary for this . Maybe I miss something.
> If doubletest.cocci came up with this patch, I think that script is
> wrong and needs a thorough review.
>
> Bart.
>
 Ok, Maybe I am wrong with this issue. Thank you for clarification.

 Sincerely,
 zhong jiang
>


