Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90237C46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:23:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4878A223F9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 10:23:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4878A223F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeHJMw1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:52:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:33475 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727258AbeHJMw0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:52:26 -0400
Received: from homer.simpson.net ([185.221.150.53]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MhAVV-1faXvr0ICX-00MLKe; Fri, 10
 Aug 2018 12:23:02 +0200
Message-ID: <1533896581.5885.16.camel@gmx.de>
Subject: Re: [PATCH] x86, kdump: Fix efi=noruntime NULL pointer dereference
From:   Mike Galbraith <efault@gmx.de>
To:     Dave Young <dyoung@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Fri, 10 Aug 2018 12:23:01 +0200
In-Reply-To: <20180810084501.GA11901@dhcp-128-65.nay.redhat.com>
References: <1533737025.4936.3.camel@gmx.de>
         <20180810084501.GA11901@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:6Cd+EnTG0iXsZ6B6na1gwfdxlOeEzVv9yhkaJdApi2wCuGOpmcu
 cuHk1UNc/G0g/3QSh775HeqKtDjRMjVPIbWkzgjRZEJW562YB2dDPHB6aIIfSoFYMnGD+7m
 xpHqvdj89PITFcAgueRcmfFVr9xRMAQqZ3djijgyqOYk2G/zIFprGoaUjlAT2y+eFB3WbY0
 QDvLBqtqdMkmGZiqUWt6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:JwI/PJSGPp8=:8rpbeVJpAifWlo8OymzVyz
 pCJKjsqWw7rXWIdpU4OCsk5L9dWZnvbL4vtUEOaS13g9Hw2M5lT09mZwzimNBMcs7vfNFmRuN
 2kSlM1w+9e1HrK+7l9CbVsUho1UgIvnk/0Alm1i6hUDpSbzjyrKf96oCC73fUKkKEoXkxyMWJ
 W5ipscK43HIQXW9T2IsG4CAf92xphgqSXHH/5yMCPuGI5Z4e+drje8BMpp8Upp+wD35Ryrynn
 36RLdXOdSbMcUdQJ74okcwBR5c08sDgnmraKgV/6SveqtYF3wHWT2KGslNTNWaQUSVnRYH1Bn
 CuYYOSIfrRx0c13hej7iLHViO+IXqHM9I1D2zLYFYvvRXcFkCuSSbF+jhmt2MndwM4j2bDcCk
 1Qx3itQq04KgujlCWHCiXVmTGzTewzv+/9nMCRUgS0r6eTN8Ss1WuKYrtBnRNfx3tSOx1qz0c
 OxDb4KXNwEEL73nc6ieAo0t/lTiXBEEGUWmCL7B4x3hpbdDEQhkgnUGDgUmdUIOaqTKUr6Ez2
 7ysTNQJAOHkzwJi7PgUatePchEAKcqCMgq5aEu1J8hdJJRA/p1x+qSVC1oM+gVAM0NrDYAMLu
 iWfZoNmLm32K8hH0Mch0dggIXeoCwpBtaSswm1kavNt7vaMstwTi2O9YSkqIkgMpxbjyr/mwG
 sAxevLEbBZykCUUAlKtOTUaacJgetEdmgQW1hT3Xv01iWgrCkVAPAdvsKl/7iG4CLTlJXz8pD
 lDr2R3sI0l6zFTfgFXcrv9eeborJmVuNpcTtfatOsWj9KxVh5ZPYzyS3MVzRToge9lVjz/nv9
 a0IEtCV
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-08-10 at 16:45 +0800, Dave Young wrote:
> 
> BTW, this patch only fix the kexec load phase problem,  even if kexec
> load successfully with the fix, the 2nd kernel can not boot because efi
> memmap info is not correct and usable.

Hm.  I didn't do anything else with kexec, but did crashdump my box
both w/wo efi=noruntime.

> So we should go with some fix similar to below, and do the cleanup we
> mentioned with a separate patch later.

Ah, you mean the one I had _just_ built when I saw this :)

> Also user space kexec-tools need a similar patch to error out in case
> no runtime maps.  It would be good to fix both userspace and kernel
> load.
> 
> diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
> index 7326078eaa7a..e34ba2f53cfb 100644
> --- a/arch/x86/kernel/kexec-bzimage64.c
> +++ b/arch/x86/kernel/kexec-bzimage64.c
> @@ -123,7 +123,7 @@ static int setup_efi_info_memmap(struct boot_params *params,
>  	struct efi_info *ei = &params->efi_info;
>  
>  	if (!efi_map_sz)
> -		return 0;
> +		return -EINVAL;
>  
>  	efi_runtime_map_copy(efi_map, efi_map_sz);
>  
> @@ -166,9 +166,10 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  {
>  	struct efi_info *current_ei = &boot_params.efi_info;
>  	struct efi_info *ei = &params->efi_info;
> +	int ret;
>  
>  	if (!current_ei->efi_memmap_size)
> -		return 0;
> +		return -EINVAL;
>  
>  	/*
>  	 * If 1:1 mapping is not enabled, second kernel can not setup EFI
> @@ -176,8 +177,8 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  	 * acpi_rsdp=<addr> on kernel command line to make second kernel boot
>  	 * without efi.
>  	 */
> -	if (efi_enabled(EFI_OLD_MEMMAP))
> -		return 0;
> +	if (efi_enabled(EFI_OLD_MEMMAP) || !efi_enabled(EFI_RUNTIME_SERVICES))
> +		return -ENODEV;
>  
>  	ei->efi_loader_signature = current_ei->efi_loader_signature;
>  	ei->efi_systab = current_ei->efi_systab;
> @@ -186,8 +187,10 @@ setup_efi_state(struct boot_params *params, unsigned long params_load_addr,
>  	ei->efi_memdesc_version = current_ei->efi_memdesc_version;
>  	ei->efi_memdesc_size = efi_get_runtime_map_desc_size();
>  
> -	setup_efi_info_memmap(params, params_load_addr, efi_map_offset,
> +	ret = setup_efi_info_memmap(params, params_load_addr, efi_map_offset,
>  			      efi_map_sz);
> +	if (ret)
> +		return ret;
>  	prepare_add_efi_setup_data(params, params_load_addr,
>  				   efi_setup_data_offset);
>  	return 0;
> @@ -250,8 +253,10 @@ setup_boot_parameters(struct kimage *image, struct boot_params *params,
>  
>  #ifdef CONFIG_EFI
>  	/* Setup EFI state */
> -	setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
> +	ret = setup_efi_state(params, params_load_addr, efi_map_offset, efi_map_sz,
>  			efi_setup_data_offset);
> +	if (ret)
> +		return ret;
>  #endif
>  
>  	/* Setup EDD info */
