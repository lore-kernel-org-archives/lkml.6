Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B34ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4BE120652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 08:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzjFmphu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4BE120652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbeGTJSp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 05:18:45 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33799 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727630AbeGTJSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 05:18:44 -0400
Received: by mail-wr1-f66.google.com with SMTP id c13-v6so10492893wrt.1;
        Fri, 20 Jul 2018 01:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:openpgp:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+ejuoEdngHXJfLFPT2qz0KtZYqN3838ZQcpWEB/698=;
        b=PzjFmphubPdZidEIOjWJlYpDQy0Iir4dpJJHXiVbpm4/vgpjbG60FUkONf8X7TheDS
         oOfBzYfAkQFvqCxofjmYPxkceloofkgnqsxbzdGtA4/UWXHKTxMgQFHYgjxWuDUOG6q7
         X9R0q+SkR1MYtysGjGuV4uzafjD58DDByNHnqQIWhKuGcG8xh8Uz//a3iXESCIt39IcQ
         2gUP89l4lQuYaWtCQbev+BGOv9jjYs/6bWlQ2ViJjXcg48JrYLCKD0J1bMr0DurJfDRO
         NRVc/4dDyv6XY8NxLWU0ynn+qluJ9lg69XSzbiIns7lJe36LhkALw19qIaWoxxW8zfFj
         Fe2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:openpgp
         :autocrypt:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=p+ejuoEdngHXJfLFPT2qz0KtZYqN3838ZQcpWEB/698=;
        b=dpN8XlR1fQ7LWHC4Y3mUMKjb1RcyYDGklrPmBNN+E0kUs0f/uyw/JckrvYXIHnMGGe
         iFfFwDrTzULWEOBzPfHhHDxl1pk0gAbwfQ95pSJwpUO4nKhKoQXN4gRmLTiyf2wAL8/5
         rScYtNWBt7+o/QTkB05W0py1ysIhutFIKJK2oc3q53C8TiZKJJE0DrNm1JJX7TV/CTXZ
         iywWfG4b4qv771tuoMAF1vk05Ol81b8or24eabGMy6jeHd0kihS0olt90L3wzv9NRm1B
         aIQ2SV6Yp6olsC/KAZ2ET7YOOQV0QmgHYmU8f1z6e9N+fFWim9Dhx0yRnmxyyhgRu+RZ
         S2dw==
X-Gm-Message-State: AOUpUlHzusjZELomi1lrkf4GJR0UaYKrTP2heu+jRRoQ/onGiBAMNSSR
        BdCxKCA1TiEZKVdm4exLx/w=
X-Google-Smtp-Source: AAOMgpdPZyU7t3PAySpqI+6gDFzQsegkfwzMvhVthrAScKAs7/qh01FJ2lAHUuCAzUNq0Bwcpy9N7g==
X-Received: by 2002:adf:dc8e:: with SMTP id r14-v6mr766785wrj.166.1532075492843;
        Fri, 20 Jul 2018 01:31:32 -0700 (PDT)
Received: from [192.168.10.150] (dynamic-adsl-78-12-156-57.clienti.tiscali.it. [78.12.156.57])
        by smtp.googlemail.com with ESMTPSA id b198-v6sm1125248wme.11.2018.07.20.01.31.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jul 2018 01:31:32 -0700 (PDT)
Subject: Re: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address space
 mapping flush support
