Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751426AbeBVVaD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 16:30:03 -0500
Received: from mga14.intel.com ([192.55.52.115]:36625 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751180AbeBVVaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 16:30:02 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,378,1515484800";
   d="scan'208";a="19714589"
Subject: Re: [RFC][PATCH 04/10] x86/espfix: use kernel-default PTE mask
To: Nadav Amit <namit@vmware.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203658.80705136@viggo.jf.intel.com>
 <93613F56-C778-4EA0-8945-A0B8ABC1A5FD@vmware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <f90cef60-1710-1d99-61ee-4527067b115f@linux.intel.com>
Date: Thu, 22 Feb 2018 13:30:01 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <93613F56-C778-4EA0-8945-A0B8ABC1A5FD@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 01:27 PM, Nadav Amit wrote:
> Dave Hansen <dave.hansen@linux.intel.com> wrote:
>> From: Dave Hansen <dave.hansen@linux.intel.com>
>> In creating its page tables, the espfix code masks its PGTABLE_PROT
>> value with the supported mask: __supported_pte_mask.  This ensures
>> that unsupported bits are not set in the final PTE.  But, it also
>> sets _PAGE_GLOBAL which we do not want for PTE.  Use
>> __default_kernel_pte_mask instead which clears _PAGE_GLOBAL for PTI.
> 
> Can you please explain what is your concern? Exposing more gadgets for
> speculative ROP attacks?
> 
> Or is it a general rule of not exposing any kernel code &data more than
> absolutely necessary?

I think it's good practice to just expose only the *minimal* amount of
data necessary.  It's easier to audit and less likely to expose things
accidentall.
