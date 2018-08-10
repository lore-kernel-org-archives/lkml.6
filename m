Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9861DC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:40:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37E7222428
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 17:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37E7222428
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728110AbeHJUKr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 16:10:47 -0400
Received: from mout.gmx.net ([212.227.15.18]:51035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeHJUKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 16:10:47 -0400
Received: from homer.simpson.net ([185.221.150.53]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M2LZc-1g4TDi3fc4-00s7q6; Fri, 10
 Aug 2018 19:39:46 +0200
Message-ID: <1533922786.5083.7.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Aug 2018 19:39:46 +0200
In-Reply-To: <20180810102846.GA31327@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
         <20180810084501.GA11901@dhcp-128-65.nay.redhat.com>
         <20180810102846.GA31327@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:/d/hhCwU74g/0FJGvEYcS0kWO4QfeHayaCfQfDa1xJnPUPOVJ0b
 F4177QIjaZOWayBusxkFxURQERC5dpXsnNiztyIUlzOQaVht2Avp4VHS0/JUBZoZCVu7itQ
 C5ss+e3MKsW4FqYBMmXENgUJLOglNWdarbw9tS3nuBGaZANlHqb3rWq3UWPcydRhh1GJjQw
 /a7vQgne3E7284TRuRLGg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:5tv+BC+Ui1w=:RFvoORBrok85co5a8G1IkE
 uvCn+3niVzF8Sk+Z6eGghkuE3FnHdyW9sGyG0mmHPQPe5CSwxXwjGmD1xXUOmf64InMw4QA4k
 c2rX5OETNINEKYCQ6prpOD5+lwHnYB9wEjl02nJ5mYp3IBAQysmkHXMaDNRzTnUWQ+iLJKUJQ
 DBvr2VgM+XFcddeUOu3c4NUCduVX/kqyBe4l1fBhGbArgLEZ9RCuulqW7d2zhHC0VPNwCJ5LW
 toauu3z9D2H0SHeq/x7PSfekfOPZEv4ASyHlyt9D4GyLVtCwL5jUIiT7/a/a9d9FR2VGCX8MT
 zYJqcEDiK/s8if76cClFNoHV2WGvIJ/61KrAjh5QrssD+IAivUWr6Ojf3km3d2CYezhAw9aTQ
 RMc1SrJ7mQWoyGjKAtHU8N6dMa63qW1v3tmO1tylaON+PQqjPc2oEFDZUG9cqzzgsZfd4rXQF
 hx4HgxMCnBxBdFdsKxoydcbs0Rqisomn4FPqSod9ssl3QrHRNco1yEibHZKE+Su+MzMuRy8Vf
 ZghBcLXt/wJQ1TJTbcrfn/a0pgLGV8N3Odx9ZFsQeoeFBU0WDyXWE+4afIhLof5+dLs9Ru2/d
 GvJpZAeqCt2mKetgtL9Sz3/s3zyUnX3Tg9DdTNhbX/MetN8sxbO9+t6ItrBxd+S2nsOTpRiCm
 HHspUvMSr5EUOp2yaBJjazbWfb5FmvnxeLnX65dbQ+qMdywyAjfYFAinjxGalX6v/Dm9O7lHd
 ARG0RphQQYKdXwXoIOMqY7C8LVM3uow8dnOntaSexbmaw4bsp1mZuF8CKWP99Rf3j1HkVQLBW
 jFPRr+Y
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 18:28 +0800, Dave Young wrote:
> 
> > @@ -250,8 +253,10 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
> >  
> >  #ifdef CONFIG_EFI
> >  	/* Setup EFI state */
> > -	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> > +	ret = setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> >  			efi_setup_data_offset);
> > +	if (ret)
> 
> Here should check efi_enabled(EFI_BOOT) && ret

Patch with that works for me.

> In case efi boot we need the efi info set correctly,  or one need pass
> acpi_rsdp= in kernel cmdline param.
> 
> Still not sure how to allow one to workaround it by using acpi_rsdp=
> param with kexec_file_load..

Does this improve things, and plug the no boot hole?

x86, kdump: cleanup efi setup data handling a bit

1. Remove efi specific variables from bzImage64_load() other than the
one it needs, efi_map_sz, passing it and params_cmdline_sz on to efi
setup functions, giving them all they need without duplication.

2. Only allocate space for efi setup data when a 1:1 mapping is available.
Bail early with -ENODEV if not available, but is required to boot, and
acpi_rsdp= was not passed on the command line. 

3. Use the proper config dependency to isolate efi setup functions,
adding a !EFI_RUNTIME_MAP stub for setup_efi_state().

4. Change efi functions that cannot fail to void. 

Signed-off-by: Mike Galbraith <efault@gmx.de>
---
 arch/x86/kernel/kexec-bzimage64.c |   99 +++++++++++++++++---------------------
 1 file changed, 45 insertions(+), 54 deletions(-)

--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -112,35 +112,32 @@ static int setup_e820_entries(struct boo
 	return 0;
 }
 
-#ifdef CONFIG_EFI
-static int setup_efi_info_memmap(struct boot_params *params,
+#ifdef CONFIG_EFI_RUNTIME_MAP
+static void setup_efi_info_memmap(struct boot_params *params,
 				  unsigned long params_load_addr,
-				  unsigned int efi_map_offset,
+				  unsigned int params_cmdline_sz,
 				  unsigned int efi_map_sz)
 {
-	void *efi_map = (void *)params + efi_map_offset;
-	unsigned long efi_map_phys_addr = params_load_addr + efi_map_offset;
+	void *efi_map = (void *)params + params_cmdline_sz;
+	unsigned long efi_map_phys_addr = params_load_addr + params_cmdline_sz;
 	struct efi_info *ei = &params->efi_info;
 
-	if (!efi_map_sz)
-		return -EINVAL;
-
 	efi_runtime_map_copy(efi_map, efi_map_sz);
 
 	ei->efi_memmap = efi_map_phys_addr & 0xffffffff;
 	ei->efi_memmap_hi = efi_map_phys_addr >> 32;
 	ei->efi_memmap_size = efi_map_sz;
-
-	return 0;
 }
 
-static int
+static void
 prepare_add_efi_setup_data(struct boot_params *params,
-		       unsigned long params_load_addr,
-		       unsigned int efi_setup_data_offset)
+			   unsigned long params_load_addr,
+			   unsigned int params_cmdline_sz,
+			   unsigned int efi_map_sz)
 {
+	unsigned int data_offset = params_cmdline_sz + ALIGN(efi_map_sz, 16);
 	unsigned long setup_data_phys;
-	struct setup_data *sd = (void *)params + efi_setup_data_offset;
+	struct setup_data *sd = (void *)params + data_offset;
 	struct efi_setup_data *esd = (void *)sd + sizeof(struct setup_data);
 
 	esd->fw_vendor = efi.fw_vendor;
@@ -152,33 +149,20 @@ prepare_add_efi_setup_data(struct boot_p
 	sd->len = sizeof(struct efi_setup_data);
 
 	/* Add setup data */
-	setup_data_phys = params_load_addr + efi_setup_data_offset;
+	setup_data_phys = params_load_addr + data_offset;
 	sd->next = params->hdr.setup_data;
 	params->hdr.setup_data = setup_data_phys;
-
-	return 0;
 }
 
 static int
 setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
-		unsigned int efi_map_offset, unsigned int efi_map_sz,
-		unsigned int efi_setup_data_offset)
+		unsigned int params_cmdline_sz, unsigned int efi_map_sz)
 {
 	struct efi_info *current_ei = &boot_params.efi_info;
 	struct efi_info *ei = &params->efi_info;
-	int ret;
-
-	if (!current_ei->efi_memmap_size)
-		return -EINVAL;
 
-	/*
-	 * If 1:1 mapping is not enabled, second kernel can not setup EFI
-	 * and use EFI run time services. User space will have to pass
-	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
-	 * without efi.
-	 */
-	if (efi_enabled(EFI_OLD_MEMMAP) || !efi_enabled(EFI_RUNTIME_SERVICES))
-		return -ENODEV;
+	if (!efi_map_sz || !current_ei->efi_memmap_size)
+		return efi_map_sz ? -EINVAL : 0;
 
 	ei->efi_loader_signature = current_ei->efi_loader_signature;
 	ei->efi_systab = current_ei->efi_systab;
@@ -187,21 +171,24 @@ setup_efi_state(struct boot_params *para
 	ei->efi_memdesc_version = current_ei->efi_memdesc_version;
 	ei->efi_memdesc_size = efi_get_runtime_map_desc_size();
 
-	ret = setup_efi_info_memmap(params, params_load_addr, efi_map_offset,
+	setup_efi_info_memmap(params, params_load_addr, params_cmdline_sz,
 			      efi_map_sz);
-	if (ret)
-		return ret;
-	prepare_add_efi_setup_data(params, params_load_addr,
-				   efi_setup_data_offset);
+	prepare_add_efi_setup_data(params, params_load_addr, params_cmdline_sz,
+				   efi_map_sz);
 	return 0;
 }
-#endif /* CONFIG_EFI */
+#else /* !CONFIG_EFI_RUNTIME_MAP */
+static int
+setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
+		unsigned int params_cmdline_sz, unsigned int efi_map_sz)
+{ return 0; }
+#endif /* CONFIG_EFI_RUNTIME_MAP */
 
 static int
 setup_boot_parameters(struct kimage *image, struct boot_params *params,
 		      unsigned long params_load_addr,
-		      unsigned int efi_map_offset, unsigned int efi_map_sz,
-		      unsigned int efi_setup_data_offset)
+		      unsigned int params_cmdline_sz,
+		      unsigned int efi_map_sz)
 {
 	unsigned int nr_e820_entries;
 	unsigned long long mem_k, start, end;
@@ -251,13 +238,9 @@ setup_boot_parameters(struct kimage *ima
 		}
 	}
 
