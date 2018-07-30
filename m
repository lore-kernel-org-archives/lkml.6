Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE25C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:42:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECBA420892
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 23:42:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="bf22JaQC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECBA420892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dabbelt.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbeGaBUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 21:20:14 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43089 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729477AbeGaBUO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 21:20:14 -0400
Received: by mail-pl0-f67.google.com with SMTP id x6-v6so6251038plv.10
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 16:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id;
        bh=aYXEB0Q6GjawXwfU0EWVFKzxEEZgLC9Qu6FvFzWiEb0=;
        b=bf22JaQCvMDPDbBxufcBs+Lv1XbikPL1ia3aVgL/I/nz4d/OTkXaKEY74uYfsCn3TV
         trXyfWsCBOk4UfWyI3zwhHTe5+1ZxUgie4MOci6uTfB8D1hA5pqgXBdD1JUkp8nb8C53
         YVqWwvE9QjQfXWIfvCWhONmfUf65CKGZGb2yAmzsIbR8ob6Og7Ju+8959uok4sFGF0D3
         u6dJtIjjF/aCjOr46CbANfNQOB5BB42xGxLFQ5yLQ3SAk7iq0RzXOX+9fXaGmGqrf1dx
         /GwkxbIvlAxDwusXpLryo8vkR8dOYDDWOFWlydVBkz6PHYevugk1DKSFBxY9nPczdfOS
         qn5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id;
        bh=aYXEB0Q6GjawXwfU0EWVFKzxEEZgLC9Qu6FvFzWiEb0=;
        b=qID7Far70UgdQEIyLxmcafOxi6TVWn5BKhf9bNtOQFZ9Ml7uSQt+8gUytrQlXGiMli
         KEfMTBzW55IL6+DJB0vfx3OqPdPNfpedvAbKREQNruJxMBTj7rOyod7zIbYdQet65kAm
         bUAQnpZMx44li64XtTVOxjQN5KKs2i5HeJM9AqXKy2YJCCV0qR3iJT+rol+yQSWYyee/
         mvbwh/PXQK0XdxIF9sdxTDFfxV6N/BAkIMTgBezuN/NzTxEq5hrNDVR0REmy4dJZ5U+1
         nwL6FyEXazZ6plw0KGCCfAAFoCavdp309gBnpOmHkR633s3e0k9p6X8pyJBLbrOswUHJ
         AHSA==
X-Gm-Message-State: AOUpUlHeiSokMFKePZbea3NkauNt2Qo3G7HQwKQ+9wV2o2y07UoeL6pi
        DrWK0OYHM9FkJb9XUmx3vH1ntw==
X-Google-Smtp-Source: AAOMgpcjrdT61EhZrBdE1CNrbKIqgC90+z/BXnvYrMLKjceHJ4eXWXFXD7Ml4mVnxiJ+Ncjm53CQow==
X-Received: by 2002:a17:902:6b:: with SMTP id 98-v6mr6357596pla.68.1532994170976;
        Mon, 30 Jul 2018 16:42:50 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id i28-v6sm21807572pfk.108.2018.07.30.16.42.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Jul 2018 16:42:49 -0700 (PDT)
Date:   Mon, 30 Jul 2018 16:42:49 -0700 (PDT)
X-Google-Original-Date: Mon, 30 Jul 2018 16:42:09 PDT (-0700)
Subject:     Re: [PATCH v9 04/12] RISC-V: Init and Halt Code
In-Reply-To: <20171005110111.GB4929@leverpostej>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, linux-kernel@vger.kernel.org,
        patches@groups.riscv.org, robh+dt@kernel.org, albert@sifive.com,
        yamada.masahiro@socionext.com, mmarek@suse.com,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, oleg@redhat.com, mingo@redhat.com,
        devicetree@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     mark.rutland@arm.com, linux-riscv@lists.infradead.org
Message-ID: <mhng-266f17e0-1151-4136-9627-9e0e8d242e4c@palmer-si-x1c4>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry it took me an absurd amount of time to get back around to this...  I'm 
adding our mailing list, as we didn't even have one a year ago.

I've included a few patches in line here, but they're just drafts.  I'll test
them and submit them properly.

