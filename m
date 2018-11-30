Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4873BC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E51D921473
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nygxk6Zb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51D921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbeK3Tkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 14:40:33 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54071 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbeK3Tkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 14:40:33 -0500
Received: by mail-it1-f193.google.com with SMTP id g85so8019861ita.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Nov 2018 00:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nizQyag2l/YPhPpfsVTM340PDhtCZOj84Wq9SiYgrl4=;
        b=Nygxk6ZbcdIWqOkw57Gz3YZMtn9bV84SXnWFBK0t8juAzf6+sozhRjLSUvW8Cnwvg/
         Twi7JebuOl0CUop60D5QGBcchyylgd28dzAdHh5r/efAODM2+2x21gTIt67xACUFnBBr
         6Vd9QjA07smAHWsNGArDD4yVjJPx9Bg6w+nq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nizQyag2l/YPhPpfsVTM340PDhtCZOj84Wq9SiYgrl4=;
        b=BjRPeK+ulB7c30FE55q9k3tQCboo1hcqLrFSfuGmZG26jIfNNRybq3CgYNmW4gXXIx
         KTdoxzpwDoP3nfOHqHDc8uQ0joVkeprYpRECT5HsnEm7VUiE8p40Qm0hbFXELQ5qXlbo
         KSoYtHL8I54VGAbovbxMhV/c9NDcFTfcMwHA5KmOTVTjalFVCsFm9f7qG2bBjfnYmziZ
         6VhmDzHPtYllkEkdBes5ikne9f3UiGGm7bkzD1MzBYigsC6hMJ1Kx8mRZorCsRPfaDxM
         OtPQ8lzuSQV2a9qsQTNlB1sru+kAI2gwzUNng0uBIt1Y9SEBuI5n0J16hP8q97vB3Ax+
         zaDg==
X-Gm-Message-State: AA+aEWabOn6/Dpn+1tJjE7RoSaSc7Rx6LLmVQSGInIjXE9e9otmXzFNJ
        njeZORGwgUN4YWThCxE7jWqC60bEWCWgcPbyEdcKAw==
X-Google-Smtp-Source: AFSGD/VEgdlGgopFfJxc5zJB3muSxGVNOWB4MRS9d6q7p0zwpAd20aM4i9kRNDcPS1tJAbLmxmb3LpkPJhHXqupfLgE=
X-Received: by 2002:a02:734b:: with SMTP id a11mr4047014jae.62.1543566720331;
 Fri, 30 Nov 2018 00:32:00 -0800 (PST)
MIME-Version: 1.0
References: <20181129171230.18699-1-ard.biesheuvel@linaro.org>
 <20181129171230.18699-3-ard.biesheuvel@linaro.org> <20181130075658.GB16084@gmail.com>
In-Reply-To: <20181130075658.GB16084@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 30 Nov 2018 09:31:47 +0100
Message-ID: <CAKv+Gu8dLTwQp-FemEB0Bhzc3KEYDqpP_Pke3Q+miCh3h2xxbw@mail.gmail.com>
Subject: Re: [PATCH] efi/fdt: More cleanups
To:     Ingo Molnar <mingo@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arend Van Spriel <arend.vanspriel@broadcom.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Joe Perches <joe@perches.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        YiFei Zhu <zhuyifei1999@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Nov 2018 at 08:57, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
>
> > From: Julien Thierry <julien.thierry@arm.com>
> >
> > Closing bracket seems to end a for statement when it is actually ending
> > the contained if. Add some brackets to have clear delimitation of each
> > scope.
> >
> > No functional change/fix, just fix the indentation.
> >
> > Signed-off-by: Julien Thierry <julien.thierry@arm.com>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > ---
> >  drivers/firmware/efi/libstub/fdt.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/firmware/efi/libstub/fdt.c b/drivers/firmware/efi/libstub/fdt.c
> > index 0c0d2312f4a8..a3614f9b5f75 100644
> > --- a/drivers/firmware/efi/libstub/fdt.c
> > +++ b/drivers/firmware/efi/libstub/fdt.c
> > @@ -376,7 +376,7 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
> >       tables = (efi_config_table_t *) sys_table->tables;
> >       fdt = NULL;
> >
> > -     for (i = 0; i < sys_table->nr_tables; i++)
> > +     for (i = 0; i < sys_table->nr_tables; i++) {
> >               if (efi_guidcmp(tables[i].guid, fdt_guid) == 0) {
> >                       fdt = (void *) tables[i].table;
> >                       if (fdt_check_header(fdt) != 0) {
> > @@ -385,7 +385,8 @@ void *get_fdt(efi_system_table_t *sys_table, unsigned long *fdt_size)
> >                       }
> >                       *fdt_size = fdt_totalsize(fdt);
> >                       break;
> > -      }
> > +             }
> > +     }
>
> So if we are doing trivial cleanups, how about the patch below on top? It
> cleans up this file for good. Only minimally build tested.
>
> Thanks,
>
>         Ingo
>
> ======================>
> Subject: efi/fdt: More cleanups
> From: Ingo Molnar <mingo@kernel.org>
>
> Apply a number of cleanups:
>
>  - Introduce fdt_setprop_*var() helper macros to simplify and shorten repetitive
>    sequences - this also makes it less likely that the wrong variable size is
>    passed in. This change makes a lot of the property-setting calls single-line
>    and easier to read.
>

