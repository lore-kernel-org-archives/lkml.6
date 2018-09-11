Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_SBL,URIBL_SBL_A autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B643C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B962086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 13:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFZFFckp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23B962086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbeIKS3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 14:29:47 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39180 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726761AbeIKS3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 14:29:46 -0400
Received: by mail-pg1-f193.google.com with SMTP id i190-v6so12278615pgc.6;
        Tue, 11 Sep 2018 06:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QRHs+ZJSUy5CcrnYhq3XCEbVC9lfJMxEwaZoG8egajw=;
        b=WFZFFckp+ciczyfZeHBcEuzWbQCnWdIfXSIogwNH9vamjnGUeBDbDZcI8r3LlauOMF
         EZQfQ4JiHv0ToRxlzswHrQ+jAj5LYlXt6nMiigVca/WIuo7wSctq4I6XAJRIVgj4BDDc
         ecQugXR0971fpLfdqm688wW2n+9jYsPpvYSif/sOSP0v9GxxygWhs67x1LWQPZBCsN2H
         J7SBV4Dt2fGNwZyj81+G+kzJOTKsDaGndvPqRy45+XKSMgExTEmm+Kxu/7eCWFynniUc
         EgrvPehLfYhTnsodYt+imAq5ffxTGWiwIK4AmzEYhxbgn6G+3YkvruCx/7fPz/V4E8U/
         Hk6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QRHs+ZJSUy5CcrnYhq3XCEbVC9lfJMxEwaZoG8egajw=;
        b=ereYkpITTO3buOKLCARpZXbAn0leZkvA9NYNYfRQa+iP5b/ilc3ah3KgCWP5eu3Hb5
         /OBAeUow+Q9NA20TywMie0IMqClcpDOkDWI4sKjD5w1zX8AONjyb41I0yRN1gDo3A4C5
         s+aT0g1XI9+jSaSYtSSIUMoFDxcWdf01NMKNB0fcqRJ0UhpYlG414TvfIrt9tlL2hLw0
         cgPErxx3hxmYDksfb0urzKtqw6O5a6h3x6nqnQQmCv+2fCzwwO7TYUTMbzqsOYUT2VF2
         fjn6ANF9dOUu6aYMRFSIp7BZRhVb5IX8o6a57OWWrbN+c8OqMzxiocygvzxh2SFXWkAz
         fohg==
X-Gm-Message-State: APzg51C8a7JA6u9nAnYd+BXfaVg0fM5mgtSJ1BlxetQ+uam5J0Qf+uQV
        2K+q/6rvUt9uYC9gLapx3Bc=
X-Google-Smtp-Source: ANB0VdbImnXfpxDj9sOd+BUaulqRL2+GydlqrSSLY+uMwED3Ckgrtqr7jXinleT0m6jfjD/bh2+IQA==
X-Received: by 2002:a62:f208:: with SMTP id m8-v6mr29433753pfh.222.1536672625281;
        Tue, 11 Sep 2018 06:30:25 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id m25-v6sm24618748pgn.1.2018.09.11.06.30.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 06:30:24 -0700 (PDT)
Subject: Re: Random crashes with i386 and efi boots
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     linux-kernel@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Joerg Roedel <jroedel@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Andi Kleen <ak@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Pavel Machek <pavel@ucw.cz>, linux-efi@vger.kernel.org,
        x86@kernel.org
References: <20180910215659.GA17966@roeck-us.net>
 <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net>
Date:   Tue, 11 Sep 2018 06:30:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/11/2018 04:52 AM, Andy Lutomirski wrote:
> 
> 
>> On Sep 10, 2018, at 2:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi folks,
>>
>> even after commit eeb89e2bb1ac ("x86/efi: Load fixmap GDT in
>> efi_call_phys_epilog()"), my i386/efi qemu boot tests still crash randomly
>> (roughly 5-10% of the time). As before, I don't see much useful output in
>> the qemu log (this time it doesn't even complain about a triple fault).
>>
>> Debugging shows that the crash happens in efi_call_phys_epilog().
>> A sample log from a crashed test run is attached below. It appears that
>> the crash happens if there is an interrupt at a critical section of the
>> code.
>>
>> While playing with the code, I found a possible fix.
>>
>> diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_32.c
>> index 05ca14222463..9959657127f4 100644
>> --- a/arch/x86/platform/efi/efi_32.c
>> +++ b/arch/x86/platform/efi/efi_32.c
>> @@ -85,10 +85,9 @@ pgd_t * __init efi_call_phys_prolog(void)
>>
>> void __init efi_call_phys_epilog(pgd_t *save_pgd)
>> {
>> +    load_fixmap_gdt(0);
>>     load_cr3(save_pgd);
>>     __flush_tlb_all();
>> -
>> -    load_fixmap_gdt(0);
>> }
> 
> We have IRQs on here?  It seems plausible that we’re in a window where the EFI pgd doesn’t have cpu_entry_area mapped. Also, the hard coded CPU 0 is suspicious.
> 
The hard coded CPU 0 was always there. The call is ultimately from
efi_enter_virtual_mode(), which is called from start_kernel().
so presumably it is guaranteed to run on CPU 0.

> Maybe try instrumenting the code to check whether the clone_pgd_range calls in setup_percpu.c have happened yet?
> 
The crash is seen late in the boot process, so I am quite sure it happened,
but I can add a check if needed. I think that might be a different problem,
though.

> Your patch may well be correct, but, if we have IRQs on, we should really have cpu_entry_area mapped in both pgds.
> 
> Or we could turn off IRQs. Why on Earth are IRQs on in a context where the fixmap gdt is unusable?
> 

 From arch/x86/platform/efi/efi.c:phys_efi_set_virtual_address_map():

	save_pgd = efi_call_phys_prolog();
	local_irq_save(flags);
	status = efi_call_phys(...);
         local_irq_restore(flags);

         efi_call_phys_epilog(save_pgd);

So, yes, interrupts are very much enabled.

I ran several additional test sequences. With above patch, no failures with
500 boots. Without it, failure rate (long term average) across 500 boots
is around 10%. Another data point: Moving load_fixmap_gdt(0); after
load_cr3(save_pgd); does not help; it has to come first.

Guenter
