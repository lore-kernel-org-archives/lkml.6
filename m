Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753956AbeDTASn (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 20:18:43 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:37664 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753703AbeDTASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 20:18:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01353;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0T.VpzAp_1524183500;
Subject: Re: [RFC PATCH] fs: introduce ST_HUGE flag and set it to tmpfs and
 hugetlbfs
To: Christoph Hellwig <hch@infradead.org>
Cc: viro@zeniv.linux.org.uk, nyc@holomorphy.com, mike.kravetz@oracle.com,
        kirill.shutemov@linux.intel.com, hughd@google.com,
        akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1523999293-94152-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180418102744.GA10397@infradead.org>
 <73090d4b-6831-805b-8b9d-5dff267428d9@linux.alibaba.com>
 <20180419082810.GA8624@infradead.org>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <9d8c9198-46c4-fd34-3546-c6f9b3fef0fb@linux.alibaba.com>
Date: Thu, 19 Apr 2018 17:18:20 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180419082810.GA8624@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/19/18 1:28 AM, Christoph Hellwig wrote:
> On Wed, Apr 18, 2018 at 11:18:25AM -0700, Yang Shi wrote:
>> Yes, thanks for the suggestion. I did think about it before I went with the
>> new flag. Not like hugetlb, THP will *not* guarantee huge page is used all
>> the time, it may fallback to regular 4K page or may get split. I'm not sure
>> how the applications use f_bsize field, it might break existing applications
>> and the value might be abused by applications to have counter optimization.
>> So, IMHO, a new flag may sound safer.
> But st_blksize isn't the block size, that is why I suggested it.  It is
> the preferred I/O size, and various file systems can report way
> larger values than the block size already.

Thanks. If it is safe to applications, It definitely can return huge 
page size via st_blksize.

Is it safe to return huge page size via statfs->f_bsize? It sounds it 
has not to be the physical block size too. The man page says it is 
"Optimal transfer block size".

Yang
