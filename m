Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752694AbeBKI4x (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 03:56:53 -0500
Received: from mail-ot0-f177.google.com ([74.125.82.177]:40291 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752085AbeBKI4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 03:56:51 -0500
X-Google-Smtp-Source: AH8x226K4bdKzUrto8wYuW8oQA5YyFA3s5kUZL99DjyRK330y5dui7Yhqr5aIloWj0De4DQBCYuHMiAtHB9yOYp4Xng=
MIME-Version: 1.0
In-Reply-To: <63c3626c-e64d-aa56-3935-be046d731232@gmail.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
 <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com> <d21822e2-2982-7182-1d9a-be3e5b7e1553@gmail.com>
 <5664ca7f-f391-0301-3a0d-666b73f17b15@redhat.com> <9034fe13-26c4-ee72-5b94-19aa8fc11efc@gmail.com>
 <0aedd0e5-f5eb-54d8-6f77-e7a12c65fed5@redhat.com> <63c3626c-e64d-aa56-3935-be046d731232@gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sun, 11 Feb 2018 16:56:50 +0800
Message-ID: <CANRm+CxQ29LpqPbzxUjJhM1-Yir0bMTnp=y_Ds2_+63zOSz0qQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-11 11:20 GMT+08:00 Xiao Guangrong <guangrong.xiao@gmail.com>:
>
>
> On 02/09/2018 08:42 PM, Paolo Bonzini wrote:
>>
>> On 09/02/2018 04:22, Xiao Guangrong wrote:
>>>>
>>>>
>>>
>>> That is a good question... :)
>>>
>>> This case (with KVM_MEMSLOT_INVALID is set) can be easily constructed,
>>> userspace should avoid this case by itself (avoiding vCPU accessing the
>>> memslot which is being updated). If it happens, it's a operation issue
>>> rather than INTERNAL ERROR.
>>>
>>> Maybe treat it as MMIO accessing and return to userspace with MMIO_EXIT
>>> is a better solution...
>>
>>
>> Yeah, that's what emulation would do (except if it's an instruction
>> fetch, which will cause emulation to fail).  I think it's a bug in the
>> non-EPT #PF case that we return with -EFAULT.
>
>
> Wanpeng, could you please do it? :)

Thanks for the discussion, I will have a try. :)

Regards,
Wanpeng Li
