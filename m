Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-587055-1519319280-2-16856689403714470765
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, UNPARSEABLE_RELAY 0.001, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519319280; b=jvlalA4A2ovcQq6vG9cb+7/JJkOCSlna5NHlPp2jVm8Otbo
    6CmBhARWaQ172QQxkPLgaFpHNpQJnUoYTmgvMaG/sEposHS8rBFAEWEXKksFz5NR
    fXxQYzYxkNBrLvQovpAjYPHcBZLjLFOIlHUbNe4cxrogRYliyoe19R/Gv38GnrPd
    hL5F9mmeBRzf4mHBv7G98jJ99b6CIqN45F9h/kJW4Y1FxQEbiwd7897hJRyBZjAW
    jXtpnXgOrB9W4LEnBDL6TneGbtsCvrI1qSuH7BsB6PaZw2Rr4l0+6XF7dGkTQyXL
    j7eq2WBmLsim/WnTOPgH8QBcaoGzBzEuuO2pQbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519319280; bh=sONDLPHe//Gw253ClIXPOR2ddf41e+7wVC8y47w8B54=; b=S
    tunG45Wwpdu7e+c9pyOJ1HlUJpfKs+I4Fh0NfbehGlE8XJipNtwAcExEUd/o3xSD
    PBii/+fYkC5mAe4g0PiqeqZ+D7sR9wfQT3ldN1rWgzeb3w/9eHpx2O9LXiuVz1DH
    MXaKnzkUFNJ01ilF78P5ncw72njwH0tHYpUq87B/Z6szCmUgETks5QfyU3MDJFtU
    //U8tChJIpmRdhl6J9uogLSqBnYEKfXeYxAG/l0Vy1YWcVQdRRNb2yeiHjK75emQ
    ht/KXWTZZA8jR/fbhutakB+nWQDsk5YakJhVwHuL8xDxHcMjr2igRAkerpdesHHk
    eQ2lGJd3tLfO+tPPuTgUg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=fSS6Y9Nr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=oracle.com header.i=@oracle.com header.b=fSS6Y9Nr x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=corp-2017-10-26;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=oracle.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=oracle.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933402AbeBVRHk (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 12:07:40 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:59428 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933139AbeBVRHg (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 22 Feb 2018 12:07:36 -0500
Date: Thu, 22 Feb 2018 12:07:17 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jim Mattson <jmattson@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/3] KVM: x86: use native MSR ops for SPEC_CTRL
Message-ID: <20180222170717.GP31483@char.us.oracle.com>
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
 <1519249297-73718-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1519249297-73718-2-git-send-email-pbonzini@redhat.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8812 signatures=668677
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802220214
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 21, 2018 at 10:41:35PM +0100, Paolo Bonzini wrote:
> Having a paravirt indirect call in the IBRS restore path is not a
> good idea, since we are trying to protect from speculative execution
> of bogus indirect branch targets.  It is also slower, so use
> native_wrmsrl on the vmentry path too.

But it gets replaced during patching. As in once the machine boots
the assembler changes from:

	callq 	*0xfffflbah

to
	wrmsr

? I don't think you need this patch.

>=20
> Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
> Cc: x86@kernel.org
> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 7 ++++---
>  arch/x86/kvm/vmx.c | 7 ++++---
>  2 files changed, 8 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index b3e488a74828..1598beeda11c 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -49,6 +49,7 @@
>  #include <asm/debugreg.h>
>  #include <asm/kvm_para.h>
>  #include <asm/irq_remapping.h>
> +#include <asm/microcode.h>
>  #include <asm/nospec-branch.h>
> =20
>  #include <asm/virtext.h>
> @@ -5355,7 +5356,7 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	 * being speculatively taken.
>  	 */
>  	if (svm->spec_ctrl)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
> =20
>  	asm volatile (
>  		"push %%" _ASM_BP "; \n\t"
> @@ -5465,10 +5466,10 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	 * save it.
>  	 */
>  	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
> -		rdmsrl(MSR_IA32_SPEC_CTRL, svm->spec_ctrl);
> +		svm->spec_ctrl =3D native_read_msr(MSR_IA32_SPEC_CTRL);
> =20
>  	if (svm->spec_ctrl)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> =20
>  	/* Eliminate branch target predictions from guest mode */
>  	vmexit_fill_RSB();
> diff --git a/arch/x86/kvm/vmx.c b/arch/x86/kvm/vmx.c
> index 67b028d8e726..5caeb8dc5bda 100644
> --- a/arch/x86/kvm/vmx.c
> +++ b/arch/x86/kvm/vmx.c
> @@ -51,6 +51,7 @@
>  #include <asm/apic.h>
>  #include <asm/irq_remapping.h>
>  #include <asm/mmu_context.h>
> +#include <asm/microcode.h>
>  #include <asm/nospec-branch.h>
> =20
>  #include "trace.h"
> @@ -9453,7 +9454,7 @@ static void __noclone vmx_vcpu_run(struct kvm_vcp=
u *vcpu)
>  	 * being speculatively taken.
>  	 */
>  	if (vmx->spec_ctrl)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
> =20
>  	vmx->__launched =3D vmx->loaded_vmcs->launched;
>  	asm(
> @@ -9589,10 +9590,10 @@ static void __noclone vmx_vcpu_run(struct kvm_v=
cpu *vcpu)
>  	 * save it.
>  	 */
>  	if (!msr_write_intercepted(vcpu, MSR_IA32_SPEC_CTRL))
> -		rdmsrl(MSR_IA32_SPEC_CTRL, vmx->spec_ctrl);
> +		vmx->spec_ctrl =3D native_read_msr(MSR_IA32_SPEC_CTRL);
> =20
>  	if (vmx->spec_ctrl)
> -		wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> +		native_wrmsrl(MSR_IA32_SPEC_CTRL, 0);
> =20
>  	/* Eliminate branch target predictions from guest mode */
>  	vmexit_fill_RSB();
> --=20
> 1.8.3.1
>=20
>=20
