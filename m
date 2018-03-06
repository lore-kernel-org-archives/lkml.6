Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-767234-1520352707-2-3300821053851554261
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520352706; b=tJF/yuTe4tyz+xuC+5NEs/SkdqzBMhx085sveEoU+724pMR
    J71OzvN+Vh5Tm1ttZ6POeh6C5mKZp+Mq9NcgIed0s+UV1yxHKCMxyENnuIjOkVAR
    b11ogZttJRySjiMVNo/wsPhxcCztqDvn961K4hpbm4Z20/EYuP5UOrIQhPJ5mfGu
    UBfQv4S/j3vL7A+xcdpLEk/pPkdmqVTwUr9W0d0K+qKgbyjv4BAVRf0w+OMg13w1
    uZLbfReBNTJl2WHCZugEZ9ZBGfP2pLN9mGpYqNzBaXhFGu84zAm9VnyoWGa17lJw
    Ul+UlEhtklynwuoZxpp75oU+73Jej7pqftscLGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    arctest; t=1520352706; bh=jwhuBsSbRHxJ3CJ1o7dgBgi8n4/HAiWh3mxEfx
    1y04g=; b=j6TmC7SbfGWHfG/TuntR9hpszrqcFQhLN/AN0wfgkAq3kGcEVuAbGX
    zbUVwTAjxgm/6USdReUbZ59ZOVJuHjgQ+9uDqqoCCtrJI7go2lNB++n8cGdyXuE0
    h147lUllab8Y3b800ejuEkLpgO3D3GG2TkH/3p9pFVsQcrsKMjDAVsueJKjDO/6E
    9WwTMucLokv20D2FdTNLedIDVzw92SjHiSJPpwVkWuAbO2KGQDEWg8ubZtnQQxIn
    k4AYPbfIy65qDVHHGyWtI3+MFcN7D72S5hshRxvCHnrldwTpe0FleGN94af/aARZ
    n0joErdszWpfFLTTasppp7wuXwbdLQog==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b=isf45b16 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=profitbricks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSldFb7I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=profitbricks.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=profitbricks-com.20150623.gappssmtp.com header.i=@profitbricks-com.20150623.gappssmtp.com header.b=isf45b16 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=profitbricks.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=SSldFb7I;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=profitbricks.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753070AbeCFQLn (ORCPT <rfc822;greg@kroah.com>);
        Tue, 6 Mar 2018 11:11:43 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:42267 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752784AbeCFQLl (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 6 Mar 2018 11:11:41 -0500
X-Google-Smtp-Source: AG47ELtBmjA5fVu8utfPWVyr2gopbjPZ9a0bEMBMrETUJQN6VEReyTNeAvVWN10WcIbPr55ZpxzL6O35iVFTvR7WHO0=
MIME-Version: 1.0
In-Reply-To: <0a95efad-1a3d-4aab-6d94-58dd583d275a@suse.cz>
References: <20180223170325.997716448@linuxfoundation.org> <20180223170354.028619665@linuxfoundation.org>
 <0a95efad-1a3d-4aab-6d94-58dd583d275a@suse.cz>
From: Jinpu Wang <jinpu.wang@profitbricks.com>
Date: Tue, 6 Mar 2018 17:11:20 +0100
Message-ID: <CAMGffEm3bRrshMftdpC4cTNppQuFUPyOniE3zZL7PJRinbVVfw@mail.gmail.com>
Subject: Re: [PATCH 4.4 178/193] x86/syscall: Sanitize syscall table
 de-references under speculation
To: Jiri Slaby <jslaby@suse.cz>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable <stable@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, kernel-hardening@lists.openwall.com,
        Andy Lutomirski <luto@kernel.org>, alan@linux.intel.com,
        David Woodhouse <dwmw@amazon.co.uk>,
        Jan Beulich <JBeulich@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 6, 2018 at 3:21 PM, Jiri Slaby <jslaby@suse.cz> wrote:
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
>>        movq    %r10, %rcx
>>  #ifdef CONFIG_RETPOLINE
>>        movq    sys_call_table(, %rax, 8), %rax
>> @@ -282,6 +284,8 @@ tracesys_phase2:
>>        cmpl    $__NR_syscall_max, %eax
>>  #endif
>>        ja      1f                              /* return -ENOSYS (already in pt_regs->ax) */
>> +      sbb     %rcx, %rcx                      /* array_index_mask_nospec() */
>> +      and     %rcx, %rax
>>        movq    %r10, %rcx                      /* fixup for C */
>>  #ifdef CONFIG_RETPOLINE
>>        movq    sys_call_table(, %rax, 8), %rax
>
> Discovered by Jan Beulich.
>
> thanks,
> --
> js
> suse labs

Thanks Jiri, yes, indeed, could you send a formal patch of the fix?

Thanks!
Jack Wang
