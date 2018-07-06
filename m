Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F1C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFB620835
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 23:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="tFEUf+ez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDFB620835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754316AbeGFXxN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 19:53:13 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36017 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753791AbeGFXxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 19:53:12 -0400
Received: by mail-oi0-f67.google.com with SMTP id r16-v6so26444944oie.3
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jul 2018 16:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V9fJe8Kmgj2XFX/k2qSIc3JTq9bLJzJQHBz2pQBJ+VE=;
        b=tFEUf+ez6vRch+n9ysCN8NuuN9boY3vi5vIf7Nu1AGAjDNcFqa867mItQFj7CC/+HF
         H8NSKGTo8sM0x97dnoAKIX3UiFMXAcoy1ix2CwjkeQqlab3pjwU1T3c/mcVpSqw6eQnv
         6H+KMl9FV3GpVN1U3TycOjPtYN5lZ0NFFLHB/FgNZ/B/7yVSj/gQzVe5E1zwxKGbcBb/
         M0etqHfFhbRb1lwKq9EcHRN3uCe5o+mXjBCy7QuI9MzNu65KJKFE0oAdNWrJYCg+B/88
         MVC5F+uSOr/+zN0TM6mhu0G+iJAxYvyZmnrkXAVu5req26+RbtIkX8rOcmNOLSa90acK
         jPpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V9fJe8Kmgj2XFX/k2qSIc3JTq9bLJzJQHBz2pQBJ+VE=;
        b=YX+ERM/YTlqCLBj4kHZ+1fH4JMdcaoDPoTHzGtni5pjHTqd+276QbdKIv9I4C6JSfL
         H5jpcLuJ1TW2h0Vh39uciQJY3eJGATdMe08mCsetvA6prxvy0oD5ftI5FM/RrtF9vAOA
         iTdSFCH8+Gyc2l32j7ZknxRyldEFBH4yQ7GA0s0j3pkFGkIVd4sqwNznRjvGLAFXSwOH
         hrm18KrBi+gVe4E1phxnJvxtRbHtljUSqzpqvg+3GoUDztQFc8M6R96rUKq0wUXjCsd9
         w5yqfR/BmzN7jfxeF75oMHC7eWeqDUT8ANI5t0nEWNFWqyls1g+tZV5NgBAlyy4HYTRZ
         k38w==
X-Gm-Message-State: APt69E1p/5RvR+GI410Mqe53bQ/WtxDEXbNSdCgTv9bor7+7SytqKdLp
        wXot40SlhBPGmgOG4Lq2cxY9Nm1jaB8OanJpoS7+0A==
X-Google-Smtp-Source: AAOMgpdnwNyCabT2E4WSW45haUBelogPHkqfWxk+so6kSyM85DJW0Qfeq4n3lY4B/VfrAmfx+QWxZJk2cM96iGNV6io=
X-Received: by 2002:aca:3c45:: with SMTP id j66-v6mr12526489oia.118.1530921191952;
 Fri, 06 Jul 2018 16:53:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Fri, 6 Jul 2018 16:53:11 -0700 (PDT)
In-Reply-To: <152938831573.17797.15264540938029137916.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152938827880.17797.439879736804291936.stgit@dwillia2-desk3.amr.corp.intel.com>
 <152938831573.17797.15264540938029137916.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 6 Jul 2018 16:53:11 -0700
Message-ID: <CAPcyv4hCZ6jJkB=BLfoEn6146k7FG32=3J8ussZDXmAScQJkAg@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] mm, hmm: Mark hmm_devmem_{add, add_resource} EXPORT_SYMBOL_GPL
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@lst.de>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:05 PM, Dan Williams <dan.j.williams@intel.com> w=
rote:
> The routines hmm_devmem_add(), and hmm_devmem_add_resource() are
> now wrappers around the functionality provided by devm_memremap_pages() t=
o
> inject a dev_pagemap instance and hook page-idle events. The
> devm_memremap_pages() interface is base infrastructure for HMM which has
> more and deeper ties into the kernel memory management implementation
> than base ZONE_DEVICE.
>
> Originally, the HMM page structure creation routines copied the
> devm_memremap_pages() code and reused ZONE_DEVICE. A cleanup to unify
> the implementations was discussed during the initial review:
> http://lkml.iu.edu/hypermail/linux/kernel/1701.2/00812.html
>
> Given that devm_memremap_pages() is marked EXPORT_SYMBOL_GPL by its
> authors and the hmm_devmem_{add,add_resource} routines are simple
> wrappers around that base, mark these routines as EXPORT_SYMBOL_GPL as
> well.
>
> Cc: "J=C3=A9r=C3=B4me Glisse" <jglisse@redhat.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Currently OpenAFS is blocked from compiling with the 4.18 series due
to the current state of put_page() inadvertently pulling in GPL-only
symbols. This series, "PATCH v3 0/8] mm: Rework hmm to use
devm_memremap_pages and other fixes" corrects that situation and
corrects HMM's usage of EXPORT_SYMBOL_GPL.

If HMM wants to export functionality to out-of-tree proprietary
drivers it should do so without consuming GPL-only exports, or
consuming internal-only public functions in its exports.

In addition to duplicating devm_memremap_pages(), that should have
been EXPORT_SYMBOL_GPL from the beginning, it is also exporting /
consuming these GPL-only symbols via HMM's EXPORT_SYMBOL entry points.

    mmu_notifier_unregister_no_release
    percpu_ref
    region_intersects
    __class_create

Those entry points also consume / export functionality that is
currently not exported to any other driver.

    alloc_pages_vma
    walk_page_range

Andrew, please consider applying this v3 series to fix this up (let me
know if you need a resend).
