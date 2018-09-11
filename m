Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BECC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 413C220839
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:36:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="LeVRefCR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413C220839
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbeIKVhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:37:00 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:38639 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbeIKVhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:37:00 -0400
Received: by mail-pg1-f196.google.com with SMTP id t84-v6so10691903pgb.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Sep 2018 09:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lKs1UX94L9BAxidNacCZTFJ5DpwcqcE/dRUS6HJqKAU=;
        b=LeVRefCRvOIUwlfRHM/vAe66vzpNk0IrrMRqyNUhMScZMDxQCtZyNUuwJpqDceJbcn
         +52HWw03VJUGgyMdq2xGuMDmJ+0A3/dlgUnTXGrO3MG7bjgdsaXjBkXUqjl7Gc1dZuFO
         /5fUErRESp1IPOoJdAlFGY/yX8SKM7fgr2OUcMzHSA3ZRw4q2IVb5nelWXgM91ccxkEQ
         WWbxysCffo3AgrJ+I6Javm32t+cHkE19Atkm1DZxBCSR5+9+fFh2Ui527fux/TUSCs3/
         QVdQnM+y9X4amnF6hhdkuFA+v2AjBEtDopVD+CFdmgglmVxJyehvkx4zGFdtJOaQ7gAq
         62Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=lKs1UX94L9BAxidNacCZTFJ5DpwcqcE/dRUS6HJqKAU=;
        b=EDr6LVcezGdi35D/b6QSz4ktIifDUrxGwRcRnYf+RxwKsr6xyJsofb1LHqQU4NGII0
         oY7GCbG2Ne8QpB10z2Ahf1L1fu6Qcwyegsu2C8ioGDMFXTvouJV5LgRRIaRfGC8HwtOQ
         VOsNLhXcWinX5YGIQt+PuaOWVT5n9wXyJOZ5lm3hiLx18kuP1kfRcuk4Z8PcmwAwK88R
         bk7Mlh7melC3Ty8PEM1sC43IHBxprmXSd3TwyNpg/4iZHXtKnHiBoxJOZArPHlDC24DB
         hXgeWczqvyKnblYO71GLynTs7PuPudOBDOSojilSEZPRVU6DSAkn4Ol2jgntXZmyUm+v
         3rxA==
X-Gm-Message-State: APzg51DMeqfoCjMDgmu108kCWNX0A3N4feYj2I6H0bCSGQx+E9KrwJNo
        q3MC2P2mWFofUlmmJnOshfv2PBVN6K8=
X-Google-Smtp-Source: ANB0VdaO6pwDbC2U//dr0hXUzc5OQdbkgks+2Ja+P2bAjWzVXntLEm+GDI3lhNJ/oyLmNKzUM61jyQ==
X-Received: by 2002:a63:5f01:: with SMTP id t1-v6mr29732499pgb.149.1536683814106;
        Tue, 11 Sep 2018 09:36:54 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:7429:6c19:77f6:df55:1bb5? ([2601:646:c200:7429:6c19:77f6:df55:1bb5])
        by smtp.gmail.com with ESMTPSA id c1-v6sm24516580pfi.142.2018.09.11.09.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Sep 2018 09:36:52 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Random crashes with i386 and efi boots
From:   Andy Lutomirski <luto@amacapital.net>
X-Mailer: iPhone Mail (15G77)
In-Reply-To: <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net>
Date:   Tue, 11 Sep 2018 09:36:51 -0700
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
Content-Transfer-Encoding: quoted-printable
Message-Id: <90A7FF2E-F186-49CF-A028-CDE317BE13E1@amacapital.net>
References: <20180910215659.GA17966@roeck-us.net> <D213F8BC-5C8E-44A2-810F-918B915F0804@amacapital.net> <877118e5-beee-4551-28d3-79e7aa52f74e@roeck-us.net>
To:     Guenter Roeck <linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Sep 11, 2018, at 6:30 AM, Guenter Roeck <linux@roeck-us.net> wrote:
>=20
> On 09/11/2018 04:52 AM, Andy Lutomirski wrote:
>>> On Sep 10, 2018, at 2:56 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>>>=20
>>> Hi folks,
>>>=20
>>> even after commit eeb89e2bb1ac ("x86/efi: Load fixmap GDT in
>>> efi_call_phys_epilog()"), my i386/efi qemu boot tests still crash random=
ly
>>> (roughly 5-10% of the time). As before, I don't see much useful output i=
n
>>> the qemu log (this time it doesn't even complain about a triple fault).
>>>=20
>>> Debugging shows that the crash happens in efi_call_phys_epilog().
>>> A sample log from a crashed test run is attached below. It appears that
>>> the crash happens if there is an interrupt at a critical section of the
>>> code.
>>>=20
>>> While playing with the code, I found a possible fix.
>>>=20
>>> diff --git a/arch/x86/platform/efi/efi_32.c b/arch/x86/platform/efi/efi_=
32.c
>>> index 05ca14222463..9959657127f4 100644
>>> --- a/arch/x86/platform/efi/efi_32.c
>>>  +++ b/arch/x86/platform/efi/efi_32.c
>>> @@ -85,10 +85,9 @@ pgd_t * __init efi_call_phys_prolog(void)
>>>=20
>>> void __init efi_call_phys_epilog(pgd_t *save_pgd)
>>> {
>>> +    load_fixmap_gdt(0);
>>>    load_cr3(save_pgd);
>>>    __flush_tlb_all();
>>> -
>>> -    load_fixmap_gdt(0);
>>> }
>> We have IRQs on here?  It seems plausible that we=E2=80=99re in a window w=
here the EFI pgd doesn=E2=80=99t have cpu_entry_area mapped. Also, the hard c=
oded CPU 0 is suspicious.
> The hard coded CPU 0 was always there. The call is ultimately from
> efi_enter_virtual_mode(), which is called from start_kernel().
> so presumably it is guaranteed to run on CPU 0.
>=20
>> Maybe try instrumenting the code to check whether the clone_pgd_range cal=
ls in setup_percpu.c have happened yet?
> The crash is seen late in the boot process, so I am quite sure it happened=
,
> but I can add a check if needed. I think that might be a different problem=
,
> though.
>=20
>> Your patch may well be correct, but, if we have IRQs on, we should really=
 have cpu_entry_area mapped in both pgds.
>> Or we could turn off IRQs. Why on Earth are IRQs on in a context where th=
e fixmap gdt is unusable?
>=20
> =46rom arch/x86/platform/efi/efi.c:phys_efi_set_virtual_address_map():
>=20
>    save_pgd =3D efi_call_phys_prolog();
>    local_irq_save(flags);
>    status =3D efi_call_phys(...);
>        local_irq_restore(flags);
>=20
>        efi_call_phys_epilog(save_pgd);
>=20
> So, yes, interrupts are very much enabled.

Does fixing that solve the problem?  It seems more robust.

>=20
> I ran several additional test sequences. With above patch, no failures wit=
h
> 500 boots. Without it, failure rate (long term average) across 500 boots
> is around 10%. Another data point: Moving load_fixmap_gdt(0); after
> load_cr3(save_pgd); does not help; it has to come first.
>=20
> Guenter
