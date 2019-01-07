Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74707C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 300A42070C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 09:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfAGJiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 04:38:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40916 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbfAGJiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 04:38:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF41987623;
        Mon,  7 Jan 2019 09:38:53 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-80.pek2.redhat.com [10.72.12.80])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 39E625D9CD;
        Mon,  7 Jan 2019 09:38:42 +0000 (UTC)
Subject: Re: [PATCH 1/2 v5] kdump: add the vmcoreinfo documentation
To:     "Hatayama, Daisuke" <d.hatayama@jp.fujitsu.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "k-hagio@ab.jp.nec.com" <k-hagio@ab.jp.nec.com>,
        "anderson@redhat.com" <anderson@redhat.com>
References: <20190107014734.9730-1-lijiang@redhat.com>
 <20190107014734.9730-2-lijiang@redhat.com>
 <33710E6CAA200E4583255F4FB666C4E21BB8AD64@G01JPEXMBYT03>
From:   lijiang <lijiang@redhat.com>
Message-ID: <1bfb6c42-51c3-aef2-21aa-b0572d6bc35b@redhat.com>
Date:   Mon, 7 Jan 2019 17:38:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <33710E6CAA200E4583255F4FB666C4E21BB8AD64@G01JPEXMBYT03>
Content-Type: text/plain; charset=iso-2022-jp
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 07 Jan 2019 09:38:54 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2019年01月07日 15:55, Hatayama, Daisuke 写道:
> Hi,
> 
>> -----Original Message-----
>> From: linux-kernel-owner@vger.kernel.org
>> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Lianbo Jiang
>> Sent: Monday, January 7, 2019 10:48 AM
>> To: linux-kernel@vger.kernel.org
>> Cc: kexec@lists.infradead.org; tglx@linutronix.de; mingo@redhat.com;
>> bp@alien8.de; x86@kernel.org; akpm@linux-foundation.org; bhe@redhat.com;
>> dyoung@redhat.com; linux-doc@vger.kernel.org; k-hagio@ab.jp.nec.com;
>> anderson@redhat.com
>> Subject: [PATCH 1/2 v5] kdump: add the vmcoreinfo documentation
>>
>> This document lists some variables that export to vmcoreinfo, and briefly
>> describles what these variables indicate. It should be instructive for
>> many people who do not know the vmcoreinfo, and it also normalizes the
> 
> I agree to this part, but
> 
>> exported variables as a convention between kernel and use-space.
> 
> I don't agree to this part.
> 
> The meaning of each symbol is decided by each feature in the kernel,
> not by vmcoreinfo. I suspect anyone mistakenly understand this document is
> ABI enforcing each symbol works as described. We can change symbols and
> their meaning regardless of this document.
> 
> Oh, I found this topic has already been discussed at v3, and
> you removed "ABI" in the patch description at v4.
> 
> But it seems still confusing to me.
> I think the explicit description saying that this is for user-land tools,
> they treats each symbol as described,
> and the document never affect implementation of each kernel components,
> is necessary in e.g. "Purpose of this document" section?
> 

Thanks for your advice.

If this part could make the document become a rope tied around our necks, i would
like to remove this part from the patch log in next post.

Regards,
Lianbo

