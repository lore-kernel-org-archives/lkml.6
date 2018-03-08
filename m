Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756026AbeCHQQT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:16:19 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58624 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752059AbeCHQQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:16:18 -0500
Date: Thu, 8 Mar 2018 17:15:36 +0100
From: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
To: Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KVM/X86: Check input sreg values before loading vcpu
Message-ID: <20180308161536.GH12290@flask>
References: <1519714664-2649-1-git-send-email-Tianyu.Lan@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519714664-2649-1-git-send-email-Tianyu.Lan@microsoft.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-27 06:57+0000, Tianyu Lan:
> From: Lan Tianyu <Tianyu.Lan@microsoft.com>
> 
> This patch is to check sreg value first and then load vcpu in order
> to avoid redundant loading/putting vcpu.
> 
> Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> ---

Patch "KVM: x86: KVM_CAP_SYNC_REGS" made significant changes to the
sregs setter, so the patch cannot be applied in current form.

I think that moving the X86_CR4_OSXSAVE check to guest_cpuid_has still
makes sense, but avoiding the vcpu_load/put would produce worse code
elsewhere and avoiding the load/put is not critical as any error is
probably going to be the end for this VM.

Thanks.
