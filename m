Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0C5C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:08:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7D8820834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 15:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="ju/sYDU6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7D8820834
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbeLCPIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 10:08:20 -0500
Received: from mail.skyhub.de ([5.9.137.197]:39166 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbeLCPIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 10:08:20 -0500
Received: from zn.tnic (p200300EC2BC7BF00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bc7:bf00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 88BEB1EC0AD8;
        Mon,  3 Dec 2018 16:08:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1543849694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=J0Tqf09DNMfVBdKSHHtU0DNCEkMAmNB81Xrfo67qcjU=;
        b=ju/sYDU69jOA9RqAwU+Ha1V/MFAboZq+MBHHpqZtUWjbtSI2Ycoy6kxCQ6+5higjrvJOJf
        gFCQa7AkWapcc1vDZbmFMUWUw7HEzd8ugFK1netsewSImV7qCYREUtRx9+pnDRj7pWDz0D
        q8fi8gO4AzfkFIOtE30k4n/rJj+9KP4=
Date:   Mon, 3 Dec 2018 16:08:09 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Lianbo Jiang <lijiang@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kexec@lists.infradead.org,
        tglx@linutronix.de, mingo@redhat.com, x86@kernel.org,
        akpm@linux-foundation.org, bhe@redhat.com, dyoung@redhat.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2 v2] kdump: add the vmcoreinfo documentation
Message-ID: <20181203150809.GA4794@zn.tnic>
References: <20181202030839.29945-1-lijiang@redhat.com>
 <20181202030839.29945-2-lijiang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181202030839.29945-2-lijiang@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add some more Ccs.

On Sun, Dec 02, 2018 at 11:08:38AM +0800, Lianbo Jiang wrote:
> This document lists some variables that export to vmcoreinfo, and briefly
> describles what these variables indicate. It should be instructive for
> many people who do not know the vmcoreinfo, and it also normalizes the
> exported variable as a standard ABI between kernel and use-space.

Yeah, I'm not sure about it being an ABI. Apparently, it is considered
too tightly coupled to the kernel for it to be an ABI.

Regardless, thanks for doing that.

> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> ---
>  Documentation/kdump/vmcoreinfo.txt | 400 +++++++++++++++++++++++++++++
>  1 file changed, 400 insertions(+)
>  create mode 100644 Documentation/kdump/vmcoreinfo.txt
> 
> diff --git a/Documentation/kdump/vmcoreinfo.txt b/Documentation/kdump/vmcoreinfo.txt

Aren't we adding new docs in rst format only or what is the logic there?

Jon?

> new file mode 100644
> index 000000000000..c6759be14af7
> --- /dev/null
> +++ b/Documentation/kdump/vmcoreinfo.txt
> @@ -0,0 +1,400 @@
> +================================================================
> +		Documentation for Vmcoreinfo
> +================================================================
> +
> +=======================
> +What is the vmcoreinfo?
> +=======================
> +The vmcoreinfo contains the first kernel's various information, for

The first sentence here should be explaining what VMCOREINFO is: it is
an ELF PT_NOTE section. So that people can go, oh ok, it is a special
ELF section, when reading.

Then, MAKEDUMPFILE(8) spells VMCOREINFO in all caps and I think we
should do that too here, for ease of recognition.

Btw, do we have a makedumpfile switch or a tool/script which dumps
VMCOREINFO contents in human-readable form?

Maybe something nicer than:

$ hexdump -C /proc/kcore

> +example, structure size, page size, symbol values and field offset,
> +etc. These data are encapsulated into an elf format, and these data
> +will also help user-space tools(e.g. makedumpfile, crash) analyze the
> +first kernel's memory usage.
> +
> +================
> +Common variables
> +================
> +
> +init_uts_ns.name.release
> +========================
> +The number of OS release.
> +
> +PAGE_SIZE
> +=========
> +The size of a page. It is usually 4k bytes.
> +
> +init_uts_ns
> +===========
> +This is the UTS namespace, which is used to isolate two specific elements
> +of the system that relate to the uname system call. The UTS namespace is
> +named after the data structure used to store information returned by the
> +uname system call.

Those non-obvious exports should also have a short explanation why
they're part of VMCOREINFO.

> +
> +node_online_map
> +===============
> +It is a macro definition, actually it is an arrary node_states[N_ONLINE],
> +and it represents the set of online node in a system, one bit position
> +per node number.

Ditto.

So yeah, people can find out what those things are but I think it is
more important to state here *why* they're part of VMCOREINFO and how
they're used and why they're exported.

Who knows, some might turn out to be not needed anymore. :)

> +
> +swapper_pg_dir
> +=============
> +It is always an array, it gerenally stands for the pgd for the kernel.
> +When mmu is enabled in config file, the 'swapper_pg_dir' is valid.
> +
> +_stext
> +======
> +It is an assemble directive that defines the beginning of the text section.

That's an assembly symbol.

> +In gerenal, the '_stext' indicates the kernel start address.
> +
> +vmap_area_list
> +==============
> +It stores the virtual area list, makedumpfile can get the vmalloc start
> +value according to this variable.

"... from this variable."

> +
> +mem_map
> +=======
> +Physical addresses are translated to struct pages by treating them as an
> +index into the mem_map array. Shifting a physical address PAGE_SHIFT bits
> +to the right will treat it as a PFN from physical address 0, which is also
> +an index within the mem_map array.
> +
> +In a word, it can map the address to struct page.

"In short, ... "

> +
> +contig_page_data
> +================
> +Makedumpfile can get the pglist_data structure according to this symbol

Please look up in the dictionary what "according" means. Using it in
this context is at least weird.

> +'contig_page_data'. The pglist_data structure is used to describe the
> +memory layout.
> +
> +mem_section|(mem_section, NR_SECTION_ROOTS)|(mem_section, section_mem_map)
> +==========================================================================
> +Export the address of 'mem_section' array, and it's length, structure size,
> +and the 'section_mem_map' offset.
> +
> +It exists in the sparse memory mapping model, and it is also somewhat
> +similar to the mem_map variable, both of them will help to translate
> +the address.
> +
> +page
> +====
> +The size of a 'page' structure.
> +
> +pglist_data
> +===========
> +The size of a 'pglist_data' structure.
> +
> +zone
> +====
> +The size of a 'zone' structure.
> +
> +free_area
> +=========
> +The size of a 'free_area' structure.
> +
> +list_head
> +=========
> +The size of a 'list_head' structure.
> +
> +nodemask_t
> +==========
> +The size of a 'nodemask_t' type.
> +
> +(page, flags|_refcount|mapping|lru|_mapcount|private|compound_dtor|
> +       compound_order|compound_head)
> +===================================================================
> +The page structure is a familiar concept for most of linuxer, there is no
> +need to explain too much.

Just delete that sentence.

> To know more information, please refer to the
> +definition of the page struct(include/linux/mm_types.h).
> +
> +(pglist_data, node_zones|nr_zones|node_mem_map|node_start_pfn|node_
> +              spanned_pages|node_id)
> +===================================================================
> +On NUMA machines, each NUMA node would have a pg_data_t to describe

s/would have/has/

> +it's memory layout. On UMA machines there is a single pglist_data which
> +describes the whole memory.
> +
> +The pglist_data structure contains these varibales, here export their
					    ^^^^^^^^^

Before you send next time, run the *whole* text through a spellchecker.

> +offset in the pglist_data structure, which is defined in this file
> +"include/linux/mmzone.h".

You don't have to state where stuff is defined - I hope everyone
should be able to grep.

...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
