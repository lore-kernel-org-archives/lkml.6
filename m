Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932452AbeEHOau (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:30:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:34572 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932334AbeEHOat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:30:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,378,1520924400";
   d="scan'208";a="47654572"
Subject: Re: [PATCH] x86/boot/64/clang: Use fixup_pointer() to access
 '__supported_pte_mask'
To: Alexander Potapenko <glider@google.com>, mingo@kernel.org,
        kirill.shutemov@linux.intel.com
References: <20180508121638.174022-1-glider@google.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, mka@chromium.org,
        dvyukov@google.com, md@google.com
From: Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Message-ID: <1f69bdb6-df5e-d709-064a-4f6fdd6e11a7@linux.intel.com>
Date: Tue, 8 May 2018 07:30:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508121638.174022-1-glider@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 05:16 AM, Alexander Potapenko wrote:
> Similarly to commit 187e91fe5e91
> ("x86/boot/64/clang: Use fixup_pointer() to access 'next_early_pgt'"),
> '__supported_pte_mask' must be also accessed using fixup_pointer() to
> avoid position-dependent relocations.
> 
> Signed-off-by: Alexander Potapenko <glider@google.com>
> Fixes: fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")

In the interests of standalone changelogs, I'd really appreciate an
actual explanation of what's going on here.  Your patch makes the code
uglier and doesn't fix anything functional from what I can see.

The other commit has some explanation, so it seems like the rules for
accessing globals in head64.c are different than other files because...
something.

The functional problem here is that it causes insta-reboots?

Do we have anything we can do to keep us from recreating these kinds of
regressions all the time?
