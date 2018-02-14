Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162159AbeBNSbj (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 13:31:39 -0500
Received: from mga05.intel.com ([192.55.52.43]:56498 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1161897AbeBNSbh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 13:31:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,513,1511856000";
   d="scan'208";a="34704868"
Subject: Re: [RFC PATCH V2 00/22] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
To: Mike Kravetz <mike.kravetz@oracle.com>, tglx@linutronix.de,
        fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>
References: <cover.1518443616.git.reinette.chatre@intel.com>
 <e0d59d83-14a1-6059-6f0b-da47b3b7de31@oracle.com>
From: Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <29d1be82-9fc8-ecde-a5ee-4eafc92e39f1@intel.com>
Date: Wed, 14 Feb 2018 10:31:36 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <e0d59d83-14a1-6059-6f0b-da47b3b7de31@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

On 2/14/2018 10:12 AM, Mike Kravetz wrote:
> On 02/13/2018 07:46 AM, Reinette Chatre wrote:
>> Adding MM maintainers to v2 to share the new MM change (patch 21/22) that
>> enables large contiguous regions that was created to support large Cache
>> Pseudo-Locked regions (patch 22/22). This week MM team received another
>> proposal to support large contiguous allocations ("[RFC PATCH 0/3]
>> Interface for higher order contiguous allocations" at
>> http://lkml.kernel.org/r/20180212222056.9735-1-mike.kravetz@oracle.com).
>> I have not yet tested with this new proposal but it does seem appropriate
>> and I should be able to rework patch 22 from this series on top of that if
>> it is accepted instead of what I have in patch 21 of this series.
>>
> 
> Well, I certainly would prefer the adoption and use of a more general
> purpose interface rather than exposing alloc_gigantic_page().
> 
> Both the interface I suggested and alloc_gigantic_page end up calling
> alloc_contig_range().  I have not looked at your entire patch series, but
> do be aware that in its present form alloc_contig_range will run into
> issues if called by two threads simultaneously for the same page range.
> Calling alloc_gigantic_page without some form of synchronization will
> expose this issue.  Currently this is handled by hugetlb_lock for all
> users of alloc_gigantic_page.  If you simply expose alloc_gigantic_page
> without any type of synchronization, you may run into issues.  The first
> patch in my RFC "mm: make start_isolate_page_range() fail if already
> isolated" should handle this situation IF we decide to expose
> alloc_gigantic_page (which I do not suggest).

My work depends on the ability to create large contiguous regions,
creating these large regions is not the goal in itself. Certainly I
would want to use the most appropriate mechanism and I would gladly
modify my work to do so.

I do not insist on using alloc_gigantic_page(). Now that I am aware of
your RFC I started the process to convert to the new
find_alloc_contig_pages(). I did not do so earlier because it was not
available when I prepared this work for submission. I plan to respond to
your RFC when my testing is complete but please give me a few days to do
so. Could you please also cc me if you do send out any new versions?

Thank you very much!

Reinette
