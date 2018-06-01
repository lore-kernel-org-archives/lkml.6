Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751203AbeFABWY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 21:22:24 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:39203 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750718AbeFABWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 21:22:22 -0400
X-Google-Smtp-Source: ADUXVKJPOHeA4+ygIVnDreaenhrKK89ZsiBGYLGYJFj+xNO0uG6eGC7pRZhO+STZQVI0W0qOvTXaXg==
Subject: Re: Can kfree() sleep at runtime?
To: Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>
Cc: penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <30ecafd7-ed61-907b-f924-77fc37dcc753@gmail.com>
 <20180531140808.GA30221@bombadil.infradead.org>
 <01000163b68a8026-56fb6a35-040b-4af9-8b73-eb3b4a41c595-000000@email.amazonses.com>
 <20180531141452.GC30221@bombadil.infradead.org>
 <01000163b69b6b62-6c5ac940-d6c1-419a-9dc9-697908020c53-000000@email.amazonses.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <066df211-4d1e-787b-b89d-31b8827ea7a5@gmail.com>
Date: Fri, 1 Jun 2018 09:22:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <01000163b69b6b62-6c5ac940-d6c1-419a-9dc9-697908020c53-000000@email.amazonses.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/5/31 22:30, Christopher Lameter wrote:
> On Thu, 31 May 2018, Matthew Wilcox wrote:
>
>>> Freeing a page in the page allocator also was traditionally not sleeping.
>>> That has changed?
>> No.  "Your bug" being "The bug in your static analysis tool".  It probably
>> isn't following the data flow correctly (or deeply enough).
> Well ok this is not going to trigger for kfree(), this is x86 specific and
> requires CONFIG_DEBUG_PAGEALLOC and a free of a page in a huge page.
>
> Ok that is a very contorted situation but how would a static checker deal
> with that?

I admit that my tool does not follow the data flow well, and I need to 
improve it.
In this case of kfree(), I want know how the data flow leads to my mistake.


Best wishes,
Jia-Ju Bai
