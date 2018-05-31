Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754699AbeEaUus convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:50:48 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42099 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754434AbeEaUuh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:50:37 -0400
Date: Thu, 31 May 2018 13:50:23 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrUL0sV3f4z=S0y-fwPE82pp8BTGDGkvi=MPHak8-zwBnQ@mail.gmail.com>
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com> <1527789525-8857-7-git-send-email-chang.seok.bae@intel.com> <CALCETrUL0sV3f4z=S0y-fwPE82pp8BTGDGkvi=MPHak8-zwBnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH V2 06/15] taint: Add taint for insecure
To: Andy Lutomirski <luto@kernel.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>
CC: Andrew Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
From: hpa@zytor.com
Message-ID: <60869EFF-9C2E-4415-B538-0826FA26B698@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2018 1:25:39 PM PDT, Andy Lutomirski <luto@kernel.org> wrote:
>On Thu, May 31, 2018 at 10:58 AM Chang S. Bae
><chang.seok.bae@intel.com> wrote:
>>
>> When adding new feature support, patches need to be
>> incrementally applied and tested with temporal parameters.
>> For such testing (or root-only) purposes, the new flag
>> will serve to tag the kernel taint state properly.
>
>I'm okay with this, I guess, but I'm not at all convinced we need it.

This was my idea. It isn't the only thing that may want it, and I think it is critical that we give the system a way to flag that the system contains experimental code that is known to break security. Sometimes that kind of experimental code is useful (I have written some myself, e.g. to treat SMAP), but it is a good idea to be able to flag such a kernel permanently, even if it's a module that can be removed.

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
