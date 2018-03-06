Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-445509-1520346096-2-10013976446989947215
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520346095; b=cXSMJg5C0/3639snpGdY66g4S1mR+C7eu5v1giDPtLHVDth
    AXiWFapYQV0skVCs1jJne4sQVW5Q/D6eZHiWiKY40r/SmwoBCJ4e8cm80i+4CPDQ
    afQlbVA5/ifWfxMfjdeX6cg8h+zJBx1xEhXNUhCJ2xQO+ljGUZaofo6klQC/PRqk
    +/0QC42tcK9KKbdSNrKiFaULJJV08kyLVe8VV0N4vlG6dPCI7CtprR/LhNa2xkvE
    2cc5QdcVtZOwPm+aZnHpWx42GZZSetHFs969QzinJigfc4pQVMa+MNxZJrkhd7on
    9FWfdDWri34Z6JvU4GfU3Sak9TXHxT6HVJhUmHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520346095; bh=Z6mHdugjL3o5ZnotABJ/XlCJLsRarLuAYXfJJcq16g0=; b=b
    u+QTEoE6wdiEYSV+k5zmMFT5Cu9H0hx7tPStsCCOrDp73ENn1n85dOzEKSfgYa93
    oSYNSg5FUig4c9XQPO9BUH8GbAgdnXWYocKM1YichvyopDXEWLyOwYgKf0+2MzWU
    viLtx4MSLYoNHDrQ6DLVZXtYLFAR0TWoo022uKHmatxDVoaWurWfxvKRrOBmgjze
    X0wCSjHtJewGSQ5bfYzeRVBHvEuUGWdlyJImi3qfqposwyqnkNOeGg6S7KlwpLdf
    MbRbVDA/fhScnj2xzvCopca5TTwbtl5k1lTn8D7s9CQbAT6U8bah7ECl2vtcmdB9
    zrcTFxfYJW1gSd/AiDdzg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RU85NxwC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=RU85NxwC;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753535AbeCFOVc (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 09:21:32 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40050 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753466AbeCFOVb (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 09:21:31 -0500
X-Google-Smtp-Source: AG47ELtY+nRq7fNQ/YoXBr0GzexE6mKTSMZB48VQDWWpHXi3+TFU8wJ2sGCNVsk06Mtcb7RIYVvEZA==
Subject: Re: [PATCH 4.4 178/193] x86/syscall: Sanitize syscall table
 de-references under speculation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Andy Lutomirski <luto@kernel.org>, alan@linux.intel.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jack Wang <jinpu.wang@profitbricks.com>,
        Jan Beulich <JBeulich@suse.com>
References: <20180223170325.997716448@linuxfoundation.org>
 <20180223170354.028619665@linuxfoundation.org>
From: Jiri Slaby <jslaby@suse.cz>
Message-ID: <0a95efad-1a3d-4aab-6d94-58dd583d275a@suse.cz>
Date: Tue, 6 Mar 2018 15:21:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180223170354.028619665@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/23/2018, 07:26 PM, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dan Williams <dan.j.williams@intel.com>
> 
> (cherry picked from commit 2fbd7af5af8665d18bcefae3e9700be07e22b681)
> 
> The syscall table base is a user controlled function pointer in kernel
> space. Use array_index_nospec() to prevent any out of bounds speculation.
> 
> While retpoline prevents speculating into a userspace directed target it
> does not stop the pointer de-reference, the concern is leaking memory
> relative to the syscall table base, by observing instruction cache
> behavior.
> 
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-arch@vger.kernel.org
> Cc: kernel-hardening@lists.openwall.com
> Cc: gregkh@linuxfoundation.org
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: alan@linux.intel.com
> Link: https://lkml.kernel.org/r/151727417984.33451.1216731042505722161.stgit@dwillia2-desk3.amr.corp.intel.com
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> [jwang: port to 4.4, no syscall_64]

This is not complete IMO, the syscall is indeed there, only written in
assembly in 4.4 yet.

So this patch looks like it is missing these two hunks (from my
SLE12-SP2 backport):

> --- a/arch/x86/entry/entry_64.S
> +++ b/arch/x86/entry/entry_64.S
> @@ -184,6 +184,8 @@ entry_SYSCALL_64_fastpath:
>        cmpl    $__NR_syscall_max, %eax
>  #endif
>        ja      1f                              /* return -ENOSYS (already in pt_regs->ax) */
> +      sbb     %rcx, %rcx                      /* array_index_mask_nospec() */
> +      and     %rcx, %rax
>        movq    %r10, %rcx
>  #ifdef CONFIG_RETPOLINE
>        movq    sys_call_table(, %rax, 8), %rax
> @@ -282,6 +284,8 @@ tracesys_phase2:
>        cmpl    $__NR_syscall_max, %eax
>  #endif
>        ja      1f                              /* return -ENOSYS (already in pt_regs->ax) */
> +      sbb     %rcx, %rcx                      /* array_index_mask_nospec() */
> +      and     %rcx, %rax
>        movq    %r10, %rcx                      /* fixup for C */
>  #ifdef CONFIG_RETPOLINE
>        movq    sys_call_table(, %rax, 8), %rax

Discovered by Jan Beulich.

thanks,
-- 
js
suse labs
