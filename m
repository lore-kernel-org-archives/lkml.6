Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F329ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A62421547
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 05:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A62421547
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389176AbeIULU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 07:20:26 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47871 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726479AbeIULU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 07:20:26 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C58D0F3C27468;
        Fri, 21 Sep 2018 13:33:10 +0800 (CST)
Received: from [127.0.0.1] (10.177.29.68) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.399.0; Fri, 21 Sep 2018
 13:33:08 +0800
Message-ID: <5BA48294.8090503@huawei.com>
Date:   Fri, 21 Sep 2018 13:33:08 +0800
From:   zhong jiang <zhongjiang@huawei.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Bhupesh Sharma <bhsharma@redhat.com>
CC:     Baoquan He <bhe@redhat.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] kernel: kexec_file: remove some duplicated include
 file
References: <1537498098-19171-1-git-send-email-zhongjiang@huawei.com> <CACi5LpMPZiv7zgZLR9SD=2SPPT8W3RuP6=NHD4rzqVnpB4xkaA@mail.gmail.com>
In-Reply-To: <CACi5LpMPZiv7zgZLR9SD=2SPPT8W3RuP6=NHD4rzqVnpB4xkaA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.68]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/9/21 13:21, Bhupesh Sharma wrote:
> Hi,
>
> On Fri, Sep 21, 2018 at 8:18 AM, zhong jiang <zhongjiang@huawei.com> wrote:
>> We include kexec.h and slab.h twice in kexec_file.c. It's unnecessary.
>> hence just remove them.
>>
>> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
>> ---
>>  kernel/kexec_file.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
>> index c6a3b68..35cf0ad 100644
>> --- a/kernel/kexec_file.c
>> +++ b/kernel/kexec_file.c
>> @@ -25,8 +25,6 @@
>>  #include <linux/elf.h>
>>  #include <linux/elfcore.h>
>>  #include <linux/kernel.h>
>> -#include <linux/kexec.h>
>> -#include <linux/slab.h>
>>  #include <linux/syscalls.h>
>>  #include <linux/vmalloc.h>
>>  #include "kexec_internal.h"
>> --
>> 1.7.12.4
>>
> Nice catch.
> Reviewed-by: Bhupesh Sharma <bhsharma@redhat.com>
>
> BTW while we are at it, can you also send out a separate patch to list the
> include files in this file (i.e. kexec_file.c) alphabetically (similar
> to other linux source files - see
> <https://patchwork.kernel.org/patch/10258279/> for example). Something
> like:
>
> #include <crypto/hash.h>
> #include <crypto/sha.h>
> #include <linux/capability.h>
> #include <linux/elf.h>
> #include <linux/elfcore.h>
> #include <linux/file.h>
> #include <linux/fs.h>
> #include <linux/ima.h>
> #include <linux/kernel.h>
> #include <linux/kexec.h>
> #include <linux/list.h>
> #include <linux/mm.h>
> #include <linux/mutex.h>
> #include <linux/slab.h>
> #include <linux/syscalls.h>
> #include <linux/vmalloc.h>
> #include "kexec_internal.h"
>
> This will improve readability and also reduce similar instances of
> include files being added twice in this source file in future.
>
> Thanks,
> Bhupesh
Thank you for suggestion, I do not know whether all of maintainer care about this or not.
Anyhow I will try it.

Sincerely,
zhong jiang



