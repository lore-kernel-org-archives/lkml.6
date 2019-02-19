Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE6F2C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CA5821736
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 15:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EgXxWNf4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727645AbfBSP3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 10:29:43 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36746 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbfBSP3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 10:29:43 -0500
Received: by mail-it1-f195.google.com with SMTP id h6so7136053itl.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 07:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1IrSqaPXH7ci0S/zHuzbtcDJp+fF9ea0eam+spv38+Q=;
        b=EgXxWNf49iw439H2FOZgyYNFnlA38VB1XN8tdIEp7Ndqv9+3lWwEqhTPROunzBT0bK
         RfWn0BlkceIRrAOwnNearaygZlYCVcuW3y10jS5XHeaoABn4eVcY3R2ef3SqXjTAUtYN
         6QOxV5lLiBA97XXvg+sUhFg36bDS34wOrtS8h5w782nIV9PETHQwoVjJqnyjF4MRZw/c
         9BLubd1WuLhuGbrnULhGhQOa98U8ry/zOy8KckS4ayhbgF55HCAmB+2OKHgmPd0Djd4A
         tfOGNzQseY6Ucw8867D/yzYqIYq41Z6D/83pzr9nChuhsjk9H+1/6/ZYaCTRYxesE0vs
         GnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1IrSqaPXH7ci0S/zHuzbtcDJp+fF9ea0eam+spv38+Q=;
        b=X7BPBVUxj0BleGHd2KjO8hPOPL325bGWyZjHN8oXuafwEn372ovlRvkTIFeNvwHqBf
         bm/o22GkE7vPqBiRk1x1sob3b++U62KUM4LA3myWN2mAZknu4Y0vLYTbMxgy4Vs499Nu
         Mu48iYZyb9tfAKe/9yj+nciXkjbj1FdhRRnSJ8cI31TVxwaM+eESu+/K6szKA0yJydX4
         b1zhT5y05tyEO3iuACQVsZ+sFSBtqNxo3Zkgi6jGdWsAn4i1Iy9eyB5QEvUKym6nSVq8
         bKRsXQw3T9kBVPn7dErNJeq9fZXO/CbSDkl9vW5aqf3oo/WEZZNhkEOdO71IFrjh8kwb
         xBVQ==
X-Gm-Message-State: AHQUAuagA5mVqtLNJAO8AdKA/iImw7GWDr30NRtAdZb4cobJHKXDzU0+
        6uZEeNAkOpEWFkqfcd8nZY3VUFTq7mC22MFEXsHwTw==
X-Google-Smtp-Source: AHgI3IYySwRhMap6e3N429moLVL0QAjoze2nt7wW6jALNn0zXD9JPF+BLvEsAAEejzIi425yXzCQnBXkiK7NhPIcsKY=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr18691715ioj.60.1550590182346;
 Tue, 19 Feb 2019 07:29:42 -0800 (PST)
MIME-Version: 1.0
References: <20190217105926.GA69415@gmail.com> <CAHk-=wi=ooh9chSKyLipU6+eFbdfc680PUn3uKEoxLAMDMyMgg@mail.gmail.com>
 <20190219151639.GA77461@gmail.com>
In-Reply-To: <20190219151639.GA77461@gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Feb 2019 16:29:30 +0100
Message-ID: <CAKv+Gu85QM5LM++7L6Tn-DfUuYZ5dzzm00LipgenVr8qyAsmZg@mail.gmail.com>
Subject: Re: [RFC GIT PULL] EFI fixes, memblock quirk
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tejun Heo <tj@kernel.org>, Yinghai Lu <yinghai@kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Tang Chen <tangchen@cn.fujitsu.com>,
        Alexander Kuleshov <kuleshovmail@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Feb 2019 at 16:16, Ingo Molnar <mingo@kernel.org> wrote:
>
>
> * Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > On Sun, Feb 17, 2019 at 2:59 AM Ingo Molnar <mingo@kernel.org> wrote:
> > >
> > > I marked it RFC: please have a second look at the mm/memblock.c change,
> > > which adds a INIT_MEMBLOCK_RESERVED_REGIONS detour that ARM64 takes for
> > > these systems.
> >
> > It's not pretty, but it looks minimal for now. Pulled.
>
> Thanks!
>
> > > Perhaps we should upgrade the build time sizing of all platforms to
> > > INIT_MEMBLOCK_REGIONS+NR_CPUS+1 and thus centrally give an extra
> > > allocation entry per CPU configured?
> > >
> > > Or is there some cleaner solution?
> >
> > Is there some reason other platforms might want that kind of thing?
>
> Not that I'm aware of.
>

Nor me.

> > If not, then the current hack seems sufficient.
>
> Ok!
>

Thanks. It's a bit of a hack indeed, but every other option I explored
was a lot nastier. We might be able to tweak the LPI table allocation
logic so that they are adjacent, taking up only a single slot in the
reservation table, but that will have to wait for v5.2
