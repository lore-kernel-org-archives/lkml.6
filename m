Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752341AbeBXAnE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 19:43:04 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751864AbeBXAnD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 19:43:03 -0500
Subject: Re: [PATCH] KVM: x86: move LAPIC initialization after VMCS creation
To: Liran Alon <liran.alon@oracle.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <764f4da9-2d0c-41cf-a4a4-d9b3bf3447c2@default>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <79e3fc04-c76e-186e-3b73-74f5128dff91@redhat.com>
Date: Sat, 24 Feb 2018 01:43:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <764f4da9-2d0c-41cf-a4a4-d9b3bf3447c2@default>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2018 01:39, Liran Alon wrote:
> I agree with the bug and the fix.
> It makes sense to reset LAPIC in the same place other components are reset
> rather than in it's creation.
> 
> However, I failed to understand why you mention it fixes commit:
> 851c1a18c541 ("KVM: nVMX: Fix injection to L2 when L1 don't intercept external-interrupts")
> 
> Before and after that commit, vmx_hwapic_irr_update() did exactly the same
> because is_guest_mode(vcpu)==false at this point.
> Therefore, vmx_hwapic_irr_update() has always just called vmx_set_rvi()
> which has not changed in that commit.
> 
> It seems to me that the commit which introduced this issue is actually:
> 4191db26b714 ("KVM: x86: Update APICv on APIC reset")
> 
> What am I missing?

No, you're right.  But then I'm not sure why I'm only seeing the issue
now, and not with 4.15 kernels.

Paolo
