Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F35C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:48:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40C2520866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 07:48:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C2520866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbeIJMl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 08:41:28 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:44620 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726148AbeIJMl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 08:41:28 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0B894962F8AC2;
        Mon, 10 Sep 2018 15:48:40 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.399.0; Mon, 10 Sep 2018
 15:48:41 +0800
Message-ID: <5B9621D8.2030408@huawei.com>
Date:   Mon, 10 Sep 2018 15:48:40 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     <mhiramat@kernel.org>, <daniel@iogearbox.net>,
        <tglx@linutronix.de>, <naveen.n.rao@linux.vnet.ibm.com>,
        <jbacik@fb.com>, <keescook@chromium.org>, <ast@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] error-injection: remove meaningless null pointer check
 before debugfs_remove_recursive
References: <1536398674-20868-1-git-send-email-zhongjiang@huawei.com> <20180910072120.GB47768@gmail.com>
In-Reply-To: <20180910072120.GB47768@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/10 15:21, Ingo Molnar wrote:
> * zhong jiang <zhongjiang@huawei.com> wrote:
>
>> debugfs_remove_recursive has taken the null pointer into account.
>> just remove the null check before debugfs_remove_recursive.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  kernel/fail_function.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/kernel/fail_function.c b/kernel/fail_function.c
>> index bc80a4e..17f75b5 100644
>> --- a/kernel/fail_function.c
>> +++ b/kernel/fail_function.c
>> @@ -173,8 +173,7 @@ static void fei_debugfs_remove_attr(struct fei_attr *attr)
>>  	struct dentry *dir;
>>  
>>  	dir = debugfs_lookup(attr->kp.symbol_name, fei_debugfs_dir);
>> -	if (dir)
>> -		debugfs_remove_recursive(dir);
>> +	debugfs_remove_recursive(dir);
>>  }
>>  
>>  static int fei_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
> Please Cc: such patches to lkml and akpm.
 Ok, will do.
> Thanks,
>
> 	Ingo
>
>


