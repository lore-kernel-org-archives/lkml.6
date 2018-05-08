Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3155486-1525802314-2-1324510463331690294
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525802313; b=j5IsFjqtBfWaYmwDoub1vplRux372bVa6f2aWRhmrhHf5L5aaJ
    IHFkAT3qQvtBEBWVciTqAWrDbGVd8pp/FHmbWjA3sP0toBh2zPT5rigTlMwrqcLn
    EXcFTqtKt9JQyZZ8IXBgTWwzLDwAoh2FJUvM8qelFRNEWEjlV5fp87/gBh45pHAJ
    cpPrAnqY8HdKu/vO6TVquIx7FTaIdS6RmwJ9FR8PaXJKdjssk6JO+6Bm0Z7N5CWT
    lQwbUE8KMjFKUbvSRFccE1HRZDvguORp/nyzmJpL76pg12DXmQonRvTGJGylyZQJ
    kT7cwhIRTnk/dh7LDCXzFDIn8S/sXaOITVjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1525802313;
    bh=U1UPkiDeGujWoM3acAf5He8HT+Q1+Dr07VvJvb2HfJ4=; b=V7AcH83DMEr7
    7gqH5k5UmHXQBnSt8QwaLW1iELFbe+9hiQniW1k+sL77lOSXYtNlcXO9HGbEyCPF
    M73oaRM/9X60+ZQmhg+XS5GLA9EQ+76SdLsoHXvWZRaClBA4c0iUEw8ibpaSI4S6
    B3qsHqFKgL5UqaxF8Ce2ZM78gj7SNqrWFMuzIh3pyNC1xiZGoeEWEhGIa3I/1Ces
    fiYq96cKlWBBWnNJz6Aa+G0Ckaxz5Stv0EzxfU7QQwh9i/GL1l3XJgCh/tjerCYq
    XyLsMNlXJzk8vMH1f0VR1sExhDPmjy/rZKNRrIlT0J7DbEj4SgvDKaHOvTEuSIWe
    Ui+dWDzhwA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH/NUMKfJl7u32vPYtV1SrfoVsZP/ksFTbMPC6MVQ7HvYf23O1PmBnl55FcEjr+SImoKJYat7+tJY8/nlPbqyXtVC5qeqpBmu3OiFoHwqRvzapu2jOJr
    dbHKee0lnNm5IsfvXnPjmzMvZvNtkfQuIr3EPRl+0fhNaDAVttie01wK/0WFhqs/7JmHyKwbPgBF0LAAwb97bMJ6J3DyGBf3r2xVrf2ZB0y0M4z7Z2gygjGl
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=20KFwNOVAAAA:8 a=Z4Rwk6OoAAAA:8 a=VwQbUJbxAAAA:8 a=71D7HTsCAAAA:8
    a=hf53o8O2t3Ey77Yib14A:9 a=QEXdDO2ut3YA:10 a=HkZW87K1Qel5hWWM3VKY:22
    a=AjGcO6oz07-iQ99wixmX:22 a=MPOO32LiSuuV5f9AgKQu:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754659AbeEHR6a (ORCPT <rfc822;greg@kroah.com>);
        Tue, 8 May 2018 13:58:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40360 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752763AbeEHR62 (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 8 May 2018 13:58:28 -0400
Subject: Re: [PATCH] compiler-gcc: disable -ftracer for __noclone functions
To: Nadav Amit <nadav.amit@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kvm list <kvm@vger.kernel.org>, lkml@tlinx.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Marek <mmarek@suse.cz>, stable@vger.kernel.org
References: <1459410252-15531-1-git-send-email-pbonzini@redhat.com>
 <6BAD64FE-CC59-40C3-9C42-90BB8EEE5453@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <86f2fb42-b0eb-46d2-0aed-7efdb306bfe0@redhat.com>
Date: Tue, 8 May 2018 19:58:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6BAD64FE-CC59-40C3-9C42-90BB8EEE5453@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/05/2018 19:22, Nadav Amit wrote:
> Paolo Bonzini <pbonzini@redhat.com> wrote:
> 
>> -ftracer can duplicate asm blocks causing compilation to fail in
>> noclone functions.  For example, KVM declares a global variable
>> in an asm like
>>
>>    asm("2: ... \n
>>         .pushsection data \n
>>         .global vmx_return \n
>>         vmx_return: .long 2b");
>>
>> and -ftracer causes a double declaration.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Michal Marek <mmarek@suse.cz>
>> Cc: stable@vger.kernel.org
>> Cc: kvm@vger.kernel.org
>> Reported-by: Linda Walsh <lkml@tlinx.org>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>> include/linux/compiler-gcc.h | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
>> index 22ab246feed3..eeae401a2412 100644
>> --- a/include/linux/compiler-gcc.h
>> +++ b/include/linux/compiler-gcc.h
>> @@ -199,7 +199,7 @@
>> #define unreachable() __builtin_unreachable()
>>
>> /* Mark a function definition as prohibited from being cloned. */
>> -#define __noclone	__attribute__((__noclone__))
>> +#define __noclone	__attribute__((__noclone__, __optimize__("no-tracer")))
> 
> [ Bringing the thread back from the dead for context ]
> 
> Setting different optimization attributes to certain functions apparently
> prevents gcc from inlining functions with different “optimizations”. This
> results in poor compilation - most notably of vmx_vcpu_run() - and causes
> short functions such as to_vmx() not to be inlined.

Hmm, I suppose we need to disable -fno-tracer globally...  Has this
changed in recent versions of GCC?

Paolo
