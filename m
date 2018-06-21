Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13BA3C43142
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:24:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03DC224C1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 22:24:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03DC224C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933772AbeFUWYc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 18:24:32 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:42850 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933187AbeFUWYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 18:24:31 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04455;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0T37v0xd_1529619861;
Received: from US-143344MP.local(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0T37v0xd_1529619861)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Jun 2018 06:24:24 +0800
Subject: Re: [PATCH] mm: thp: register mm for khugepaged when merging vma for
 shmem
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     hughd@google.com, kirill.shutemov@linux.intel.com, vbabka@suse.cz,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1529617247-126312-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180621221008.r33hpd223kx2gv3a@kshutemo-mobl1>
From:   Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <be046d3f-06e0-09fd-c1d0-3e374dedcf16@linux.alibaba.com>
Date:   Thu, 21 Jun 2018 15:24:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180621221008.r33hpd223kx2gv3a@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/21/18 3:10 PM, Kirill A. Shutemov wrote:
> On Fri, Jun 22, 2018 at 05:40:47AM +0800, Yang Shi wrote:
>> When merging anonymous page vma, if the size of vam can fit in at least
> s/vam/vma/
>
>> one hugepage, the mm will be registered for khugepaged for collapsing
>> THP in the future.
>>
>> But, it skips shmem vma. Doing so for shmem too when merging vma in
>> order to increase the odd to collapse hugepage by khugepaged.
> Good catch. Thanks.
>
> I think the fix incomplete. We shouldn't require vma->anon_vma for shmem,
> only for anonymous mappings. We don't support file-private THPs.

So you mean, shmem_file(vma->vm_file) && PageAnon(page)?

>
>> Also increase the count of shmem THP collapse. It looks missed before.
> Separate patch, please.

Sure.

Thanks,
Yang

>

