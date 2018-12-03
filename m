Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632CCC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32C59208A3
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bT9GXCy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32C59208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbeLCRlG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:41:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:39255 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbeLCRlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:41:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id 101so6823216pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BgEaxCO/470PEVlbeluTKHTbaxmkta1dSRL0CqOJKW0=;
        b=bT9GXCy999iFGDnhUMyg8ueoUF0syZGQWV+OjFV02R5yJE6lZH4++lr6elly5LYQeH
         AB5+g5qyalzIbBdaLmquTvrNxSvpeFrYOObuhuDSWhTCws3HjhFTMDUvOGVdYBYaaYv5
         KdB2HPZGlIJguL1vgTxBb28H6RRxbWHk81ykwo4Rlzsf/ieP+DvLVUgUDx3soJzG5wKo
         3LBtkkOXETRsfmowt6K+Kb9YXs6MVZjj+H3vBQk1TnoALDbPGLiGhItG11nOBDcEgJSV
         XR6gu59T9TOAayFz6GH77TZchfT10cFlFzsLNfsIUjPUvY6SJ2jDw7fSjtBaNt6avx46
         ogzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BgEaxCO/470PEVlbeluTKHTbaxmkta1dSRL0CqOJKW0=;
        b=U0AUTqU9RbcycoUU0J8Mnp+caUChXIo69p2xEzrrUWq39iptZYlToPbTWj6kzc/uh4
         ayzcqBBLWmoZdDtPejBGEhnEqDDpUpRpIWFQx4cFZUFKBN3b+gs/bnODrvW6gR+VLlWp
         aAJqmZ01XAmPEhAYLuKKQfH9UzpkDy6bC2TBoMecgVVKoXtag+e8BHMLdYRR/Pl6sWGF
         VI1Yxgla7Mmfbnmhrknh46B11JoaEpWuMqImJuVi1Tng8Auq37bTg8D+aL6mnAWnkclW
         wJdKPzinjJBVD8uNqHDTJtebF+xbQHoodKnzvUeU+PtZ4HYLz7Ijp+wfaqkW1/C/M8KI
         kD5g==
X-Gm-Message-State: AA+aEWaKtSxI5Awy+9HG7JfkW6PQ5CLfDnTxwOsv0go/ooVgLHsMqVd4
        ls9nHWG+JJpspxGUPBGt0SfUfg==
X-Google-Smtp-Source: AFSGD/VOW6pRA2/GhFTOD6TCbWRIuUa37reu4ofYU1qOj0TS7d2A9IOKIz/L0tR2IM3PQu0jEjqqBw==
X-Received: by 2002:a17:902:20c6:: with SMTP id v6mr17101855plg.156.1543858857489;
        Mon, 03 Dec 2018 09:40:57 -0800 (PST)
Received: from gnomeregan.cam.corp.google.com ([2620:15c:6:14:ad22:1cbb:d8fa:7d55])
        by smtp.gmail.com with ESMTPSA id z62sm22014544pfi.4.2018.12.03.09.40.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 09:40:57 -0800 (PST)
Date:   Mon, 3 Dec 2018 12:40:51 -0500
From:   Barret Rhoden <brho@google.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Jiang <dave.jiang@intel.com>, zwisler@kernel.org,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, rkrcmar@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "Zhang, Yi Z" <yi.z.zhang@intel.com>,
        alexander.h.duyck@linux.intel.com
Subject: Re: [PATCH v2 0/3] kvm: Use huge pages for DAX-backed files
Message-ID: <20181203124051.05c1d2ce@gnomeregan.cam.corp.google.com>
In-Reply-To: <CAPcyv4jga=HnsfHffWoo+JjRUBf3stD4VP3B5X5xSOZb=yh+Mw@mail.gmail.com>
References: <20181109203921.178363-1-brho@google.com>
        <20181114215155.259978-1-brho@google.com>
        <CAPcyv4jga=HnsfHffWoo+JjRUBf3stD4VP3B5X5xSOZb=yh+Mw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-11-14 at 16:55 Dan Williams <dan.j.williams@intel.com> wrote:
> [ add Alex who is looking into removing PageReserved for DAX pages. ]

Thanks.  I can keep my eye out for his patches and repost once that's
done.  

Alternatively, if you all want to merge this before the PageReserved /
DAX changes, then I can repost - just Ack/Review tags.  It's harmless
with the existing PageReserved behavior.

Thanks,

Barret


> On Wed, Nov 14, 2018 at 1:53 PM Barret Rhoden <brho@google.com> wrote:
> >
> > This patch series depends on dax pages not being PageReserved.  Once
> > that is in place, these changes will let KVM use huge pages with
> > dax-backed files.  Without the PageReserved change, KVM and DAX still
> > work with these patches, simply without huge pages - which is the
> > current situation.
> >
> > RFC/discussion thread:
> > https://lore.kernel.org/lkml/20181029210716.212159-1-brho@google.com/
> >
> > v1 -> v2:
> > https://lore.kernel.org/lkml/20181109203921.178363-1-brho@google.com/
> >
> > - Updated Acks/Reviewed-by
> > - Minor touchups
> > - Added patch to remove redundant PageReserved() check
> > - Rebased onto linux-next
> >
> >
> > Barret Rhoden (3):
> >   mm: make dev_pagemap_mapping_shift() externally visible
> >   kvm: Use huge pages for DAX-backed files
> >   kvm: remove redundant PageReserved() check
> >
> >  arch/x86/kvm/mmu.c  | 33 +++++++++++++++++++++++++++++++--
> >  include/linux/mm.h  |  3 +++
> >  mm/memory-failure.c | 38 +++-----------------------------------
> >  mm/util.c           | 34 ++++++++++++++++++++++++++++++++++
> >  virt/kvm/kvm_main.c |  8 ++------
> >  5 files changed, 73 insertions(+), 43 deletions(-)
> >
> > --
> > 2.19.1.1215.g8438c0b245-goog
> >  

