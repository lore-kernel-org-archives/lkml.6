Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A5EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:23:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC39320663
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 19:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="eljcFXTp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC39320663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbeK1GWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 01:22:03 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:50900 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbeK1GWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 01:22:02 -0500
Received: by mail-it1-f194.google.com with SMTP id z7so365757iti.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 11:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dtxnaGKAn0penH7rfmR72FmsgiEXSZktg9IsWreVmHE=;
        b=eljcFXTpCyHRJfDlE6ZB6i/gZFy4sxHpJ7ai4nt5kSJehb7Cd3hWoP/I/APP7M9bDX
         MzHsUP18O2MKna7oZwhH2vPknS8gPiwtBR4u+iRzUiNGk5eb+/SSMocw54/RQKR3bGv0
         kwFA3S2SYsWFu4gsK7rnDgrRygHClyG//Li/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dtxnaGKAn0penH7rfmR72FmsgiEXSZktg9IsWreVmHE=;
        b=WkurzpKxjz6kTuit8Co6h1y4nO1uA2VfdL3AzPcKswBsB/5VHCWXPFa9/UHbviekQL
         W9ri+Q+Mk7VXMc9cJYMNYTm6/sSZ8XJX+noZf1lniZyC0BtpNkRcopDqkdU79bjXs2GF
         fOvrN79yO29E23lKTwNe6VLkZibiR5r6SyqMZF4fCa9cVWLKSC3+KFzCULk1pR50D/Di
         vtFw9Z6OEBdx75+ryJIeZXGtBB7g2nMUQj4vgKIdoBq0cNZKbeahKVTmS5oUL1Q5qKmF
         INwvzXS6zHHEQpEF2ndFKPaMvOgSzzQPR/ETVehkKZUwEkaqhUCMmZNB0H4kLNbw7kT3
         acnw==
X-Gm-Message-State: AA+aEWbQpMHEizhzi88LtedWbChkA5xRAO3gEhE7zoiTFReebOXC8suZ
        b4P1AtoMIR7+NMHH28mBM/QBybMklsZ9zUVkSEHCGQ==
X-Google-Smtp-Source: AFSGD/XqHA7sj0lIVqn8PYVOk7Ja+Khovi6Wtk5AhQud4tFDQxnIuceycw3W8mqfkf3yngkRGoWuEPemaRjf9Hj/fpI=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr141195itk.71.1543346219530;
 Tue, 27 Nov 2018 11:16:59 -0800 (PST)
MIME-Version: 1.0
References: <20181114175544.12860-1-ard.biesheuvel@linaro.org>
 <20181114175544.12860-6-ard.biesheuvel@linaro.org> <a8346212-70cb-0bbb-9e29-e21fa2ee5040@arm.com>
In-Reply-To: <a8346212-70cb-0bbb-9e29-e21fa2ee5040@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 27 Nov 2018 20:16:47 +0100
Message-ID: <CAKv+Gu8HFq0EnQv6PBVXqO5=WCBqA=ztwb+-otrpBz+J9SnHfA@mail.gmail.com>
Subject: Re: [PATCH 5/5] efi: permit calling efi_mem_reserve_persistent from
 atomic context
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Nov 2018 at 19:59, Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Hi Ard,
>
>
> On 11/14/2018 11:55 AM, Ard Biesheuvel wrote:
> > Currently, efi_mem_reserve_persistent() may not be called from atomic
> > context, since both the kmalloc() call and the memremap() call may
> > sleep.
> >
> > The kmalloc() call is easy enough to fix, but the memremap() call
> > needs to be moved into an init hook since we cannot control the
> > memory allocation behavior of memremap() at the call site.
>
> So, at first glance this looks correct until I noticed that
> its_cpu_init_lpis() is being called before the early_initcalls are run.
>
> This results in the WARN_ON triggering with the following backtrace:
>
> [    0.000000]  its_cpu_init_lpis+0x1d4/0x2e0
> [    0.000000]  its_cpu_init+0x78/0x1b4
> [    0.000000]  gic_init_bases+0x2c4/0x2e0
> [    0.000000]  gic_acpi_init+0x158/0x270
> [    0.000000]  acpi_match_madt+0x4c/0x84
> [    0.000000]  acpi_table_parse_entries_array+0x140/0x218
> [    0.000000]  acpi_table_parse_entries+0x70/0x98
> [    0.000000]  acpi_table_parse_madt+0x40/0x50
> [    0.000000]  __acpi_probe_device_table+0x88/0xe0
> [    0.000000]  irqchip_init+0x38/0x40
> [    0.000000]  init_IRQ+0xfc/0x130
> [    0.000000]  start_kernel+0x344/0x4cc
>
> due to the efi_memreserve_root not yet being set.
>

Yup

https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?h=efi/urgent&id=976b489120cdab2b1b3a41ffa14661db43d58190

That should fix it. Please let me know if it doesn't work for you
