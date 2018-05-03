Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751525AbeECOnB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 10:43:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:5588 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751236AbeECOm6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 10:42:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,358,1520924400";
   d="scan'208";a="51238648"
Subject: Re: BUG: Bad page map in process python2 pte:10000000000
 pmd:17e8be067
To: Huaitong Han <oenhan@gmail.com>
References: <20180419054047.xxiljmzaf2u7odc6@wfg-t540p.sh.intel.com>
 <17463682-dc08-358d-8b44-02821352604c@intel.com>
 <CAAuJbeKT1eBxT4Y8FgQBrQcFDU_3R8ad=s_8zsyj+GPiZT7VhQ@mail.gmail.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Huang Ying <ying.huang@intel.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@01.org
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <7d386ba4-85ba-85dd-4f81-4cc984b149dd@intel.com>
Date: Thu, 3 May 2018 07:42:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAAuJbeKT1eBxT4Y8FgQBrQcFDU_3R8ad=s_8zsyj+GPiZT7VhQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2018 08:20 PM, Huaitong Han wrote:
> 
> kernel: swap_free: Bad swap file entry 1000000000103256
> kernel: BUG: Bad page map in process in:imjournal  pte:8192b1000 pmd:3ff9324067
> kernel: addr:00007f920adc5000 vm_flags:080000d1 anon_vma:
> (null) mapping:ffff883fe5284960 index:3f8
> kernel: vma->vm_ops->fault: shmem_fault+0x0/0x1d0
> kernel: vma->vm_file->f_op->mmap: shmem_mmap+0x0/0x30
> kernel: CPU: 5 PID: 9166 Comm: in:imjournal Tainted: G        W  OE
> K------------   3.10.0-514.16.1.el7.x86_64 #1

This looks like an entirely different signature.  There are lots of bits
set in the bad swap entry instead of a single one.  It's also a vintage
RHEL kernel, not mainline.
