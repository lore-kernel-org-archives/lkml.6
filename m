Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753740AbeDISRk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 14:17:40 -0400
Received: from mga12.intel.com ([192.55.52.136]:4635 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbeDISRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 14:17:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,427,1517904000";
   d="scan'208";a="32897988"
Subject: Re: [PATCH 00/11] [v5] Use global pages with PTI
To: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
References: <20180406205501.24A1A4E7@viggo.jf.intel.com>
 <c96373d0-c16a-4463-147c-8624ad90af61@amd.com>
Cc: linux-mm@kvack.org, aarcange@redhat.com, luto@kernel.org,
        torvalds@linux-foundation.org, keescook@google.com, hughd@google.com,
        jgross@suse.com, x86@kernel.org, namit@vmware.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <b9802f89-93b3-b535-742c-f84e9f5be832@linux.intel.com>
Date: Mon, 9 Apr 2018 11:17:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c96373d0-c16a-4463-147c-8624ad90af61@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2018 11:04 AM, Tom Lendacky wrote:
> On 4/6/2018 3:55 PM, Dave Hansen wrote:
>> Changes from v4
>>  * Fix compile error reported by Tom Lendacky
> This built with CONFIG_RANDOMIZE_BASE=y, but failed to boot successfully.
> I think you're missing the initialization of __default_kernel_pte_mask in
> kaslr.c.

This should be simple to fix (just add a -1 instead of 0), but let me
double-check and actually boot the fix.
