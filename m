Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8698FC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:02:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9FD25496
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 06:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QeV6MbiR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E9FD25496
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeFYGCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 02:02:04 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39931 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751921AbeFYGCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 02:02:02 -0400
Received: by mail-io0-f196.google.com with SMTP id f1-v6so11364680ioh.6
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jun 2018 23:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bjxGr0QkxYa6s4tcjWsIujVLOjLRhcrhhQCmdHM1mO4=;
        b=QeV6MbiR3z6iGt6eFDSSyGBQI7mogAwc43FurRDvEYCJHUAa0MgcugZHNxUitx65aE
         IShCj4TgN5xSv7mh1j0gj57lClIR4kprIUvL0jG4fIdU86fsKohZFvb8Fjpxnf8p2zZC
         1fd4i3xmcTAqjHhT8BMcE13rWZcoTFpDfPd/8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bjxGr0QkxYa6s4tcjWsIujVLOjLRhcrhhQCmdHM1mO4=;
        b=bOgqIfnBIEIr6axb61Vv76XQKXtIEdd3WsNJ3XB6zs0ookz/Brrs6XdjJXc6wpsG38
         eOAwyU/ty6TEd1RDNDnPOPhcu3q722TVZx0UGmnXiVnCtlu2StNaSvpCY0hKlJHlyFSY
         hiwrN7mW1ltE3yn6+ItLOJz5b8wY467ajXt3Yi3PJ5kIlZINdpYW6bjsYCC4lAbw/ur9
         4Kmz3BiEn4UIkJHnpdYvoqVslpc16NCkOMTsHYA3b/DJ+OKNrapSGq3vAFS9p8BhQrrg
         4elTUNjaLHzf7j94TFhS+7s2gtToD4V8qg9NflOlJXTlDWVpnDIQ66/U54BW4eisANBK
         +3SA==
X-Gm-Message-State: APt69E14U+OMCPasCMRRKahbJkm8O3raTlb5Y2YccxlKCWYFWfu2r/7Y
        wKO/3/o3hKEPIbGS8z0yyTSVoFfOFdw8xIQs0IoaAg==
X-Google-Smtp-Source: AAOMgpfMctzqgyBiGiLzgAdlon7Y2Y+GTB9INfC10h2AnClkdhRHT+nL+Lx6MixgwntieHwZ1usD4MutJ141rolzgE4=
X-Received: by 2002:a6b:5d09:: with SMTP id r9-v6mr5507634iob.170.1529906521697;
 Sun, 24 Jun 2018 23:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Sun, 24 Jun 2018 23:02:01
 -0700 (PDT)
In-Reply-To: <1529891271-24319-1-git-send-email-sai.praneeth.prakhya@intel.com>
References: <1529891271-24319-1-git-send-email-sai.praneeth.prakhya@intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 25 Jun 2018 08:02:01 +0200
Message-ID: <CAKv+Gu_xK9WSVPx-gfy=vNjUsrT8aChofghjDbQPJaHPkS7bnw@mail.gmail.com>
Subject: Re: [PATCH] efi: Remove the declaration of efi_late_init() as the
 function is unused
To:     Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lee Chun-Yi <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Dave Young <dyoung@redhat.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ravi Shankar <ravi.v.shankar@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 June 2018 at 03:47, Sai Praneeth Prakhya
<sai.praneeth.prakhya@intel.com> wrote:
> From: Sai Praneeth <sai.praneeth.prakhya@intel.com>
>
> Commit 7b0a911478c74 (efi/x86: Move the EFI BGRT init code to early
> init code), removed the implementation and all the references to
> efi_late_init() but the function is still declared at
> include/linux/efi.h. Hence, remove the unnecessary declaration.
>
> Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> Cc: Lee Chun-Yi <jlee@suse.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Young <dyoung@redhat.com>
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Ricardo Neri <ricardo.neri@intel.com>
> Cc: Ravi Shankar <ravi.v.shankar@intel.com>
> Cc: Matt Fleming <matt@codeblueprint.co.uk>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks Sai

Queued in efi/next

> ---
>  include/linux/efi.h | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/include/linux/efi.h b/include/linux/efi.h
> index 56add823f190..ae47be636b98 100644
> --- a/include/linux/efi.h
> +++ b/include/linux/efi.h
> @@ -988,14 +988,12 @@ extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
>  extern void efi_gettimeofday (struct timespec64 *ts);
>  extern void efi_enter_virtual_mode (void);     /* switch EFI to virtual mode, if possible */
>  #ifdef CONFIG_X86
> -extern void efi_late_init(void);
>  extern void efi_free_boot_services(void);
>  extern efi_status_t efi_query_variable_store(u32 attributes,
>                                              unsigned long size,
>                                              bool nonblocking);
>  extern void efi_find_mirror(void);
>  #else
> -static inline void efi_late_init(void) {}
>  static inline void efi_free_boot_services(void) {}
>
>  static inline efi_status_t efi_query_variable_store(u32 attributes,
> --
> 2.7.4
>
