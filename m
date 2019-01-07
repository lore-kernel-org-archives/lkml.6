Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F753C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:28:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D776A2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 17:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfAGR2S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 12:28:18 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:17120 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727012AbfAGR2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 12:28:18 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A3D26EDA4CA00F994B4B;
        Tue,  8 Jan 2019 01:28:12 +0800 (CST)
Received: from [127.0.0.1] (10.202.226.43) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Tue, 8 Jan 2019
 01:28:03 +0800
Subject: Re: [PATCH] scsi: sd: Make protection lookup tables static
To:     Bart Van Assche <bvanassche@acm.org>, <jejb@linux.vnet.ibm.com>,
        <martin.petersen@oracle.com>
References: <1546872111-5627-1-git-send-email-john.garry@huawei.com>
 <1546880243.83374.12.camel@acm.org>
CC:     <linuxarm@huawei.com>, <linux-kernel@vger.kernel.org>,
        <linux-scsi@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <b269a676-8941-4de4-faed-c40ec0d0a45a@huawei.com>
Date:   Mon, 7 Jan 2019 17:27:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <1546880243.83374.12.camel@acm.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2019 16:57, Bart Van Assche wrote:
> On Mon, 2019-01-07 at 22:41 +0800, John Garry wrote:
>> Currently the protection lookup tables in sd_prot_flag_mask() and
>> sd_prot_op() are declared non-static. As such, they will be rebuilt for
>> each respective function call.
>>
>> Optimise by making them static.
>>
>> This saves ~100B object code for sd.c:
>>
>> Before:
>>    text	   data	    bss	    dec	    hex	filename
>>   25403	   1024	     16	  26443	   674b	drivers/scsi/sd.o
>>
>> After:
>>   text	   data	    bss	    dec	    hex	filename
>>   25299	   1024	     16	  26339	   66e3	drivers/scsi/sd.o
>
> Since the sd_prot_op() function only has a single caller, please move it from sd.h
> into sd.c.

Can do, as long as no one has objection.

Function sd_prot_flag_mask() also has a single caller AFAICS, so this 
could also be relocated.

Cheers,
John

>
> Thanks,
>
> Bart.
>
>