To:     KY Srinivasan <kys@microsoft.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>
Cc:     "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>
References: <20180719083946.121493-1-Tianyu.Lan@microsoft.com>
 <MW2PR2101MB1113BF48AF4E3802CC29A10EA0510@MW2PR2101MB1113.namprd21.prod.outlook.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=pbonzini@redhat.com; keydata=
 xsEhBFRCcBIBDqDGsz4K0zZun3jh+U6Z9wNGLKQ0kSFyjN38gMqU1SfP+TUNQepFHb/Gc0E2
 CxXPkIBTvYY+ZPkoTh5xF9oS1jqI8iRLzouzF8yXs3QjQIZ2SfuCxSVwlV65jotcjD2FTN04
 hVopm9llFijNZpVIOGUTqzM4U55sdsCcZUluWM6x4HSOdw5F5Utxfp1wOjD/v92Lrax0hjiX
 DResHSt48q+8FrZzY+AUbkUS+Jm34qjswdrgsC5uxeVcLkBgWLmov2kMaMROT0YmFY6A3m1S
 P/kXmHDXxhe23gKb3dgwxUTpENDBGcfEzrzilWueOeUWiOcWuFOed/C3SyijBx3Av/lbCsHU
 Vx6pMycNTdzU1BuAroB+Y3mNEuW56Yd44jlInzG2UOwt9XjjdKkJZ1g0P9dwptwLEgTEd3Fo
 UdhAQyRXGYO8oROiuh+RZ1lXp6AQ4ZjoyH8WLfTLf5g1EKCTc4C1sy1vQSdzIRu3rBIjAvnC
 tGZADei1IExLqB3uzXKzZ1BZ+Z8hnt2og9hb7H0y8diYfEk2w3R7wEr+Ehk5NQsT2MPI2QBd
 wEv1/Aj1DgUHZAHzG1QN9S8wNWQ6K9DqHZTBnI1hUlkp22zCSHK/6FwUCuYp1zcAEQEAAc0f
 UGFvbG8gQm9uemluaSA8Ym9uemluaUBnbnUub3JnPsLBTQQTAQIAIwUCVEJ7AwIbAwcLCQgH
 AwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEH4VEAzNNmmxNcwOniaZVLsuy1lW/ntYCA0Caz0i
 sHpmecK8aWlvL9wpQCk4GlOX9L1emyYXZPmzIYB0IRqmSzAlZxi+A2qm9XOxs5gJ2xqMEXX5
 FMtUH3kpkWWJeLqe7z0EoQdUI4EG988uv/tdZyqjUn2XJE+K01x7r3MkUSFz/HZKZiCvYuze
 VlS0NTYdUt5jBXualvAwNKfxEkrxeHjxgdFHjYWhjflahY7TNRmuqPM/Lx7wAuyoDjlYNE40
 Z+Kun4/KjMbjgpcF4Nf3PJQR8qXI6p3so2qsSn91tY7DFSJO6v2HwFJkC2jU95wxfNmTEUZc
 znXahYbVOwCDJRuPrE5GKFd/XJU9u5hNtr/uYipHij01WXal2cce1S5mn1/HuM1yo1u8xdHy
 IupCd57EWI948e8BlhpujUCU2tzOb2iYS0kpmJ9/oLVZrOcSZCcCl2P0AaCAsj59z2kwQS9D
 du0WxUs8waso0Qq6tDEHo8yLCOJDzSz4oojTtWe4zsulVnWV+wu70AioemAT8S6JOtlu60C5
 dHgQUD1Tp+ReXpDKXmjbASJx4otvW0qah3o6JaqO79tbDqIvncu3tewwp6c85uZd48JnIOh3
 utBAu684nJakbbvZUGikJfxd887ATQRUQnHuAQgAx4dxXO6/Zun0eVYOnr5GRl76+2UrAAem
 Vv9Yfn2PbDIbxXqLff7oyVJIkw4WdhQIIvvtu5zH24iYjmdfbg8iWpP7NqxUQRUZJEWbx2CR
 wkMHtOmzQiQ2tSLjKh/cHeyFH68xjeLcinR7jXMrHQK+UCEw6jqi1oeZzGvfmxarUmS0uRuf
 fAb589AJW50kkQK9VD/9QC2FJISSUDnRC0PawGSZDXhmvITJMdD4TjYrePYhSY4uuIV02v02
 8TVAaYbIhxvDY0hUQE4r8ZbGRLn52bEzaIPgl1p/adKfeOUeMReg/CkyzQpmyB1TSk8lDMxQ
 zCYHXAzwnGi8WU9iuE1P0wARAQABwsEzBBgBAgAJBQJUQnHuAhsMAAoJEH4VEAzNNmmxp1EO
 oJy0uZggJm7gZKeJ7iUpeX4eqUtqelUw6gU2daz2hE/jsxsTbC/w5piHmk1H1VWDKEM4bQBT
 uiJ0bfo55SWsUNN+c9hhIX+Y8LEe22izK3w7mRpvGcg+/ZRG4DEMHLP6JVsv5GMpoYwYOmHn
 plOzCXHvmdlW0i6SrMsBDl9rw4AtIa6bRwWLim1lQ6EM3PWifPrWSUPrPcw4OLSwFk0CPqC4
 HYv/7ZnASVkR5EERFF3+6iaaVi5OgBd81F1TCvCX2BEyIDRZLJNvX3TOd5FEN+lIrl26xecz
 876SvcOb5SL5SKg9/rCBufdPSjojkGFWGziHiFaYhbuI2E+NfWLJtd+ZvWAAV+O0d8vFFSvr
 iy9enJ8kxJwhC0ECbSKFY+W1eTIhMD3aeAKY90drozWEyHhENf4l/V+Ja5vOnW+gCDQkGt2Y
 1lJAPPSIqZKvHzGShdh8DduC0U3xYkfbGAUvbxeepjgzp0uEnBXfPTy09JGpgWbg0w91GyfT
 /ujKaGd4vxG2Ei+MMNDmS1SMx7wu0evvQ5kT9NPzyq8R2GIhVSiAd2jioGuTjX6AZCFv3ToO
 53DliFMkVTecLptsXaesuUHgL9dKIfvpm+rNXRn9wAwGjk0X/A==