On Thu, 05 Oct 2017 04:01:12 PDT (-0700), mark.rutland@arm.com wrote:
> On Tue, Sep 26, 2017 at 06:56:30PM -0700, Palmer Dabbelt wrote:
>> +/*
>> + * This is particularly ugly: it appears we can't actually get the definition
>> + * of task_struct here, but we need access to the CPU this task is running on.
>> + * Instead of using C we're using asm-offsets.h to get the current processor
>> + * ID.
>> + */
>> +#define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
>
> Are you using CONFIG_THREAD_INFO_IN_TASK?
>
> I assume so, becauase 'TI' usually stands for thread_info.
>
> So if you can include your <asm/thread_info.h> here, I think you can do
> something like:
>
> #define get_ti()		((struct thread_info *)get_current())
> #define raw_smp_processor_id()	(get_ti()->cpu)

Thanks.  I'm not sure how I didn't manage to figure that out, but it appears to
work.

    commit d999f1419829c708462dacbfe8d62a795ba6cecc
    gpg: Signature made Tue 24 Jul 2018 04:12:45 PM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Tue Jul 24 16:11:54 2018 -0700

        RISC-V: Provide a cleaner raw_smp_processor_id()

        I'm not sure how I managed to miss this the first time, but this is much
        better.

        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

    diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
    index 85e4220839b0..f6a1df5c8df8 100644
    --- a/arch/riscv/include/asm/smp.h
    +++ b/arch/riscv/include/asm/smp.h
    @@ -14,11 +14,6 @@
     #ifndef _ASM_RISCV_SMP_H
     #define _ASM_RISCV_SMP_H

    -/* This both needs asm-offsets.h and is used when generating it. */
    -#ifndef GENERATING_ASM_OFFSETS
    -#include <asm/asm-offsets.h>
    -#endif
    -
     #include <linux/cpumask.h>
     #include <linux/irqreturn.h>

    @@ -36,13 +31,12 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
     /* Hook for the generic smp_call_function_single() routine. */
     void arch_send_call_function_single_ipi(int cpu);

    -/*
    - * This is particularly ugly: it appears we can't actually get the definition
    - * of task_struct here, but we need access to the CPU this task is running on.
    - * Instead of using C we're using asm-offsets.h to get the current processor
    - * ID.
    - */
    -#define raw_smp_processor_id() (*((int*)((char*)get_current() + TASK_TI_CPU)))
    +/* Obtains the hart ID of the currently executing task.  This relies on
    + * THREAD_INFO_IN_TASK, but we define that unconditionally. */
    +#ifdef CONFIG_THREAD_INFO_IN_TASK
    +#define get_ti()                ((struct thread_info *)get_current())
    +#define raw_smp_processor_id()  (get_ti()->cpu)
    +#endif

     /* Interprocessor interrupt handler */
     irqreturn_t handle_ipi(void);

>> +static void ci_leaf_init(struct cacheinfo *this_leaf,
>> +			 struct device_node *node,
>> +			 enum cache_type type, unsigned int level)
>> +{
>> +	this_leaf->of_node = node;
>> +	this_leaf->level = level;
>> +	this_leaf->type = type;
>> +	/* not a sector cache */
>> +	this_leaf->physical_line_partition = 1;
>> +	/* TODO: Add to DTS */
>> +	this_leaf->attributes =
>> +		CACHE_WRITE_BACK
>> +		| CACHE_READ_ALLOCATE
>> +		| CACHE_WRITE_ALLOCATE;
>> +}
>
> In practice, it's very hard to remove implicit assumptions later down
> the line, so I'd recommend you add this to your DT from the outset.

Are these actually used by anything?  I poked around the kernel and it appears 
that pretty much all they do is get printed in drivers/base/cacheinfo.c.  It 
looks like we're only filling out half the info in there anyway so it feels 
like we'd be better off just deleting these and waiting until we have a proper 
scheme before setting anything.

>> +/* Return -1 if not a valid hart */
>> +int riscv_of_processor_hart(struct device_node *node)
>
> Perhaps s/hart/hart_id/ for the function name? Otherwise, it's not
> immediately obvious what it is doing.

