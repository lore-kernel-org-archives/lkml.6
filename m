Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EB1DC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:53:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9897920870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 13:53:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9897920870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbeIJSrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 14:47:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45852 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728110AbeIJSrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 14:47:11 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B42AC7984261;
        Mon, 10 Sep 2018 21:52:55 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.399.0; Mon, 10 Sep 2018
 21:52:53 +0800
Message-ID: <5B967735.1020001@huawei.com>
Date:   Mon, 10 Sep 2018 21:52:53 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Juergen Gross <jgross@suse.com>
CC:     <boris.ostrovsky@oracle.com>, <xen-devel@lists.xenproject.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] xen: remove unnecessary condition check before kfree
References: <1536416318-34106-1-git-send-email-zhongjiang@huawei.com> <12d9b430-e08a-3e28-5289-028f6b395d11@suse.com>
In-Reply-To: <12d9b430-e08a-3e28-5289-028f6b395d11@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/10 17:52, Juergen Gross wrote:
> On 08/09/18 16:18, zhong jiang wrote:
>> kfree has taken null pointer into account. So just remove the
>> condition check before kfree.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  drivers/xen/xen-acpi-processor.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/xen/xen-acpi-processor.c b/drivers/xen/xen-acpi-processor.c
>> index fbb9137..7e1d49e 100644
>> --- a/drivers/xen/xen-acpi-processor.c
>> +++ b/drivers/xen/xen-acpi-processor.c
>> @@ -268,7 +268,7 @@ static int push_pxx_to_hypervisor(struct acpi_processor *_pr)
>>  		pr_warn("(_PXX): Hypervisor error (%d) for ACPI CPU%u\n",
>>  			ret, _pr->acpi_id);
>>  err_free:
>> -	if (!IS_ERR_OR_NULL(dst_states))
>> +	if (!IS_ERR(dst_states))
> This is just a change of the condition, not a removal.
>
> I don't think change is worth it.
>
 Fine, I just consider the duplication of function.  Of course. make sense you have said.
 Maybe it will more clear to have the judgement.

 Thanks,
 zhong jiang
> Juergen
>
>


