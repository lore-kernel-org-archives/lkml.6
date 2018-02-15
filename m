Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166135AbeBOSNJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 13:13:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:2414 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162671AbeBOSNG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 13:13:06 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,517,1511856000";
   d="scan'208";a="18782526"
Subject: Re: [PATCH 0/3] Use global pages with PTI
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20180215132053.6C9B48C8@viggo.jf.intel.com>
 <CA+55aFy8k_zSJ_ASyzkA9C-jLV4mZsHpv1sOxJ9qpvfS_P6eMg@mail.gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Andrew Lutomirski <luto@kernel.org>,
        Kees Cook <keescook@google.com>, Hugh Dickins <hughd@google.com>,
        =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>,
        the arch/x86 maintainers <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <648e1bf1-c03e-2f1a-8a08-3763e6211ad3@linux.intel.com>
Date: Thu, 15 Feb 2018 10:13:05 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CA+55aFy8k_zSJ_ASyzkA9C-jLV4mZsHpv1sOxJ9qpvfS_P6eMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/15/2018 09:47 AM, Linus Torvalds wrote:
> On Thu, Feb 15, 2018 at 5:20 AM, Dave Hansen
> <dave.hansen@linux.intel.com> wrote:
>>
>> During the switch over to PTI, we seem to have lost our ability to have
>> GLOBAL mappings.
> 
> Oops. Odd, I have this distinct memory of somebody even _testing_ the
> global bit performance when I pointed out that we shouldn't just make
> the bit go away entirely.
> 
> [ goes back and looks at archives ]
> 
> Oh, that was in fact you who did that performance test.
...
> Did you perhaps re-run any benchmark numbers just to verify? Because
> it's always good to back up patches that should improve performance
> with actual numbers..

Nope, haven't done it yet, but I will.

I wanted to double-check that there was not a reason for doing the
global disabling other than the K8 TLB mismatch issues that Thomas fixed
a few weeks ago:

> commit 52994c256df36fda9a715697431cba9daecb6b11
> Author: Thomas Gleixner <tglx@linutronix.de>
> Date:   Wed Jan 3 15:57:59 2018 +0100
> 
>     x86/pti: Make sure the user/kernel PTEs match
>     
>     Meelis reported that his K8 Athlon64 emits MCE warnings when PTI is
>     enabled:
>     
>     [Hardware Error]: Error Addr: 0x0000ffff81e000e0
>     [Hardware Error]: MC1 Error: L1 TLB multimatch.
>     [Hardware Error]: cache level: L1, tx: INSN
