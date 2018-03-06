Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-682215-1520352170-2-3383517570642918875
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
    t=1520352167; b=m1rlVWr08hx3QEiFJFJhwSPQC+aF2gW7AnpaUK5Ros9PWBR
    ZTZ09dIt4TZbVr+xwZQ/fo04OEjvxj8YrkI2lhRWWRgynzJsX+t5cjUSkBTlY2ZN
    qd3b2ZsF58wUsQm8fhrmd+wWGv+Pc4qxx1fPIBip/PUtgGUmp3ySuSHz99kXvfHO
    ZKiuCYm6gqtxDx1EaMMzo5ongKD3iK2sR5OfSVnDL1OkjUxIZF7mB/oTchR5dXGK
    3Wt66G0pmTODiqWzU3hoFhFwCmiRzK7/ZcZeOwRtcKFn/OMeNSsm2ft47nWkZghh
    K6zgdOWUBGYy0KcBxxv6+aFdKvygqZ82vGy9fdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520352167; bh=rMg+gzp5o/W/Dnf/es0As+0fP7dRHX2adm0bwx5BJS8=; b=B
    VW4kjyXbnhWwzAQ5MgC4h/zbNP3se20TaDiaNEkQQqSEtIP/Yur1QZ/mZiHhsPF1
    //R64SkopfWn669GPhQeoN4M9fe/NLMRombBH6rBxdMxkr17uNjHo9cb5N+25566
    aQQJP2HdEZ4cbplkWAJHmhPMfs41k72O3ZvvA1Orp+cR3ldiSg35CsaI3Su2G1U5
    oDianH4fUfIZ3+A+LYecsXcsGVpRY2uGtvD5e/qpz/GNo2tl0KjW+/Z3XDObeHXT
    ZuHT+8lO6sSvZm/vtLFAeYnz7humsFKwMf8BHjarc24yKtdc2sclETEyeljG9muW
    AdmqyJ4zIBm9eWQy51MUQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=slPqyku3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=slPqyku3;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeCFQCo (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 11:02:44 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34469 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752055AbeCFQCn (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 11:02:43 -0500
X-Google-Smtp-Source: AG47ELtYpQnQO2w2fADW5eXAO8HuzpAGcNh03MBExdIZ1mAUYfv7lwpvWjD6pURYCL6AjxsjV+dSsQ==
Subject: Re: [PATCH 4.4 178/193] x86/syscall: Sanitize syscall table
 de-references under speculation
From: Jiri Slaby <jslaby@suse.cz>
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
 <0a95efad-1a3d-4aab-6d94-58dd583d275a@suse.cz>
Message-ID: <10c08ff1-ba52-24a1-c915-42dd0eb175aa@suse.cz>
Date: Tue, 6 Mar 2018 17:02:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0a95efad-1a3d-4aab-6d94-58dd583d275a@suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/06/2018, 03:21 PM, Jiri Slaby wrote:
> On 02/23/2018, 07:26 PM, Greg Kroah-Hartman wrote:
>> 4.4-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Dan Williams <dan.j.williams@intel.com>
>>
>> (cherry picked from commit 2fbd7af5af8665d18bcefae3e9700be07e22b681)
>>
>> The syscall table base is a user controlled function pointer in kernel
>> space. Use array_index_nospec() to prevent any out of bounds speculation.
>>
>> While retpoline prevents speculating into a userspace directed target it
>> does not stop the pointer de-reference, the concern is leaking memory
>> relative to the syscall table base, by observing instruction cache
>> behavior.
>>
>> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> Cc: linux-arch@vger.kernel.org
>> Cc: kernel-hardening@lists.openwall.com
>> Cc: gregkh@linuxfoundation.org
>> Cc: Andy Lutomirski <luto@kernel.org>
>> Cc: alan@linux.intel.com
>> Link: https://lkml.kernel.org/r/151727417984.33451.1216731042505722161.stgit@dwillia2-desk3.amr.corp.intel.com
>> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
>> [jwang: port to 4.4, no syscall_64]
> 
> This is not complete IMO, the syscall is indeed there, only written in
> assembly in 4.4 yet.
> 
> So this patch looks like it is missing these two hunks (from my
> SLE12-SP2 backport):
> 
>> --- a/arch/x86/entry/entry_64.S
>> +++ b/arch/x86/entry/entry_64.S
>> @@ -184,6 +184,8 @@ entry_SYSCALL_64_fastpath:
>>        cmpl    $__NR_syscall_max, %eax
>>  #endif
>>        ja      1f                              /* return -ENOSYS (already in pt_regs->ax) */
>> +      sbb     %rcx, %rcx                      /* array_index_mask_nospec() */
>> +      and     %rcx, %rax

Which is not completely correct either. The preceding comparison should
write:
    cmpl    $NR_syscalls, %eax
    jae     1f
to have sbb correctly working even on the last syscall number.

thanks,
-- 
js
suse labs
