Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A89ECE562
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:19:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FB93214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 09:19:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB93214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727375AbeIQOp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 10:45:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:46309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726824AbeIQOpz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 10:45:55 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D6DA0B4AFF3A1;
        Mon, 17 Sep 2018 17:19:20 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.399.0; Mon, 17 Sep 2018
 17:19:19 +0800
Message-ID: <5B9F7196.1070203@huawei.com>
Date:   Mon, 17 Sep 2018 17:19:18 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     <georgi.djakov@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] interconnect: Fix a GCC compiler warning
References: <1537108310-2086-1-git-send-email-zhongjiang@huawei.com> <5B9F6B8B.7020100@huawei.com> <20180917085954.GA23740@kroah.com>
In-Reply-To: <20180917085954.GA23740@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/17 16:59, Greg KH wrote:
> On Mon, Sep 17, 2018 at 04:53:31PM +0800, zhong jiang wrote:
>> +to Greg and Andrew.
>>
>> On 2018/9/16 22:31, zhong jiang wrote:
>>> Fix the following compile warning:
>>>
>>> drivers/interconnect/core.c:26:23: warning: 'icc_debugfs_dir' defined but not used [-Wunused-variable]
>>>  static struct dentry *icc_debugfs_dir;
>>>
>>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>>> ---
>>>  drivers/interconnect/core.c | 3 +++
> This file is not in a released tree, where are you seeing it?
I see it in linux-next.
>>>  1 file changed, 3 insertions(+)
>>>
>>> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
>>> index 2740f1a..9ea9959 100644
>>> --- a/drivers/interconnect/core.c
>>> +++ b/drivers/interconnect/core.c
>>> @@ -23,7 +23,10 @@
>>>  static DEFINE_IDR(icc_idr);
>>>  static LIST_HEAD(icc_provider_list);
>>>  static DEFINE_MUTEX(icc_lock);
>>> +
>>> +#ifdef CONFIG_DEBUG_FS
>>>  static struct dentry *icc_debugfs_dir;
>>> +#endif
> Why not move the variable to where it is used?  It should be able to go
> under an existing #ifdef section, right?
Because the variable need to be used in __init and __exit.  So it should be identified as
a gloabl variable.  I fix it under the #ifdef condition.

Thanks,
zhong jiang
> thanks,
>
> greg k-h
>
> .
>


