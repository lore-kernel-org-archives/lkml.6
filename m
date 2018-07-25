Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863AC6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C40820844
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AehgCfhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C40820844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbeGYJrv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:47:51 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:43628 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeGYJru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:47:50 -0400
Received: by mail-qk0-f193.google.com with SMTP id z74-v6so4375946qkb.10;
        Wed, 25 Jul 2018 01:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=T6eY+cI9E1c1Yz4+++tBmVSONxmFYvkC4KIpXgNjBnc=;
        b=AehgCfhJi7HBdC+ZIZg+aTXMxqQqqbY7aLj+iZ5eu8gDsxer8h/2hP4E6RGCO/IhSe
         y59iQ7tkjBEzFKc5Qw1aAcJH6VFqIwaThk5w0qCabw3xXzNyVALI+lt7ibkIYSPCCwB7
         mppGTXAOs2ox+BdNL/prFY61h1qTgFlHjC9AdLKj1j+n5/PfP12CnMGbHxAJzP5nXhpH
         x10yP60+v+vn4QlkPey7JOfSQisquzUk21M8KeD+m5N7xlWUt033xJSiGcT9gG10x0YS
         Olt41TUSm7eS7iKrxPu3rgIFeNy3XiZUj51yluN2glW4sHVZGF3osb9lcHpUHK8WYdQj
         X/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=T6eY+cI9E1c1Yz4+++tBmVSONxmFYvkC4KIpXgNjBnc=;
        b=RUF/9cAuYGvfGNIw07RloYIrQGencU0p55PuFQggJ0vmrpKbo4DVNKjepIRTNCeifR
         Gvpw7vrvHa+juRjL8u7ZkpkNIWnb20XVReXIgjETkn2+t7BmzFDVyYYgrC1qfKAasZ1o
         gStECdyJaWfpu9FGcFZF5qIBJsIMIn1+vu/LPYScDKudkpAj/CJXzbUuzvP59F0SDyUQ
         cnKc/vHygSIdDuhxC9ku2RfDQPKZyjnUio6o2kCjQNJdk1ID7dtNICVnlxMglAZwT9LX
         Psx0s2TuIxHiCe25o6oi1swIzUhsXbdf3pgwIrAqu/QdLmK7eHvf4ySVopTkSb8hHj+K
         APiQ==
X-Gm-Message-State: AOUpUlFhxoQ0g531YUc58VviDm199uaJfA6bJoqGmS7J1E2hmyGiPWsi
        HKywT7fhCu7zuaX01kQS2IlVqn94MKGQnNtgVvkil8jC
X-Google-Smtp-Source: AAOMgpes0Vnl8+Y2Kz/OrsbdNjObbapltblLqKJ4SqFG8tJ+l68pWF+lMgigJ/rh90ps4nLKVteYR0EEzTYlz06CYRo=
X-Received: by 2002:a37:338f:: with SMTP id z137-v6mr18391117qkz.172.1532507831335;
 Wed, 25 Jul 2018 01:37:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2824:0:0:0:0:0 with HTTP; Wed, 25 Jul 2018 01:37:10
 -0700 (PDT)
In-Reply-To: <036fd396-9b5f-a565-7aed-eec6ac5d5133@redhat.com>
References: <CAKhg4tJjp3yymCTDFpCQJiekos3265AcuBMuCw5TkZUvjCvg1g@mail.gmail.com>
 <036fd396-9b5f-a565-7aed-eec6ac5d5133@redhat.com>
From:   Liang C <liangchen.linux@gmail.com>
Date:   Wed, 25 Jul 2018 16:37:10 +0800
Message-ID: <CAKhg4tLjqwR3=jdaKz1r3fEiOAu3L4yih-eNdUEF2R-A0MBxSQ@mail.gmail.com>
Subject: Re: VM boot failure on nodes not having DMA32 zone
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rkrcmar@redhat.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for the quick reply and confirmation!  I just made
and submitted a patch according to your advice.

Thanks,
Liang

On Wed, Jul 25, 2018 at 2:05 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 24/07/2018 09:53, Liang C wrote:
>> Hi,
>>
>> We have a situation where our qemu processes need to be launched under
>> cgroup cpuset.mems control. This introduces an similar issue that was
>> discussed a few years ago. The difference here is that for our case,
>> not being able to allocate from DMA32 zone is a result a cgroup
>> restriction not mempolicy enforcement. Here is the steps to reproduce
>> the failure,
>>
>> mkdir /sys/fs/cgroup/cpuset/nodeX (where X is a node not having DMA32 zone)
>> echo X > /sys/fs/cgroup/cpuset/nodeX/cpuset.mems
>> echo X > /sys/fs/cgroup/cpuset/nodeX/cpuset.cpus
>> echo 1 > /sys/fs/cgroup/cpuset/node0/cpuset.mem_hardwall
>> echo $$ > /sys/fs/cgroup/cpuset/nodeX/tasks
>>
>> #launch a virtual machine
>> kvm_init_vcpu failed: Cannot allocate memory
>>
>> There are workarounds, like always putting qemu processes onto the
>> node with DMA32 zone or not restricting qemu processes memory
>> allocation until that DMA32 alloc finishes (difficult to be precise).
>> But we would like to find a way to address the root cause.
>>
>> Considering the fact that the pae_root shadow should not be needed
>> when ept is in use, which is indeed our case - ept is always available
>> for us (guessing this is the same case for most of other users), we
>> made a patch roughly like this,
>>
>> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
>> index d594690..1d1b61e 100644
>> --- a/arch/x86/kvm/mmu.c
>> +++ b/arch/x86/kvm/mmu.c
>> @@ -5052,7 +5052,7 @@ int kvm_mmu_create(struct kvm_vcpu *vcpu)
>>         vcpu->arch.mmu.translate_gpa = translate_gpa;
>>         vcpu->arch.nested_mmu.translate_gpa = translate_nested_gpa;
>>
>> -       return alloc_mmu_pages(vcpu);
>> +       return tdp_enabled ? 0 : alloc_mmu_pages(vcpu);
>>  }
>>
>>  void kvm_mmu_setup(struct kvm_vcpu *vcpu)
>>
>>
>> It works through our test cases. But we would really like to have your
>> insight on this patch before applying it in production environment and
>> contributing it back to the community. Thanks in advance for any help
>> you may provide!
>
> Yes, this looks good.  However, I'd place the "if" in alloc_mmu_pages
> itself.
>
> Thanks,
>
> Paolo
