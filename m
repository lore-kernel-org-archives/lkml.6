Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31CEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9632147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 05:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="GcZXO4e4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725998AbfBZFDN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 00:03:13 -0500
Received: from mail-ot1-f53.google.com ([209.85.210.53]:38417 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbfBZFDM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 00:03:12 -0500
Received: by mail-ot1-f53.google.com with SMTP id m1so10068126otf.5
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 21:03:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wwgR6yeFRT6B3IKxyeg5mKh+1+c6JM7isQ7KgpYbXnI=;
        b=GcZXO4e4kon+DOCwNlnCJDZjTcMui+u9oc0gvoKPP72kGuTRoRvZ09g9mvP31A1lEt
         w50l5xZG7hSRNaziiBfhasvONdCS71Gcb9K3nVNniaENzjHY4PdGmfDKombm7VNorlOs
         1QYf8pZjNvxYlfD0L7dUxvZhP8myOQzP/pSEkogQoC5ByRI2rREpXrsa3FQtrmAaZhOg
         J3W2sWWBCfE17jJXm3Y3N2qGa7dg+ycWOS2ut0RQFPiObTj0vyg/m/6QyOUsQKYaSfsG
         bIN9EKbDjjycDrMlcP+Ya1Pboru1LSrSYmwI4OtKQOI0l/S81oYf++F6wLw9igql9xRr
         583w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wwgR6yeFRT6B3IKxyeg5mKh+1+c6JM7isQ7KgpYbXnI=;
        b=CdtqRj8dGwYSCGiPxVPEiC9dBkuHjOy+dEmqezwT8wfRhUohUczEUaDynlzg+HY63X
         vri6sBZFA5QD68yJrHmVImFAeZYxiXGfY1RKZYKdLlqyCzElAa3dO4Ve3TSV+S89IuaT
         SoObrw19QvvpuSuLVqqDCf+mD+1l/8pLnM54GV05ksSDOml16SoMbRxMKVsalPFVQxZb
         4DVsHCNNiXrbPfos5yTgXpepkX/YTtmEjeBeOIQhgulqSGlLGvBRQ5L4EzGiyNm4WjV/
         gIy+pQBPth70iEIcUi2z5GOJo4fYywevg5NKsv4ts8LPMNQQY8o2QacXCC/ERbQkuxRB
         HReQ==
X-Gm-Message-State: AHQUAuZwOOQlpyPfI+QwMBmsE1entBt3tpFn8TZbYpi+sfTYB3HjGjBn
        yTEwHojhotKV9xkpFwdcx7JTCh15wj8QepdxRR1jrA==
X-Google-Smtp-Source: AHgI3IZuXyTFqzyW5LBzyAD7wGYMP2aN8r1X+kII34yqoHOxZ+Xk0lGm/Z3ou8SEpBDzGdryseX0gvHowq5pIyL5u2k=
X-Received: by 2002:a9d:77d1:: with SMTP id w17mr13455120otl.353.1551157392161;
 Mon, 25 Feb 2019 21:03:12 -0800 (PST)
MIME-Version: 1.0
References: <CAPcyv4gs7nGnf81Lj-Hf04uhmMb2wxKzi42ajaNVCHty7PAsAQ@mail.gmail.com>
 <20190216153511.GM12668@bombadil.infradead.org> <20190216172948.GN12668@bombadil.infradead.org>
 <20190216211105.GO12668@bombadil.infradead.org>
In-Reply-To: <20190216211105.GO12668@bombadil.infradead.org>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 25 Feb 2019 21:03:00 -0800
Message-ID: <CAPcyv4j8G0S4Z2ngzrz_OhFjp8+4tqCtpRRE6Eq33uczh0QBRA@mail.gmail.com>
Subject: Re: find_get_entries_tag regression bisected
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-nvdimm <linux-nvdimm@lists.01.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Balcer, Piotr" <piotr.balcer@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 1:11 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sat, Feb 16, 2019 at 09:29:48AM -0800, Matthew Wilcox wrote:
> > On Sat, Feb 16, 2019 at 07:35:11AM -0800, Matthew Wilcox wrote:
> > > Another way to fix this would be to mask the address in dax_entry_mkclean(),
> > > but I think this is cleaner.
> >
> > That's clearly rubbish, dax_entry_mkclean() can't possibly mask the
> > address.  It might be mis-aligned in another process.  But ... if it's
> > misaligned in another process, dax_entry_mkclean() will only clean the first
> > PTE associated with the PMD; it won't clean the whole thing.  I think we need
> > something like this:
>
> Nope, this isn't enough.  It's _necessary_ to find the processes that
> have part of this PMD page mapped, but not the start of it.  But it's
> not _sufficient_ because it'll still only mkclean the first PTE.  So we
> need a loop.  I'm feeling a bit over my head here.  I may have a go at
> a fuller fix, but if someone else wants to have a go at it, be my guest!

Nothing comes to mind outside of pseudo-reverting this conversion by
introducing a way to get back to the old semantics. If you don't see a
path forward, us mere Xarray-mortals stand no chance.