-#ifdef CONFIG_EFI
-	/* Setup EFI state */
-	ret = setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
-			efi_setup_data_offset);
-	if (efi_enabled(EFI_BOOT) && ret)
+	ret = setup_efi_state(params, params_load_addr, params_cmdline_sz, efi_map_sz);
+	if (ret)
 		return ret;
-#endif
 
 	/* Setup EDD info */
 	memcpy(params->eddbuf, boot_params.eddbuf,
@@ -343,7 +326,7 @@ static void *bzImage64_load(struct kimag
 	struct kexec_entry64_regs regs64;
 	void *stack;
 	unsigned int setup_hdr_offset = offsetof(struct boot_params, hdr);
-	unsigned int efi_map_offset, efi_map_sz, efi_setup_data_offset;
+	unsigned int efi_map_sz = 0;
 	struct kexec_buf kbuf = { .image = image, .buf_max = ULONG_MAX,
 				  .top_down = true };
 	struct kexec_buf pbuf = { .image = image, .buf_min = MIN_PURGATORY_ADDR,
@@ -402,19 +385,28 @@ static void *bzImage64_load(struct kimag
 	 * have to create separate segment for each. Keeps things
 	 * little bit simple
 	 */
-	efi_map_sz = efi_get_runtime_map_size();
 	params_cmdline_sz = sizeof(struct boot_params) + cmdline_len +
 				MAX_ELFCOREHDR_STR_LEN;
 	params_cmdline_sz = ALIGN(params_cmdline_sz, 16);
-	kbuf.bufsz = params_cmdline_sz + ALIGN(efi_map_sz, 16) +
-				sizeof(struct setup_data) +
-				sizeof(struct efi_setup_data);
+	kbuf.bufsz = params_cmdline_sz + sizeof(struct setup_data);
+
+	/*
+	 * If a 1:1 mapping does not exist, the second kernel cannot setup
+	 * and use EFI run time services, user space will have to pass
+	 * acpi_rsdp=<addr> on the kernel command line to make the second
+	 * kernel boot without efi.  Allocate space for efi setup data if
+	 * this constraint is met, bail if not, but is required to boot,
+	 * and acpi_rsdp=<addr> was not passed on the command line.
+	 */
+	if (efi_enabled(EFI_RUNTIME_SERVICES) && !efi_enabled(EFI_OLD_MEMMAP)) {
+		efi_map_sz = efi_get_runtime_map_size();
+		kbuf.bufsz += ALIGN(efi_map_sz, 16) + sizeof(struct efi_setup_data);
+	} else if (efi_enabled(EFI_BOOT) && !strstr(cmdline, "acpi_rsdp="))
+		return ERR_PTR(-ENODEV);
 
 	params = kzalloc(kbuf.bufsz, GFP_KERNEL);
 	if (!params)
 		return ERR_PTR(-ENOMEM);
-	efi_map_offset = params_cmdline_sz;
-	efi_setup_data_offset = efi_map_offset + ALIGN(efi_map_sz, 16);
 
 	/* Copy setup header onto bootparams. Documentation/x86/boot.txt */
 	setup_header_size = 0x0202 + kernel[0x0201] - setup_hdr_offset;
@@ -494,8 +486,7 @@ static void *bzImage64_load(struct kimag
 		goto out_free_params;
 
 	ret = setup_boot_parameters(image, params, bootparam_load_addr,
-				    efi_map_offset, efi_map_sz,
-				    efi_setup_data_offset);
+				    params_cmdline_sz, efi_map_sz);
 	if (ret)
 		goto out_free_params;
 

