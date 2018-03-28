Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753047AbeC1UTK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:19:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48502 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752447AbeC1UTI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:19:08 -0400
Date: Wed, 28 Mar 2018 22:19:05 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>, Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/2] KVM: X86: Fix setup the virt_spin_lock_key before
 static key get initialized
Message-ID: <20180328201905.GF26753@flask>
References: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1521951444-5087-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-24 21:17-0700, Wanpeng Li:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
>  static_key_disable_cpuslocked(): static key 'virt_spin_lock_key+0x0/0x20' used before call to jump_label_init()
>  WARNING: CPU: 0 PID: 0 at kernel/jump_label.c:161 static_key_disable_cpuslocked+0x61/0x80
>  RIP: 0010:static_key_disable_cpuslocked+0x61/0x80
>  Call Trace:
>   static_key_disable+0x16/0x20
>   start_kernel+0x192/0x4b3
>   secondary_startup_64+0xa5/0xb0
> 
> Qspinlock will be choosed when dedicated pCPUs are available, however, the 
> static virt_spin_lock_key is set in kvm_spinlock_init() before jump_label_init() 
> has been called, which will result in a WARN(). This patch fixes it by delaying
> the virt_spin_lock_key setup to .smp_prepare_cpus().
> 
> Reported-by: Davidlohr Bueso <dbueso@suse.de>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Davidlohr Bueso <dbueso@suse.de>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---

Queued, thanks.
