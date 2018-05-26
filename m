Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031781AbeEZOSR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 10:18:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752095AbeEZOSQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 10:18:16 -0400
Date: Sat, 26 May 2018 16:18:11 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Lan Tianyu <Tianyu.Lan@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jim Mattson <jmattson@google.com>, Wanpeng Li <wanpengli@tencent.com>,
        David Hildenbrand <david@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: VMX: fix building without CONFIG_HYPERV
Message-ID: <20180526141810.GA23390@flask>
References: <20180525153640.3228067-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180525153640.3228067-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-05-25 17:36+0200, Arnd Bergmann:
> The global ms_hyperv variable is part of the hyperv support, so
> we get a link error from accessing it in kernels that have this
> turned off:
> 
> arch/x86/kvm/vmx.o: In function `alloc_loaded_vmcs':
> vmx.c:(.text+0x1654a): undefined reference to `ms_hyperv'
> vmx.c:(.text+0x1657a): undefined reference to `ms_hyperv'
> 
> This changes the condition to first check the compile-time
> configuration symbol to avoid the link error.
> 
> Fixes: ceef7d10dfb6 ("KVM: x86: VMX: hyper-v: Enlightened MSR-Bitmap support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Queued, thanks.
