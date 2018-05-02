Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbeEBAFU (ORCPT <rfc822;w@1wt.eu>);
        Tue, 1 May 2018 20:05:20 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:42065 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751825AbeEBAFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 May 2018 20:05:17 -0400
X-Google-Smtp-Source: AB8JxZoZCOu+SLtaBaN7z2sMZv6Owipbt5AvVcJXpUplCfGRdSF2WXVZExrrAbVNNWfQN8CZdA+8dw==
Subject: Re: [PATCH 0/2] mm: tweaks for improving use of vmap_area
To: Andrew Morton <akpm@linux-foundation.org>
Cc: willy@infradead.org, mhocko@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, igor.stoppa@huawei.com
References: <20180426234243.22267-1-igor.stoppa@huawei.com>
 <20180430161515.118e6538e4d4f1cc4ae425cc@linux-foundation.org>
From: Igor Stoppa <igor.stoppa@gmail.com>
Message-ID: <d9f91dc9-958c-e3ec-3ca4-ecb0ddfd58f3@gmail.com>
Date: Wed, 2 May 2018 04:05:14 +0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180430161515.118e6538e4d4f1cc4ae425cc@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 01/05/18 03:15, Andrew Morton wrote:
> On Fri, 27 Apr 2018 03:42:41 +0400 Igor Stoppa <igor.stoppa@gmail.com> wrote:
> 
>> These two patches were written in preparation for the creation of
>> protectable memory, however their use is not limited to pmalloc and can
>> improve the use of virtually contiguous memory.
>>
>> The first provides a faster path from struct page to the vm_struct that
>> tracks it.
>>
>> The second patch renames a single linked list field inside of vmap_area.
>> The list is currently used only for disposing of the data structure, once
>> it is not in use anymore.
>> Which means that it cold be used for other purposes while it's not queued
>> for destruction.
> 
> The patches look benign to me (feel free to add my ack),

thank you

> but I'm not seeing a reason to apply them at this time?

I thought they might come useful to others playing with vmap_areas, I'll 
resubmit them anyway with the protected memory set.

But I was also hoping to get some more review, especially for the 
second, which had not received any definitive ACK/NACK, till now.

So, I'm also ok if they can be merged once the others are ACK'ed.

--
igor
