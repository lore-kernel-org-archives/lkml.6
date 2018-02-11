Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753225AbeBKK5k (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 05:57:40 -0500
Received: from mail-ot0-f181.google.com ([74.125.82.181]:46253 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbeBKK5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 05:57:38 -0500
X-Google-Smtp-Source: AH8x226i82r5Oc9nHl4vPrBnRfS1gXlxwTweMaPQ9Cw+yR+4BpmNq71Aa1dR4CZ0NR6G+3udpf7TCpn2L7DDZ2ENLl8=
MIME-Version: 1.0
In-Reply-To: <0aedd0e5-f5eb-54d8-6f77-e7a12c65fed5@redhat.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
 <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com> <d21822e2-2982-7182-1d9a-be3e5b7e1553@gmail.com>
 <5664ca7f-f391-0301-3a0d-666b73f17b15@redhat.com> <9034fe13-26c4-ee72-5b94-19aa8fc11efc@gmail.com>
 <0aedd0e5-f5eb-54d8-6f77-e7a12c65fed5@redhat.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Sun, 11 Feb 2018 18:57:37 +0800
Message-ID: <CANRm+CxEB3S26qK1OjeN4E4MYC-fVW4MCEEgKi7nJcsCwi4BQA@mail.gmail.com>
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-09 20:42 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
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

After patch v2, I found that instruction fetch causes emulation to
fail since KVM_MEMSLOT_INVALID.

Regards,
Wanpeng Li
