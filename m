Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753400AbeC1U0q (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 16:26:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54582 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752634AbeC1U0o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 16:26:44 -0400
Date: Wed, 28 Mar 2018 22:26:41 +0200
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Babu Moger <babu.moger@amd.com>
Cc: joro@8bytes.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, pbonzini@redhat.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] KVM: VMX: Bring the common code to header file
Message-ID: <20180328202640.GJ26753@flask>
References: <1521232646-79580-1-git-send-email-babu.moger@amd.com>
 <1521232646-79580-4-git-send-email-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521232646-79580-4-git-send-email-babu.moger@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-16 16:37-0400, Babu Moger:
> This patch brings some of the code from vmx to x86.h header file. Now, we
> can share this code between vmx and svm. Modified couple functions to make
> it common.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> @@ -6683,8 +6652,9 @@ static void shrink_ple_window(struct kvm_vcpu *vcpu)
>  	struct vcpu_vmx *vmx = to_vmx(vcpu);
>  	int old = vmx->ple_window;
>  
> -	vmx->ple_window = __shrink_ple_window(old,
> -	                                      ple_window_shrink, ple_window);
> +	vmx->ple_window = __shrink_ple_window(old, ple_window,
> +					      ple_window_shrink,
> +					      0);

I have preserved the old minumum (ple_window, so we could't get
uselessly small values).
