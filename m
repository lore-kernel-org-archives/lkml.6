Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA30C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0239E21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:58:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0239E21473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJDLt7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:49:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13595 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726735AbeJDLt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:49:59 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2AC9D9F819DA8;
        Thu,  4 Oct 2018 12:58:31 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.399.0; Thu, 4 Oct 2018
 12:58:29 +0800
Message-ID: <5BB59DF5.7070106@huawei.com>
Date:   Thu, 4 Oct 2018 12:58:29 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <andrew.donnellan@au1.ibm.com>, <fbarrat@linux.vnet.ibm.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] misc: cxl: delete possible null pointer dereference
References: <1538621808-28080-1-git-send-email-zhongjiang@huawei.com> <20181004043812.GA8134@kroah.com>
In-Reply-To: <20181004043812.GA8134@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/10/4 12:38, Greg KH wrote:
> On Thu, Oct 04, 2018 at 10:56:48AM +0800, zhong jiang wrote:
>> It is safe to dereference an object below a NULL test. For the sake
>> of debugging. Just delete the call of possible null pointer dereference.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/misc/cxl/guest.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/misc/cxl/guest.c b/drivers/misc/cxl/guest.c
>> index 3bc0c15..472e8db 100644
>> --- a/drivers/misc/cxl/guest.c
>> +++ b/drivers/misc/cxl/guest.c
>> @@ -1018,7 +1018,7 @@ int cxl_guest_init_afu(struct cxl *adapter, int slice, struct device_node *afu_n
>>  
>>  void cxl_guest_remove_afu(struct cxl_afu *afu)
>>  {
>> -	pr_devel("in %s - AFU(%d)\n", __func__, afu->slice);
>> +	pr_devel("in %s\n", __func__);
> This call should just be deleted, it's not needed, ftrace can be used
> instead.
Fine.  Will do.

Sincerely,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


