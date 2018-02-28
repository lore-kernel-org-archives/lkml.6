Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933386AbeB1RT2 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 12:19:28 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932947AbeB1RTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 12:19:25 -0500
Date: Wed, 28 Feb 2018 18:19:21 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
cc: kvm@vger.kernel.org, x86@kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?ISO-8859-2?Q?Radim_Kr=E8m=E1=F8?= <rkrcmar@redhat.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Enlightened VMCS support for KVM on Hyper-V
In-Reply-To: <20180226171121.18974-1-vkuznets@redhat.com>
Message-ID: <alpine.DEB.2.21.1802281818580.1392@nanos.tec.linutronix.de>
References: <20180226171121.18974-1-vkuznets@redhat.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Feb 2018, Vitaly Kuznetsov wrote:

For the non KVM pats of this series:

Acked-by: Thomas Gleixner <tglx@linutronix.de>


> Changes since v1:
> - The only comment I got for v1 was from kbuild test robot. The issue
>   was addressed by moving HV_X64_ENLIGHTENED_VMCS_RECOMMENDED definition
>   to PATCH2.
> - Rebased to current kvm/queue.
> 
> When running nested KVM on Hyper-V it's possible to use so called
> 'Enlightened VMCS' and do normal memory reads/writes instead of
> doing VMWRITE/VMREAD instructions. In addition, clean field mask
> provides a huge room for optimization on L0's side.
> 
> Tight CPUID loop test shows significant speedup (current kvm/queue on
> E5-2667 v4 @ 3.20GHz):
>  Before: 20766 cycles
>  After: 8912 cycles
> 
> The series is based on current kvm/queue tree.
> 
> Ladi Prosek (1):
>   x86/kvm: rename HV_X64_MSR_APIC_ASSIST_PAGE to
>     HV_X64_MSR_VP_ASSIST_PAGE
> 
> Vitaly Kuznetsov (4):
>   x86/hyper-v: allocate and use Virtual Processor Assist Pages
>   x86/hyper-v: define struct hv_enlightened_vmcs and clean field bits
>   x86/hyper-v: detect nested features
>   x86/kvm: use Enlightened VMCS when running on Hyper-V
> 
>  arch/x86/hyperv/hv_init.c          |  33 +++
>  arch/x86/include/asm/mshyperv.h    |  12 +
>  arch/x86/include/uapi/asm/hyperv.h | 223 ++++++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c     |   3 +
>  arch/x86/kvm/hyperv.c              |   8 +-
>  arch/x86/kvm/lapic.h               |   2 +-
>  arch/x86/kvm/vmx.c                 | 561 ++++++++++++++++++++++++++++++++++++-
>  arch/x86/kvm/x86.c                 |   2 +-
>  8 files changed, 825 insertions(+), 19 deletions(-)
> 
> -- 
> 2.14.3
> 
> 
