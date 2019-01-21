Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E73C2F43D
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78EA220870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 15:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548085342;
	bh=w+vaaNuwR+b7JilUMpCmSZIY5nBV1f66YFttvClFKlg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U/XKM3zNXShiEq/iIHsQpwf3vHrXvjjYYnwiFxKA+saANBPQzCUD1n1sNVDlBh2de
	 Ht2ajl1U0dHtlFrjtn8/xDM9Yc1BXr4+EMec327Bajxs6ClbZWPf1E2UxMnW92GnG6
	 fazJPS7FopNLG5odJnXOBOYQdG7TfNQYCdlFbAY8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbfAUPmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 10:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729864AbfAUPmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 10:42:20 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A89E2087F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 15:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548085339;
        bh=w+vaaNuwR+b7JilUMpCmSZIY5nBV1f66YFttvClFKlg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DuyQLTURzSwtYFeb0DGYcD/JbGhBFD/EPqTLdydAoKZMrbMYvcXQhlvjVZ9X845V3
         i8/PjLTkWRnHY12rjgQK7dnhks/0M6QNjCJO/m4aBFsEny4XDcJykO3R5+dpZLV51r
         BDEvERyYRSaE4V/kVQG8JPeR7y06KJfz+CEyz4SA=
Received: by mail-qt1-f178.google.com with SMTP id p17so24013470qtl.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 07:42:19 -0800 (PST)
X-Gm-Message-State: AJcUukcsAQXjzjXsVBZNSpXT9ByqfiDrX8W414Ygwf5FKRXRuNOp6N+g
        srcfekLOvF1vWGQt9tuBe11lHYE0DC2lGYttvQ==
X-Google-Smtp-Source: ALg8bN5+56fGfeF8dyQAV7F4YxObcFbfURazVQrQh8ZhVlJoObaGJpzN7ALEzVImqsNrlUvn3qbkzfgmJ0kBHV8ujIA=
X-Received: by 2002:aed:29a6:: with SMTP id o35mr26531779qtd.257.1548085338299;
 Mon, 21 Jan 2019 07:42:18 -0800 (PST)
MIME-Version: 1.0
References: <f6fbf528-8213-e3b8-6990-9fcf9dec04d6@free.fr> <20190118143434.GE118707@arrakis.emea.arm.com>
 <b7629ecf-757c-f8b5-df83-ba83d7036b2f@free.fr> <20190119132832.GA29881@MBP.local>
 <6579db26-10ac-3fbf-1998-5b937a38f202@free.fr> <d4facdc2-0581-929f-caa2-b9efa9bd8f97@arm.com>
 <CAL_JsqKFT8J6g02gxeBiTfBb_XHhp2-ZNB6DgaLPK85kNZGRig@mail.gmail.com> <20190121143704.GE29504@arrakis.emea.arm.com>
In-Reply-To: <20190121143704.GE29504@arrakis.emea.arm.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 21 Jan 2019 09:42:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
Message-ID: <CAL_JsqKQb34zVNTzo9DLNiDwmWGxkrKezSOjwCUPAvgzUoLYjg@mail.gmail.com>
Subject: Re: kmemleak panic
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Frank Rowand <frowand.list@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Qian Cai <cai@lca.pw>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Mike Rapoport

On Mon, Jan 21, 2019 at 8:37 AM Catalin Marinas <catalin.marinas@arm.com> wrote:
>
> On Mon, Jan 21, 2019 at 07:35:11AM -0600, Rob Herring wrote:
> > On Mon, Jan 21, 2019 at 6:19 AM Robin Murphy <robin.murphy@arm.com> wrote:
> > >
> > > On 21/01/2019 11:57, Marc Gonzalez wrote:
> > > [...]
> > > > # echo dump=0xffffffc021e00000 > /sys/kernel/debug/kmemleak
> > > > kmemleak: Object 0xffffffc021e00000 (size 2097152):
> > > > kmemleak:   comm "swapper/0", pid 0, jiffies 4294892296
> > > > kmemleak:   min_count = 0
> > > > kmemleak:   count = 0
> > > > kmemleak:   flags = 0x1
> > > > kmemleak:   checksum = 0
> > > > kmemleak:   backtrace:
> > > >       kmemleak_alloc_phys+0x48/0x60
> > > >       memblock_alloc_range_nid+0x8c/0xa4
> > > >       memblock_alloc_base_nid+0x4c/0x60
> > > >       __memblock_alloc_base+0x3c/0x4c
> > > >       early_init_dt_alloc_reserved_memory_arch+0x54/0xa4
> > > >       fdt_init_reserved_mem+0x308/0x3ec
> > > >       early_init_fdt_scan_reserved_mem+0x88/0xb0
> > > >       arm64_memblock_init+0x1dc/0x254
> > > >       setup_arch+0x1c8/0x4ec
> > > >       start_kernel+0x84/0x44c
> > > >       0xffffffffffffffff
> > >
> > > OK, so via the __va(phys) call in kmemleak_alloc_phys(), you end up with
> > > the linear map address of a no-map reservation, which unsurprisingly
> > > turns out not to be mapped. Is there a way to tell kmemleak that it
> > > can't scan within a particular object?
> >
> > There was this patch posted[1]. I never got a reply, so it hasn't been applied.
> >
> > https://patchwork.ozlabs.org/patch/995367/
>
> Thanks Rob, I wasn't aware of this patch (or I just missed it at the
> time).
>
> I wonder whether kmemleak should simply remove ranges passed to
> memblock_remove(), or at least mark them as no-scan.

Seems reasonable to me, but of course that impacts a lot of other
cases. Maybe Mike R has some thoughts?

Rob
