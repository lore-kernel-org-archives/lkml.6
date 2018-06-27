Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C3FC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6C25791
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 07:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gV3RRtIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CD6C25791
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeF0HBy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 03:01:54 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:50641 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbeF0HBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 03:01:52 -0400
Received: by mail-it0-f68.google.com with SMTP id u4-v6so5968022itg.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 00:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ytBViXbuLurIjrZHtEojwVnAu8MIq3NsR3KncRuinP8=;
        b=gV3RRtIvHWhHvGINuqdaltSaURneaJdU3b7k3mbE1BHZo4grKBnZOE0eNrGpQIM8O7
         Tbr9+pPzprgJDCCqD9runFCCBxXrpFywn3jV9hjPAiEBFhPT5vkMcudAM4OpdgYvCznc
         P3mYTh4qM50BCrbqTXmNu7pZY5two9Z8CFFVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ytBViXbuLurIjrZHtEojwVnAu8MIq3NsR3KncRuinP8=;
        b=lxUVyLxydc8Fx6Q8SMKecm/mSvFxPViSsuoNnARfp3oSCMVw0QNi/jawvEJqQm1bT6
         J3RJZsKw/vq4VyCbw1rSnuAWfHBAeiNbYkX5FiqVCPPlMnZpGoOKPRceEtRKXtZnBLM6
         BJp488LSj6jBBXtXJqmGfImiv8sy6R54BZv6NsOD5Iy2GZUgCqd+HLcKtt7OrkxMIQip
         tlZIMKViXKVehWzdAPdRytJRYVpQUMs4M/50i2TgNmq/7EJsEGTAMx2Y4Dk7FRIjDn4w
         MG+DXN00OHhTBQ+7TTjIIxVRf+2KT3Ec2yff9yu3Ew5NIzg8DOa5a4R+tEqUq2LFwhUn
         hFdQ==
X-Gm-Message-State: APt69E0Z8BGG3q4PLR1yKgdpyp5z/V3YA5crHtABEe2maPjBfBWe8ZhP
        dojIwqZG3uWlomhXYPFdBGaGRm4nXmKKd2GtZOEgIA==
X-Google-Smtp-Source: AAOMgpd0uibNnC+tzt/OTI7wIOLmHCXIyFN5h8mrtQyXAtuN9uSLsEtI9VH416sQG4sAhMTEc9YjUnNepdN6OzAEWO8=
X-Received: by 2002:a02:2422:: with SMTP id f34-v6mr3986500jaa.2.1530082912108;
 Wed, 27 Jun 2018 00:01:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Wed, 27 Jun 2018 00:01:51
 -0700 (PDT)
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F4605BA0F@ORSMSX111.amr.corp.intel.com>
References: <1529980892-11833-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu-_tQsYMUMp4NGrEkRrbFGJvE=vJVciaO6TEAC_u5bmfQ@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F4605BA0F@ORSMSX111.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Wed, 27 Jun 2018 09:01:51 +0200
Message-ID: <CAKv+Gu982OPp73Tg5Rru3+1ymq6_P8XpFPROQPdZMSUDdwEOmw@mail.gmail.com>
Subject: Re: [PATCH] efi: Free existing memory map before installing new
 memory map
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        Laszlo Ersek <lersek@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        "Neri, Ricardo" <ricardo.neri@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 June 2018 at 06:51, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>> > +       /* Free the memory allocated to the existing memory map */
>> > +       efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map,
>> > + efi.memmap.late);
>> > +
>> >         data.phys_map = addr;
>> >         data.size = efi.memmap.desc_size * nr_map;
>> >         data.desc_version = efi.memmap.desc_version;
>> > --
>> > 2.7.4
>> >
>>
>> If only it were so simple :-)
>>
>> At this point, efi.memmap.phys_map could point to memory that was allocated
>> early, allocated late or simply passed to the OS at boot time by the stub (in
>> which case it was memblock_reserve()d but not memblock_alloc()d, and it
>> should not be freed)
>>
>
> Yes, completely agree that there could be three types of allocations for memmap.
> I thought,
> efi_memmap_free(efi.memmap.phys_map, efi.memmap.nr_map, efi.memmap.late);
>
> should work because the previous type of allocation should have been recorded in efi.memmap.late.
> But, now I see this will fail for memblock_reserved() memory because it will be mistaken to
> memblock_alloced() (I assumed both are almost similar :().
>
>> So only allocations made with efi_memmap_alloc() should be freed here.
>
> Makes sense and I think that also means efi_memmap_free() should be called from function
> that called efi_memmap_alloc() and not efi_memmap_install().
>
>> I'm not sure /how/ we should keep track of that: perhaps it is simply a matter of
>> replacing the boolean 'late' with an enum that describes where the memory
>> came from that phys_map points to.
>
> I did try changing boolean late to enum and it seems to be working fine. I will do more
> testing/clean up and will submit a patch for review.
>
> Also, could you please clarify if there is any specific reason why memory allocated
> using memblock_reserve() shouldn't be freed. I mean, not with memblock_free() but I
> think we could make it _available_ using free_bootmem() (or something similar, please
> correct me if this is not the right API).

On arm64, the memory map is provided to the core kernel by the stub,
and after kexec, a pointer to the same memory map will be passed to
the next kernel. So the kernel does not 'own' that allocation, and it
should not free it or overwrite it.

> If we allocate and install a new memory map (as
> in case with efi_fake_memmap()), I think we should free the memory used by memory map
> originally passed by EFI stub, because, at any point of time there should only be one active
> memory map. If we don't free the original memory map passed by EFI stub, we will be having
> two and hence will be leaking memory.
>
> Regards,
> Sai
