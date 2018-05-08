Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932905AbeEHQZF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 12:25:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:14953 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932707AbeEHQZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 12:25:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,379,1520924400";
   d="scan'208";a="39652780"
Subject: Re: [PATCH] x86/boot/64/clang: Use fixup_pointer() to access
 '__supported_pte_mask'
To: Alexander Potapenko <glider@google.com>
References: <20180508121638.174022-1-glider@google.com>
 <1f69bdb6-df5e-d709-064a-4f6fdd6e11a7@linux.intel.com>
 <CAG_fn=Xv74c80swzFjKyybQpRj7Qj9K1NVH-D6gcxcYEoUJ1xA@mail.gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Dmitriy Vyukov <dvyukov@google.com>, Michael Davidson <md@google.com>
From: Dave Hansen <dave.hansen@intel.com>
Openpgp: preference=signencrypt
Message-ID: <d149aae8-6aba-bb31-ddd6-49244598a617@intel.com>
Date: Tue, 8 May 2018 09:25:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAG_fn=Xv74c80swzFjKyybQpRj7Qj9K1NVH-D6gcxcYEoUJ1xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2018 07:50 AM, Alexander Potapenko wrote:
>>> Similarly to commit 187e91fe5e91
>>> ("x86/boot/64/clang: Use fixup_pointer() to access 'next_early_pgt'"),
>>> '__supported_pte_mask' must be also accessed using fixup_pointer() to
>>> avoid position-dependent relocations.
>>>
>>> Signed-off-by: Alexander Potapenko <glider@google.com>
>>> Fixes: fb43d6cb91ef ("x86/mm: Do not auto-massage page protections")
> 
>> In the interests of standalone changelogs, I'd really appreciate an
>> actual explanation of what's going on here.  Your patch makes the code
>> uglier and doesn't fix anything functional from what I can see.
> You're right, sure. I'll send a patch with an updated description.

Great, thanks!

>> Do we have anything we can do to keep us from recreating these kinds of
>> regressions all the time?
> I'm not really aware of the possible options in the kernel land. Looks like
> a task for some objtool-like utility?
> As long as these regressions are caught with Clang, setting up a 0day Clang
> builder might help.

I've asked the 0day folks if this is doable.  It would be great to see
it added.
