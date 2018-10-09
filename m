Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E5C67879
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D7492089D
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 00:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aZSEJsh0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7492089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbeJIHPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 03:15:08 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:35402 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725759AbeJIHPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 03:15:08 -0400
Received: by mail-yb1-f193.google.com with SMTP id o63-v6so9045247yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 17:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+EY68jU23cHCUh3qrjP91Ou2eUhLMEGFdbxmQTJSC/g=;
        b=aZSEJsh00X5arTmu1NHKkDoTlOXYXajB3zAA3Ar/9meX5L7k5Dg570L0ShpIJtozkN
         M2zt9DmG1K9ByIMeW/sG+AeoeAFlIjEOILHlvptAC4A+TD/afMTZXbrlY3c8a7aFIEiX
         sq6DHY8zqZxECnuFkuBlfGGQFijumYEyHsN9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+EY68jU23cHCUh3qrjP91Ou2eUhLMEGFdbxmQTJSC/g=;
        b=c4pXSbCDLoEHFLFdyjxaW0RriCtCDH3tpmeivDeLVC3umpIaHKgmi4agzJV9NxcUFw
         NgX+G3wmjket8KwYqUldgdVYjYtCHacpz4rGbIq4GJ5S1R76wZihUaZAq8QF2RiUV6H8
         TaOG0r0Pprc8+8BWa+RCK1Fvz4SjWPT++L4Odjez3Kz8zp794Nvm7VjHT7yqvDgZ4vxW
         GYrdh0Yg8NuZSAenXdU2SsvZuqz6k0HtAxi8wg68I/ZBA79ZzAn0IPKRjcqlBx0nHKOu
         mB4b011fyROYni+VC/lDhdBQqjU/9BtM8mU/3hpqh54OU/vMfHFMg/3MtIu1Kyh8Ges+
         rIDA==
X-Gm-Message-State: ABuFfoiw64eYNQgI8Z3UJs1TtCw8iDKfb+t/w3WMWT7PCsQcmvBQo/WZ
        +VtYTaypOZNHVPZXZrZQmm7czvQxXXo=
X-Google-Smtp-Source: ACcGV604vLMN7oZae2dgJMdz2zfci49gA0EGC/YnZ04aebGlUAQC2f8ZqjSdBi9bL0UFa3isZ8Oo/A==
X-Received: by 2002:a25:7546:: with SMTP id q67-v6mr2661259ybc.482.1539043254571;
        Mon, 08 Oct 2018 17:00:54 -0700 (PDT)
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com. [209.85.219.173])
        by smtp.gmail.com with ESMTPSA id j202-v6sm7421252ywb.69.2018.10.08.17.00.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Oct 2018 17:00:53 -0700 (PDT)
Received: by mail-yb1-f173.google.com with SMTP id o63-v6so9045216yba.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Oct 2018 17:00:53 -0700 (PDT)
X-Received: by 2002:a25:3588:: with SMTP id c130-v6mr14633607yba.410.1539043252651;
 Mon, 08 Oct 2018 17:00:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d116:0:0:0:0:0 with HTTP; Mon, 8 Oct 2018 17:00:51 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1810082151160.2455@nanos.tec.linutronix.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 8 Oct 2018 17:00:51 -0700
X-Gmail-Original-Message-ID: <CAGXu5jKdaq=xHvvQ6GazhnWsPu4R16Gbo1OrPatKxVRf4ZYuPA@mail.gmail.com>
Message-ID: <CAGXu5jKdaq=xHvvQ6GazhnWsPu4R16Gbo1OrPatKxVRf4ZYuPA@mail.gmail.com>
Subject: Re: [PATCH] x86/mm: Do not warn about PCI BIOS W+X mappings
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 8, 2018 at 12:53 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> PCI BIOS requires the BIOS area 0x0A0000-0x0FFFFFF to be mapped W+X for
> various legacy reasons. When CONFIG_DEBUG_WX is enabled, this triggers the
> WX warning, but this is misleading because the mapping is required and is
> not a result of an accidental oversight.
>
> Prevent the full warning when PCI BIOS is enabled and the detected WX
> mapping is in the BIOS area. Just emit a pr_warn() which denotes the
> fact. This is partially duplicating the info which the PCI BIOS code emits
> when it maps the area as executable, but that info is not in the context of
> the WX checking output.
>
> Reported-by: Paul Menzel <pmenzel@molgen.mpg.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/x86/mm/dump_pagetables.c |   35 +++++++++++++++++++++++++++--------
>  1 file changed, 27 insertions(+), 8 deletions(-)
>
> --- a/arch/x86/mm/dump_pagetables.c
> +++ b/arch/x86/mm/dump_pagetables.c
> @@ -19,7 +19,9 @@
>  #include <linux/sched.h>
>  #include <linux/seq_file.h>
>  #include <linux/highmem.h>
> +#include <linux/pci.h>
>
> +#include <asm/e820/types.h>
>  #include <asm/pgtable.h>
>
>  /*
> @@ -241,6 +243,29 @@ static unsigned long normalize_addr(unsi
>         return (signed long)(u << shift) >> shift;
>  }
>
> +static void note_wx(struct pg_state *st)
> +{
> +       unsigned long npages;
> +
> +       npages = (st->current_address - st->start_address) / PAGE_SIZE;
> +
> +#ifdef CONFIG_PCI_BIOS
> +       /*
> +        * If PCI BIOS is enabled, the PCI BIOS area is forced to WX.
> +        * Inform about it, but avoid the warning.
> +        */
> +       if (pcibios_enabled && st->start_address >= PAGE_OFFSET + BIOS_BEGIN &&
> +           st->current_address <= PAGE_OFFSET + BIOS_END) {
> +               pr_warn_once("x86/mm: PCI BIOS W+X mapping %lu pages\n", npages);
> +               return;
> +       }
> +#endif
> +       /* Account the WX pages */
> +       st->wx_pages += npages;
> +       WARN_ONCE(1, "x86/mm: Found insecure W+X mapping at address %p/%pS\n",
> +                 (void *)st->start_address, (void *)st->start_address);

Probably we should just drop the "%p/" part. %pS should give us
everything we need and %p will be meaningless normally.

Otherwise, yes, this look good.

-Kees

-- 
Kees Cook
Pixel Security
