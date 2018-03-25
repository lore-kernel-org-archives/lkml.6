Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753111AbeCYAcq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 20:32:46 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:47187 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752317AbeCYAcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 20:32:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0T-0xik-_1521937945;
Subject: Re: [PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Matthew Wilcox <willy@infradead.org>
Cc: adobriyan@gmail.com, mhocko@kernel.org, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <1521851771-108673-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180324043044.GA22733@bombadil.infradead.org>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <aed7f679-a32f-d8d7-eb59-ec05fc49a70e@linux.alibaba.com>
Date: Sat, 24 Mar 2018 17:32:24 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180324043044.GA22733@bombadil.infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/23/18 9:30 PM, Matthew Wilcox wrote:
>> So, introduce a new rwlock in mm_struct to protect the concurrent access
>> to arg_start|end and env_start|end.
> I don't think an rwlock makes much sense here.  There is almost no
> concurrency on the read side, and an rwlock is more expensive than
> a spinlock.  Just use a spinlock.

Thanks for the comment. Yes, actually there is not concurrency on the 
read side, will change to regular spin lock.

Yang
