Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752145AbeAaUwd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 15:52:33 -0500
Received: from mail-pg0-f45.google.com ([74.125.83.45]:40147 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751737AbeAaUwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 15:52:32 -0500
X-Google-Smtp-Source: AH8x227K8y/voNVVVC/XkJX1HZ81jNyHYHm6Gjgo7qM5ZgqcesEe6HI1IJWgKAJIyPS5n0/hMFJPYw==
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH] x86: Align TLB invalidation info
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <1e0c2666-d0ee-8fe2-3272-6b49bf045834@linux.intel.com>
Date: Wed, 31 Jan 2018 12:52:29 -0800
Cc: Andy Lutomirski <luto@amacapital.net>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>
Message-Id: <CFEB6DDC-D0C6-4B0C-9679-CB743BDCE3FC@gmail.com>
References: <20180131201118.1694-1-namit@vmware.com>
 <BD28D2CF-CAD7-45A1-87D0-DE38F7B0EFE5@amacapital.net>
 <747E60F0-2315-4BEC-895E-0E29C57A0AF0@gmail.com>
 <1e0c2666-d0ee-8fe2-3272-6b49bf045834@linux.intel.com>
To: Dave Hansen <dave.hansen@linux.intel.com>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w0VKqbe0000770

Dave Hansen <dave.hansen@linux.intel.com> wrote:

> On 01/31/2018 12:48 PM, Nadav Amit wrote:
>>>> On Jan 31, 2018, at 12:11 PM, Nadav Amit <namit@vmware.com> wrote:
>>>> 
>>>> The TLB invalidation info is allocated on the stack, which might cause
>>>> it to be unaligned. Since this information may be transferred to
>>>> different cores for TLB shootdown, this might result in an additional
>>>> cache-line bouncing between the cores.
>>>> 
>>>> GCC provides a way to deal with it by using
>>>> __builtin_alloca_with_align(). Use it to avoid the bouncing cache lines.
>>> Eww.  How about __aligned?
>> Err.. Stupid me. For some reason I remembered I tried it and it didn’t have
>> the desired effect, which caused me to assume it does not work for variables
>> on the stack. Anyhow, it does the work. I’ll submit v2.
> 
> Also, just curious, but did you find this situation by inspection or did
> it show up in a profile somewhere?

Actually, not. I considered adding data to info for a different reason
(which eventually I deserted); I was assuming you will all kill me for
increasing the size, so this was a preemption step.