Message-ID: <a51f8e18-5592-5dbd-87e2-9cf42c1af16a@redhat.com>
Date:   Fri, 20 Jul 2018 10:31:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <MW2PR2101MB1113BF48AF4E3802CC29A10EA0510@MW2PR2101MB1113.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/2018 05:58, KY Srinivasan wrote:
> 
> 
>> -----Original Message-----
>> From: Tianyu Lan
>> Sent: Thursday, July 19, 2018 1:40 AM
>> Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>; devel@linuxdriverproject.org;
>> Haiyang Zhang <haiyangz@microsoft.com>; hpa@zytor.com;
>> kvm@vger.kernel.org; KY Srinivasan <kys@microsoft.com>; linux-
>> kernel@vger.kernel.org; mingo@redhat.com; pbonzini@redhat.com;
>> rkrcmar@redhat.com; Stephen Hemminger <sthemmin@microsoft.com>;
>> tglx@linutronix.de; x86@kernel.org; Michael Kelley (EOSG)
>> <Michael.H.Kelley@microsoft.com>; vkuznets@redhat.com
>> Subject: [PATCH V3 0/4] KVM/x86/hyper-V: Introduce PV guest address
>> space mapping flush support
>>
>> Hyper-V provides a para-virtualization hypercall
>> HvFlushGuestPhysicalAddressSpace
>> to flush nested VM address space mapping in l1 hypervisor and it's to reduce
>> overhead
>> of flushing ept tlb among vcpus. The tradition way is to send IPIs to all
>> affected
>> vcpus and executes INVEPT on each vcpus. It will trigger several vmexits for
>> IPI and
>> INVEPT emulation. The pv hypercall can help to flush specified ept table on all
>> vcpus
>> via one single hypercall.
>>
>> Change since v2:
>>        - Make ept_pointers_match as tristate "check", "match" and "mismatch".
>>        Set "check" in vmx_set_cr3(), check all ept table pointers in
>> hv_remote_flush_tlb()
>>        and call hypercall when all ept pointers are same.
>>        - Rename kvm_arch_hv_flush_remote_tlb with
>> kvm_arch_flush_remote_tlb and
>>        Rename kvm_x86_ops->hv_tlb_remote_flush with kvm_x86_ops-
>>> tlb_remote_flush
>>        - Fix issue that ignore updating tlbs_dirty during calling
>> kvm_arch_flush_remote_tlbs()
>>        - Merge patch "KVM/VMX: Add identical ept table pointer check" and
>>        patch "KVM/x86: Add tlb_remote_flush callback support for vmx"
>>
>> Change since v1:
>>        - Fix compilation error for non-x86 platform.
>>        - Use ept_pointers_match to check condition of identical ept
>>             table pointer and get ept pointer from struct vcpu_vmx->ept_pointer.
>>        - Add hyperv_nested_flush_guest_mapping ftrace support
>>
>>
>>
>> Lan Tianyu (4):
>>   X86/Hyper-V: Add flush HvFlushGuestPhysicalAddressSpace hypercall
>>     support
>>   X86/Hyper-V: Add hyperv_nested_flush_guest_mapping ftrace support
>>   KVM: Add tlb remote flush callback in kvm_x86_ops.
>>   KVM/x86: Add tlb_remote_flush callback support for vmx
>>
>>  arch/x86/hyperv/Makefile            |  2 +-
>>  arch/x86/hyperv/nested.c            | 67
>> ++++++++++++++++++++++++++++++++++
>>  arch/x86/include/asm/hyperv-tlfs.h  |  8 +++++
>>  arch/x86/include/asm/kvm_host.h     | 11 ++++++
>>  arch/x86/include/asm/mshyperv.h     |  2 ++
>>  arch/x86/include/asm/trace/hyperv.h | 14 ++++++++
>>  arch/x86/kvm/vmx.c                  | 72
>> ++++++++++++++++++++++++++++++++++++-
>>  include/linux/kvm_host.h            |  7 ++++
>>  virt/kvm/kvm_main.c                 |  3 +-
>>  9 files changed, 183 insertions(+), 3 deletions(-)
>>  create mode 100644 arch/x86/hyperv/nested.c
> 
> Acked-by: K. Y. Srinivasan <kys@microsoft.com>

Queued, thanks!

Paolo

