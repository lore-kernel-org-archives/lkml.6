Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117DBC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D13A92054F
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 11:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDe82Sb4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbfAQLX7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 06:23:59 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:37676 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbfAQLX6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 06:23:58 -0500
Received: by mail-lf1-f65.google.com with SMTP id y11so7508084lfj.4
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jan 2019 03:23:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZAuKN4FHOkeuvFTVfdXuwEyS7W+wswuosNv2Pa8ysE=;
        b=kDe82Sb4BfkBwqNE3l3qCPBQRWjCXAMCiNQ4eoXgTk6ztyOTbiyGE+tms6+mFmqU4i
         1MWb2xNrSjUodizYBNrccHWBOzyJe16tfhhu6NJiPXn/bmSyg0ECdnFS76ZKEpsJSJYk
         BlUpZ1Kei/vlJ55BigXZ5ACN1kXug0y/N24QJskK+3ZtXEKnyZb0RjGyEp7IOVzrC5GR
         YxR5vtvc7WJM3gtlfO5ER1FkTQBpECr8tHYVxuhcS7xPqVwxAmRWk1r4WI0DSJ/Su8o/
         4NgYSlmT34YJUgYuZX2OfTaF1KoRHpIIq9Q3G4JBijCaVi7Z1IOlu0g26WorgE5cbP1R
         kUvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZAuKN4FHOkeuvFTVfdXuwEyS7W+wswuosNv2Pa8ysE=;
        b=ZxqjP+CQKYd1KOFKfvqaCBWE6tB8kYzv76U5rrJI0DAhTJu6eriJ6D3viRVAbdx5YQ
         /dBMGXwA0dd5xqi+nuDoXlrKiPIK8TJJW/sVRG4fHMrjoaqZ3tnIVFr3Gm9KFFi5w7Nk
         UT9fhvZ5LbuppEZsmF4EW7d1qI+LHkMlryE1YxnO5GzmhxpZ8xq+hlcFRoV/zBy34ZBM
         oaIg9F+jGLv1GAz2ob7GEp5EQXyASieD5PRlXIaPhpXPar0exja6ncFRqDNM2vdp/7IH
         inNHYFYrikzaD36Un3LIfCdQko8+MoO50f4I00pNmACRek2XPcCduBAwvHNvn3wYbtKU
         F4Ug==
X-Gm-Message-State: AJcUukf8RmJOxa+4PezpriTj/9pbKZp0NaHL8PT+5J9+wmncJ0jyMGMK
        17c8L0vQIhCQO1Ghi8xi4qVYuvNE6VFIONqUgCs=
X-Google-Smtp-Source: ALg8bN6YVJ9BGmyrwg1/LPDqrGvSCHD/6Z2SagrixxHQrMHQSrRvVZkL9u4zTosJ5PU7vgAjpUXiCL6PJJwm1yun+xk=
X-Received: by 2002:a19:2906:: with SMTP id p6mr9702397lfp.17.1547724236455;
 Thu, 17 Jan 2019 03:23:56 -0800 (PST)
MIME-Version: 1.0
References: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
In-Reply-To: <20190107172805.GA8462@jordon-HP-15-Notebook-PC>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Thu, 17 Jan 2019 16:53:44 +0530
Message-ID: <CAFqt6zbbXvpEEH2rNnLCBpNxEjK3YwNS1kYkyFPBhG7uvsHE1A@mail.gmail.com>
Subject: Re: [PATCH] arch/arm/mm: Remove duplicate header
To:     Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michal Hocko <mhocko@suse.com>, rppt@linux.vnet.ibm.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 7, 2019 at 10:54 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> Remove duplicate headers which are included twice.
>
> Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>

Any comment on this patch ?

> ---
>  arch/arm/mm/mmu.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index f5cc1cc..dde3032 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -23,7 +23,6 @@
>  #include <asm/sections.h>
>  #include <asm/cachetype.h>
>  #include <asm/fixmap.h>
> -#include <asm/sections.h>
>  #include <asm/setup.h>
>  #include <asm/smp_plat.h>
>  #include <asm/tlb.h>
> @@ -36,7 +35,6 @@
>  #include <asm/mach/arch.h>
>  #include <asm/mach/map.h>
>  #include <asm/mach/pci.h>
> -#include <asm/fixmap.h>
>
>  #include "fault.h"
>  #include "mm.h"
> --
> 1.9.1
>
