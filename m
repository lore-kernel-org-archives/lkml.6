Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936057AbeCBGWu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 01:22:50 -0500
Received: from mga06.intel.com ([134.134.136.31]:40594 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935990AbeCBGWt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 01:22:49 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,411,1515484800";
   d="scan'208";a="208285682"
Subject: Re: [RFC][PATCH 03/10] x86/mm: introduce "default" kernel PTE mask
To: Tom Lendacky <thomas.lendacky@amd.com>, Nadav Amit <namit@vmware.com>
References: <20180222203651.B776810C@viggo.jf.intel.com>
 <20180222203656.25C9B4EC@viggo.jf.intel.com>
 <57A9625E-3F25-402B-8B54-129A68449C48@vmware.com>
 <61c68587-3ad5-edf7-539c-8af99c6220ea@linux.intel.com>
 <5b801b73-bedd-e7f5-765a-6e00759a5786@amd.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <fa314a3b-88fb-45d0-8e3a-bab2236b3a20@linux.intel.com>
Date: Fri, 23 Feb 2018 15:46:56 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5b801b73-bedd-e7f5-765a-6e00759a5786@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 03:11 PM, Tom Lendacky wrote:
>> I don't think we can help out-of-tree modules getting this wrong.
>> They're OK if they use PAGE_KERNEL*, btw.
> You will probably need to change __default_kernel_pte_mask to be an
> EXPORT_SYMBOL instead of an EXPORT_SYMBOL_GPL for (some) out-of-tree
> modules.

As much as I detest missing an opportunity to kick non-GPL drivers in
the shins, I guess it is pretty cruel to break them for doing things
like vmap(PAGE_KERNEL).

I'll make it plain EXPORT_SYMBOL().
