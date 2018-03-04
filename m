Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932408AbeCDXBJ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 18:01:09 -0500
Received: from ozlabs.org ([103.22.144.67]:53721 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932088AbeCDXBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 18:01:06 -0500
Date: Mon, 5 Mar 2018 09:49:27 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        kvm-ppc@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Fix guest time accounting with
 VIRT_CPU_ACCOUNTING_GEN
Message-ID: <20180304224927.GB14569@fergus.ozlabs.ibm.com>
References: <20180302105156.19506-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302105156.19506-1-lvivier@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 11:51:56AM +0100, Laurent Vivier wrote:
> Since commit 8b24e69fc47e ("KVM: PPC: Book3S HV: Close race with testing
> for signals on guest entry"), if CONFIG_VIRT_CPU_ACCOUNTING_GEN is set, the
> guest time is not accounted to guest time and user time, but instead to
> system time.
> 
> This is because guest_enter()/guest_exit() are called while interrupts
> are disabled and the tick counter cannot be updated between them.
> 
> To fix that, move guest_exit() after local_irq_enable(), and as
> guest_enter() is called with IRQ disabled, calls guest_enter_irqoff()
> instead.
> 
> Fixes: 8b24e69fc47e
> ("KVM: PPC: Book3S HV: Close race with testing for signals on guest entry")
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Thanks, applied to my kvm-ppc-fixes branch.

Paul.
