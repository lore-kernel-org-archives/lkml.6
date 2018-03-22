Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754124AbeCVKmh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 06:42:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51274 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753177AbeCVKmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 06:42:31 -0400
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit
 mode
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
 <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com>
Date: Thu, 22 Mar 2018 11:42:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2018 11:19, Andrew Cooper wrote:
> On 22/03/2018 10:07, Paolo Bonzini wrote:
>> On 22/03/2018 09:34, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> Explicit segment overides other than %fs and %gs are documented as ignored by
>>> both Intel and AMD.
>>>
>>> In practice, this means that:
>>>
>>>  * Explicit uses of %ss don't actually yield #SS[0] for non-canonical
>>>    memory references.
>>>  * Explicit uses of %{e,c,d}s don't override %rbp/%rsp-based memory references
>>>    to yield #GP[0] for non-canonical memory references.
>>>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> 
> When porting fixes from other projects, it is customary to identify so
> in the commit message.  In this case, the fix you've ported is
> http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=b7dce29d9faf3597d009c853ed1fcbed9f7a7f68
> 
> Here is an example of how Xen ports fixes from Linux for the drivers
> that we share. 
> http://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=4e131596f1defec9407b6e60d584a696beaf5d7e

Thanks Andrew.  The code is of course completely different, but the
commit message is 1:1.  Wanpeng, please acknowledge Jan in v2!

>> Testcase, please...
> 
> If you want to crib from one, this is the testcase I made for Xen.
> 
> http://xenbits.xen.org/docs/xtf/test-memop-seg.html

How does it ensure that the code is executed through the emulator and
not by the processor?

> With the impending KVM/PVH work which is ongoing, it will soon be easy
> to run Xen's HVM test suite unmodified under KVM, but we're not quite
> there yet.

What does the test suite use for console I/O?

Paolo
