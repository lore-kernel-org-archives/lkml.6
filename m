Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753457AbeDPEgS (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 00:36:18 -0400
Received: from mga12.intel.com ([192.55.52.136]:26369 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751151AbeDPEgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 00:36:17 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,458,1517904000";
   d="scan'208";a="33923477"
Subject: Re: [PATCH v3 4/4] mm/sparse: Optimize memmap allocation during
 sparse_init()
To: Baoquan He <bhe@redhat.com>
References: <20180228032657.32385-1-bhe@redhat.com>
 <20180228032657.32385-5-bhe@redhat.com>
 <5dd3942a-cf66-f749-b1c6-217b0c3c94dc@intel.com>
 <20180408082038.GB19345@localhost.localdomain>
 <7cc53287-4570-84d6-502c-c3dfbd279b78@intel.com>
 <20180415021940.GA1750@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        pagupta@redhat.com, linux-mm@kvack.org,
        kirill.shutemov@linux.intel.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <11c4796f-865e-9e0c-076a-f750d5da0ea7@intel.com>
Date: Sun, 15 Apr 2018 21:36:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180415021940.GA1750@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/2018 07:19 PM, Baoquan He wrote:
>>> Yes, this place is the hardest to understand. The temorary arrays are
>>> allocated beforehand with the size of 'nr_present_sections'. The error
>>> paths you mentioned is caused by allocation failure of mem_map or
>>> map_map, but whatever it's error or success paths, the sections must be
>>> marked as present in memory_present(). Error or success paths happened
>>> in alloc_usemap_and_memmap(), while checking if it's erorr or success
>>> paths happened in the last for_each_present_section_nr() of
>>> sparse_init(), and clear the ms->section_mem_map if it goes along error
>>> paths. This is the key point of this new allocation way.
>> I think you owe some commenting because this is so hard to understand.
> I can arrange and write a code comment above sparse_init() according to
> this patch's git log, do you think it's OK?
> 
> Honestly, it took me several days to write code, while I spent more
> than one week to write the patch log. Writing patch log is really a
> headache to me.

I often find the same: writing the code is the easy part.  Explaining
why it is right is the hard part.
