Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754230AbeCGAlf (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 19:41:35 -0500
Received: from mail-oi0-f43.google.com ([209.85.218.43]:44512 "EHLO
        mail-oi0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753656AbeCGAle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 19:41:34 -0500
X-Google-Smtp-Source: AG47ELuvQgs9x3xeY2s7JDBm8ysWdQ0M7Ar1vTwPirO7+WUN+1+oyO+n7nhLZvBIB8S9IY5YqgSSK8VEwBh3paAvTXg=
MIME-Version: 1.0
In-Reply-To: <20180306143939.GA23766@u40b0340c692b58f6553c.ant.amazon.com>
References: <1518483942-14741-1-git-send-email-wanpengli@tencent.com> <20180306143939.GA23766@u40b0340c692b58f6553c.ant.amazon.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 7 Mar 2018 08:41:33 +0800
Message-ID: <CANRm+Cy5bi-=5fz_raea1vxSpsGWB8C2xknYN5baRZGRzAPsMw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] KVM: Introduce dedicated vCPUs hint KVM_HINTS_DEDICATED
To: Eduardo Valentin <eduval@amazon.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-06 22:39 GMT+08:00 Eduardo Valentin <eduval@amazon.com>:
> Folks,
>
> On Tue, Feb 13, 2018 at 09:05:39AM +0800, Wanpeng Li wrote:
>> This patchset introduces dedicated vCPUs(vCPU pinning, and there is no
>> vCPU over-commitment) hint KVM_HINTS_DEDICATED, it has two users now:
>>
>> 1) Waiman Long mentioned that:
>>
>>     Generally speaking, unfair lock performs well for VMs with a small
>>     number of vCPUs. Native qspinlock may perform better than pvqspinlock
>>     if there is vCPU pinning and there is no vCPU over-commitment.
>>
>> 2) vCPUs are very unlikely to get preempted when they are the only task
>>    running on a CPU. PV TLB flush is slower that the native flush in that
>>    case.
>>
>> v3 -> v4:
>>  * update feature bit document
>> v2 -> v3:
>>  * a separate table for CPUID[0x40000001].EDX bits
>>  * a new kvm_hint_has_feature macro
>> v1 -> v2:
>>  * update to KVM_HINTS_DEDICATED
>
> Great to see this has finally moved forward! Thanks for picking it up Wanpeng.
>
> I would just request to next time at least reference the original thread and
> copy the original authors of the patch/idea.

Thanks for the original idea, Eduardo!

Regards,
Wanpeng Li