>>
>> Suggested-by: Borislav Petkov <bp@suse.de>
>> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
>> ---
>>  Documentation/kdump/vmcoreinfo.txt | 500 +++++++++++++++++++++++++++++
>>  1 file changed, 500 insertions(+)
>>  create mode 100644 Documentation/kdump/vmcoreinfo.txt
>>
>> diff --git a/Documentation/kdump/vmcoreinfo.txt
>> b/Documentation/kdump/vmcoreinfo.txt
>> new file mode 100644
>> index 000000000000..8e444586b87b
>> --- /dev/null
>> +++ b/Documentation/kdump/vmcoreinfo.txt
>> @@ -0,0 +1,500 @@
>> +================================================================
>> +			VMCOREINFO
>> +================================================================
>> +
>> +=======================
>> +What is the VMCOREINFO?
>> +=======================
>> +
>> +VMCOREINFO is a special ELF note section. It contains various
>> +information from the kernel like structure size, page size, symbol
>> +values, field offsets, etc. These data are packed into an ELF note
>> +section and used by user-space tools like crash and makedumpfile to
>> +analyze a kernel's memory layout.
>> +
>> +================
>> +Common variables
>> +================
>> +
>> +init_uts_ns.name.release
>> +------------------------
>> +
>> +The version of the Linux kernel. Used to find the corresponding source
>> +code from which the kernel has been built.
>> +
>> +PAGE_SIZE
>> +---------
>> +
>> +The size of a page. It is the smallest unit of data for memory
>> +management in kernel. It is usually 4096 bytes and a page is aligned
>> +on 4096 bytes. Used for computing page addresses.
>> +
>> +init_uts_ns
>> +-----------
>> +
>> +This is the UTS namespace, which is used to isolate two specific
>> +elements of the system that relate to the uname(2) system call. The UTS
>> +namespace is named after the data structure used to store information
>> +returned by the uname(2) system call.
>> +
>> +User-space tools can get the kernel name, host name, kernel release
>> +number, kernel version, architecture name and OS type from it.
>> +
>> +node_online_map
>> +---------------
>> +
>> +An array node_states[N_ONLINE] which represents the set of online node
>> +in a system, one bit position per node number. Used to keep track of
>> +which nodes are in the system and online.
>> +
>> +swapper_pg_dir
>> +-------------
>> +
>> +The global page directory pointer of the kernel. Used to translate
>> +virtual to physical addresses.
>> +
>> +_stext
>> +------
>> +
>> +Defines the beginning of the text section. In general, _stext indicates
>> +the kernel start address. Used to convert a virtual address from the
>> +direct kernel map to a physical address.
>> +
>> +vmap_area_list
>> +--------------
>> +
>> +Stores the virtual area list. makedumpfile can get the vmalloc start
>> +value from this variable. This value is necessary for vmalloc translation.
>> +
>> +mem_map
>> +-------
>> +
>> +Physical addresses are translated to struct pages by treating them as
>> +an index into the mem_map array. Right-shifting a physical address
>> +PAGE_SHIFT bits converts it into a page frame number which is an index
>> +into that mem_map array.
>> +
>> +Used to map an address to the corresponding struct page.
>> +
>> +contig_page_data
>> +----------------
>> +
>> +Makedumpfile can get the pglist_data structure from this symbol, which
>> +is used to describe the memory layout.
>> +
>> +User-space tools use this to exclude free pages when dumping memory.
>> +
>> +mem_section|(mem_section, NR_SECTION_ROOTS)|(mem_section, section_mem_map)
>> +-------------------------------------------------------------------------
>> -
>> +
>> +The address of the mem_section array, its length, structure size, and
>> +the section_mem_map offset.
>> +
>> +It exists in the sparse memory mapping model, and it is also somewhat
>> +similar to the mem_map variable, both of them are used to translate an
>> +address.
>> +
>> +page
>> +----
>> +
>> +The size of a page structure. struct page is an important data structure
>> +and it is widely used to compute the contiguous memory.
>> +
>> +pglist_data
>> +-----------
>> +
>> +The size of a pglist_data structure. This value will be used to check
>> +if the pglist_data structure is valid. It is also used for checking the
>> +memory type.
>> +
>> +zone
>> +----
>> +
>> +The size of a zone structure. This value is often used to check if the
>> +zone structure has been found. It is also used for excluding free pages.
>> +
>> +free_area
>> +---------
>> +
>> +The size of a free_area structure. It indicates whether the free_area
>> +structure is valid or not. Useful for excluding free pages.
>> +
>> +list_head
>> +---------
>> +
>> +The size of a list_head structure. Used when iterating lists in a
>> +post-mortem analysis session.
>> +
>> +nodemask_t
>> +----------
>> +
>> +The size of a nodemask_t type. Used to compute the number of online
>> +nodes.
>> +
>> +(page, flags|_refcount|mapping|lru|_mapcount|private|compound_dtor|
>> +       compound_order|compound_head)
>> +-------------------------------------------------------------------
>> +
>> +User-space tools can compute their values based on the offset of these
>> +variables. The variables are helpful to exclude unnecessary pages.
>> +
>> +(pglist_data, node_zones|nr_zones|node_mem_map|node_start_pfn|node_
>> +              spanned_pages|node_id)
>> +-------------------------------------------------------------------
>> +
>> +On NUMA machines, each NUMA node has a pg_data_t to describe its memory
>> +layout. On UMA machines there is a single pglist_data which describes the
>> +whole memory.
>> +
>> +These values are used to check the memory type, and they are also helpful
>> +to compute the virtual address for memory map.
>> +
>> +(zone, free_area|vm_stat|spanned_pages)
>> +---------------------------------------
>> +
>> +Each node is divided into a number of blocks called zones which
>> +represent ranges within memory. A zone is described by a structure zone.
>> +Each zone type is suitable for a different type of usage.
>> +
>> +User-space tools can compute required values based on the offset of these
>> +variables.
>> +
>> +(free_area, free_list)
>> +----------------------
>> +
>> +Offset of the free_list's member. This value is used to compute the number
>> +of free pages.
>> +
>> +Each zone has a free_area structure array called free_area[MAX_ORDER].
>> +The fields in this structure are simple, the free_list represents a linked
>> +list of free page blocks.
>> +
>> +(list_head, next|prev)
>> +----------------------
>> +
>> +Offsets of the list_head's members. list_head is used to define a
>> +circular linked list. User-space tools need these in order to traverse
>> +lists.
>> +
>> +(vmap_area, va_start|list)
>> +--------------------------
>> +
>> +Offsets of the vmap_area's members. They indicate the vmalloc layer
>> +information. Makedumpfile gets the start address of the vmalloc region.
>> +
>> +(zone.free_area, MAX_ORDER)
>> +---------------------------
>> +
>> +It indicates the maximum number of the array free_area. This macro is
>> +used by the zone buddy allocator. User-space tools use this value to
>> +iterate the free_area.
>> +
>> +log_buf
>> +-------
>> +
>> +Console output is written to the ring buffer log_buf at index
>> +log_first_idx. Used to get the kernel log.
>> +
>> +log_buf_len
>> +-----------
>> +
>> +Length of a log_buf. Used to read the number of strings from the
>> +log_buf.
>> +
>> +log_first_idx
>> +-------------
>> +
>> +Index of the first record stored in the buffer log_buf. Used by
>> +user-space tools to read the strings in the log_buf.
>> +
>> +clear_idx
>> +---------
>> +
>> +The index that the next printk() record to read after the last clear
>> +command. It indicates the first record after the last SYSLOG_ACTION
>> +_CLEAR, like issued by 'dmesg -c'. Used by user-space tools to dump
>> +the dmesg log.
>> +
>> +log_next_idx
>> +------------
>> +
>> +The index of the next record to store in the buffer log_buf. Used to
>> +compute the index of the current string position.
>> +
>> +printk_log
>> +----------
>> +
>> +The size of a structure printk_log. Used to compute the size of
>> +messages, and extract dmesg log. It can output human readable text.
>> +Encapsulate header information for log_buf, such as timestamp, syslog
>> +level, etc.
>> +
>> +(printk_log, ts_nsec|len|text_len|dict_len)
>> +-------------------------------------------
>> +
>> +It represents field offsets in struct printk_log. User space tools can
>> +parse it and check whether the values of printk_log's members have been
>> +changed.
>> +
>> +(free_area.free_list, MIGRATE_TYPES)
>> +------------------------------------
>> +
>> +The number of migrate types for pages. The free_list is divided into
>> +the array, it needs to know the number of the array when makedumpfile
>> +computes the number of free pages.
>> +
>> +NR_FREE_PAGES
>> +-------------
>> +
>> +On linux-2.6.21 or later, the number of free_pages is in
>> +vm_stat[NR_FREE_PAGES]. Used to get the number of free pages.
>> +
>> +PG_lru|PG_private|PG_swapcache|PG_swapbacked|PG_slab|PG_hwpoision
>> +|PG_head_mask|PAGE_BUDDY_MAPCOUNT_VALUE(~PG_buddy)
>> +|PAGE_OFFLINE_MAPCOUNT_VALUE(~PG_offline)
>> +-----------------------------------------------------------------
>> +
>> +Page attributes. These flags are used to filter various unnecessary
>> +pages.
>> +
>> +HUGETLB_PAGE_DTOR
>> +-----------------
>> +
>> +The HUGETLB_PAGE_DTOR flag denotes hugetlbfs pages. Makedumpfile
>> +excludes these pages.
>> +
>> +======
>> +x86_64
>> +======
>> +
>> +phys_base
>> +---------
>> +
>> +Used to convert the virtual address of an exported kernel symbol to its
>> +physical address.
>> +
>> +init_top_pgt
>> +------------
>> +
>> +Used to walk through the whole page table and convert virtual addresses
>> +to physical addresses. The init_top_pgt is somewhat similar to the
>> +swapper_pg_dir, but it is only used in x86_64.
>> +
>> +pgtable_l5_enabled
>> +------------------
>> +
>> +User-space tools need to know whether the crash kernel was in 5-level
>> +paging mode.
>> +
>> +node_data
>> +---------
>> +
>> +This is a struct pglist_data array and stores all numa nodes
>> +information. Makedumpfile gets the pglist_data structure from it.
>> +
>> +(node_data, MAX_NUMNODES)
>> +-------------------------
>> +
>> +The maximum number of the nodes in system.
>> +
>> +KERNELOFFSET
>> +------------
>> +
>> +The kernel randomization offset. Used to compute the page offset. If
>> +KASLR is disabled, this value is zero.
>> +
>> +KERNEL_IMAGE_SIZE
>> +-----------------
>> +
>> +Currently unused by Makedumpfile. Used to compute the module virtual
>> +address by Crash.
>> +
>> +sme_mask
>> +--------
>> +
>> +For AMD machine with SME feature, it indicates the secure memory
>> +encryption mask. Makedumpfile tools need to know whether the crash
>> +kernel was encrypted. If SME is enabled in the first kernel, the crash
>> +kernel's page table (pgd/pud/pmd/pte) contains the memory encryption
>> +mask and this is used to remove the SME mask to obtain the true physical
>> +address.
>> +
>> +Currently, the sme_mask stores the value of sme_me_mask(bit 47). If need,
>> +the bit(sme_mask) might be redefined in the future, but the bit 63 will
>> +be reserved.
>> +
>> +For example:
>> +[ misc	        ][ enc bit  ][ other misc SME info       ]
>> +0000_0000_0000_0000_1000_0000_0000_0000_0000_0000_..._0000
>> +63   59   55   51   47   43   39   35   31   27   ... 3
>> +
>> +======
>> +x86_32
>> +======
>> +
>> +X86_PAE
>> +-------
>> +
>> +Denotes whether physical address extensions are enabled. It has the cost
>> +of more page table lookup overhead, and also consumes more page table
>> +space per process. Used to check whether PAE was enabled in the crash
>> +kernel when converting virtual addresses to physical addresses.
>> +
>> +====
>> +ia64
>> +====
>> +
>> +pgdat_list|(pgdat_list, MAX_NUMNODES)
>> +-------------------------------------
>> +
>> +pg_data_t array storing all numa nodes information. MAX_NUMNODES
>> +indicates the number of the nodes.
>> +
>> +node_memblk|(node_memblk, NR_NODE_MEMBLKS)
>> +------------------------------------------
>> +
>> +List of node memory chunks. Filled when parsing SRAT table to obtain
>> +information about memory nodes. NR_NODE_MEMBLKS indicates the number
>> +of node memory chunks.
>> +
>> +These values are used to compute the number of nodes in the crash kernel.
>> +
>> +node_memblk_s|(node_memblk_s, start_paddr)|(node_memblk_s, size)
>> +----------------------------------------------------------------
>> +
>> +The size of a struct node_memblk_s and the offsets of the
>> +node_memblk_s's members. Used to compute the number of nodes.
>> +
>> +PGTABLE_3|PGTABLE_4
>> +-------------------
>> +
>> +User-space tools need to know whether the crash kernel was in 3-level or
>> +4-level paging mode. Used to distinguish the page table.
>> +
>> +=====
>> +ARM64
>> +=====
>> +
>> +VA_BITS
>> +-------
>> +
>> +The maximum number of bits for virtual addresses. Used to compute the
>> +virtual memory ranges.
>> +
>> +kimage_voffset
>> +--------------
>> +
>> +The offset between the kernel virtual and physical mappings. Used to
>> +translate virtual to physical addresses.
>> +
>> +PHYS_OFFSET
>> +-----------
>> +
>> +Indicates the physical address of the start of memory. Similar to
>> +kimage_voffset, which is used to translate virtual address to physical
>> +address.
>> +
>> +KERNELOFFSET
>> +------------
>> +
>> +The kernel randomization offset. Used to compute the page offset. If
>> +KASLR is disabled, this value is zero.
>> +
>> +====
>> +arm
>> +====
>> +
>> +ARM_LPAE
>> +--------
>> +
>> +It indicates whether the crash kernel supports large physical address
>> +extensions. Used to translate virtual address to physical address.
>> +
>> +====
>> +s390
>> +====
>> +
>> +lowcore_ptr
>> +----------
>> +
>> +An array with a pointer to the lowcore of every CPU. Used to print the
>> +psw and all registers information.
>> +
>> +high_memory
>> +-----------
>> +
>> +Used to get the vmalloc_start address from the high_memory symbol.
>> +
>> +(lowcore_ptr, NR_CPUS)
>> +----------------------
>> +
>> +The maximum number of CPUs.
>> +
>> +=======
>> +powerpc
>> +=======
>> +
>> +
>> +node_data|(node_data, MAX_NUMNODES)
>> +-----------------------------------
>> +
>> +See above.
>> +
>> +contig_page_data
>> +----------------
>> +
>> +See above.
>> +
>> +vmemmap_list
>> +------------
>> +
>> +The vmemmap_list maintains the entire vmemmap physical mapping. It can
>> +get vmemmap list count and populate vmemmap regions info. If the vmemmap
>> +address translation information is stored in the crash kernel, it helps
>> +to translate vmemmap kernel virtual addresses.
>> +
>> +mmu_vmemmap_psize
>> +-----------------
>> +
>> +The size of a page. Used to translate address to physical addresses.
>> +
>> +mmu_psize_defs
>> +--------------
>> +
>> +Page size definitions, i.e. 4k, 64k, or 16M.
>> +
>> +Used to make vtop translations.
>> +
>> +vmemmap_backing|(vmemmap_backing, list)|(vmemmap_backing, phys)|
>> +(vmemmap_backing, virt_addr)
>> +----------------------------------------------------------------
>> +
>> +The vmemmap virtual address space management does not have a traditional
>> +page table to track which virtual struct pages are backed by physical
>> +mapping. The virtual to physical mappings are tracked in a simple linked
>> +list format.
>> +
>> +User-space tools need to know the offset of list, phys and virt_addr
>> +when computing the count of vmemmap regions.
>> +
>> +mmu_psize_def|(mmu_psize_def, shift)
>> +------------------------------------
>> +
>> +The size of a struct mmu_psize_def and the offset of mmu_psize_def's
>> +member.
>> +
>> +Used in vtop translations.
>> +
>> +==
>> +sh
>> +==
>> +
>> +node_data|(node_data, MAX_NUMNODES)
>> +-----------------------------------
>> +
>> +See above.
>> +
>> +X2TLB
>> +-----
>> +
>> +Indicates whether the crash kernel enables SH extended mode.
>> --
>> 2.17.1
>>
> 
> 
