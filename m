Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeAaUtt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:49:49 -0500
Received: from mga11.intel.com ([192.55.52.93]:17074 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751602AbeAaUts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:49:48 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,441,1511856000";
   d="scan'208";a="170687924"
Subject: Re: [PATCH] x86: Align TLB invalidation info
To: Nadav Amit <nadav.amit@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <20180131201118.1694-1-namit@vmware.com>
 <BD28D2CF-CAD7-45A1-87D0-DE38F7B0EFE5@amacapital.net>
 <747E60F0-2315-4BEC-895E-0E29C57A0AF0@gmail.com>
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <1e0c2666-d0ee-8fe2-3272-6b49bf045834@linux.intel.com>
Date: Wed, 31 Jan 2018 12:49:47 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <747E60F0-2315-4BEC-895E-0E29C57A0AF0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/31/2018 12:48 PM, Nadav Amit wrote:
>>> On Jan 31, 2018, at 12:11 PM, Nadav Amit <namit@vmware.com> wrote:
>>>
>>> The TLB invalidation info is allocated on the stack, which might cause
>>> it to be unaligned. Since this information may be transferred to
>>> different cores for TLB shootdown, this might result in an additional
>>> cache-line bouncing between the cores.
>>>
>>> GCC provides a way to deal with it by using
>>> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
>> Eww.  How about __aligned?
> Err.. Stupid me. For some reason I remembered I tried it and it didn’t have
> the desired effect, which caused me to assume it does not work for variables
> on the stack. Anyhow, it does the work. I’ll submit v2.

Also, just curious, but did you find this situation by inspection or did
it show up in a profile somewhere?
