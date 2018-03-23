Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752006AbeCWPEf (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 11:04:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47122 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751686AbeCWPEX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 11:04:23 -0400
Subject: Re: [PATCH] KVM: X86: Fix the decoding of segment overrides in 64bit
 mode
To: Wanpeng Li <kernellwp@gmail.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>
References: <1521707651-9375-1-git-send-email-wanpengli@tencent.com>
 <aadc47c3-9d5f-b4d5-92d3-cb888a29563c@redhat.com>
 <49454fe4-16e2-4d8b-7ad5-9e488afc786e@citrix.com>
 <d1126eb9-7203-7044-f72b-174cac6607ab@redhat.com>
 <e9db6804-4881-be93-f570-e9631dbccac8@citrix.com>
 <9bd82cb0-d88f-4891-a111-3704802e1d4e@redhat.com>
 <CANRm+CwmJQCFZ7oe1_YatqoOXzzEU+SP9Z5qR6zU_ybd_DoGQQ@mail.gmail.com>
 <94bbfac5-2022-ab92-0b9a-1c3cd2275054@citrix.com>
 <CANRm+CwsFX7rVkPvENRM20D84zotonxFFJMSq98icS4BQm7o2Q@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <46ef9359-a87c-224c-53e0-c948b79314a8@redhat.com>
Date: Fri, 23 Mar 2018 16:04:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CwsFX7rVkPvENRM20D84zotonxFFJMSq98icS4BQm7o2Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2018 15:27, Wanpeng Li wrote:
> 2018-03-22 21:53 GMT+08:00 Andrew Cooper <andrew.cooper3@citrix.com>:
>> On 22/03/18 13:39, Wanpeng Li wrote:
>>> 2018-03-22 20:38 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>>> On 22/03/2018 12:04, Andrew Cooper wrote:
>>>>> We've got a Force Emulation Prefix (ud2a; .ascii "xen") for doing
>>>>> magic.  Originally, this was used for PV guests to explicitly request an
>>>>> emulated CPUID, but I extended it to HVM guests for "emulate the next
>>>>> instruction", after we had some guest user => guest kernel privilege
>>>>> escalations because of incorrect emulation.
>>>> Wanpeng, why don't you add it behind a new kvm module parameter? :)
>>> Great point! I will have a try. Thanks Paolo and Andrew. :)
>>
>> Using the force emulation prefix requires intercepting #UD, which is in
>> general a BadThing(tm) for security.  Therefore, we have a build time
> 
> Yeah, however kvm intercepts and emulates #UD by default, should we
> add a new kvm module parameter to enable it and disable by default?

No, the module parameter should only be about the force-emulation prefix.

Paolo
