Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752419AbeCOSEl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:04:41 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55814 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751394AbeCOSEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:04:40 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley \(EOSG\)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on Hyper-V
References: <20180309140249.2840-1-vkuznets@redhat.com>
        <20180309140249.2840-8-vkuznets@redhat.com>
        <2747cc75-b549-61bb-9c1b-0f554a49b536@redhat.com>
        <87zi399xih.fsf@vitty.brq.redhat.com> <20180315170202.GA5180@flask>
        <20180315172852.GA21667@flask>
Date: Thu, 15 Mar 2018 19:04:35 +0100
In-Reply-To: <20180315172852.GA21667@flask> ("Radim \=\?utf-8\?B\?S3LEjW3DocWZ\?\=
 \=\?utf-8\?B\?Iidz\?\= message of "Thu,
        15 Mar 2018 18:28:52 +0100")
Message-ID: <87sh919pvw.fsf@vitty.brq.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Radim Krčmář <rkrcmar@redhat.com> writes:

> 2018-03-15 18:02+0100, Radim Krčmář:
>> We actually already have mov in the assembly:
>> 
>>   "cmp %%" _ASM_SP ", %c[host_rsp](%0) \n\t"
>
> Oh hell, I didn't pay attention to this line before.
>

This is still going to work if we conditionally replace it with pointer
to evmcs as you suggested before but ...


>>   "je 1f \n\t"
>>   "mov %%" _ASM_SP ", %c[host_rsp](%0) \n\t" // here
>>   __ex(ASM_VMX_VMWRITE_RSP_RDX) "\n\t"
>
> I bet this path is executed only once in VM's lifetime and what we're
> doing is wasting more resources than we're ever going to save ...
>

yes, we're not gonna save anything...

-- 
  Vitaly
