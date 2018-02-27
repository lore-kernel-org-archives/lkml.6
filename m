Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeB0KWh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 05:22:37 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751752AbeB0KWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 05:22:35 -0500
Subject: Re: [PATCH v4] KVM: X86: Allow userspace to define the microcode
 version
To: Wanpeng Li <kernellwp@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>, Nadav Amit <nadav.amit@gmail.com>
References: <1519698910-4272-1-git-send-email-wanpengli@tencent.com>
 <b6051971-04a5-09e7-d11f-3689369292fe@redhat.com>
 <CANRm+CzvN5ypz=Y2moJQph36O5tpDbqzJtB2N_8Hm3guqWXYSg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c44a08d1-a532-879f-79dd-81c8ea175365@redhat.com>
Date: Tue, 27 Feb 2018 11:22:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CANRm+CzvN5ypz=Y2moJQph36O5tpDbqzJtB2N_8Hm3guqWXYSg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/2018 10:26, Wanpeng Li wrote:
> 2018-02-27 16:38 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>> On 27/02/2018 03:35, Wanpeng Li wrote:
>>> From: Wanpeng Li <wanpengli@tencent.com>
>>>
>>> Linux (among the others) has checks to make sure that certain features
>>> aren't enabled on a certain family/model/stepping if the microcode version
>>> isn't greater than or equal to a known good version.
>>>
>>> By exposing the real microcode version, we're preventing buggy guests that
>>> don't check that they are running virtualized (i.e., they should trust the
>>> hypervisor) from disabling features that are effectively not buggy.
>>>
>>> Suggested-by: Filippo Sironi <sironi@amazon.de>
>>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>>> Cc: Liran Alon <liran.alon@oracle.com>
>>> Cc: Nadav Amit <nadav.amit@gmail.com>
>>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
>>> ---
>>> v3 -> v4:
>>>  * add the shifts back
>>
>> Please wait for a review instead of pushing new versions continuously.
>> Leaving the shifts means that MSR_IA32_UCODE_REV's bits 0-31 are zeroed
>> even if KVM_SET_MSRS makes them nonzero.
> 
> How about something like this?

Yes, that's okay.

Paolo
