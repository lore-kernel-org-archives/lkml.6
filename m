Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2303794-1517707480-2-6157699522123985594
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.195, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='utf-8', plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517707479; b=Tkxpw3qNmBzoQc4vgWE2FyqLw1nCbw4KWiWrz8umcrUeW3A
    c1uaQW79COJpnQzG1M7uDvoNttpI2SIyChc2w9nLk8no6CVg9MPtmTFU6rLSHH7d
    cumiA3CYKMr7YGqhDZIEy5moTvdyBngSgukL4EAFdpyE4ZpBm77qSNjgH13Qf63U
    Gacw3JQYT1zHIYO+Nkm9Rbn6M0ouqbAdU7yHQgHlkfOc9P5ymvW+8J6+LpN7KtXo
    koBudD76KI6b3Adj/u2+8airnV+uvEWKkQeoJ7QDAj919QcURUOhJq06GUj6jZo8
    s08TRQSrU67SDUInrIZrrEz3p16PaZaKgpYPFsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1517707479; bh=3hJpFib
    2VkWXwKz7ZTyVFCcnMtVIhJRc9eYHnrb7iPw=; b=LQ48FW6I6/jgWTzhGpwuLnD
    XJBDyWtixGssxAfGQoONKc/98NCoO7mhu6ZkSQcH5ecIbX9GLzWg8TgdkhaBQf33
    sbWberYDwbFdq5qxAZ49N/ixhw2WdhwfoxL2d0oxSJFtCq9/rnUUjIkfZoVRpV24
    3AwqPH9lriBk9r0AiQXVSldBwzQjxaYoaE5g0oGNlMjivG6ziaLbnZthX936Pa8Z
    SX+1EnbCIQaxnXKTgey0XP6TWs2f6z8mWBLhTml1bKcCIAL23GH5EBfWF1tAADTo
    G9UYsk0+eUjvdfWJFofDS1fMrdGtf0f97GymDRb+YhQC31ocr3IYARt/tSkS6HQ=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cVRMlVGW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nSWP6x3Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=gmail.com header.i=@gmail.com header.b=cVRMlVGW x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=pass (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=nSWP6x3Q;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=gmail.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752770AbeBDBYe (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 20:24:34 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35847 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752675AbeBDBYd (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 3 Feb 2018 20:24:33 -0500
X-Google-Smtp-Source: AH8x227SIK/eWgiIEO8y8vxl6az0mWAMtG28E86+NhNGhBAoYEegRsN49HIcsV2xZMiklI3LPh5c5g==
Date: Sat, 3 Feb 2018 17:24:29 -0800
From: Eric Biggers <ebiggers3@gmail.com>
To: Sasha Levin <Alexander.Levin@microsoft.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Lan Tianyu <tianyu.lan@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH AUTOSEL for 4.14 006/110] KVM/x86: Check input paging
 mode when cs.l is set
Message-ID: <20180204012429.GA24727@zzz.localdomain>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
 <20180203180015.29073-6-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180203180015.29073-6-alexander.levin@microsoft.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, Feb 03, 2018 at 06:00:29PM +0000, Sasha Levin wrote:
> From: Lan Tianyu <tianyu.lan@intel.com>
> 
> [ Upstream commit f29810335965ac1f7bcb501ee2af5f039f792416 ]
> 
> Reported by syzkaller:
>     WARNING: CPU: 0 PID: 27962 at arch/x86/kvm/emulate.c:5631 x86_emulate_insn+0x557/0x15f0 [kvm]
>     Modules linked in: kvm_intel kvm [last unloaded: kvm]
>     CPU: 0 PID: 27962 Comm: syz-executor Tainted: G    B   W        4.15.0-rc2-next-20171208+ #32
>     Hardware name: Intel Corporation S1200SP/S1200SP, BIOS S1200SP.86B.01.03.0006.040720161253 04/07/2016
>     RIP: 0010:x86_emulate_insn+0x557/0x15f0 [kvm]
>     RSP: 0018:ffff8807234476d0 EFLAGS: 00010282
>     RAX: 0000000000000000 RBX: ffff88072d0237a0 RCX: ffffffffa0065c4d
>     RDX: 1ffff100e5a046f9 RSI: 0000000000000003 RDI: ffff88072d0237c8
>     RBP: ffff880723447728 R08: ffff88072d020000 R09: ffffffffa008d240
>     R10: 0000000000000002 R11: ffffed00e7d87db3 R12: ffff88072d0237c8
>     R13: ffff88072d023870 R14: ffff88072d0238c2 R15: ffffffffa008d080
>     FS:  00007f8a68666700(0000) GS:ffff880802200000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 000000002009506c CR3: 000000071fec4005 CR4: 00000000003626f0
>     Call Trace:
>      x86_emulate_instruction+0x3bc/0xb70 [kvm]
>      ? reexecute_instruction.part.162+0x130/0x130 [kvm]
>      vmx_handle_exit+0x46d/0x14f0 [kvm_intel]
>      ? trace_event_raw_event_kvm_entry+0xe7/0x150 [kvm]
>      ? handle_vmfunc+0x2f0/0x2f0 [kvm_intel]
>      ? wait_lapic_expire+0x25/0x270 [kvm]
>      vcpu_enter_guest+0x720/0x1ef0 [kvm]
>      ...
> 
> When CS.L is set, vcpu should run in the 64 bit paging mode.
> Current kvm set_sregs function doesn't have such check when
> userspace inputs sreg values. This will lead unexpected behavior.
> This patch is to add checks for CS.L, EFER.LME, EFER.LMA and
> CR4.PAE when get SREG inputs from userspace in order to avoid
> unexpected behavior.
> 
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Radim Krčmář <rkrcmar@redhat.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Jim Mattson <jmattson@google.com>
> Signed-off-by: Tianyu Lan <tianyu.lan@intel.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
> ---
>  arch/x86/kvm/x86.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 8c28023a43b1..ad0f18107c74 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7473,6 +7473,29 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
>  }
>  EXPORT_SYMBOL_GPL(kvm_task_switch);
>  
> +int kvm_valid_sregs(struct kvm_vcpu *vcpu, struct kvm_sregs *sregs)
> +{
> +	if ((sregs->efer & EFER_LME) && (sregs->cr0 & X86_CR0_PG_BIT)) {
> +		/*
> +		 * When EFER.LME and CR0.PG are set, the processor is in
> +		 * 64-bit mode (though maybe in a 32-bit code segment).
> +		 * CR4.PAE and EFER.LMA must be set.
> +		 */
> +		if (!(sregs->cr4 & X86_CR4_PAE_BIT)
> +		    || !(sregs->efer & EFER_LMA))
> +			return -EINVAL;
> +	} else {
> +		/*
> +		 * Not in 64-bit mode: EFER.LMA is clear and the code
> +		 * segment cannot be 64-bit.
> +		 */
> +		if (sregs->efer & EFER_LMA || sregs->cs.l)
> +			return -EINVAL;
> +	}
> +
> +	return 0;
> +}

This commit is broken and there was a fix for it merged: 37b95951c58 ("KVM/x86:
Fix wrong macro references of X86_CR0_PG_BIT and X86_CR4_PAE_BIT in
kvm_valid_sregs()").  Shouldn't your script have picked that up too?

- Eric
