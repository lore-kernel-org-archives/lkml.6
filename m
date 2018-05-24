Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964778AbeEXF7Y (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 01:59:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56996 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935530AbeEXF7T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 01:59:19 -0400
Subject: Re: [PATCH v1 10/10] mm/memory_hotplug: allow online/offline memory
 by a kernel module
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180523151151.6730-1-david@redhat.com>
 <20180523151151.6730-11-david@redhat.com>
 <20180523195119.GA20852@infradead.org>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat GmbH
Message-ID: <73b34d6e-9726-e0a5-0418-65ef13f87198@redhat.com>
Date: Thu, 24 May 2018 07:59:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523195119.GA20852@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.05.2018 21:51, Christoph Hellwig wrote:
> On Wed, May 23, 2018 at 05:11:51PM +0200, David Hildenbrand wrote:
>> Kernel modules that want to control how/when memory is onlined/offlined
>> need a proper interface to these functions. Also, for adding memory
>> properly, memory_block_size_bytes is required.
> 
> Which module?  Please send it along with the enabling code.

Hi,

as indicated in the cover letter, it is called "virtio-mem".
I sent it yesterday as a separate series (RFC).

Cover letter: https://lkml.org/lkml/2018/5/23/800
Relevant patch: https://lkml.org/lkml/2018/5/23/803

> 
>> --- a/drivers/base/memory.c
>> +++ b/drivers/base/memory.c
>> @@ -88,6 +88,7 @@ unsigned long __weak memory_block_size_bytes(void)
>>  {
>>  	return MIN_MEMORY_BLOCK_SIZE;
>>  }
>> +EXPORT_SYMBOL(memory_block_size_bytes);
> 
>> +EXPORT_SYMBOL(mem_hotplug_begin);
> 
>> +EXPORT_SYMBOL(mem_hotplug_done);
> 
> EXPORT_SYMBOL_GPL for any deep down VM internals, please.
> 

I continued using what was being used for symbols in this file. If there
are not other opinions, I'll switch to EXPORT_SYMBOL_GPL. Thanks!

-- 

Thanks,

David / dhildenb
