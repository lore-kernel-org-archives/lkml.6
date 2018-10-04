Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86A47C00449
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DCAD213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 02:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DCAD213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbeJDJgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 05:36:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:13183 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726268AbeJDJgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 05:36:16 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 15ED670DFC36B;
        Thu,  4 Oct 2018 10:45:08 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.399.0; Thu, 4 Oct 2018
 10:45:09 +0800
Message-ID: <5BB57EB4.2060607@huawei.com>
Date:   Thu, 4 Oct 2018 10:45:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <fbarrat@linux.vnet.ibm.com>, <andrew.donnellan@au1.ibm.com>,
        <arnd@arndb.de>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] misc: cxl: Move a deference below a NULL test
References: <1537962072-13732-1-git-send-email-zhongjiang@huawei.com> <20181002225558.GA27362@kroah.com>
In-Reply-To: <20181002225558.GA27362@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/3 6:55, Greg KH wrote:
> On Wed, Sep 26, 2018 at 07:41:12PM +0800, zhong jiang wrote:
>> It is safe to move a deference below a NULL test.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>> ---
>>  drivers/misc/cxl/guest.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
>> index 3bc0c15..559e835 100644
>> --- a/drivers/misc/cxl/guest.c
>> +++ b/drivers/misc/cxl/guest.c
>> @@ -1018,11 +1018,11 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
>>  
>>  void cxl_guest_remove_afu(struct cxl_afu *afu)
>>  {
>> -	pr_devel("in %s - AFU(%d)\n", __func__, afu->slice);
>> -
>>  	if (!afu)
>>  		return;
>>  
>> +	pr_devel("in %s - AFU(%d)\n", __func__, afu->slice);
>> +
> This call should just be deleted, ftrace can be used if this type of
> thing is really needed.
Ok, just delete the dereference in advance.  Will repost in v2.

Thanks,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


