Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753042AbeDRSTQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 14:19:16 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:50543 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752077AbeDRSTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 14:19:15 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0T.QbfBl_1524075536;
Subject: Re: [v4 PATCH] mm: introduce arg_lock to protect arg_start|end and
 env_start|end in mm_struct
To: Cyrill Gorcunov <gorcunov@gmail.com>, Michal Hocko <mhocko@kernel.org>
Cc: adobriyan@gmail.com, willy@infradead.org, mguzik@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <1523730291-109696-1-git-send-email-yang.shi@linux.alibaba.com>
 <20180418080555.GR17484@dhcp22.suse.cz> <20180418090217.GG19578@uranus.lan>
 <20180418090314.GU17484@dhcp22.suse.cz> <20180418094019.GH19578@uranus.lan>
From: Yang Shi <yang.shi@linux.alibaba.com>
Message-ID: <2712b594-91b6-24be-e88f-012c8f844f27@linux.alibaba.com>
Date: Wed, 18 Apr 2018 11:18:51 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.12; rv:52.0)
 Gecko/20100101 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180418094019.GH19578@uranus.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/18/18 2:40 AM, Cyrill Gorcunov wrote:
> On Wed, Apr 18, 2018 at 11:03:14AM +0200, Michal Hocko wrote:
>>>> What about something like the following?
>>>> "
>>>> arg_lock protects concurent updates but we still need mmap_sem for read
>>>> to exclude races with do_brk.
>>>> "
>>>> Acked-by: Michal Hocko <mhocko@suse.com>
>>> Yes, thanks! Andrew, could you slightly update the changelog please?
>> No, I meant it to be a comment in the _code_.
> Ah, I see. Then small patch on top should do the trick.

Will send out an incremental patch soon.
