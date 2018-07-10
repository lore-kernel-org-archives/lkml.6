Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA49CC5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EC42089E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53EC42089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933278AbeGJAIK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:08:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932993AbeGJAII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:08:08 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9834BAE7;
        Tue, 10 Jul 2018 00:08:07 +0000 (UTC)
Date:   Mon, 9 Jul 2018 17:08:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Subject: Re: [PATCH v4 0/3] sparse_init rewrite
Message-Id: <20180709170806.bc28d2affba0e903e946e057@linux-foundation.org>
In-Reply-To: <20180709235604.GA2070@MiWiFi-R3L-srv>
References: <20180709175312.11155-1-pasha.tatashin@oracle.com>
        <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
        <20180709235604.GA2070@MiWiFi-R3L-srv>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Jul 2018 07:56:04 +0800 Baoquan He <bhe@redhat.com> wrote:

> Hi Andrew,
> 
> On 07/09/18 at 02:29pm, Andrew Morton wrote:
> > On Mon,  9 Jul 2018 13:53:09 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> > > For the ease of review, I split this work so the first patch only adds new
> > > interfaces, the second patch enables them, and removes the old ones.
> > 
> > This clashes pretty significantly with patches from Baoquan and Oscar:
> > 
> > mm-sparse-make-sparse_init_one_section-void-and-remove-check.patch
> > mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix.patch
> > mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix-2.patch
> > mm-sparse-add-a-static-variable-nr_present_sections.patch
> > mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> > mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
> 
> > Is there duplication of intent here?  Any thoughts on the
> > prioritization of these efforts?
> 
> The final version of my patches was posted here:
> http://lkml.kernel.org/r/20180628062857.29658-1-bhe@redhat.com
> 
> Currently, only the first three patches are merged. 
> 
> mm-sparse-add-a-static-variable-nr_present_sections.patch
> mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch
> 
> They are preparation patches, and the 4th patch is the formal fix patch:
> [PATCH v6 4/5] mm/sparse: Optimize memmap allocation during sparse_init()
> 
> The 5th patch is a clean up patch according to reviewer's suggestion:
> [PATCH v6 5/5] mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER
> 
> I think Pavel's patches sits on top of all above five patches.

OK, thanks, I've just moved to the v6 series.
