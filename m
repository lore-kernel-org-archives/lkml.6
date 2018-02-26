Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751783AbeBZThe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 14:37:34 -0500
Received: from mail.skyhub.de ([5.9.137.197]:45650 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751553AbeBZThd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 14:37:33 -0500
Date: Mon, 26 Feb 2018 20:37:11 +0100
From: Borislav Petkov <bp@alien8.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Wanpeng Li <kernellwp@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: X86: Allow userspace to define the microcode version
Message-ID: <20180226193711.GS4377@pd.tnic>
References: <20180226113000.GC4377@pd.tnic>
 <CANRm+CzwY2yzKFXF7r=vfqDaHHoHxC221TSBtSHC2XtvkrQxHA@mail.gmail.com>
 <20180226114409.GD4377@pd.tnic>
 <46cecef2-b0fb-b0c2-bbf3-983328d52763@redhat.com>
 <20180226121509.GE4377@pd.tnic>
 <24cd527d-5287-f0be-ffe8-eab341bf1d94@redhat.com>
 <3866d359-0ef8-6a99-6254-84890be62b93@redhat.com>
 <20180226122205.GG4377@pd.tnic>
 <fb705c01-9bdd-9924-00c6-70d8ee940fb4@redhat.com>
 <20180226143912.GC22024@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180226143912.GC22024@char.us.oracle.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 09:39:12AM -0500, Konrad Rzeszutek Wilk wrote:
> diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
> index d19e903214b4..87d044ce837f 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -144,6 +144,13 @@ static bool bad_spectre_microcode(struct cpuinfo_x86 *c)
>  {
>  	int i;
>  
> +	/*
> +	 * We know that the hypervisor lie to us on the microcode version so
> +	 * we may as well trust that it is running the correct version.
> +	 */
> +	if (boot_cpu_has(X86_FEATURE_HYPERVISOR))

I guess

	cpu_has(c, X86_FEATURE_HYPERVISOR)

since we're passing a ptr to the current CPU.

It boils down to the same thing in the end but this is bit nicer and
besides the rest of the code uses cpu_has() too.

Otherwise, yap, this looks like a good idea.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