This change looks fine to me, but scripts/dtc/libfdt/libfdt.h is part
of an external library, so we'd either need to contribute it there or
define the macro in a local header.

>  - Harmonize comment style: capitalization, punctuation, whitespaces, etc.
>
>  - Fix some whitespace noise in the libstub Makefile which I happened to notice.
>
>  - Use the standard tabular initialization style:
>
>     -       map.map =       &runtime_map;
>     -       map.map_size =  &map_size;
>     -       map.desc_size = &desc_size;
>     -       map.desc_ver =  &desc_ver;
>     -       map.key_ptr =   &mmap_key;
>     -       map.buff_size = &buff_size;
>
>     +       map.map         = &runtime_map;
>     +       map.map_size    = &map_size;
>     +       map.desc_size   = &desc_size;
>     +       map.desc_ver    = &desc_ver;
>     +       map.key_ptr     = &mmap_key;
>     +       map.buff_size   = &buff_size;
>
>  - Use tabular structure definition for better readability.
>
>  - Make all pr*() lines single-line, even if they marginally exceed 80 cols - this
>    makes them visually less intrusive.
>
>  - Unbreak line breaks into single lines when the length exceeds 80 cols only
>    marginally, for better readability.
>
>  - Move assignment closer to the actual usage site.
>
>  - Plus some other smaller cleanups, spelling fixes, etc.
>
> No change in functionality intended.
>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Thanks for the cleanup. I will merge it once we decide where to define
the new helper macros.

