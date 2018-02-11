Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbeBKDT6 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 22:19:58 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:32981 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752285AbeBKDTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 22:19:55 -0500
X-Google-Smtp-Source: AH8x225elie1Zg0MmSUwUbl0OeJAfNc0O0n+iydXZWfeAbKag9RQIRIEQDjxfb76SwX0Igq2ar3KEg==
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
 <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com>
 <d21822e2-2982-7182-1d9a-be3e5b7e1553@gmail.com>
 <5664ca7f-f391-0301-3a0d-666b73f17b15@redhat.com>
 <9034fe13-26c4-ee72-5b94-19aa8fc11efc@gmail.com>
 <0aedd0e5-f5eb-54d8-6f77-e7a12c65fed5@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <63c3626c-e64d-aa56-3935-be046d731232@gmail.com>
Date: Sun, 11 Feb 2018 11:20:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <0aedd0e5-f5eb-54d8-6f77-e7a12c65fed5@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/09/2018 08:42 PM, Paolo Bonzini wrote:
> On 09/02/2018 04:22, Xiao Guangrong wrote:
>>>
>>
>> That is a good question... :)
>>
>> This case (with KVM_MEMSLOT_INVALID is set) can be easily constructed,
>> userspace should avoid this case by itself (avoiding vCPU accessing the
>> memslot which is being updated). If it happens, it's a operation issue
>> rather than INTERNAL ERROR.
>>
>> Maybe treat it as MMIO accessing and return to userspace with MMIO_EXIT
>> is a better solution...
> 
> Yeah, that's what emulation would do (except if it's an instruction
> fetch, which will cause emulation to fail).  I think it's a bug in the
> non-EPT #PF case that we return with -EFAULT.

Wanpeng, could you please do it? :)
