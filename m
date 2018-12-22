Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CA6BC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1427E21A4E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500386;
	bh=Oe30/VPEvYZtSxHs+nzPMjB86Z0O/7KVL6T+135d60Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ly5AjtnTUXobSY7szgB+tJETmyBkAnUZlcVIWIHFbM9sM7QCYbDuclpX2hOB4GceR
	 MKf2cfmgrqlNoL5bnsEgLDVONbyDEJ23F0+p1sciR6SlGXoa5vZ/Rdq5Qvk2TJtb/S
	 9GI9Ur0R4DWSq/bw6HY6nRPbNqVUfPRiWeyoqfoU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392652AbeLVRjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:39:45 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55330 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392627AbeLVRji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:39:38 -0500
Received: by mail-wm1-f66.google.com with SMTP id y139so7989323wmc.5;
        Sat, 22 Dec 2018 09:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FGCCJ/VYLbjYtJnfV7b3tl8Z/z2VEa4Rim/Qzw/5Hck=;
        b=CxIuOaR5FL7L9GBeVLnxzIF3DflS2AazMpxUJ64IDDDc8xq5cwAQdns+QPhM9pZuwd
         hbvwvTeCcZWViJdh+XYaYPwLnlEiM1Q0zPXmqTJcrGflfPgIZtONgFL7TQCpbOv6GC8v
         FtFOQMZeezihLg0O8lVEWatKaux5dJjZsm4T9mHHgCDY5gtOsanu2Mt3WUlGclrNsVlQ
         JdK5QqW4lap1KAN4QHOAF0pgNZT77+AO48cC6r8IljEu9WqAPUdViLdui8tZH8+jp9jm
         uhGsuFKFrE3Sw5SDOtxj3u9SulRqk4YIFPyeYY3pDh5R6Xzjn5MG2ezzYxZtKco83i2G
         /p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=FGCCJ/VYLbjYtJnfV7b3tl8Z/z2VEa4Rim/Qzw/5Hck=;
        b=TLzdRI/0O0AYXkN9UZr3B9v9a1WSgI5lynJv/Y5vTNIA9BGXiVFlD2RQiB5yHh1gxm
         bp0FLHoZ8F1GALPmDCU1rSugXHSUVVYxUr1qq/wWwLt6e2pJaC5oYpAb+Dp+Lc7nrrjJ
         q3A98DRNFYjUsKzPR45BBOMTDa3vbvlQPWaQW7FBpVY0+yCYcqlgI8kGF2aU5NDSDutL
         aVNZ/loiphe01QJZn0mohBcFmTo0rPH+jZG7So+V2MGBX+HhvgHdzwFxltzhbre6gWk3
         01hdlXLSsqumT54AITqCEwKhWcftBdGDAALta6aoz9wPW4qf+/y1mQaZRx1ip+neasKN
         IUoA==
X-Gm-Message-State: AJcUukfKmyztkBmXCwD3Jpv3Id4OAAYrNzw/HajJGv2YQQm21QiJUbsk
        NUbQQxopgOdARTya/U70mAqIu+o3
X-Google-Smtp-Source: ALg8bN5eUn89gG4rwDOgZnEqjKZIuPX061ji307m1Dyu9nbdkzRnw+9Cj6MhlN4p8ezsOAUM3RxUMg==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr5845677wmk.47.1545476053776;
        Sat, 22 Dec 2018 02:54:13 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id 126sm26451262wmx.26.2018.12.22.02.54.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 22 Dec 2018 02:54:12 -0800 (PST)
Date:   Sat, 22 Dec 2018 11:54:10 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: [PATCH] x86/efi: Don't unmap EFI boot services code/data regions
 for EFI_OLD_MEMMAP and EFI_MIXED_MODE
Message-ID: <20181222105410.GA130780@gmail.com>
References: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181222022234.7573-1-sai.praneeth.prakhya@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com> wrote:

> Commit d5052a7130a6 ("x86/efi: Unmap EFI boot services code/data regions
> from efi_pgd") forgets to take two EFI modes into consideration namely
> EFI_OLD_MEMMAP and EFI_MIXED_MODE.

So the commit sha1 ended up being this one in tip:efi/core:

  08cfb38f3ef4: x86/efi: Unmap EFI boot services code/data regions from efi_pgd

> EFI_OLD_MEMMAP is a legacy way of mapping EFI regions into swapper_pg_dir
> using ioremap() and init_memory_mapping(). This feature can be enabled by
> passing "efi=old_map" as kernel command line argument. But,
> efi_unmap_pages() unmaps EFI boot services code/data regions *only* from
> efi_pgd and hence cannot be used for unmapping EFI boot services code/data
> regions from swapper_pg_dir.
> 
> Introduce a temporary fix to not unmap EFI boot services code/data regions
> when EFI_OLD_MEMMAP is enabled while working on a real fix.
> 
> EFI_MIXED_MODE is another feature where a 64-bit kernel runs on a
> 64-bit platform crippled by a 32-bit firmware. To support EFI_MIXED_MODE,
> all RAM (i.e. namely EFI regions like EFI_CONVENTIONAL_MEMORY,
> EFI_LOADER_<CODE/DATA>, EFI_BOOT_SERVICES_<CODE/DATA> and
> EFI_RUNTIME_CODE/DATA regions) is mapped into efi_pgd all the time to
> facilitate EFI runtime calls access it's arguments in 1:1 mode. Hence,
> don't unmap EFI boot services code/data regions when booted in mixed mode.
> 
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/x86/platform/efi/quirks.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
> index 09e811b9da26..9c34230aaeae 100644
> --- a/arch/x86/platform/efi/quirks.c
> +++ b/arch/x86/platform/efi/quirks.c
> @@ -380,6 +380,22 @@ static void __init efi_unmap_pages(efi_memory_desc_t *md)
>  	u64 pa = md->phys_addr;
>  	u64 va = md->virt_addr;
>  
> +	/*
> +	 * To Do: Remove this check after adding functionality to unmap EFI boot
> +	 * services code/data regions from direct mapping area because
> +	 * "efi=old_map" maps EFI regions in swapper_pg_dir.
> +	 */
> +	if (efi_enabled(EFI_OLD_MEMMAP))
> +		return;
> +
> +	/*
> +	 * EFI mixed mode has all RAM mapped to access arguments while making
> +	 * EFI runtime calls, hence don't unmap EFI boot services code/data
> +	 * regions.
> +	 */
> +	if (!efi_is_native() && IS_ENABLED(CONFIG_EFI_MIXED))
> +		return;

I suppose old_mmap and mixed mode stopped working altogether after the 
unmapping changes? What are the symptoms, instant reboots, crasher, or 
some more benign behavior like non-working runtime EFI functionality?

If Ard acks this I'll apply it immediately, as these bugs look like 
show-stoppers for merging the EFI tree into v4.21.

Thanks,

	Ingo