> ---
>  drivers/firmware/efi/libstub/Makefile |    4 -
>  drivers/firmware/efi/libstub/fdt.c    |  109 ++++++++++++++++------------------
>  scripts/dtc/libfdt/libfdt.h           |   10 +++
>  3 files changed, 64 insertions(+), 59 deletions(-)
>
> Index: tip/drivers/firmware/efi/libstub/Makefile
> ===================================================================
> --- tip.orig/drivers/firmware/efi/libstub/Makefile
> +++ tip/drivers/firmware/efi/libstub/Makefile
> @@ -49,7 +49,7 @@ lib-$(CONFIG_EFI_ARMSTUB)     += arm-stub.o
>
>  lib-$(CONFIG_ARM)              += arm32-stub.o
>  lib-$(CONFIG_ARM64)            += arm64-stub.o
> -CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
> +CFLAGS_arm64-stub.o            := -DTEXT_OFFSET=$(TEXT_OFFSET)
>
>  #
>  # arm64 puts the stub in the kernel proper, which will unnecessarily retain all
> @@ -86,7 +86,7 @@ quiet_cmd_stubcopy = STUBCPY $@
>        cmd_stubcopy = if $(STRIP) --strip-debug $(STUBCOPY_RM-y) -o $@ $<; \
>                      then if $(OBJDUMP) -r $@ | grep $(STUBCOPY_RELOC-y); \
>                      then (echo >&2 "$@: absolute symbol references not allowed in the EFI stub"; \
> -                          rm -f $@; /bin/false);                         \
> +                          rm -f $@; /bin/false);                         \
>                      else $(OBJCOPY) $(STUBCOPY_FLAGS-y) $< $@; fi        \
>                      else /bin/false; fi
>
> Index: tip/drivers/firmware/efi/libstub/fdt.c
> ===================================================================
> --- tip.orig/drivers/firmware/efi/libstub/fdt.c
> +++ tip/drivers/firmware/efi/libstub/fdt.c
> @@ -26,10 +26,8 @@ static void fdt_update_cell_size(efi_sys
>         offset = fdt_path_offset(fdt, "/");
>         /* Set the #address-cells and #size-cells values for an empty tree */
>
> -       fdt_setprop_u32(fdt, offset, "#address-cells",
> -                       EFI_DT_ADDR_CELLS_DEFAULT);
> -
> -       fdt_setprop_u32(fdt, offset, "#size-cells", EFI_DT_SIZE_CELLS_DEFAULT);
> +       fdt_setprop_u32(fdt, offset, "#address-cells", EFI_DT_ADDR_CELLS_DEFAULT);
> +       fdt_setprop_u32(fdt, offset, "#size-cells",    EFI_DT_SIZE_CELLS_DEFAULT);
>  }
>
>  static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
> @@ -42,7 +40,7 @@ static efi_status_t update_fdt(efi_syste
>         u32 fdt_val32;
>         u64 fdt_val64;
>
> -       /* Do some checks on provided FDT, if it exists*/
> +       /* Do some checks on provided FDT, if it exists: */
>         if (orig_fdt) {
>                 if (fdt_check_header(orig_fdt)) {
>                         pr_efi_err(sys_table, "Device Tree header not valid!\n");
> @@ -50,7 +48,7 @@ static efi_status_t update_fdt(efi_syste
>                 }
>                 /*
>                  * We don't get the size of the FDT if we get if from a
> -                * configuration table.
> +                * configuration table:
>                  */
>                 if (orig_fdt_size && fdt_totalsize(orig_fdt) > orig_fdt_size) {
>                         pr_efi_err(sys_table, "Truncated device tree! foo!\n");
> @@ -64,8 +62,8 @@ static efi_status_t update_fdt(efi_syste
>                 status = fdt_create_empty_tree(fdt, new_fdt_size);
>                 if (status == 0) {
>                         /*
> -                        * Any failure from the following function is non
> -                        * critical
> +                        * Any failure from the following function is
> +                        * non-critical:
>                          */
>                         fdt_update_cell_size(sys_table, fdt);
>                 }
> @@ -86,12 +84,13 @@ static efi_status_t update_fdt(efi_syste
>         if (node < 0) {
>                 node = fdt_add_subnode(fdt, 0, "chosen");
>                 if (node < 0) {
> -                       status = node; /* node is error code when negative */
> +                       /* 'node' is an error code when negative: */
> +                       status = node;
>                         goto fdt_set_fail;
>                 }
>         }
>
> -       if ((cmdline_ptr != NULL) && (strlen(cmdline_ptr) > 0)) {
> +       if (cmdline_ptr != NULL && strlen(cmdline_ptr) > 0) {
>                 status = fdt_setprop(fdt, node, "bootargs", cmdline_ptr,
>                                      strlen(cmdline_ptr) + 1);
>                 if (status)
> @@ -103,13 +102,12 @@ static efi_status_t update_fdt(efi_syste
>                 u64 initrd_image_end;
>                 u64 initrd_image_start = cpu_to_fdt64(initrd_addr);
>
> -               status = fdt_setprop(fdt, node, "linux,initrd-start",
> -                                    &initrd_image_start, sizeof(u64));
> +               status = fdt_setprop_var(fdt, node, "linux,initrd-start", initrd_image_start);
>                 if (status)
>                         goto fdt_set_fail;
> +
>                 initrd_image_end = cpu_to_fdt64(initrd_addr + initrd_size);
> -               status = fdt_setprop(fdt, node, "linux,initrd-end",
> -                                    &initrd_image_end, sizeof(u64));
> +               status = fdt_setprop_var(fdt, node, "linux,initrd-end", initrd_image_end);
>                 if (status)
>                         goto fdt_set_fail;
>         }
> @@ -117,30 +115,28 @@ static efi_status_t update_fdt(efi_syste
>         /* Add FDT entries for EFI runtime services in chosen node. */
>         node = fdt_subnode_offset(fdt, 0, "chosen");
>         fdt_val64 = cpu_to_fdt64((u64)(unsigned long)sys_table);
> -       status = fdt_setprop(fdt, node, "linux,uefi-system-table",
> -                            &fdt_val64, sizeof(fdt_val64));
> +
> +       status = fdt_setprop_var(fdt, node, "linux,uefi-system-table", fdt_val64);
>         if (status)
>                 goto fdt_set_fail;
>
>         fdt_val64 = U64_MAX; /* placeholder */
> -       status = fdt_setprop(fdt, node, "linux,uefi-mmap-start",
> -                            &fdt_val64,  sizeof(fdt_val64));
> +
> +       status = fdt_setprop_var(fdt, node, "linux,uefi-mmap-start", fdt_val64);
>         if (status)
>                 goto fdt_set_fail;
>
>         fdt_val32 = U32_MAX; /* placeholder */
> -       status = fdt_setprop(fdt, node, "linux,uefi-mmap-size",
> -                            &fdt_val32,  sizeof(fdt_val32));
> +
> +       status = fdt_setprop_var(fdt, node, "linux,uefi-mmap-size", fdt_val32);
>         if (status)
>                 goto fdt_set_fail;
>
> -       status = fdt_setprop(fdt, node, "linux,uefi-mmap-desc-size",
> -                            &fdt_val32, sizeof(fdt_val32));
> +       status = fdt_setprop_var(fdt, node, "linux,uefi-mmap-desc-size", fdt_val32);
>         if (status)
>                 goto fdt_set_fail;
>
> -       status = fdt_setprop(fdt, node, "linux,uefi-mmap-desc-ver",
> -                            &fdt_val32, sizeof(fdt_val32));
> +       status = fdt_setprop_var(fdt, node, "linux,uefi-mmap-desc-ver", fdt_val32);
>         if (status)
>                 goto fdt_set_fail;
>
> @@ -150,8 +146,7 @@ static efi_status_t update_fdt(efi_syste
>                 efi_status = efi_get_random_bytes(sys_table, sizeof(fdt_val64),
>                                                   (u8 *)&fdt_val64);
>                 if (efi_status == EFI_SUCCESS) {
> -                       status = fdt_setprop(fdt, node, "kaslr-seed",
> -                                            &fdt_val64, sizeof(fdt_val64));
> +                       status = fdt_setprop_var(fdt, node, "kaslr-seed", fdt_val64);
>                         if (status)
>                                 goto fdt_set_fail;
>                 } else if (efi_status != EFI_NOT_FOUND) {
> @@ -159,7 +154,7 @@ static efi_status_t update_fdt(efi_syste
>                 }
>         }
>
> -       /* shrink the FDT back to its minimum size */
> +       /* Shrink the FDT back to its minimum size: */
>         fdt_pack(fdt);
>
>         return EFI_SUCCESS;
> @@ -182,26 +177,26 @@ static efi_status_t update_fdt_memmap(vo
>                 return EFI_LOAD_ERROR;
>
>         fdt_val64 = cpu_to_fdt64((unsigned long)*map->map);
> -       err = fdt_setprop_inplace(fdt, node, "linux,uefi-mmap-start",
> -                                 &fdt_val64, sizeof(fdt_val64));
> +
> +       err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-start", fdt_val64);
>         if (err)
>                 return EFI_LOAD_ERROR;
>
>         fdt_val32 = cpu_to_fdt32(*map->map_size);
> -       err = fdt_setprop_inplace(fdt, node, "linux,uefi-mmap-size",
> -                                 &fdt_val32, sizeof(fdt_val32));
> +
> +       err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-size", fdt_val32);
>         if (err)
>                 return EFI_LOAD_ERROR;
>
>         fdt_val32 = cpu_to_fdt32(*map->desc_size);
> -       err = fdt_setprop_inplace(fdt, node, "linux,uefi-mmap-desc-size",
> -                                 &fdt_val32, sizeof(fdt_val32));
> +
> +       err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-desc-size", fdt_val32);
>         if (err)
>                 return EFI_LOAD_ERROR;
>
>         fdt_val32 = cpu_to_fdt32(*map->desc_ver);
> -       err = fdt_setprop_inplace(fdt, node, "linux,uefi-mmap-desc-ver",
> -                                 &fdt_val32, sizeof(fdt_val32));
> +
> +       err = fdt_setprop_inplace_var(fdt, node, "linux,uefi-mmap-desc-ver", fdt_val32);
>         if (err)
>                 return EFI_LOAD_ERROR;
>
> @@ -209,13 +204,13 @@ static efi_status_t update_fdt_memmap(vo
>  }
>
>  #ifndef EFI_FDT_ALIGN
> -#define EFI_FDT_ALIGN EFI_PAGE_SIZE
> +# define EFI_FDT_ALIGN EFI_PAGE_SIZE
>  #endif
>
>  struct exit_boot_struct {
> -       efi_memory_desc_t *runtime_map;
> -       int *runtime_entry_count;
> -       void *new_fdt_addr;
> +       efi_memory_desc_t       *runtime_map;
> +       int                     *runtime_entry_count;
> +       void                    *new_fdt_addr;
>  };
>
>  static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
> @@ -235,7 +230,7 @@ static efi_status_t exit_boot_func(efi_s
>  }
>
>  #ifndef MAX_FDT_SIZE
> -#define MAX_FDT_SIZE   SZ_2M
> +# define MAX_FDT_SIZE SZ_2M
>  #endif
>
>  /*
> @@ -266,16 +261,16 @@ efi_status_t allocate_new_fdt_and_exit_b
>         unsigned long mmap_key;
>         efi_memory_desc_t *memory_map, *runtime_map;
>         efi_status_t status;
> -       int runtime_entry_count = 0;
> +       int runtime_entry_count;
>         struct efi_boot_memmap map;
>         struct exit_boot_struct priv;
>
> -       map.map =       &runtime_map;
> -       map.map_size =  &map_size;
> -       map.desc_size = &desc_size;
> -       map.desc_ver =  &desc_ver;
> -       map.key_ptr =   &mmap_key;
> -       map.buff_size = &buff_size;
> +       map.map         = &runtime_map;
> +       map.map_size    = &map_size;
> +       map.desc_size   = &desc_size;
> +       map.desc_ver    = &desc_ver;
> +       map.key_ptr     = &mmap_key;
> +       map.buff_size   = &buff_size;
>
>         /*
>          * Get a copy of the current memory map that we will use to prepare
> @@ -289,15 +284,13 @@ efi_status_t allocate_new_fdt_and_exit_b
>                 return status;
>         }
>
> -       pr_efi(sys_table,
> -              "Exiting boot services and installing virtual address map...\n");
> +       pr_efi(sys_table, "Exiting boot services and installing virtual address map...\n");
>
>         map.map = &memory_map;
>         status = efi_high_alloc(sys_table, MAX_FDT_SIZE, EFI_FDT_ALIGN,
>                                 new_fdt_addr, max_addr);
>         if (status != EFI_SUCCESS) {
> -               pr_efi_err(sys_table,
> -                          "Unable to allocate memory for new device tree.\n");
> +               pr_efi_err(sys_table, "Unable to allocate memory for new device tree.\n");
>                 goto fail;
>         }
>
> @@ -318,11 +311,12 @@ efi_status_t allocate_new_fdt_and_exit_b
>                 goto fail_free_new_fdt;
>         }
>
> -       priv.runtime_map = runtime_map;
> -       priv.runtime_entry_count = &runtime_entry_count;
> -       priv.new_fdt_addr = (void *)*new_fdt_addr;
> -       status = efi_exit_boot_services(sys_table, handle, &map, &priv,
> -                                       exit_boot_func);
> +       runtime_entry_count             = 0;
> +       priv.runtime_map                = runtime_map;
> +       priv.runtime_entry_count        = &runtime_entry_count;
> +       priv.new_fdt_addr               = (void *)*new_fdt_addr;
> +
> +       status = efi_exit_boot_services(sys_table, handle, &map, &priv, exit_boot_func);
>
>         if (status == EFI_SUCCESS) {
>                 efi_set_virtual_address_map_t *svam;
> @@ -363,6 +357,7 @@ fail_free_new_fdt:
>
>  fail:
>         sys_table->boottime->free_pool(runtime_map);
> +
>         return EFI_LOAD_ERROR;
>  }
>
> @@ -373,7 +368,7 @@ void *get_fdt(efi_system_table_t *sys_ta
>         void *fdt;
>         int i;
>
> -       tables = (efi_config_table_t *) sys_table->tables;
> +       tables = (efi_config_table_t *)sys_table->tables;
>         fdt = NULL;
>
>         for (i = 0; i < sys_table->nr_tables; i++) {
> Index: tip/scripts/dtc/libfdt/libfdt.h
> ===================================================================
> --- tip.orig/scripts/dtc/libfdt/libfdt.h
> +++ tip/scripts/dtc/libfdt/libfdt.h
> @@ -1213,8 +1213,14 @@ int fdt_setprop_inplace_namelen_partial(
>   *     -FDT_ERR_TRUNCATED, standard meanings
>   */
>  #ifndef SWIG /* Not available in Python */
> +
>  int fdt_setprop_inplace(void *fdt, int nodeoffset, const char *name,
>                         const void *val, int len);
> +
> +/* Helper macro for the usual case of using simple C variables: */
> +#define fdt_setprop_inplace_var(fdt, node_offset, name, var) \
> +       fdt_setprop_inplace((fdt), (node_offset), (name), &(var), sizeof(var))
> +
>  #endif
>
>  /**
> @@ -1540,6 +1546,10 @@ int fdt_setprop(void *fdt, int nodeoffse
>  int fdt_setprop_placeholder(void *fdt, int nodeoffset, const char *name,
>                             int len, void **prop_data);
>
> +/* Helper macro for the usual case of using simple C variables: */
> +#define fdt_setprop_var(fdt, node_offset, name, var) \
> +       fdt_setprop((fdt), (node_offset), (name), &(var), sizeof(var))
> +
>  /**
>   * fdt_setprop_u32 - set a property to a 32-bit integer
>   * @fdt: pointer to the device tree blob
