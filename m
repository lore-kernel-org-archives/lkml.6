Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA04C5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E26A920873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 23:56:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26A920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754633AbeGIX4N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 19:56:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59612 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754508AbeGIX4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 19:56:11 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 35C804023470;
        Mon,  9 Jul 2018 23:56:10 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8DCF52026D7E;
        Mon,  9 Jul 2018 23:56:08 +0000 (UTC)
Date:   Tue, 10 Jul 2018 07:56:04 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, osalvador@techadventures.net
Subject: Re: [PATCH v4 0/3] sparse_init rewrite
Message-ID: <20180709235604.GA2070@MiWiFi-R3L-srv>
References: <20180709175312.11155-1-pasha.tatashin@oracle.com>
 <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.4
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 23:56:10 +0000 (UTC)
X-Greylist: inspected by milter-greylist-4.5.16 (mx1.redhat.com [10.11.55.6]); Mon, 09 Jul 2018 23:56:10 +0000 (UTC) for IP:'10.11.54.4' DOMAIN:'int-mx04.intmail.prod.int.rdu2.redhat.com' HELO:'smtp.corp.redhat.com' FROM:'bhe@redhat.com' RCPT:''
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On 07/09/18 at 02:29pm, Andrew Morton wrote:
> On Mon,  9 Jul 2018 13:53:09 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> > For the ease of review, I split this work so the first patch only adds new
> > interfaces, the second patch enables them, and removes the old ones.
> 
> This clashes pretty significantly with patches from Baoquan and Oscar:
> 
> mm-sparse-make-sparse_init_one_section-void-and-remove-check.patch
> mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix.patch
> mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix-2.patch
> mm-sparse-add-a-static-variable-nr_present_sections.patch
> mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
> mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch

> Is there duplication of intent here?  Any thoughts on the
> prioritization of these efforts?

The final version of my patches was posted here:
http://lkml.kernel.org/r/20180628062857.29658-1-bhe@redhat.com

Currently, only the first three patches are merged. 

mm-sparse-add-a-static-variable-nr_present_sections.patch
mm-sparsemem-defer-the-ms-section_mem_map-clearing.patch
mm-sparse-add-a-new-parameter-data_unit_size-for-alloc_usemap_and_memmap.patch

They are preparation patches, and the 4th patch is the formal fix patch:
[PATCH v6 4/5] mm/sparse: Optimize memmap allocation during sparse_init()

The 5th patch is a clean up patch according to reviewer's suggestion:
[PATCH v6 5/5] mm/sparse: Remove CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER

I think Pavel's patches sits on top of all above five patches.

Thanks
Baoquan
