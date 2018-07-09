Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD91C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 079E120881
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 21:29:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079E120881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933245AbeGIV3c (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 17:29:32 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:40778 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932980AbeGIV3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 17:29:31 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E37E2E2C;
        Mon,  9 Jul 2018 21:29:29 +0000 (UTC)
Date:   Mon, 9 Jul 2018 14:29:28 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        bhe@redhat.com, gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Subject: Re: [PATCH v4 0/3] sparse_init rewrite
Message-Id: <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
In-Reply-To: <20180709175312.11155-1-pasha.tatashin@oracle.com>
References: <20180709175312.11155-1-pasha.tatashin@oracle.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 Jul 2018 13:53:09 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:

> In sparse_init() we allocate two large buffers to temporary hold usemap and
> memmap for the whole machine. However, we can avoid doing that if we
> changed sparse_init() to operated on per-node bases instead of doing it on
> the whole machine beforehand.
> 
> As shown by Baoquan
> http://lkml.kernel.org/r/20180628062857.29658-1-bhe@redhat.com
> 
> The buffers are large enough to cause machine stop to boot on small memory
> systems.
> 
> These patches should be applied on top of Baoquan's work, as
> CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is removed in that work.
> 
> For the ease of review, I split this work so the first patch only adds new
> interfaces, the second patch enables them, and removes the old ones.

This clashes pretty significantly with patches from Baoquan and Oscar:

mm-sparse-make-sparse_init_one_section-void-and-remove-check.patch
mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix.patch
mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix-2.patch
mm-sparse-add-a-static-variable-nr_present_sections.patch
mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch

Is there duplication of intent here?  Any thoughts on the
prioritization of these efforts?


