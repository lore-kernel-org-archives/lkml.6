Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966197AbeE2ST4 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 14:19:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52661 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S936904AbeE2STu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 14:19:50 -0400
Date: Tue, 29 May 2018 11:19:25 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <35cdbb04-7b1d-59ae-2ff8-af1d57751113@redhat.com>
References: <20180529123800.19627-1-prarit@redhat.com> <CAGXu5jJvJbTZT5=u7TJtLsN-TsuSEfw8h2EwV8w-oefJkADoBg@mail.gmail.com> <71b5df93-2e21-f3c3-fa22-4488729daeb5@redhat.com> <20180529160743.GA7381@thunk.org> <35cdbb04-7b1d-59ae-2ff8-af1d57751113@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH] x86, random: Fix get_random_bytes() warning in x86 start_kernel
To: Prarit Bhargava <prarit@redhat.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rik van Riel <riel@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Kate Stewart <kstewart@linuxfoundation.org>
From: hpa@zytor.com
Message-ID: <54FF298C-0992-4592-AAF8-9ABBF8DE917D@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2018 9:58:10 AM PDT, Prarit Bhargava <prarit@redhat.com> wrote:
>
>
>On 05/29/2018 12:07 PM, Theodore Y. Ts'o wrote:
>> On Tue, May 29, 2018 at 11:01:07AM -0400, Prarit Bhargava wrote:
>>> Kees, in early boot no pool is available so the stack canary is
>initialized from
>>> the TSC.  Later in boot, the stack canary will use the the crng.
>>>
>>> ie) in early boot only TSC is okay, and late boot (when crng_ready()
>is true)
>>> the pool will be used.
>> 
>> But that means all of the kernel threads (e.g., workqueues, et. al)
>> would not be well protected by the stack canary.  That
>> seems.... rather unfortunate.
>
>Well, as stated the TSC is used as a source of entropy in early boot. 
>It's
>always been that way and get_random_bytes() AFAICT has always returned
>0.  CPUs
>added later on via hotplug do use get_random_bytes().
>
>Does anyone cc'd have a better idea on how to get another source of
>entropy this
>early in boot?
>
>P.
>
>> 
>>       	     	  	      	   	     - Ted
>> 

RDRAND/RDSEED for newer x86 processors.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
