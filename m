Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753088AbeBOXzr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 18:55:47 -0500
Received: from mga05.intel.com ([192.55.52.43]:38177 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752887AbeBOXzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 18:55:46 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,518,1511856000";
   d="scan'208";a="175720089"
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
Message-ID: <91298252-6cef-d4ee-fa77-eb4008eb5f53@linux.intel.com>
Date: Thu, 15 Feb 2018 15:55:45 -0800
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
>> During the switch over to PTI, we seem to have lost our ability to have
>> GLOBAL mappings.
...
> Did you perhaps re-run any benchmark numbers just to verify? Because
> it's always good to back up patches that should improve performance
> with actual numbers..

Same test as last time except I'm using all 4 cores on a Skylake desktop
instead of just 1.  The test is this:

> https://github.com/antonblanchard/will-it-scale/blob/master/tests/lseek1.c

With PCIDs, lseek()s/second go up around 2% to 3% with the these patches
enabling the global bit (it's noisy).  I measured it at 3% before, so
definitely the same ballpark.  That was also before all of Andy's
trampoline stuff and the syscall fast path removal.
