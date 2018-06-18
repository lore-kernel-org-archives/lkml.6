Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEEFC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6930920020
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kZnWODZe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6930920020
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935422AbeFRRZL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 13:25:11 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:39440 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934963AbeFRRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 13:25:06 -0400
Received: by mail-it0-f66.google.com with SMTP id p185-v6so13108920itp.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 10:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sKpouGROSmLroMt1dwuobig8fhFH/tg6uC1vylQGCx0=;
        b=kZnWODZexCApx+8WFN1yp3hTWol2408j9RBm+3tP09PT+H5PPwWUNWQCCuGbggn7kB
         gbhS7DxnEZp1WBN6UA/RFNCB8E03qkhptG5W+CEIIESL39qxUsurMGW4T60bniGrMceI
         fFz3sFOztcF283Y8vkyGZeVT+TEFgfPOSnma0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sKpouGROSmLroMt1dwuobig8fhFH/tg6uC1vylQGCx0=;
        b=ih7vGbM//GgVUCZGv0gRfbFBF9JUVaLxzhFkivytceC2OST8QSd0Pt5L03S7WOYv2/
         LQRNAHcncGA+/hXAH4eOH1/di37AwQJX1jQbOYCUSOeI3dVztEC8o1wTm688AEcBpoLh
         KeP9iqspxkRDUGrAQRtVz++Fi65XYMRR7njl9HAmXi2J8fsPS9clhT/t0oPBy7j4uo9G
         cUag7gBNJ2idN8oQl/Ekh1hydzgCOSM2Yr8G5z1A4pIEWEpaBjoKvqNzJVKtVvZTSBsy
         c1GbGdU/7qjDRgby7eAlP5YNI+HcI0I5xp2Ov3C6iUZkZTHgmCGMBDlHRC0H8j+jH/gm
         3Jsw==
X-Gm-Message-State: APt69E3risaefYR5TSx36olDISgqwozrWqPP7rPX0oEI5TmgpO9ikfLw
        wfrFnqxv2RDRp3XfVkDgTLq1Ux2Vr3+UdMwrNM9Rww==
X-Google-Smtp-Source: ADUXVKJT+k5hd3qZGZk8FxQSxp44DatnNl6O8w2oa5UUtFqkzjQJuDTJzEtulLVvjuJk48c4+ZHk+WO98ywXySR4Uw8=
X-Received: by 2002:a02:4187:: with SMTP id n7-v6mr10795529jad.86.1529342705976;
 Mon, 18 Jun 2018 10:25:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 10:25:05
 -0700 (PDT)
In-Reply-To: <1529342439.2333.60.camel@intel.com>
References: <1529111365-32295-1-git-send-email-sai.praneeth.prakhya@intel.com>
 <CAKv+Gu-L=UMkzet7s1rUEYMYZxtoE1M_Qa1dqKo134S_hoZWuw@mail.gmail.com> <1529342439.2333.60.camel@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 18 Jun 2018 19:25:05 +0200
Message-ID: <CAKv+Gu9-YrLPuduh3YH67Fk0+tL1AfAveguu+mPjBwEBNU+==Q@mail.gmail.com>
Subject: Re: [PATCH] x86/efi: Free allocated memory if remap fails
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Tony Luck <tony.luck@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 June 2018 at 19:20, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
>
>> > It's a fact that memremap() and early_memremap() might never fail and
>> > this code might never get a chance to run but to maintain good kernel
>> > programming semantics, we might need this patch.
>> >
>> > Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
>> > Reviewed-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> Please don't include tags for reviews that did not happen on-list.
>>
>
> Sure! Thanks for letting me know.
>
>> > @@ -450,10 +451,11 @@ void __init efi_free_boot_services(void)
>> >
>> >         memunmap(new);
>> >
>> > -       if (efi_memmap_install(new_phys, num_entries)) {
>> > +       if (efi_memmap_install(new_phys, num_entries))
>> >                 pr_err("Could not install new EFI memmap\n");
>> > -               return;
>> > -       }
>> > +
>> > +free_mem:
>> > +       efi_memmap_free(new_phys, num_entries);
>> Doesn't this free the memory map that you just installed?
>>
>
> That's true! It's a bug. I will fix it.
>
>> >
>> >  }
>> >
>> >  /**
>> > + * efi_memmap_free - Free memory allocated by efi_memmap_alloc()
>> > + * @mem: Physical address allocated by efi_memmap_alloc()
>> > + * @num_entries: Number of entries in the allocated map.
>> > + *
>> > + * efi_memmap_alloc() allocates memory depending on whether mm_init()
>> > + * has already been invoked or not. It uses either memblock or "normal"
>> > + * page allocation. Use this function to free the memory allocated by
>> > + * efi_memmap_alloc(). Since the allocation is done in two different
>> > + * ways, similarly, we free it in two different ways.
>> > + *
>> > + */
>> > +void __init efi_memmap_free(phys_addr_t mem, unsigned int num_entries)
>> > +{
>> > +       unsigned long size = num_entries * efi.memmap.desc_size;
>> > +       unsigned int order = get_order(size);
>> > +       phys_addr_t end = mem + size - 1;
>> > +
>> > +       if (slab_is_available()) {
>> > +               __free_pages(pfn_to_page(PHYS_PFN(mem)), order);
>> How do you know that the memory you are freeing was allocated when
>> slab_is_available() was already true?
>>
>
> efi_memmap_free() should be used *only* in conjunction
> with efi_memmap_alloc()(As I explicitly didn't mention this, maybe it might
> have confused you).
>
> When allocating memory efi_memmap_alloc() does similar check
> for slab_is_available() and if so, it allocates memory using alloc_pages().
> So, to free pages allocated using alloc_pages(), efi_memmap_free()
> uses __free_pages().
>

I understand that. But by abstracting away the free() routine as well
as the alloc() routine, you are hiding this fact.

What is preventing me from using efi_memmap_alloc() to allocate space
for the memmap, and using efi_memmap_free() in another place? How are
you preventing that this does not happen in a way where mm_init() may
be called in the mean time?

Whether __free_pages() should be used or memblock_free() is a property
of the *allocation* itself, not of whether mm_init() has already been
called. So if (!slab_is_available()), you can use memblock_free().
However, if (slab_is_available()), you cannot use __free_pages()
because the allocation could have been made before mm_init() was
called.


>> >
>> > +               return;
>> > +       }
>> > +
>> > +       if (memblock_free(mem, size))
>> > +               pr_err("Failed to free mem from %pa to %pa\n", &mem,
>> > &end);
>> > +}
>> > +
>
> Regards,
> Sai
