Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeEGTIh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 15:08:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59670 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752099AbeEGTIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 15:08:36 -0400
From: Jeff Moyer <jmoyer@redhat.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>,
        Huaisheng Ye <yehs1@lenovo.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, chengnt@lenovo.com,
        Dave Hansen <dave.hansen@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        pasha.tatashin@oracle.com, Linux MM <linux-mm@kvack.org>,
        colyli@suse.de, Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <alexander.levin@verizon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [RFC PATCH v1 0/6] use mm to manage NVDIMM (pmem) zone
References: <1525704627-30114-1-git-send-email-yehs1@lenovo.com>
        <20180507184622.GB12361@bombadil.infradead.org>
        <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Date: Mon, 07 May 2018 15:08:32 -0400
In-Reply-To: <CAPcyv4hBJN3npXwg3Ur32JSWtKvBUZh7F8W+Exx3BB-uKWwPag@mail.gmail.com>
        (Dan Williams's message of "Mon, 7 May 2018 11:57:10 -0700")
Message-ID: <x49a7tbi8r3.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:

> On Mon, May 7, 2018 at 11:46 AM, Matthew Wilcox <willy@infradead.org> wrote:
>> On Mon, May 07, 2018 at 10:50:21PM +0800, Huaisheng Ye wrote:
>>> Traditionally, NVDIMMs are treated by mm(memory management) subsystem as
>>> DEVICE zone, which is a virtual zone and both its start and end of pfn
>>> are equal to 0, mm wouldn’t manage NVDIMM directly as DRAM, kernel uses
>>> corresponding drivers, which locate at \drivers\nvdimm\ and
>>> \drivers\acpi\nfit and fs, to realize NVDIMM memory alloc and free with
>>> memory hot plug implementation.
>>
>> You probably want to let linux-nvdimm know about this patch set.
>> Adding to the cc.
>
> Yes, thanks for that!
>
>> Also, I only received patch 0 and 4.  What happened
>> to 1-3,5 and 6?
>>
>>> With current kernel, many mm’s classical features like the buddy
>>> system, swap mechanism and page cache couldn’t be supported to NVDIMM.
>>> What we are doing is to expand kernel mm’s capacity to make it to handle
>>> NVDIMM like DRAM. Furthermore we make mm could treat DRAM and NVDIMM
>>> separately, that means mm can only put the critical pages to NVDIMM

Please define "critical pages."

>>> zone, here we created a new zone type as NVM zone. That is to say for
>>> traditional(or normal) pages which would be stored at DRAM scope like
>>> Normal, DMA32 and DMA zones. But for the critical pages, which we hope
>>> them could be recovered from power fail or system crash, we make them
>>> to be persistent by storing them to NVM zone.

[...]

> I think adding yet one more mm-zone is the wrong direction. Instead,
> what we have been considering is a mechanism to allow a device-dax
> instance to be given back to the kernel as a distinct numa node
> managed by the VM. It seems it times to dust off those patches.

What's the use case?  The above patch description seems to indicate an
intent to recover contents after a power loss.  Without seeing the whole
series, I'm not sure how that's accomplished in a safe or meaningful
way.

Huaisheng, could you provide a bit more background?

Thanks!
Jeff
