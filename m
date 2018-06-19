Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB10CC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A686A20020
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 17:36:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A686A20020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030334AbeFSRgQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 13:36:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34562 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966650AbeFSRgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 13:36:14 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F0047DAC3;
        Tue, 19 Jun 2018 17:36:14 +0000 (UTC)
Received: from [10.36.117.92] (ovpn-117-92.ams2.redhat.com [10.36.117.92])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DAFF0111AF25;
        Tue, 19 Jun 2018 17:36:08 +0000 (UTC)
Subject: Re: [PATCH] kvm: x86: mmu: Add cast to negated bitmasks in
 update_permission_bitmask()
To:     Joe Perches <joe@perches.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Matthias Kaehlcke <mka@chromium.org>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>, hpa@zytor.com,
        x86@kernel.org, kvm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20180615174731.47588-1-mka@chromium.org>
 <CAKwvOd=n3CdFhL-cFueOEO7ahOoTY6zfvJApXimQ1tBF6XzSOA@mail.gmail.com>
 <d4f32707a89030733217b23b557b38504f0d83ca.camel@perches.com>
 <20180615182945.GN88063@google.com>
 <c852072704e82ac5342f344c5862d20ce5559c21.camel@perches.com>
 <CAKwvOdkv7D8b+apFXUdv_hwJDoWZtUJUTSF2BEzxbMzLVreG6g@mail.gmail.com>
 <ffe4b263-8a8d-c8ed-7ba1-ca55600ab273@redhat.com>
 <CAKwvOdnhPCDRFMhYiAr2kSCDWrL_gaY8c6XHJ96PupcN-wcDpQ@mail.gmail.com>
 <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d6a99e26-b100-715b-2615-b77259ec8397@redhat.com>
Date:   Tue, 19 Jun 2018 19:35:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <ad7a9addf043ee7fda8907eff9f83c9709b575dc.camel@perches.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 19 Jun 2018 17:36:14 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.2]); Tue, 19 Jun 2018 17:36:14 +0000 (UTC) for IP:'10.11.54.3' DOMAIN:'int-mx03.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'pbonzini@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2018 19:23, Joe Perches wrote:
> On Tue, 2018-06-19 at 10:08 -0700, Nick Desaulniers wrote:
>> On Tue, Jun 19, 2018 at 8:19 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>>>
>>> On 15/06/2018 20:45, Nick Desaulniers wrote:
>>>>>
>>>>>> In any case I think it it preferable to fix the code over disabling
>>>>>> the warning, unless the warning is bogus or there are just too many
>>>>>> occurrences.
>>>>>
>>>>> Maybe.
>>>>
>>>> Spurious warning today, actual bug tomorrow?  I prefer to not to
>>>> disable warnings wholesale.  They don't need to find actual bugs to be
>>>> useful.  Flagging code that can be further specified does not hurt.
>>>> Part of the effort to compile the kernel with different compilers is
>>>> to add warning coverage, not remove it.  That said, there may be
>>>> warnings that are never useful (or at least due to some invariant that
>>>> only affects the kernel).  I cant think of any off the top of my head,
>>>> but I'm also not sure this is one.
>>>
>>> This one really makes the code uglier though, so I'm not really inclined
>>> to applying the patch.
>>
>> Note that of the three variables (w, u, x), only u is used later on.
>> What about declaring them as negated with the cast, that way there's
>> no cast in a ternary?
> 
> It'd be simpler to cast in the BYTE_MASK macro itself

I don't think that would work, as the ~ would be done on a zero-extended
signed int.

Paolo

> Ex:
>>
>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> index d594690d8b95..53673ad4b295 100644
>> --- a/arch/x86/kvm/mmu.c
>> +++ b/arch/x86/kvm/mmu.c
>> @@ -4261,8 +4261,9 @@ static void update_permission_bitmask(struct
>> kvm_vcpu *vcpu,
>>  {
>>         unsigned byte;
>>
>> -       const u8 x = BYTE_MASK(ACC_EXEC_MASK);
>> -       const u8 w = BYTE_MASK(ACC_WRITE_MASK);
>> +       const u8 x_not = (u8)~BYTE_MASK(ACC_EXEC_MASK);
>> +       const u8 w_not = (u8)~BYTE_MASK(ACC_WRITE_MASK);
>> +       const u8 u_not = (u8)~BYTE_MASK(ACC_USER_MASK);
>>         const u8 u = BYTE_MASK(ACC_USER_MASK);
>>
>>
>>         bool cr4_smep = kvm_read_cr4_bits(vcpu, X86_CR4_SMEP) != 0;
>> @@ -4278,11 +4279,11 @@ static void update_permission_bitmask(struct
>> kvm_vcpu *vcpu,
>>                  */
>>
>>                 /* Faults from writes to non-writable pages */
>> -               u8 wf = (pfec & PFERR_WRITE_MASK) ? ~w : 0;
>> +               u8 wf = (pfec & PFERR_WRITE_MASK) ? w_not : 0;
>>                 /* Faults from user mode accesses to supervisor pages */
>> -               u8 uf = (pfec & PFERR_USER_MASK) ? ~u : 0;
>> +               u8 uf = (pfec & PFERR_USER_MASK) ? u_not : 0;
>>                 /* Faults from fetches of non-executable pages*/
>> -               u8 ff = (pfec & PFERR_FETCH_MASK) ? ~x : 0;
>> +               u8 ff = (pfec & PFERR_FETCH_MASK) ? x_not : 0;
>>                 /* Faults from kernel mode fetches of user pages */
>>                 u8 smepf = 0;
>>                 /* Faults from kernel mode accesses of user pages */
>>
>>
>> Maybe you have a better naming scheme than *_not ? What do you think?
> 
> It'd be nicer to cast in the BYTE_MASK macro
> and using "unsigned byte;" is misleading at best.
> 
> ---
>  arch/x86/kvm/mmu.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index d594690d8b95..201711aa99b9 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4246,15 +4246,14 @@ reset_ept_shadow_zero_bits_mask(struct kvm_vcpu *vcpu,
>  				    boot_cpu_data.x86_phys_bits, execonly);
>  }
>  
> -#define BYTE_MASK(access) \
> -	((1 & (access) ? 2 : 0) | \
> -	 (2 & (access) ? 4 : 0) | \
> -	 (3 & (access) ? 8 : 0) | \
> -	 (4 & (access) ? 16 : 0) | \
> -	 (5 & (access) ? 32 : 0) | \
> -	 (6 & (access) ? 64 : 0) | \
> -	 (7 & (access) ? 128 : 0))
> -
> +#define BYTE_MASK(access)				\
> +	((u8)(((access) & 1 ?   2 : 0) |		\
> +	      ((access) & 2 ?   4 : 0) |		\
> +	      ((access) & 3 ?   8 : 0) |		\
> +	      ((access) & 4 ?  16 : 0) |		\
> +	      ((access) & 5 ?  32 : 0) |		\
> +	      ((access) & 6 ?  64 : 0) |		\
> +	      ((access) & 7 ? 128 : 0)))
>  
>  static void update_permission_bitmask(struct kvm_vcpu *vcpu,
>  				      struct kvm_mmu *mmu, bool ept)
> 

