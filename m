Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965280AbeE2Q6N (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:58:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55838 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965151AbeE2Q6M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:58:12 -0400
Subject: Re: [PATCH] x86, random: Fix get_random_bytes() warning in x86
 start_kernel
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
References: <20180529123800.19627-1-prarit@redhat.com>
 <CAGXu5jJvJbTZT5=u7TJtLsN-TsuSEfw8h2EwV8w-oefJkADoBg@mail.gmail.com>
 <71b5df93-2e21-f3c3-fa22-4488729daeb5@redhat.com>
 <20180529160743.GA7381@thunk.org>
From: Prarit Bhargava <prarit@redhat.com>
Message-ID: <35cdbb04-7b1d-59ae-2ff8-af1d57751113@redhat.com>
Date: Tue, 29 May 2018 12:58:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180529160743.GA7381@thunk.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/29/2018 12:07 PM, Theodore Y. Ts'o wrote:
> On Tue, May 29, 2018 at 11:01:07AM -0400, Prarit Bhargava wrote:
>> Kees, in early boot no pool is available so the stack canary is initialized from
>> the TSC.  Later in boot, the stack canary will use the the crng.
>>
>> ie) in early boot only TSC is okay, and late boot (when crng_ready() is true)
>> the pool will be used.
> 
> But that means all of the kernel threads (e.g., workqueues, et. al)
> would not be well protected by the stack canary.  That
> seems.... rather unfortunate.

Well, as stated the TSC is used as a source of entropy in early boot.  It's
always been that way and get_random_bytes() AFAICT has always returned 0.  CPUs
added later on via hotplug do use get_random_bytes().

Does anyone cc'd have a better idea on how to get another source of entropy this
early in boot?

P.

> 
>       	     	  	      	   	     - Ted
> 
