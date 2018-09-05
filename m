Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DF9C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D47820857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 13:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GPj4hurI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D47820857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727679AbeIEReF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:34:05 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:46721 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbeIEReF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:34:05 -0400
Received: by mail-io0-f194.google.com with SMTP id y12-v6so5817646ioj.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Sep 2018 06:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ob7yPhT44/Lkqbct77mnyu8pbxSlkFdORyu/Uy3uoPg=;
        b=GPj4hurIavFE0g/uRvIAe1VR3YhUgAblUuFIfUrxcQRTd6vI0n7jP47go/RW/IRSXk
         W0iWBCQWF3J2/FYwP8TnxDFvRTZsi4EamnGXn9iputqHcJesqxMPDiBudwQQH5YVjjQ7
         HmGQRsB2HTaf/oC3iE4jqot0CA3ed/9VqgawA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ob7yPhT44/Lkqbct77mnyu8pbxSlkFdORyu/Uy3uoPg=;
        b=KbK5E4RmUTkUzz1oNpB6WWqfzi3BJOb3s6qqdGhR5PAlFE9X9CCd22DIeV26VkgaeE
         T7TaAv54C6xzLOs8JyNEp+mR2vq9EX/U/xTDVusqQLnhPEUu4hOmNCacUsgkFhoirZtM
         aAgZoRSAUbQL0/EP8yuKOklUsK6+U92/nrqUPYAZfnlrnHH9+Yfj+ZUzbPOuwysd4HNK
         6suEgLE+ZvlSuqiV1SX0C+uJaNa7VWJpwny62vOKIoPYnb6rkhy7UlwDltevq9kgTjJx
         54WC3YGQUP6uI1A2J/rZUklROYHZT4Cwol4Q5V2YmPg33mofhSNlk7NpcT7H6dfThoLW
         kx6w==
X-Gm-Message-State: APzg51AxFgD/CxCPmyjJ5xjpsY4rONvtKzV+yCl1JHjleVEqoiYlqy8m
        LCkSiGWcmntLl7sjvLZeEhvRLIwMWmp4Iq1Lv+nCzcAlGPt7cQ==
X-Google-Smtp-Source: ANB0VdZHcQTaTtrtm9qkiWfLOPIEvKwEwx+QUFGQDQC43g5Y4AC/Agc4uXslCCBEgh9t4OTmuNoR42kuaPOrI2C9DiA=
X-Received: by 2002:a6b:ba86:: with SMTP id k128-v6mr25428559iof.170.1536152633034;
 Wed, 05 Sep 2018 06:03:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:1c06:0:0:0:0:0 with HTTP; Wed, 5 Sep 2018 06:03:52 -0700 (PDT)
In-Reply-To: <20180905125645.GX24082@hirez.programming.kicks-ass.net>
References: <1536099149-12564-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <1536099149-12564-4-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu9mfWYww49OmBETutSsaTDfE6VFJjbf+LWAoXF=mNmDBA@mail.gmail.com> <20180905125645.GX24082@hirez.programming.kicks-ass.net>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 5 Sep 2018 15:03:52 +0200
Message-ID: <CAKv+Gu_DC=+7_YmDGGJ9fYJkGSNbUK-eXOAGMuZ2B7XXPWvZ9g@mail.gmail.com>
Subject: Re: [PATCH V3 3/5] x86/efi: Permanently save the EFI_MEMORY_MAP
 passed by the firmware
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Al Stone <astone@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 September 2018 at 14:56, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Sep 05, 2018 at 02:27:49PM +0200, Ard Biesheuvel wrote:
>> On 5 September 2018 at 00:12, Sai Praneeth Prakhya
>> <sai.praneeth.prakhya@intel.com> wrote:
>> > From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>> >
>> > The efi page fault handler that recovers from page faults caused by the
>> > firmware needs the original memory map passed by the firmware. It looks
>> > up this memory map to find the type of the memory region at which the
>> > page fault occurred. Presently, EFI subsystem discards the original
>> > memory map passed by the firmware and replaces it with a new memory map
>> > that has only EFI_RUNTIME_SERVICES_<CODE/DATA> regions. But illegal
>> > accesses by firmware can occur at any region. Hence, _only_ if
>> > CONFIG_EFI_WARN_ON_ILLEGAL_ACCESS is defined, create a backup of the
>> > original memory map passed by the firmware, so that efi page fault
>> > handler could detect/recover from illegal accesses to *any* efi region.
>> >
>>
>> Why do we care about the memory map at all when a fault occurs during
>> the invocation of a EFI runtime service?
>>
>> I think reasoning about what went wrong and why, and distinguishing
>> between allowable and non-allowable faults is a slippery slope, so
>> [taking Thomas's feedback into account], I think we can simplify this
>> series further and just block all subsequent EFI runtime services
>> calls if any permission or page fault occurs while executing them.
>>
>> Would we still need to preserve the old memory map in that case?
>
> I thought the reason for having this was being able to know the fault is
> in an EFI area. But of course, I'm not wel versed in this whole EFI
> crapola.

I'm not entirely sure whether that really matters. The EFI services
access the stack and can access byref/pointer arguments which are not
covered by the EFI memory map as runtime services code/data, and so
they can trigger page faults by running off the vmapped stack or
writing to const byref arguments.

EFI runtime services using boot services regions after they are no
longer available are a known source of headaches, but I don't see why
we should restrict ourselves to such cases if we bother to wire up
fault handling specifically for EFI services calls.

So any page or permission fault occurring in the context of a EFI
runtime services invocation should be treated the same, I think.
