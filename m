Return-Path: <SRS0=aB5v=OC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D2BC43441
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82DFB206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Nov 2018 07:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fk4yUBRN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82DFB206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408226AbeKWRqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Nov 2018 12:46:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40396 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731655AbeKWRqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Nov 2018 12:46:20 -0500
Received: by mail-wr1-f68.google.com with SMTP id p4so11248117wrt.7;
        Thu, 22 Nov 2018 23:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gQdZKYblrwTj4f+bCgwmPJ00GVcY5LnOcDagPbVLG3Y=;
        b=Fk4yUBRNxIqZjCaXkHOJ0T2WyX9VXGl7ElxKMqMFuY5UEVJk2GEKuA2cowTQXX3Nvw
         t8YSunHD7YbkjjauGQJWc9NPKjTFKzCQi9OhdP/cL5qeixwB3LRi8H8rrGgQQ3/sT7s8
         okp1fdzbsusfm5buavNpHtkuxpppyN2qzO7u5NB/ff/OsnTaSHWTjLhykoAhqHmcQNKN
         rllxQTd9C9BTshG/Sinc6SVvfY8ZVB1iXEwpyFihwP0eecgYX26yzW2IvMq/xQYbBJc2
         xd1tfFKMoi2jHjuPFlJ1awgryIVrsihsj5opS050HgzU7e8CnvyH0sl5MedEIk/0j41e
         PW3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=gQdZKYblrwTj4f+bCgwmPJ00GVcY5LnOcDagPbVLG3Y=;
        b=YgxxSjDyBbw8T4K8eZHX6yrvm3KcrLqnMOFCC83x8zOuPTI1LjEbpP4Ehx/W2cIR37
         C/ZF48FhL5G8dZ3aBJ7v/GKkrCLG5LNjd/liiqsIpYLUYp/Ry6jae2SXOed33hhHzPuK
         RjGV/+SmYOlmGfpDtJ6B2gnRgopgSxw6mt+Y6NtyEPGNwS8WK7UTzc/6CPOdCeBq/c0a
         /pqF0iyW9kssURFZQMQgASyNGvQ2HhLDEpCaL2xO3Eix+RR4iXpqQwHWx8o9RhqMF6Y+
         eCTiPaa538t+LMy0bsGjLrLEfzHTLYIV1V2Yl7ELSuZ+HV3PE9SWVIRVpvvRNRoEvdmY
         p/tA==
X-Gm-Message-State: AA+aEWbq8U0uLQG5ucIMgd3YOy+i4uP8vudeeA2vbtfXHrilX4wo00R0
        QLHPD45/TPcPp+Pw1G7j8qY=
X-Google-Smtp-Source: AFSGD/WIEJBED7akuaI6SyWLnTy/VUXnraCVdxMlXYa1fI8SBtyqyMXi/Gx2WErscWyZix0fvQtCKg==
X-Received: by 2002:a5d:470b:: with SMTP id y11mr11944684wrq.16.1542956602086;
        Thu, 22 Nov 2018 23:03:22 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id x8sm14620145wrd.53.2018.11.22.23.03.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 23:03:21 -0800 (PST)
Date:   Fri, 23 Nov 2018 08:03:19 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     wang.yi59@zte.com.cn, torvalds@linux-foundation.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
        peterz@infradead.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/cleanups] x86/headers: Fix -Wmissing-prototypes warning
Message-ID: <20181123070318.GA41027@gmail.com>
References: <1542852249-19820-1-git-send-email-wang.yi59@zte.com.cn>
 <tip-d37904c5b14317a2c76efec6b9e4dbcaa17380e5@git.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tip-d37904c5b14317a2c76efec6b9e4dbcaa17380e5@git.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* tip-bot for Yi Wang <tipbot@zytor.com> wrote:

> Commit-ID:  d37904c5b14317a2c76efec6b9e4dbcaa17380e5
> Gitweb:     https://git.kernel.org/tip/d37904c5b14317a2c76efec6b9e4dbcaa17380e5
> Author:     Yi Wang <wang.yi59@zte.com.cn>
> AuthorDate: Thu, 22 Nov 2018 10:04:09 +0800
> Committer:  Ingo Molnar <mingo@kernel.org>
> CommitDate: Thu, 22 Nov 2018 09:52:28 +0100
> 
> x86/headers: Fix -Wmissing-prototypes warning


>  #endif /* _ASM_X86_CRASH_H */
> diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
> index eea40d52ca78..063f1d4d698e 100644
> --- a/arch/x86/include/asm/efi.h
> +++ b/arch/x86/include/asm/efi.h
> @@ -173,8 +173,6 @@ static inline bool efi_runtime_supported(void)
>  extern struct console early_efi_console;
>  extern void parse_efi_setup(u64 phys_addr, u32 data_len);
>  
> -extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
> -
>  #ifdef CONFIG_EFI_MIXED
>  extern void efi_thunk_runtime_setup(void);
>  extern efi_status_t efi_thunk_set_virtual_address_map(

> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 845174e113ce..890c4cb37502 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -1053,6 +1053,8 @@ extern struct kobject *efi_kobj;
>  extern int efi_reboot_quirk_mode;
>  extern bool efi_poweroff_required(void);
>  
> +extern void efifb_setup_from_dmi(struct screen_info *si, const char *opt);
> +
>  #ifdef CONFIG_EFI_FAKE_MEMMAP
>  extern void __init efi_fake_memmap(void);
>  #else

These efifb_setup_from_dmi() changes were completely bogus and broke 
every non-x86 EFI architecture, which a simple:

  git grep efifb_setup_from_dmi

should have already exposed.

Did you actually check the usage of every single prototype and think 
about them case by case? It doesn't seem to be the case.

Thanks,

	Ingo
