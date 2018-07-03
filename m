Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80BD6C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F569224D6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 12:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F569224D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeGCMOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 08:14:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35293 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752491AbeGCMOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 08:14:40 -0400
Received: by mail-lj1-f194.google.com with SMTP id i125-v6so1359107lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 05:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=G3gwYlJPJjiuj7Ajr/8y0M0zmtZkCbtPm7j/8c4do/g=;
        b=oFpE2fn7WuJZrOq0WymYGyKQ3oGVWdyFMltPoAPwSyjxQ0EaT7Q3Gl6NIosem8DNAk
         6lmIwynA/sRFwvqAn2UThgbYuX+f9hGsdjcpY7sAdaQUAcmZKxMbCAckI/zS2OKqhplx
         V6TQ4JN4CKgy0Uchynhtd5v3ya2IxmW3fYjO3iOqXTLzYYcwGGSrIZ+aP0DmHXzQuwZc
         18K2pou8yrDjbGNP1nG5jI/+CBSwMOy5srRfw7kF9ZY7+tq5nuFyvFSktw0j4zuinrhg
         hMsOUeJFeZiY6T/Io7Fi3qG6Mcf7AHsDKkwJmZkkk5jYJKGyouhq08ojjiUf4JOK0VDv
         KGjA==
X-Gm-Message-State: APt69E0iQ+s0Pwqyi8DwfbGujOLBSdH98F4Ij2nfgGK7Tgls35JhN0bc
        FWZUs676JkDouOWec+KJs5tyfvnNJjPMQV2ggYLf7Q==
X-Google-Smtp-Source: ADUXVKIZaOI+4VJZn4CAup1T4Q8rCkvvUcC6IkBrFFgPMoDsUFbqZZd5y8OSPanekwOKseIvlD+1isGPvZR+obTmgHw=
X-Received: by 2002:a2e:c52:: with SMTP id o18-v6mr18947560ljd.72.1530620078839;
 Tue, 03 Jul 2018 05:14:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:3904:0:0:0:0:0 with HTTP; Tue, 3 Jul 2018 05:14:37 -0700 (PDT)
In-Reply-To: <20180703064726.GU23681@linaro.org>
References: <20180619064424.6642-1-takahiro.akashi@linaro.org>
 <20180619064424.6642-2-takahiro.akashi@linaro.org> <72307608-90e0-4842-edc1-d3b284782940@oracle.com>
 <ca9e5d9d-e090-f9e0-bc10-3297c9e3b7e1@arm.com> <891c3e5a-9760-1353-4a2c-0900082dd245@oracle.com>
 <20180703064726.GU23681@linaro.org>
From:   Bhupesh Sharma <bhsharma@redhat.com>
Date:   Tue, 3 Jul 2018 17:44:37 +0530
Message-ID: <CACi5LpNhQ+jBvNL2F2w5aMpUd61JkzZSV=HsBLxCx6DRy2d7Vw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] arm64: export memblock_reserve()d regions via /proc/iomem
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        James Morse <james.morse@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>, akpm@linux-foundation.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, lorenzo.pieralisi@arm.com,
        graeme.gregory@linaro.org, Al Stone <al.stone@linaro.org>,
        Bhupesh Sharma <bhsharma@redhat.com>, tbaicar@codeaurora.org,
        kexec mailing list <kexec@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <hanjun.guo@linaro.org>, sudeep.holla@arm.com,
        Dave Young <dyoung@redhat.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 3, 2018 at 12:17 PM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On Tue, Jun 19, 2018 at 10:22:46AM -0500, Dave Kleikamp wrote:
