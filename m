Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751163AbeFDS4O (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:56:14 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:56384 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751017AbeFDS4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:56:13 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07402;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0T2B5UvL_1528138557;
To: emunson@akamai.com, "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
From: Yang Shi <yang.shi@linux.alibaba.com>
Subject: [QUESTION] About VM_LOCKONFAULT for file page
Message-ID: <aff10e88-8755-b163-8965-3f8065c0c971@linux.alibaba.com>
Date: Mon, 4 Jun 2018 11:55:56 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,


I did a quick test with mlock2 + VM_LOCKONFAULT flag. The test just does 
an 1MB anonymous map and 1MB file map with VM_LOCKONFAULT respectively. 
Then it tries to access one page of each mapping.


 From /proc/meminfo, I can see 1 page marked mlocked from anonymous 
mapping. But, the page from file mapping is *not* marked as mlocked.


I can see the do_anonymous_page() calls 
lru_cache_add_active_or_unevictable() to set the page's PG_mlocked flag. 
But, do_read_fault()/do_shared_fault()/do_cow_fault() don't do it, it 
looks they just do it for COW page.


I'm a little bit confused. Does VM_LOCKONFAULT work for anonymous map 
only? Or did I miss something? Any hint is appreciated.


Thanks,

Yang
