Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBHKbX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 05:31:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57560 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750806AbeBHKbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 05:31:22 -0500
Subject: Re: [PATCH] KVM: X86: Fix SMRAM accessing even if VM is shutdown
To: Xiao Guangrong <guangrong.xiao@gmail.com>,
        Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>
References: <1517984706-47244-1-git-send-email-wanpengli@tencent.com>
 <233cfca3-971e-c3c2-f0fe-b50dd69d2546@redhat.com>
 <d21822e2-2982-7182-1d9a-be3e5b7e1553@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <5664ca7f-f391-0301-3a0d-666b73f17b15@redhat.com>
Date: Thu, 8 Feb 2018 11:31:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <d21822e2-2982-7182-1d9a-be3e5b7e1553@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/2018 09:57, Xiao Guangrong wrote:
>> Maybe it should return RET_PF_EMULATE, which would cause an emulation
>> failure and then an exit with KVM_EXIT_INTERNAL_ERROR.
> 
> So the root cause is that a running vCPU accessing the memory whose memslot
> is being updated (met the condition KVM_MEMSLOT_INVALID is set on the its
> memslot).
> 
> The normal #PF handler breaks KVM_RUN and returns -EFAULT to userspace,
> we'd better to make ept-misconfig's handler follow this style as well.

Why return -EFAULT and not attempt emulation (which will fail)?

Paolo
