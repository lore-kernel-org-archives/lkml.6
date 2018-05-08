Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933102AbeEHQtn (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:49:43 -0400
Received: from mga17.intel.com ([192.55.52.151]:48105 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932606AbeEHQtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:49:42 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39659044"
Subject: Re: [PATCH v2] x86/boot/64/clang: Use fixup_pointer() to access
 '__supported_pte_mask'
To: Alexander Potapenko <glider@google.com>, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
References: <20180508162829.7729-1-glider@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mka@chromium.org,
        dvyukov@google.com, md@google.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Message-ID: <a67943d1-f7e8-c465-ce8d-a9c9a0a6f653@linux.intel.com>
Date: Tue, 8 May 2018 09:49:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508162829.7729-1-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 09:28 AM, Alexander Potapenko wrote:
> Clang builds with defconfig started crashing after commit fb43d6cb91ef
> ("x86/mm: Do not auto-massage page protections")
> This was caused by introducing a new global access in __startup_64().
> 
> Code in __startup_64() can be relocated during execution, but the compiler
> doesn't have to generate PC-relative relocations when accessing globals
> from that function. Clang actually does not generate them, which leads
> to boot-time crashes. To work around this problem, every global pointer
> must be adjusted using fixup_pointer().

Looks good to me.  Thanks for adding the comment, especially!

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
