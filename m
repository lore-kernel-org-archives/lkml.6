Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753831AbeDITuX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 15:50:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:25634 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbeDITuW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 15:50:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="32920959"
Subject: Re: [PATCH 00/11] [v5] Use global pages with PTI
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
References: <20180406205501.24A1A4E7@viggo.jf.intel.com>
 <c96373d0-c16a-4463-147c-8624ad90af61@amd.com>
 <b9802f89-93b3-b535-742c-f84e9f5be832@linux.intel.com>
 <1b45ffd1-99bb-4ac1-fb65-0de3e42c1c0a@amd.com>
Cc: linux-mm@kvack.org, aarcange@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <f87b6f47-2416-4c12-55dd-5f0cb86f1464@linux.intel.com>
Date: Mon, 9 Apr 2018 12:50:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1b45ffd1-99bb-4ac1-fb65-0de3e42c1c0a@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 11:59 AM, Tom Lendacky wrote:
> On 4/9/2018 1:17 PM, Dave Hansen wrote:
>> On 04/09/2018 11:04 AM, Tom Lendacky wrote:
>>> On 4/6/2018 3:55 PM, Dave Hansen wrote:
>>>> Changes from v4
>>>>  * Fix compile error reported by Tom Lendacky
>>> This built with CONFIG_RANDOMIZE_BASE=y, but failed to boot successfully.
>>> I think you're missing the initialization of __default_kernel_pte_mask in
>>> kaslr.c.
>>
>> This should be simple to fix (just add a -1 instead of 0), but let me
>> double-check and actually boot the fix.
> 
> Yup, added an "= ~0" and everything is good.

I'm testing at this commit in the tip tree:

0564258... x86/pti: Leave kernel text global for !PCID

It seems to boot OK with RANDOMIZE_BASE=y for both PCID and non-PCID
configuration.  Could you send along your .config so I can try to reproduce?
