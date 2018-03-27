Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752090AbeC0JP5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 05:15:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51982 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751121AbeC0JP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 05:15:56 -0400
Subject: Re: [PATCH 2/2] KVM: VMX: Add Force Emulation Prefix for "emulate the
 next instruction"
To: Nikita Leshenko <nikita.leshchenko@oracle.com>,
        Liran Alon <liran.alon@oracle.com>
Cc: kernellwp@gmail.com, rkrcmar@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <d34c1d3c-324e-4645-9d48-09c94212aa5e@default>
 <95B06D42-EFDF-4750-AD03-98D6C78378D5@oracle.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <6d039f9d-99d9-fa4c-170b-6225bdba302a@redhat.com>
Date: Tue, 27 Mar 2018 11:15:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <95B06D42-EFDF-4750-AD03-98D6C78378D5@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2018 11:05, Nikita Leshenko wrote:
> What you are essentially trying to do is create a PV interface to access
> the x86 emulator.
> Why not use a simple hypercall (VMCALL) to accomplish this instead of
> inventing yet another PV method?

Because hypercalls force you to use %rax for the hypercall number.

Paolo

> Something like “KVM_HC_EMULATE_NEXT_INSTRUCTION” in kvm_emulate_hypercall
> should do the trick (however it needs to be placed before the check for
> CPL>0 so that user mode code can test the emulator too).
> 
> Nikita
