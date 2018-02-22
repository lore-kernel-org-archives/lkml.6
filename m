Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3969394-1519292382-2-17618557106531456219
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: cc='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519292381; b=m5Q7erjc8ntvowE2LCc17mrDdiXBLBdLLW2+DyRnBvCRN7I
    8wUqRdveYWvnNNjQYALNA4SvsnjPwDOb9SeAxd6NRHwPlSw5CS082B9APuyaHGzn
    r6DF6nwTAypz/XzaVa4yWWWLiXg+jsLvNmLsh/u5+d07goSVdXkB65NAfxso4j6w
    r4VVD8hOJUfogE5vIuO7WfGXpFw85fFMUDsiV7VMb3i0d/2qj1NY0pPWonr6F6bK
    E2uYfuloMyn6jI2vopSCw1EFVKwU/FSbKq9azj2ItvxIHxtYMwloCy2FZmzEZ6Tk
    Gh+PdzftHD/DGOs2Ujz/vMtMG6ofEn3TMsFPXHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1519292381; bh=OJFJYu+154gGmbl7d8X3i3bk3qwS9ewjcWD5Vt8duSU=; b=O
    +50z4gyd+QckStYt+aW0Qgv2NFsiEPTNcug4Th3OwxRrzWGuByqnWaw72vyfMhnY
    G6lc2/6zqcw/NbVcCvpj2ePqCovxhnDgqzXwNUiLQA/QI9lT/GxbMySvVUzPGIj3
    NVBYA9EQkHugC3Fbq2EV2MBMUg868C+WYx7xCp3B3LiSQH9EHtBFEqwEvKnKyW9T
    orzJALzcZQcodgm07i17G0yWOkwzG+hvT1RPbwjqntnPmf92P9YnTaM3igoOq0/m
    Aa/Cr1KvhaQ3j0zh2WXDJ0SY4vcDM6ZPM/7J/xtTQ7YgpoHKbfRU0CMaIvmRA+xY
    m98/Qy7U5qc0+E1O10SoA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753089AbeBVJjW (ORCPT <rfc822;greg@kroah.com>);
        Thu, 22 Feb 2018 04:39:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53468 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753029AbeBVJjT (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 22 Feb 2018 04:39:19 -0500
Subject: Re: [PATCH 2/3] KVM: nVMX: fix wrong condition for SPEC_CTRL and
 PRED_CMD MSRs
To: Jim Mattson <jmattson@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org
References: <1519249297-73718-1-git-send-email-pbonzini@redhat.com>
 <1519249297-73718-3-git-send-email-pbonzini@redhat.com>
 <CALMp9eSbH67rm2vDnuaCjSU0JRsZxT1cW2qoyWQREV_iSAVaTw@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7ef4216d-6ebf-0ffe-c477-b820a2c942c3@redhat.com>
Date: Thu, 22 Feb 2018 10:39:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CALMp9eSbH67rm2vDnuaCjSU0JRsZxT1cW2qoyWQREV_iSAVaTw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 22/02/2018 01:07, Jim Mattson wrote:
> On Wed, Feb 21, 2018 at 1:41 PM, Paolo Bonzini <pbonzini@redhat.com> wrote:
>> We need to change the default all-1s bitmap if the MSRs are _not_
>> intercepted.  However, the code was disabling the intercept when it was
>> _enabled_ in the VMCS01.  This is not causing bigger trouble,
>> because vmx_vcpu_run checks the VMCS02's MSR bitmap and would do the
>> right thing even if fed garbage... but it's obviously a bug and it can
>> cause extra MSR reads and writes when running nested guests.
>>
>> Fixes: d28b387fb74da95d69d2615732f50cceb38e9a4d
>> Fixes: 15d45071523d89b3fb7372e2135fbd72f6af9506
>> Cc: x86@kernel.org
>> Cc: Radim Krčmář <rkrcmar@redhat.com>
>> Cc: KarimAllah Ahmed <karahmed@amazon.de>
>> Cc: David Woodhouse <dwmw@amazon.co.uk>
>> Cc: Jim Mattson <jmattson@google.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@kernel.org>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Wasn't this already fixed by 206587a9fb76 ("X86/nVMX: Properly set
> spec_ctrl and pred_cmd before merging MSRs")?

Ouch, yes, and my patch would have no conflicts at all so it would
reintroduce the bug!  Will resend v2 without it.

Paolo
