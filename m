Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932530AbeD0TcP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:32:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1757590AbeD0TcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:32:09 -0400
Date: Fri, 27 Apr 2018 21:32:05 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] KVM: x86: use timespec64 for
 KVM_HC_CLOCK_PAIRING
Message-ID: <20180427193204.GD23874@flask>
References: <20180423080512.1614520-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180423080512.1614520-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-04-23 10:04+0200, Arnd Bergmann:
> The hypercall was added using a struct timespec based implementation,
> but we should not use timespec in new code.
> 
> This changes it to timespec64. There is no functional change
> here since the implementation is only used in 64-bit kernels
> that use the same definition for timespec and timespec64.
> 
> Fixes: 55dd00a73a51 ("KVM: x86: add KVM_HC_CLOCK_PAIRING hypercall")

(Removed the "Fixes:" tag as it doesn't really change behavior.)

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> I originally sent this in October, but got no reply. The patch
> is still required for the overall cleanup of 'timespec' uses
> in the kernel, please apply.

Queued now, thanks!

Anything we need to do for the x86_platform_ops switch?
