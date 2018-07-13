Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 030B8ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB20C208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 09:59:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB20C208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbeGMKNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:13:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46483 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbeGMKNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:13:34 -0400
Received: by mail-wr1-f65.google.com with SMTP id s11-v6so24508967wra.13
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 02:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yd+TJjfYDAfzyk8goi04k6a79sq12zGGSkOEEsysC28=;
        b=b4GoJ4V1W/AxjsbpU91Z51Xey8bxP4V4ysWH4KFmItJSyqvGZKi0GqsrMLyuLQo4ZQ
         XInJIXDdNcagYXT82wQHiYNL9tZZe/TTCOVZTbYXVElRhYKsi7XXDR5ZFNIk6MaXjoh1
         SoNnwZWDqXBzQ7roiKCAsKicdzMYgO3pUzOJGWAQrKV0TVsRsFz4kseD7okbryTQzyEW
         M9IkjsM8+p8ake+tvw3Tw6368I6j0tQiHpxLujZ8qZnGsy32njypZb6A+KF4Y5U9lN9V
         DuIA6me9gtHUSx4CXRYQDDQuV+Q2oY6J+eY/FWY4YPFlzwo9R/dbuL+HxPcH3yWg/L3P
         ou/Q==
X-Gm-Message-State: AOUpUlF66g/zGK0t3WpWGtfQqMEVOncVtgy1aI9rMRaj8xT8mCsNh+ag
        njupnSk2WzEWHlPxrBC6sHU=
X-Google-Smtp-Source: AAOMgpdpksxCXXfzL16wdisDMRhJan9QxjyO4J1QiJRw0oNCqT91lNWBpgmPkU1I6h0JTyIcCyON+A==
X-Received: by 2002:adf:ba12:: with SMTP id o18-v6mr4594173wrg.249.1531475976326;
        Fri, 13 Jul 2018 02:59:36 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id n8-v6sm34878383wrt.56.2018.07.13.02.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 02:59:35 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id 07E86123EBC; Fri, 13 Jul 2018 11:59:35 +0200 (CEST)
Date:   Fri, 13 Jul 2018 11:59:34 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Pavel Tatashin <pasha.tatashin@oracle.com>
Cc:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, dan.j.williams@intel.com, jack@suse.cz,
        jglisse@redhat.com, jrdr.linux@gmail.com, bhe@redhat.com,
        gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org, abdhalee@linux.vnet.ibm.com,
        mpe@ellerman.id.au
Subject: Re: [PATCH v5 0/5] sparse_init rewrite
Message-ID: <20180713095934.GB15039@techadventures.net>
References: <20180712203730.8703-1-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180712203730.8703-1-pasha.tatashin@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2018 at 04:37:25PM -0400, Pavel Tatashin wrote:
> Changelog:
> v5 - v4
> 	- Fixed the issue that was reported on ppc64 when
> 	  CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is removed
> 	- Consolidated the new buffer allocation between vmemmap
> 	  and non-vmemmap variants of sparse layout.
> 	- Removed all review-by comments, because I had to do
> 	  significant amount of changes compared to previous version
> 	  and need another round of review.
> 	- I also would appreciate if those who reported problems with
> 	  PPC64 could test this change.

About PPC64, your patchset fixes the issue as the population gets followed by a
sparse_init_one_section().

It can be seen here:

Before:

kernel: vmemmap_populate f000000000000000..f000000000004000, node 0
kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
kernel: vmemmap_populate f000000000000000..f000000000008000, node 0
kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
kernel: vmemmap_populate f000000000000000..f00000000000c000, node 0
kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)


After:

kernel: vmemmap_populate f000000000000000..f000000000004000, node 0
kernel:       * f000000000000000..f000000000010000 allocated at (____ptrval____)
kernel: vmemmap_populate f000000000000000..f000000000008000, node 0
kernel: vmemmap_populate f000000000000000..f00000000000c000, node 0
kernel: vmemmap_populate f000000000000000..f000000000010000, node 0
kernel: vmemmap_populate f000000000010000..f000000000014000, node 0
kernel:       * f000000000010000..f000000000020000 allocated at (____ptrval____)


As can be seen, before the patchset, we keep calling vmemmap_create_mapping() even if we
populated that section already, because of vmemmap_populated() checking for SECTION_HAS_MEM_MAP.

After the patchset, since each population is being followed by a call to sparse_init_one_section(),
when vmemmap_populated() gets called, we have SECTION_HAS_MEM_MAP already in case the section
was populated.
-- 
Oscar Salvador
SUSE L3