>> On 06/19/2018 10:00 AM, James Morse wrote:
>> > Hi Dave,
>> >
>> > On 19/06/18 14:37, Dave Kleikamp wrote:
>> >> On 06/19/2018 01:44 AM, AKASHI Takahiro wrote:
>> >>> +static int __init reserve_memblock_reserved_regions(void)
>> >>> +{
>> >>> + phys_addr_t start, end, roundup_end = 0;
>> >>> + struct resource *mem, *res;
>> >>> + u64 i;
>> >>> +
>> >>> + for_each_reserved_mem_region(i, &start, &end) {
>> >>> +         if (end <= roundup_end)
>> >>> +                 continue; /* done already */
>> >>> +
>> >>> +         start = __pfn_to_phys(PFN_DOWN(start));
>> >>> +         end = __pfn_to_phys(PFN_UP(end)) - 1;
>> >>> +         roundup_end = end;
>> >>> +
>> >>> +         res = kzalloc(sizeof(*res), GFP_ATOMIC);
>> >>> +         if (WARN_ON(!res))
>> >>> +                 return -ENOMEM;
>> >>> +         res->start = start;
>> >>> +         res->end = end;
>> >>> +         res->name  = "reserved";
>> >>> +         res->flags = IORESOURCE_MEM;
>> >>> +
>> >>> +         mem = request_resource_conflict(&iomem_resource, res);
>> >>> +         /*
>> >>> +          * We expected memblock_reserve() regions to conflict with
>> >>> +          * memory created by request_standard_resources().
>> >>> +          */
>> >>> +         if (WARN_ON_ONCE(!mem))
>> >>> +                 continue;
>> >>> +         kfree(res);
>> >>
>> >> Why is kfree() after the conditional continue? This is a memory leak.
>> >
>> > request_resource_conflict() inserts res into the iomem_resource tree, or returns
>> > the conflict if there is already something at this address.
>> >
>> > We expect something at this address: a 'System RAM' section added by
>> > request_resource(). This code wants the conflicting 'System RAM' entry so that
>> > reserve_region_with_split() can fill in the gaps below it with 'reserved'. See
>> > the commit-message for an example.
>> >
>> > If there was no conflict, it means the memory map doesn't look like we expect,
>> > we can't pass NULL to reserve_region_with_split(), and we just inserted the
>> > 'reserved' at the top level. Freeing res at this point would be a use-after-free
>> > hanging from /proc/iomem.
>> > This code generates a WARN_ON_ONCE() and leaves the 'reserved' description where
>> > it is.
>>
>> Okay. I get it.
>>
>> > Trying to cleanup here is pointless, we can remove the resource entry and free
>> > it ... but we still want to report it as reserved, which is what just happened,
>> > just not quite how we we wanted it.
>> >
>> > If you ever see this warning, it means some RAM stopped being nomap between
>> > request_resources() and reserve_memblock_reserved_regions(). I can't find any
>> > case where that ever happens.
>> >
>> >
>> > If all that makes sense: how can I improve the comment above the WARN_ON_ONCE()
>> > to make it clearer?
>>
>> I guess something like you described above.
>>
>> /*
>>  * We expect a 'System RAM' section at this address. In the unexpected
>>  * case where one is not found, request_resource_conflict() will insert
>>  * res into the iomem_resource tree.
>>  */
>>
>> Do you think this is clearer?
>
> If this is the only change needed in my patchset, I'd like the maintainers
> to take care of it instead of my posting another version.
>

+1.

crashkernel booting on arm64 machines which support boot via acpi
tables is broken since a long time, so it would be great to get these
into upstream asap.

I think the comment can be addressed while picking up the patchset in
the maintainer's tree.

I am not sure whether it will go through the ARM tree (Will) or the
EFI tree (Ard), but since this has a Tested-by (from myself) and
Reviewed-by (from James), probably this can be pulled in to allow
further tests via the maintainer's tree.

Thanks,
Bhupesh


>> >
>> >
>> > Thanks,
>> >
>> > James
>> >
>> >
>> >>> +
>> >>> +         reserve_region_with_split(mem, start, end, "reserved");
>> >>> + }
>> >>> +
>> >>> + return 0;
>> >>> +}
>> >>> +arch_initcall(reserve_memblock_reserved_regions);
>> >>> +
>> >>>  u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
>> >>>
>> >>>  void __init setup_arch(char **cmdline_p)
>> >>>
>> >
