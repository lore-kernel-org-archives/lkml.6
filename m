Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933560AbeCGSYM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:24:12 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41324 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753949AbeCGSYJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:24:09 -0500
Date: Wed, 7 Mar 2018 19:23:28 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Matthias Kaehlcke <mka@chromium.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <groeck@chromium.org>
Subject: Re: [PATCH] KVM: x86: Make enum conversion explicit in
 kvm_pdptr_read()
Message-ID: <20180307182328.GG12290@flask>
References: <20180226224224.244247-1-mka@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226224224.244247-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-26 14:42-0800, Matthias Kaehlcke:
> The type 'enum kvm_reg_ex' is an extension of 'enum kvm_reg', however
> the extension is only semantical and the compiler doesn't know about the
> relationship between the two types. In kvm_pdptr_read() a value of the
> extended type is passed to kvm_x86_ops->cache_reg(), which expects a
> value of the base type. Clang raises the following warning about the
> type mismatch:

Yeah, expressing this in C type system seems impossible.

> arch/x86/kvm/kvm_cache_regs.h:44:32: warning: implicit conversion from
>   enumeration type 'enum kvm_reg_ex' to different enumeration type
>   'enum kvm_reg' [-Wenum-conversion]
>     kvm_x86_ops->cache_reg(vcpu, VCPU_EXREG_PDPTR);
> 
> Cast VCPU_EXREG_PDPTR to 'enum kvm_reg' to make the compiler happy.
> 
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---

Applied, thanks.
