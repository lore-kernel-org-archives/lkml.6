Return-Path: <linux-efi-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-289078-1526280474-2-11510039345302950306
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-efi-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526280474; b=hhjR+vTpVjSdaLWA5Z9zZWKFe2u1WO90lG37P+Hysb1wbFfTsP
    CjgIx+sms7MJSPZU2E5GbbU5joVj2GziG6DtyoijOfNVP0kybGeCbZ1pHBixueYR
    fQQVHQbS4Hp1/yb3BDOoVonXzU3uVfGMjnuyq+tUwddJut0huUzrNH5YRT7xajbg
    u46oJlivO24/ZFTAJCXRyfOF/V2j4NXfX11CZuriIPYeKWwJ7+WRzHzvidn6eHfL
    rcuaYWDdcT74a2kL+AbnsoedbuKvMR/M+znY080B8FQ5GUN5hLE2EVCMYYKLyWG7
    CiyZpk4fxI0dv/S8kpAnGmwMoPvETC0aATdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1526280474; bh=uPxhA2ccz4Rzz5vJ1BbUtpvCewz6lW0HBqqRDG2o9u
    M=; b=YrO7JFECQIK4/Yc07llEcTBGX+oKDY/RnSawZm432gMI4ctUYcOr8tQJrX
    lC87Pv0dDVlIU1vm5Z2ycU1N1xwuMCACiGOK/KhOoChc/Mya4IkDo1EuGxsQ5/xV
    8OzDrhlgYc4UzkcaYB8bPuCdR53xPSYL3AhGX8YGnRZLyUMtz+Q8R8tgJOB5a9hs
    +fG3VFMrgycdtrznjQu2s53TE3lj8E5HXHNa8TJJJffkYC4z6myep9FY0+H2ZqO4
    wGWTDl6nVQedO/fA77uErSPcdei3Zudf1h/0lMmr5CEiIW4WzJi4z2Iq2mQ+FKiO
    zA1rejUkQ7nN7dXYOFA2+J8Iu45w==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
    header.d=linaro.org header.i=@linaro.org header.b=AxEtmU7h x-bits=1024
    x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=AIObPBlE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 1024-bit rsa key sha256)
      header.d=linaro.org header.i=@linaro.org header.b=AxEtmU7h x-bits=1024
      x-keytype=rsa x-algorithm=sha256 x-selector=google;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=linaro.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-efi-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=AIObPBlE;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=linaro.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDN3JBAuhqvqeiA2DX+a5GBtnCSUWV3WJqOrGtoTMo7f+d0dIbgguTmJdh8+4ml4HtPlnHIbQqgxKGMEwJiSaA+Z0FXfy79OhJ1k7HsNtyb+jq3LJQPF
    Yv1cWJvUlu8rrRqt31tGGiJu+IwE+nXnJbXoXYWMpxP4r94/s9WRMPHOjMmLRhDloW/tCn5jsnLG6OHXnfZyeMzM5dUhrwxUoJ+sr1RV8bZBGVuAwgAulJ7a
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=Z4Rwk6OoAAAA:8 a=CxaZg77CAAAA:8
    a=JfrnYn6hAAAA:8 a=aUW7OhzU6u7WLaM4W98A:9 a=rWSZQqS5Cv5rk_IB:21
    a=lmiuDIoa9ROBT50n:21 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=cvBusfyB2V15izCimMoJ:22 a=HkZW87K1Qel5hWWM3VKY:22
    a=HxQw6O0h_v37Y3_G5fB_:22 a=1CNFftbPRP8L7MoqJWF3:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751961AbeENGrw (ORCPT <rfc822;linux@kroah.com>);
        Mon, 14 May 2018 02:47:52 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:55651 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeENGrv (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 14 May 2018 02:47:51 -0400
X-Google-Smtp-Source: AB8JxZpu7BUN3EwZ5QxdzCFv5qsRZ95pX8rKq5w3SvHW6u+3OzzWrwPtwMAkWjgGKyXL/SDZv/IeftDv+QH+UuayjPw=
MIME-Version: 1.0
In-Reply-To: <20180514064323.GB16596@gmail.com>
References: <20180504060003.19618-1-ard.biesheuvel@linaro.org>
 <20180504060003.19618-16-ard.biesheuvel@linaro.org> <20180514064323.GB16596@gmail.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Mon, 14 May 2018 08:47:50 +0200
Message-ID: <CAKv+Gu-v-dw28pjo_8of_dNR7mEMK3ngDUksFYUTWwro14PFfw@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Clean up the eboot code a bit
To: Ingo Molnar <mingo@kernel.org>
Cc: linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
X-Mailing-List: linux-efi@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14 May 2018 at 08:43, Ingo Molnar <mingo@kernel.org> wrote:
>
> So I looked at arch/x86/boot/compressed/eboot.c to improve a printk message and
> ended up with the cleanups below.
>
> Only build tested.
>
> Thanks,
>
>         Ingo
>
> =================>
> Subject: efi/x86: Clean up the eboot code
> From: Ingo Molnar <mingo@kernel.org>
> Date: Mon May 14 08:33:40 CEST 2018
>
> Various small cleanups:
>
>  - Standardize printk messages:
>
>      'alloc' => 'allocate'
>      'mem'   => 'memory'
>
>    also put variable names in printk messages between quotes.
>
>  - Align mass-assignments vertically for better readability
>
>  - Break multi-line function prototypes at the name where possible,
>    not in the middle of the parameter list
>
>  - Use a newline before return statements consistently.
>
>  - Use curly braces in a balanced fashion.
>
>  - Remove stray newlines.
>
> No change in functionality.
>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-efi@vger.kernel.org
> Signed-off-by: Ingo Molnar <mingo@kernel.org>

Thanks Ingo

Reviewed-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

> ---
>  arch/x86/boot/compressed/eboot.c |  247 +++++++++++++++++++--------------------
>  1 file changed, 126 insertions(+), 121 deletions(-)
>
> Index: tip/arch/x86/boot/compressed/eboot.c
> ===================================================================
> --- tip.orig/arch/x86/boot/compressed/eboot.c
> +++ tip/arch/x86/boot/compressed/eboot.c
> @@ -34,9 +34,9 @@ static void setup_boot_services##bits(st
>                                                                         \
>         table = (typeof(table))sys_table;                               \
>                                                                         \
> -       c->runtime_services = table->runtime;                           \
> -       c->boot_services = table->boottime;                             \
> -       c->text_output = table->con_out;                                \
> +       c->runtime_services     = table->runtime;                       \
> +       c->boot_services        = table->boottime;                      \
> +       c->text_output          = table->con_out;                       \
>  }
>  BOOT_SERVICES(32);
>  BOOT_SERVICES(64);
> @@ -64,6 +64,7 @@ static inline efi_status_t __open_volume
>                 efi_printk(sys_table, "Failed to open volume\n");
>
>         *__fh = fh;
> +
>         return status;
>  }
>
> @@ -90,6 +91,7 @@ static inline efi_status_t __open_volume
>                 efi_printk(sys_table, "Failed to open volume\n");
>
>         *__fh = fh;
> +
>         return status;
>  }
>
> @@ -140,16 +142,16 @@ __setup_efi_pci(efi_pci_io_protocol_t *p
>
>         status = efi_call_early(allocate_pool, EFI_LOADER_DATA, size, &rom);
>         if (status != EFI_SUCCESS) {
> -               efi_printk(sys_table, "Failed to alloc mem for rom\n");
> +               efi_printk(sys_table, "Failed to allocate memory for 'rom'\n");
>                 return status;
>         }
>
>         memset(rom, 0, sizeof(*rom));
>
> -       rom->data.type = SETUP_PCI;
> -       rom->data.len = size - sizeof(struct setup_data);
> -       rom->data.next = 0;
> -       rom->pcilen = pci->romsize;
> +       rom->data.type  = SETUP_PCI;
> +       rom->data.len   = size - sizeof(struct setup_data);
> +       rom->data.next  = 0;
> +       rom->pcilen     = pci->romsize;
>         *__rom = rom;
>
>         status = efi_call_proto(efi_pci_io_protocol, pci.read, pci,
> @@ -186,8 +188,7 @@ free_struct:
>  }
>
>  static void
> -setup_efi_pci32(struct boot_params *params, void **pci_handle,
> -               unsigned long size)
> +setup_efi_pci32(struct boot_params *params, void **pci_handle, unsigned long size)
>  {
>         efi_pci_io_protocol_t *pci = NULL;
>         efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
> @@ -226,13 +227,11 @@ setup_efi_pci32(struct boot_params *para
>                         params->hdr.setup_data = (unsigned long)rom;
>
>                 data = (struct setup_data *)rom;
> -
>         }
>  }
>
>  static void
> -setup_efi_pci64(struct boot_params *params, void **pci_handle,
> -               unsigned long size)
> +setup_efi_pci64(struct boot_params *params, void **pci_handle, unsigned long size)
>  {
>         efi_pci_io_protocol_t *pci = NULL;
>         efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
> @@ -271,7 +270,6 @@ setup_efi_pci64(struct boot_params *para
>                         params->hdr.setup_data = (unsigned long)rom;
>
>                 data = (struct setup_data *)rom;
> -
>         }
>  }
>
> @@ -301,7 +299,7 @@ static void setup_efi_pci(struct boot_pa
>                                         size, (void **)&pci_handle);
>
>                 if (status != EFI_SUCCESS) {
> -                       efi_printk(sys_table, "Failed to alloc mem for pci_handle\n");
> +                       efi_printk(sys_table, "Failed to allocate memory for 'pci_handle'\n");
>                         return;
>                 }
>
> @@ -347,8 +345,7 @@ static void retrieve_apple_device_proper
>                 status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
>                                         size + sizeof(struct setup_data), &new);
>                 if (status != EFI_SUCCESS) {
> -                       efi_printk(sys_table,
> -                                       "Failed to alloc mem for properties\n");
> +                       efi_printk(sys_table, "Failed to allocate memory for 'properties'\n");
>                         return;
>                 }
>
> @@ -364,9 +361,9 @@ static void retrieve_apple_device_proper
>         new->next = 0;
>
>         data = (struct setup_data *)(unsigned long)boot_params->hdr.setup_data;
> -       if (!data)
> +       if (!data) {
>                 boot_params->hdr.setup_data = (unsigned long)new;
> -       else {
> +       } else {
>                 while (data->next)
>                         data = (struct setup_data *)(unsigned long)data->next;
>                 data->next = (unsigned long)new;
> @@ -479,8 +476,8 @@ setup_uga64(void **uga_handle, unsigned
>  /*
>   * See if we have Universal Graphics Adapter (UGA) protocol
>   */
> -static efi_status_t setup_uga(struct screen_info *si, efi_guid_t *uga_proto,
> -                             unsigned long size)
> +static efi_status_t
> +setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
>  {
>         efi_status_t status;
>         u32 width, height;
> @@ -509,23 +506,24 @@ static efi_status_t setup_uga(struct scr
>                 goto free_handle;
>
>         /* EFI framebuffer */
> -       si->orig_video_isVGA = VIDEO_TYPE_EFI;
> +       si->orig_video_isVGA    = VIDEO_TYPE_EFI;
>
> -       si->lfb_depth = 32;
> -       si->lfb_width = width;
> -       si->lfb_height = height;
> -
> -       si->red_size = 8;
> -       si->red_pos = 16;
> -       si->green_size = 8;
> -       si->green_pos = 8;
> -       si->blue_size = 8;
> -       si->blue_pos = 0;
> -       si->rsvd_size = 8;
> -       si->rsvd_pos = 24;
> +       si->lfb_depth           = 32;
> +       si->lfb_width           = width;
> +       si->lfb_height          = height;
> +
> +       si->red_size            = 8;
> +       si->red_pos             = 16;
> +       si->green_size          = 8;
> +       si->green_pos           = 8;
> +       si->blue_size           = 8;
> +       si->blue_pos            = 0;
> +       si->rsvd_size           = 8;
> +       si->rsvd_pos            = 24;
>
>  free_handle:
>         efi_call_early(free_pool, uga_handle);
> +
>         return status;
>  }
>
> @@ -607,7 +605,7 @@ struct boot_params *make_boot_params(str
>         status = efi_low_alloc(sys_table, 0x4000, 1,
>                                (unsigned long *)&boot_params);
>         if (status != EFI_SUCCESS) {
> -               efi_printk(sys_table, "Failed to alloc lowmem for boot params\n");
> +               efi_printk(sys_table, "Failed to allocate lowmem for boot params\n");
>                 return NULL;
>         }
>
> @@ -623,9 +621,9 @@ struct boot_params *make_boot_params(str
>          * Fill out some of the header fields ourselves because the
>          * EFI firmware loader doesn't load the first sector.
>          */
> -       hdr->root_flags = 1;
> -       hdr->vid_mode = 0xffff;
> -       hdr->boot_flag = 0xAA55;
> +       hdr->root_flags = 1;
> +       hdr->vid_mode   = 0xffff;
> +       hdr->boot_flag  = 0xAA55;
>
>         hdr->type_of_loader = 0x21;
>
> @@ -633,6 +631,7 @@ struct boot_params *make_boot_params(str
>         cmdline_ptr = efi_convert_cmdline(sys_table, image, &options_size);
>         if (!cmdline_ptr)
>                 goto fail;
> +
>         hdr->cmd_line_ptr = (unsigned long)cmdline_ptr;
>         /* Fill in upper bits of command line address, NOP on 32 bit  */
>         boot_params->ext_cmd_line_ptr = (u64)(unsigned long)cmdline_ptr >> 32;
> @@ -669,10 +668,12 @@ struct boot_params *make_boot_params(str
>         boot_params->ext_ramdisk_size  = (u64)ramdisk_size >> 32;
>
>         return boot_params;
> +
>  fail2:
>         efi_free(sys_table, options_size, hdr->cmd_line_ptr);
>  fail:
>         efi_free(sys_table, 0x4000, (unsigned long)boot_params);
> +
>         return NULL;
>  }
>
> @@ -684,7 +685,7 @@ static void add_e820ext(struct boot_para
>         unsigned long size;
>
>         e820ext->type = SETUP_E820_EXT;
> -       e820ext->len = nr_entries * sizeof(struct boot_e820_entry);
> +       e820ext->len  = nr_entries * sizeof(struct boot_e820_entry);
>         e820ext->next = 0;
>
>         data = (struct setup_data *)(unsigned long)params->hdr.setup_data;
> @@ -698,8 +699,8 @@ static void add_e820ext(struct boot_para
>                 params->hdr.setup_data = (unsigned long)e820ext;
>  }
>
> -static efi_status_t setup_e820(struct boot_params *params,
> -                              struct setup_data *e820ext, u32 e820ext_size)
> +static efi_status_t
> +setup_e820(struct boot_params *params, struct setup_data *e820ext, u32 e820ext_size)
>  {
>         struct boot_e820_entry *entry = params->e820_table;
>         struct efi_info *efi = &params->efi_info;
> @@ -820,11 +821,11 @@ static efi_status_t alloc_e820ext(u32 nr
>  }
>
>  struct exit_boot_struct {
> -       struct boot_params *boot_params;
> -       struct efi_info *efi;
> -       struct setup_data *e820ext;
> -       __u32 e820ext_size;
> -       bool is64;
> +       struct boot_params      *boot_params;
> +       struct efi_info         *efi;
> +       struct setup_data       *e820ext;
> +       __u32                   e820ext_size;
> +       bool                    is64;
>  };
>
>  static efi_status_t exit_boot_func(efi_system_table_t *sys_table_arg,
> @@ -854,15 +855,15 @@ static efi_status_t exit_boot_func(efi_s
>         signature = p->is64 ? EFI64_LOADER_SIGNATURE : EFI32_LOADER_SIGNATURE;
>         memcpy(&p->efi->efi_loader_signature, signature, sizeof(__u32));
>
> -       p->efi->efi_systab = (unsigned long)sys_table_arg;
> -       p->efi->efi_memdesc_size = *map->desc_size;
> -       p->efi->efi_memdesc_version = *map->desc_ver;
> -       p->efi->efi_memmap = (unsigned long)*map->map;
> -       p->efi->efi_memmap_size = *map->map_size;
> +       p->efi->efi_systab              = (unsigned long)sys_table_arg;
> +       p->efi->efi_memdesc_size        = *map->desc_size;
> +       p->efi->efi_memdesc_version     = *map->desc_ver;
> +       p->efi->efi_memmap              = (unsigned long)*map->map;
> +       p->efi->efi_memmap_size         = *map->map_size;
>
>  #ifdef CONFIG_X86_64
> -       p->efi->efi_systab_hi = (unsigned long)sys_table_arg >> 32;
> -       p->efi->efi_memmap_hi = (unsigned long)*map->map >> 32;
> +       p->efi->efi_systab_hi           = (unsigned long)sys_table_arg >> 32;
> +       p->efi->efi_memmap_hi           = (unsigned long)*map->map >> 32;
>  #endif
>
>         return EFI_SUCCESS;
> @@ -880,17 +881,17 @@ static efi_status_t exit_boot(struct boo
>         struct efi_boot_memmap map;
>         struct exit_boot_struct priv;
>
> -       map.map =               &mem_map;
> -       map.map_size =          &map_sz;
> -       map.desc_size =         &desc_size;
> -       map.desc_ver =          &desc_version;
> -       map.key_ptr =           &key;
> -       map.buff_size =         &buff_size;
> -       priv.boot_params =      boot_params;
> -       priv.efi =              &boot_params->efi_info;
> -       priv.e820ext =          NULL;
> -       priv.e820ext_size =     0;
> -       priv.is64 =             is64;
> +       map.map                 = &mem_map;
> +       map.map_size            = &map_sz;
> +       map.desc_size           = &desc_size;
> +       map.desc_ver            = &desc_version;
> +       map.key_ptr             = &key;
> +       map.buff_size           = &buff_size;
> +       priv.boot_params        = boot_params;
> +       priv.efi                = &boot_params->efi_info;
> +       priv.e820ext            = NULL;
> +       priv.e820ext_size       = 0;
> +       priv.is64               = is64;
>
>         /* Might as well exit boot services now */
>         status = efi_exit_boot_services(sys_table, handle, &map, &priv,
> @@ -898,10 +899,11 @@ static efi_status_t exit_boot(struct boo
>         if (status != EFI_SUCCESS)
>                 return status;
>
> -       e820ext = priv.e820ext;
> -       e820ext_size = priv.e820ext_size;
> +       e820ext                 = priv.e820ext;
> +       e820ext_size            = priv.e820ext_size;
> +
>         /* Historic? */
> -       boot_params->alt_mem_k = 32 * 1024;
> +       boot_params->alt_mem_k  = 32 * 1024;
>
>         status = setup_e820(boot_params, e820ext, e820ext_size);
>         if (status != EFI_SUCCESS)
> @@ -914,8 +916,8 @@ static efi_status_t exit_boot(struct boo
>   * On success we return a pointer to a boot_params structure, and NULL
>   * on failure.
>   */
> -struct boot_params *efi_main(struct efi_config *c,
> -                            struct boot_params *boot_params)
> +struct boot_params *
> +efi_main(struct efi_config *c, struct boot_params *boot_params)
>  {
>         struct desc_ptr *gdt = NULL;
>         efi_loaded_image_t *image;
> @@ -963,7 +965,7 @@ struct boot_params *efi_main(struct efi_
>         status = efi_call_early(allocate_pool, EFI_LOADER_DATA,
>                                 sizeof(*gdt), (void **)&gdt);
>         if (status != EFI_SUCCESS) {
> -               efi_printk(sys_table, "Failed to alloc mem for gdt structure\n");
> +               efi_printk(sys_table, "Failed to allocate memory for 'gdt' structure\n");
>                 goto fail;
>         }
>
> @@ -971,7 +973,7 @@ struct boot_params *efi_main(struct efi_
>         status = efi_low_alloc(sys_table, gdt->size, 8,
>                            (unsigned long *)&gdt->address);
>         if (status != EFI_SUCCESS) {
> -               efi_printk(sys_table, "Failed to alloc mem for gdt\n");
> +               efi_printk(sys_table, "Failed to allocate memory for 'gdt'\n");
>                 goto fail;
>         }
>
> @@ -1008,19 +1010,20 @@ struct boot_params *efi_main(struct efi_
>
>         if (IS_ENABLED(CONFIG_X86_64)) {
>                 /* __KERNEL32_CS */
> -               desc->limit0 = 0xffff;
> -               desc->base0 = 0x0000;
> -               desc->base1 = 0x0000;
> -               desc->type = SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
> -               desc->s = DESC_TYPE_CODE_DATA;
> -               desc->dpl = 0;
> -               desc->p = 1;
> -               desc->limit1 = 0xf;
> -               desc->avl = 0;
> -               desc->l = 0;
> -               desc->d = SEG_OP_SIZE_32BIT;
> -               desc->g = SEG_GRANULARITY_4KB;
> -               desc->base2 = 0x00;
> +               desc->limit0    = 0xffff;
> +               desc->base0     = 0x0000;
> +               desc->base1     = 0x0000;
> +               desc->type      = SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
> +               desc->s         = DESC_TYPE_CODE_DATA;
> +               desc->dpl       = 0;
> +               desc->p         = 1;
> +               desc->limit1    = 0xf;
> +               desc->avl       = 0;
> +               desc->l         = 0;
> +               desc->d         = SEG_OP_SIZE_32BIT;
> +               desc->g         = SEG_GRANULARITY_4KB;
> +               desc->base2     = 0x00;
> +
>                 desc++;
>         } else {
>                 /* Second entry is unused on 32-bit */
> @@ -1028,15 +1031,16 @@ struct boot_params *efi_main(struct efi_
>         }
>
>         /* __KERNEL_CS */
> -       desc->limit0 = 0xffff;
> -       desc->base0 = 0x0000;
> -       desc->base1 = 0x0000;
> -       desc->type = SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
> -       desc->s = DESC_TYPE_CODE_DATA;
> -       desc->dpl = 0;
> -       desc->p = 1;
> -       desc->limit1 = 0xf;
> -       desc->avl = 0;
> +       desc->limit0    = 0xffff;
> +       desc->base0     = 0x0000;
> +       desc->base1     = 0x0000;
> +       desc->type      = SEG_TYPE_CODE | SEG_TYPE_EXEC_READ;
> +       desc->s         = DESC_TYPE_CODE_DATA;
> +       desc->dpl       = 0;
> +       desc->p         = 1;
> +       desc->limit1    = 0xf;
> +       desc->avl       = 0;
> +
>         if (IS_ENABLED(CONFIG_X86_64)) {
>                 desc->l = 1;
>                 desc->d = 0;
> @@ -1044,41 +1048,41 @@ struct boot_params *efi_main(struct efi_
>                 desc->l = 0;
>                 desc->d = SEG_OP_SIZE_32BIT;
>         }
> -       desc->g = SEG_GRANULARITY_4KB;
> -       desc->base2 = 0x00;
> +       desc->g         = SEG_GRANULARITY_4KB;
> +       desc->base2     = 0x00;
>         desc++;
>
>         /* __KERNEL_DS */
> -       desc->limit0 = 0xffff;
> -       desc->base0 = 0x0000;
> -       desc->base1 = 0x0000;
> -       desc->type = SEG_TYPE_DATA | SEG_TYPE_READ_WRITE;
> -       desc->s = DESC_TYPE_CODE_DATA;
> -       desc->dpl = 0;
> -       desc->p = 1;
> -       desc->limit1 = 0xf;
> -       desc->avl = 0;
> -       desc->l = 0;
> -       desc->d = SEG_OP_SIZE_32BIT;
> -       desc->g = SEG_GRANULARITY_4KB;
> -       desc->base2 = 0x00;
> +       desc->limit0    = 0xffff;
> +       desc->base0     = 0x0000;
> +       desc->base1     = 0x0000;
> +       desc->type      = SEG_TYPE_DATA | SEG_TYPE_READ_WRITE;
> +       desc->s         = DESC_TYPE_CODE_DATA;
> +       desc->dpl       = 0;
> +       desc->p         = 1;
> +       desc->limit1    = 0xf;
> +       desc->avl       = 0;
> +       desc->l         = 0;
> +       desc->d         = SEG_OP_SIZE_32BIT;
> +       desc->g         = SEG_GRANULARITY_4KB;
> +       desc->base2     = 0x00;
>         desc++;
>
>         if (IS_ENABLED(CONFIG_X86_64)) {
>                 /* Task segment value */
> -               desc->limit0 = 0x0000;
> -               desc->base0 = 0x0000;
> -               desc->base1 = 0x0000;
> -               desc->type = SEG_TYPE_TSS;
> -               desc->s = 0;
> -               desc->dpl = 0;
> -               desc->p = 1;
> -               desc->limit1 = 0x0;
> -               desc->avl = 0;
> -               desc->l = 0;
> -               desc->d = 0;
> -               desc->g = SEG_GRANULARITY_4KB;
> -               desc->base2 = 0x00;
> +               desc->limit0    = 0x0000;
> +               desc->base0     = 0x0000;
> +               desc->base1     = 0x0000;
> +               desc->type      = SEG_TYPE_TSS;
> +               desc->s         = 0;
> +               desc->dpl       = 0;
> +               desc->p         = 1;
> +               desc->limit1    = 0x0;
> +               desc->avl       = 0;
> +               desc->l         = 0;
> +               desc->d         = 0;
> +               desc->g         = SEG_GRANULARITY_4KB;
> +               desc->base2     = 0x00;
>                 desc++;
>         }
>
> @@ -1088,5 +1092,6 @@ struct boot_params *efi_main(struct efi_
>         return boot_params;
>  fail:
>         efi_printk(sys_table, "efi_main() failed!\n");
> +
>         return NULL;
>  }