Makes sense.  I've gone and added a comment as well:

    commit c1547731897ca4cb683fbb3bf26dd243a9ed6486
    gpg: Signature made Wed 25 Jul 2018 02:36:07 PM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Wed Jul 25 14:31:57 2018 -0700
    
        RISC-V: Rename riscv_of_processor_hart to riscv_of_processor_hartid
    
        It's a bit confusing exactly what this function does: it actually
        returns the hartid of an OF processor node, failing with -1 on invalid
        nodes.
    
        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
    
    diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
    index 3fe4af8147d2..9d32670d84a4 100644
    --- a/arch/riscv/include/asm/processor.h
    +++ b/arch/riscv/include/asm/processor.h
    @@ -88,7 +88,9 @@ static inline void wait_for_interrupt(void)
     }
    
     struct device_node;
    -extern int riscv_of_processor_hart(struct device_node *node);
    +/* Returns the hart ID of the given device tree node, or -1 if the device tree
    + * node isn't a RISC-V hart. */
    +extern int riscv_of_processor_hartid(struct device_node *node);
    
     extern void riscv_fill_hwcap(void);
    
    diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
    index ca6c81e54e37..19e98c1710dd 100644
    --- a/arch/riscv/kernel/cpu.c
    +++ b/arch/riscv/kernel/cpu.c
    @@ -16,7 +16,7 @@
     #include <linux/of.h>
    
     /* Return -1 if not a valid hart */
    -int riscv_of_processor_hart(struct device_node *node)
    +int riscv_of_processor_hartid(struct device_node *node)
     {
     	const char *isa, *status;
     	u32 hart;
    diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
    index f741458c5a3f..e08efc60726c 100644
    --- a/arch/riscv/kernel/smpboot.c
    +++ b/arch/riscv/kernel/smpboot.c
    @@ -53,7 +53,7 @@ void __init setup_smp(void)
     	int hart, im_okay_therefore_i_am = 0;
    
     	while ((dn = of_find_node_by_type(dn, "cpu"))) {
    -		hart = riscv_of_processor_hart(dn);
    +		hart = riscv_of_processor_hartid(dn);
     		if (hart >= 0) {
     			set_cpu_possible(hart, true);
     			set_cpu_present(hart, true);

>> +{
>> +	const char *isa, *status;
>> +	u32 hart;
>> +
>> +	if (!of_device_is_compatible(node, "riscv")) {
>> +		pr_warn("Found incompatible CPU\n");
>> +		return -(ENODEV);
>> +	}
>> +
>> +	if (of_property_read_u32(node, "reg", &hart)) {
>> +		pr_warn("Found CPU without hart ID\n");
>> +		return -(ENODEV);
>> +	}
>> +	if (hart >= NR_CPUS) {
>> +		pr_info("Found hart ID %d, which is above NR_CPUs.  Disabling this hart\n", hart);
>> +		return -(ENODEV);
>> +	}
>
> Here you assume that the hard ID is equalt to the Linux logical ID.
>
> I'd recommend that (as other architectures do), you decouple the two.
>
> That's going to be necessary for things like kdump to work, as the kdump
> kernel will run on (Linux logical) CPU0, but may have been executed from
> any secondary CPU.

This is a good point.  We currently have another headache with CPU numbering on
some systems where the machine CPU ID of 0 actually isn't a Linux CPU (ie, it
doesn't have virtual memory) and we're handling the remapping in the
bootloader.  That's a bit convoluted, so it might be easier to handle the
remapping in Linux.

>> +
>> +	if (of_property_read_string(node, "status", &status)) {
>> +		pr_warn("CPU with hartid=%d has no \"status\" property\n", hart);
>> +		return -(ENODEV);
>> +	}
>> +	if (strcmp(status, "okay")) {
>> +		pr_info("CPU with hartid=%d has a non-okay status of \"%s\"\n", hart, status);
>> +		return -(ENODEV);
>> +	}
>
> Please use of_device_is_available().
>
>> +
>> +	if (of_property_read_string(node, "riscv,isa", &isa)) {
>> +		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
>> +		return -(ENODEV);
>> +	}
>> +	if (isa[0] != 'r' || isa[1] != 'v') {
>> +		pr_warn("CPU with hartid=%d has an invalid ISA of \"%s\"\n", hart, isa);
>> +		return -(ENODEV);
>> +	}
>
> As mentioned on the binding patch, I'd recommend that you use a set of
> discrete flags.

RISC-V defines what the ISA string means, and it's got all sorts of mechanism
for extensibility already defined.  I'm trying to avoid inventing any other
encodings of this as they're just going to be incompatible in some subtle way.

> [...]
>
>> +static int c_show(struct seq_file *m, void *v)
>> +{
>> +	unsigned long hart_id = (unsigned long)v - 1;
>> +	struct device_node *node = of_get_cpu_node(hart_id, NULL);
>> +	const char *compat, *isa, *mmu;
>> +
>> +	seq_printf(m, "hart\t: %lu\n", hart_id);
>> +	if (!of_property_read_string(node, "riscv,isa", &isa)
>> +	    && isa[0] == 'r'
>> +	    && isa[1] == 'v')
>> +		seq_printf(m, "isa\t: %s\n", isa);
>> +	if (!of_property_read_string(node, "mmu-type", &mmu)
>> +	    && !strncmp(mmu, "riscv,", 6))
>> +		seq_printf(m, "mmu\t: %s\n", mmu+6);
>> +	if (!of_property_read_string(node, "compatible", &compat)
>> +	    && strcmp(compat, "riscv"))
>> +		seq_printf(m, "uarch\t: %s\n", compat);
>> +	seq_puts(m, "\n");
>
> I'd *very strongly* recommend that you don't pass the DT values straight
> through to userspace.
>
> Otherwise, things like riscv,isa = "rvtypo'd\nsomething" get exposed,
> and inevitably, some subset of userspace ends up relying upon it, while
> others break based upon it.
>
> Further, specifically for the ISA parts, this is a very bad idea. If
> some ISA extensions require kernel support (e.g. to context switch
> state, or disable some configurable traps), they cannot work without
> kernel support. Generally, the wayt to handle this is for the kernel to
> detect the features at boot time, and save these in hwcaps.
>
> Later, the hwcaps can be used to generate /proc/cpunifo output, and are
> also exposed via auxv, which avoids applications and libraries having to
> parse /proc/cpuinfo just to determine whether they have a particular
> feature, which doesn't work in many situations (e.g. early boot where
> /proc may not be mounted).
>
> Take a look at arm64's hwcaps for an example of how to use hwcaps.

Yes, that's a very good point.  We actually have an implementation of hwcaps
(that's exposed via the aux vector) that's cropped up in the mean time, and
while the right thing to do is probably to generate cpuinfo from that I do at
least have a simple patch that allows us to avoid passing garbage to userspace:

    commit 6dbfebe5b2ddd873283abf625556b99f98cc85f2
    gpg: Signature made Fri 27 Jul 2018 10:40:02 AM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Fri Jul 27 09:57:29 2018 -0700

        RISC-V: Filter ISA and MMU values in cpuinfo

        We shouldn't be directly passing device tree values to userspace, both
        because there could be mistakes in device trees and because the kernel
        doesn't support arbitrary ISAs.

        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

    diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
    index 19e98c1710dd..a18b4e3962a1 100644
    --- a/arch/riscv/kernel/cpu.c
    +++ b/arch/riscv/kernel/cpu.c
    @@ -58,6 +58,57 @@ int riscv_of_processor_hartid(struct device_node *node)

     #ifdef CONFIG_PROC_FS

    +static void print_isa(struct seq_file *f, const char *orig_isa)
    +{
    +    static const char *ext = "mafdc";
    +    const char *isa = orig_isa;
    +    const char *e;
    +
    +    /* Linux doesn't support rv32e or rv128i, and we only support booting
    +     * kernels on harts with the same ISA that the kernel is compiled for. */
    +#if defined(CONFIG_32BIT)
    +    if (strncmp(isa, "rv32i", 5) != 0)
    +        return;
    +#elif defined(CONFIG_64BIT)
    +    if (strncmp(isa, "rv64i", 5) != 0)
    +        return;
    +#endif
    +
    +    /* Print the base ISA, as we already know it's legal. */
    +    seq_printf(f, "isa\t: ");
    +    seq_write(f, isa, 5);
    +    isa += 5;
    +
    +    /* Check the rest of the ISA string for valid extensions, printing those we
    +     * find.  RISC-V ISA strings define an order, so we only print the
    +     * extension bits when they're in order. */
    +    for (e = ext; *e != '\0'; ++e) {
    +        if (isa[0] == e[0]) {
    +            seq_write(f, isa, 1);
    +            isa++;
    +        }
    +    }
    +
    +    /* If we were given an unsupported ISA in the device tree then print a bit
    +     * of info describing what went wrong. */
    +    if (isa[0] != '\0')
    +        pr_info("unsupported ISA \"%s\" in device tree", orig_isa);
    +}
    +
    +static void print_mmu(struct seq_file *f, const char *mmu_type)
    +{
    +#if defined(CONFIG_32BIT)
    +    if (strcmp(mmu_type, "riscv,sv32") != 0)
    +        return;
    +#elif defined(CONFIG_64BIT)
    +    if ((strcmp(mmu_type, "riscv,sv39") != 0)
    +        && (strcmp(mmu_type, "riscv,sv48") != 0))
    +        return;
    +#endif
    +
    +    seq_printf(f, "mmu\t: %s\n", mmu_type+6);
    +}
    +
     static void *c_start(struct seq_file *m, loff_t *pos)
     {
     	*pos = cpumask_next(*pos - 1, cpu_online_mask);
    @@ -83,13 +134,10 @@ static int c_show(struct seq_file *m, void *v)
     	const char *compat, *isa, *mmu;

     	seq_printf(m, "hart\t: %lu\n", hart_id);
    -	if (!of_property_read_string(node, "riscv,isa", &isa)
    -	    && isa[0] == 'r'
    -	    && isa[1] == 'v')
    -		seq_printf(m, "isa\t: %s\n", isa);
    -	if (!of_property_read_string(node, "mmu-type", &mmu)
    -	    && !strncmp(mmu, "riscv,", 6))
    -		seq_printf(m, "mmu\t: %s\n", mmu+6);
    +	if (!of_property_read_string(node, "riscv,isa", &isa))
    +        print_isa(m, isa);
    +	if (!of_property_read_string(node, "mmu-type", &mmu))
    +        print_mmu(m, mmu);
     	if (!of_property_read_string(node, "compatible", &compat)
     	    && strcmp(compat, "riscv"))
     		seq_printf(m, "uarch\t: %s\n", compat);

> [...]
>
> I deleted the context from my draft, but I didn't spot a header sta the
> start of your head.S. I would very strongly recommend that you have a
> header with magic, image size (including unpopulated BSS), and other
> room for expansion, so that bootloaders can figure out how to load your
> kernel correctly.
>
> [...]
>
>> +ENTRY(_start)
>> +	/* Mask all interrupts */
>> +	csrw sie, zero
>> +
>> +	/* Load the global pointer */
>> +.option push
>> +.option norelax
>> +	la gp, __global_pointer$
>> +.option pop
>> +
>> +	/*
>> +	 * Disable FPU to detect illegal usage of
>> +	 * floating point in kernel space
>> +	 */
>> +	li t0, SR_FS
>> +	csrc sstatus, t0
>> +
>> +	/* Pick one hart to run the main boot sequence */
>> +	la a3, hart_lottery
>> +	li a2, 1
>> +	amoadd.w a3, a2, (a3)
>> +	bnez a3, .Lsecondary_start
>
> I would *very strongly* recommend that you do not throw all CPUs into
> the kernel at the start of time, and instead have a mechanism where you
> can bring CPUs into the kernel individually.
>
> While it's simple, it comes with a number of long term problems (e.g.
> for kexec/kdump), some of which are unsolvable (e.g. as you cannot know
> how many CPUs are stuck in the kernel text, which haven't been brought
> online).
>
> If you want a simple SMP bringup mechanism, ePAPR's spin-table (and
> arm64's different-but-identically-named spin-table) are good starting
> points. Just make sure you require each CPU is brought online
> individually. We didn't do that for arm64 from day one, and it still
> prevents us from making improvements that we'd like to, years later.
>
> Doing that will also simplify decoupling the HART IDs from linux logical
> IDs, necessary for kdump/kexec, etc.

Defining a proper platform specification is something we've been punting on for
too long.  It's nominally on my plate, but I'm a bit behind right now.  We've
been able to get away without one because we don't have real bootloaders yet,
but it's really time to get started working on this so we don't end up in a bad
situation where we have production hardware out there that is capable of
running Linux but is stuck with pre-specification firmware.

> [...]
>
>> +/*
>> + * Allow the user to manually add a memory region (in case DTS is broken);
>> + * "mem_end=nn[KkMmGg]"
>> + */
>
> This doesn't have a start, so it can't work for discontiguous memory
> blocks (e.g. if FW has reserved/carved-out a chunk in the middle).
>
> Other architectures have "mem=" which would allow you to specify a
> region. I'd generally recommend you provide an incentive to fix dts,
> however.

Thanks, we've already removed this.

>> +void __init setup_arch(char **cmdline_p)
>> +{
>> +#if defined(CONFIG_HVC_RISCV_SBI)
>> +	if (likely(early_console == NULL)) {
>> +		early_console = &riscv_sbi_early_console_dev;
>> +		register_console(early_console);
>> +	}
>> +#endif
>
> This would be better driven by the DT or command line. Otherwise, this
> may come back to bite you in future, as you have to come up with a new
> mechanism to describe absence of the console, rather than using an
> exsiting mechanism to describe its presence.

That makes sense.  I think we'll have to roll this into a platform discussion.

> [...]
>
>> +void __init smp_prepare_cpus(unsigned int max_cpus)
>> +{
>> +}
>> +
>> +void __init setup_smp(void)
>> +{
>> +	struct device_node *dn = NULL;
>> +	int hart, im_okay_therefore_i_am = 0;
>> +
>> +	while ((dn = of_find_node_by_type(dn, "cpu"))) {
>> +		hart = riscv_of_processor_hart(dn);
>> +		if (hart >= 0) {
>> +			set_cpu_possible(hart, true);
>> +			set_cpu_present(hart, true);
>> +			if (hart == smp_processor_id()) {
>> +				BUG_ON(im_okay_therefore_i_am);
>> +				im_okay_therefore_i_am = 1;
>> +			}
>> +		}
>> +	}
>> +
>> +	BUG_ON(!im_okay_therefore_i_am);
>> +}
>
> That name is somewhat opaque. Perhaps bool found_boot_cpu?

Makes sense -- the name was odd but I couldn't think of anything better to
change it to.

    commit 21c4ed85816420ff8641bfdceaf239cafd415faf
    gpg: Signature made Fri 27 Jul 2018 03:09:44 PM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Fri Jul 27 15:09:23 2018 -0700

        RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu

        The old name was a bit odd.

        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

    diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
    index e08efc60726c..4f18ca5050bc 100644
    --- a/arch/riscv/kernel/smpboot.c
    +++ b/arch/riscv/kernel/smpboot.c
    @@ -50,7 +50,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
     void __init setup_smp(void)
     {
     	struct device_node *dn = NULL;
    -	int hart, im_okay_therefore_i_am = 0;
    +	int hart, found_boot_cpu = 0;

     	while ((dn = of_find_node_by_type(dn, "cpu"))) {
     		hart = riscv_of_processor_hartid(dn);
    @@ -58,13 +58,13 @@ void __init setup_smp(void)
     			set_cpu_possible(hart, true);
     			set_cpu_present(hart, true);
     			if (hart == smp_processor_id()) {
    -				BUG_ON(im_okay_therefore_i_am);
    -				im_okay_therefore_i_am = 1;
    +				BUG_ON(found_boot_cpu);
    +				found_boot_cpu = 1;
     			}
     		}
     	}

    -	BUG_ON(!im_okay_therefore_i_am);
    +	BUG_ON(!found_boot_cpu);
     }

     int __cpu_up(unsigned int cpu, struct task_struct *tidle)

>> +
>> +int __cpu_up(unsigned int cpu, struct task_struct *tidle)
>> +{
>> +	tidle->thread_info.cpu = cpu;
>> +
>> +	/*
>> +	 * On RISC-V systems, all harts boot on their own accord.  Our _start
>> +	 * selects the first hart to boot the kernel and causes the remainder
>> +	 * of the harts to spin in a loop waiting for their stack pointer to be
>> +	 * setup by that main hart.  Writing __cpu_up_stack_pointer signals to
>> +	 * the spinning harts that they can continue the boot process.
>> +	 */
>> +	smp_mb();
>> +	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
>> +	__cpu_up_task_pointer[cpu] = tidle;
>
> Shouldn't these be WRITE_ONCE() (or some atomic) to avoid tearing?
>
> How are the secondaries reading these? Is there any requirement on the
> order these become visible?

They just need to be WRITE_ONCE, the secondary harts spin until both of these
are non-zero so it's not necessary to have any ordering here.  Thanks for
pointing this out, though, as this would have been an afwul bug to track down :)

    commit 21c4ed85816420ff8641bfdceaf239cafd415faf
    gpg: Signature made Fri 27 Jul 2018 03:09:44 PM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Fri Jul 27 15:09:23 2018 -0700

        RISC-V: Rename im_okay_therefore_i_am to found_boot_cpu

        The old name was a bit odd.

        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

    diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
    index e08efc60726c..4f18ca5050bc 100644
    --- a/arch/riscv/kernel/smpboot.c
    +++ b/arch/riscv/kernel/smpboot.c
    @@ -50,7 +50,7 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
     void __init setup_smp(void)
     {
     	struct device_node *dn = NULL;
    -	int hart, im_okay_therefore_i_am = 0;
    +	int hart, found_boot_cpu = 0;

     	while ((dn = of_find_node_by_type(dn, "cpu"))) {
     		hart = riscv_of_processor_hartid(dn);
    @@ -58,13 +58,13 @@ void __init setup_smp(void)
     			set_cpu_possible(hart, true);
     			set_cpu_present(hart, true);
     			if (hart == smp_processor_id()) {
    -				BUG_ON(im_okay_therefore_i_am);
    -				im_okay_therefore_i_am = 1;
    +				BUG_ON(found_boot_cpu);
    +				found_boot_cpu = 1;
     			}
     		}
     	}

    -	BUG_ON(!im_okay_therefore_i_am);
    +	BUG_ON(!found_boot_cpu);
     }

     int __cpu_up(unsigned int cpu, struct task_struct *tidle)

> [...]
>
>> +/*
>> + * C entry point for a secondary processor.
>> + */
>> +asmlinkage void __init smp_callin(void)
>> +{
>> +	struct mm_struct *mm = &init_mm;
>> +
>> +	/* All kernel threads share the same mm context.  */
>> +	atomic_inc(&mm->mm_count);
>
> I beleive this should be:
>
> 	mmgrab(mm);
>
> See commit f1f1007644ffc805 ("mm: add new mmgrab() helper")

Thanks!

    commit 120b58060bbd67d893552d89b18ebbc7fea66ea9
    gpg: Signature made Fri 27 Jul 2018 03:19:16 PM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Fri Jul 27 15:16:35 2018 -0700

        RISC-V: Use mmgrab()

        f1f1007644ff ("mm: add new mmgrab() helper") added a helper that we
        missed out on.

        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

    diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
    index 4f18ca5050bc..57552fa3892b 100644
    --- a/arch/riscv/kernel/smpboot.c
    +++ b/arch/riscv/kernel/smpboot.c
    @@ -79,8 +79,8 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
     	 * the spinning harts that they can continue the boot process.
     	 */
     	smp_mb();
    -	__cpu_up_stack_pointer[cpu] = task_stack_page(tidle) + THREAD_SIZE;
    -	__cpu_up_task_pointer[cpu] = tidle;
    +	WRITE_ONCE(__cpu_up_stack_pointer[cpu], task_stack_page(tidle) + THREAD_SIZE);
    +	WRITE_ONCE(__cpu_up_task_pointer[cpu], tidle);

     	while (!cpu_online(cpu))
     		cpu_relax();
    @@ -100,7 +100,7 @@ asmlinkage void __init smp_callin(void)
     	struct mm_struct *mm = &init_mm;

     	/* All kernel threads share the same mm context.  */
    -	atomic_inc(&mm->mm_count);
    +   mm_grab(mm);
     	current->active_mm = mm;

     	trap_init();

>> +	current->active_mm = mm;
>> +
>> +	trap_init();
>> +	init_clockevent();
>> +	notify_cpu_starting(smp_processor_id());
>> +	set_cpu_online(smp_processor_id(), 1);
>> +	local_flush_tlb_all();
>
> Why do you need a TLB flush here?

On RISC-V systems there is a mask that specifies which CPUs to target with
remote TLB flushes.  If the CPU is offline then it will not be included as part
of the mask bits set for global TLB flushes, so they're essentially ignored.
Thus we do a local flush here in case any other flushes were ignored.

    commit ab8e24dede6b8555cb89c5b948bcb8bff7037ad3
    gpg: Signature made Mon 30 Jul 2018 11:33:58 AM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Mon Jul 30 11:33:21 2018 -0700

        RISC-V: Comment on the TLB flush in smp_callin()

        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

    diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
    index 9d56f23952a7..b06af8cedf64 100644
    --- a/arch/riscv/kernel/smpboot.c
    +++ b/arch/riscv/kernel/smpboot.c
    @@ -107,6 +107,8 @@ asmlinkage void __init smp_callin(void)
     	init_clockevent();
     	notify_cpu_starting(smp_processor_id());
     	set_cpu_online(smp_processor_id(), 1);
    +	/* Remote TLB flushes are ignored while the CPU is offline, so emit a local
    +	 * TLB flush right now just in case. */
     	local_flush_tlb_all();
     	local_irq_enable();
     	preempt_disable();

>> +	local_irq_enable();
>> +	preempt_disable();
>
> I believe these two should be the other way around, if the
> preempt_disable() is necessary.

I'm honestly not sure here, all this early boot stuff is a bit of a mystery to
me.  I seem some architectures having (arm and arm64) having preempt_disable() first,
some others (alpha) having local_irq_enable() first.  Logically it makes sense
to me that preemption should be disabled before enabling interrupts, as
otherwise you could take an interrupt in the middle and get the scheduler all
confused.

    commit b60a66c94f7ec1982b5dd12f2c2e2a352574992d
    gpg: Signature made Mon 30 Jul 2018 03:20:39 PM PDT
    gpg:                using RSA key 00CE76D1834960DFCE886DF8EF4CA1502CCBAB41
    gpg:                issuer "palmer@dabbelt.com"
    gpg: Good signature from "Palmer Dabbelt <palmer@dabbelt.com>" [ultimate]
    gpg:                 aka "Palmer Dabbelt <palmer@sifive.com>" [ultimate]
    Author: Palmer Dabbelt <palmer@sifive.com>
    Date:   Mon Jul 30 15:19:43 2018 -0700

        RISC-V: Disable preemption before enabling interrupts when booting secondary harts

        I'm not sure, but I think this was a bug: if the scheduler fired right
        here then I believe it would blow up.

        Signed-off-by: Palmer Dabbelt <palmer@sifive.com>

    diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
    index b06af8cedf64..2b9d51b9e0a5 100644
    --- a/arch/riscv/kernel/smpboot.c
    +++ b/arch/riscv/kernel/smpboot.c
    @@ -110,7 +110,9 @@ asmlinkage void __init smp_callin(void)
     	/* Remote TLB flushes are ignored while the CPU is offline, so emit a local
     	 * TLB flush right now just in case. */
     	local_flush_tlb_all();
    -	local_irq_enable();
    +	/* Disable preemption before enabling interrupts, so we don't try to
    +	 * schedule a CPU that hasn't actually started yet. */
     	preempt_disable();
    +	local_irq_enable();
     	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
     }

I'll clean up the patches and submit them for real, so feel free to comment on
the real patches as these might be horribly broken.

Sorry this took so long to get around to, and thanks for the feedback!
