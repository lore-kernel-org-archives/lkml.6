Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B199C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:00:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EAAC20881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 06:00:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EAAC20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=techadventures.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbeGJGAC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 02:00:02 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43840 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750934AbeGJGAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 02:00:00 -0400
Received: by mail-wr1-f67.google.com with SMTP id b15-v6so13203538wrv.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 23:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RUwxP9WRSHYbpbIsqOXkRfDHcGn0pCfNbYGARSG/nPk=;
        b=XW95cmj4MywdEjZ4I9XYeMsKTMlbT7JeQv0yDE0tCOIL61QYu47WMrGYjgOZ/qebNU
         lw+2SJEpAFVBS2LSfa04qB7PtROrDM1DFTvQOlzMB9cOMc70Ja06WQcqtWZRzP+2TtWk
         fAIbXu3C+jq2yHGyFw/KL+ZI9hFYu0PHThvJxdOoriovgcwaZNnctDJQtGUG6Bs2yE9J
         JeJtoNLs0Xy+zt8wF/CBk8/l7t9TejxfDE5d2L5Dad3JXi6SscOMs4Bfs7/qn5+1vuPL
         E4ANcmh47rimSZxtnWTLqy1FGfevokKf1GZWTKfN8VKUfIDJWzOM7Uy65EUoWQ0VGiZE
         LuxQ==
X-Gm-Message-State: AOUpUlHsNx7Q4WOWsxyEaB8k4c+NWrrwhpSD37N7oX2u0JMFNFamOhYe
        sF4amgenSK3mGqjIlOTUs9O0Pdel
X-Google-Smtp-Source: AAOMgpcytQEmopBCyQeyHRyVXXKXuEOrtgC5QCCQoiVSb/lHg+Dts1Vnzbc6FRfmRxkkkYf7vyw33A==
X-Received: by 2002:adf:8919:: with SMTP id s25-v6mr5600377wrs.89.1531202399709;
        Mon, 09 Jul 2018 22:59:59 -0700 (PDT)
Received: from techadventures.net (techadventures.net. [62.201.165.239])
        by smtp.gmail.com with ESMTPSA id m136-v6sm11980291wma.32.2018.07.09.22.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 22:59:58 -0700 (PDT)
Received: by techadventures.net (Postfix, from userid 1000)
        id E3F85123D0F; Tue, 10 Jul 2018 07:59:57 +0200 (CEST)
Date:   Tue, 10 Jul 2018 07:59:57 +0200
From:   Oscar Salvador <osalvador@techadventures.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Pavel Tatashin <pasha.tatashin@oracle.com>,
        steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, kirill.shutemov@linux.intel.com,
        mhocko@suse.com, linux-mm@kvack.org, dan.j.williams@intel.com,
        jack@suse.cz, jglisse@redhat.com, jrdr.linux@gmail.com,
        bhe@redhat.com, gregkh@linuxfoundation.org, vbabka@suse.cz,
        richard.weiyang@gmail.com, dave.hansen@intel.com,
        rientjes@google.com, mingo@kernel.org
Subject: Re: [PATCH v4 0/3] sparse_init rewrite
Message-ID: <20180710055957.GA7380@techadventures.net>
References: <20180709175312.11155-1-pasha.tatashin@oracle.com>
 <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709142928.c8af4a1ddf80c407fe66b224@linux-foundation.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 02:29:28PM -0700, Andrew Morton wrote:
> On Mon,  9 Jul 2018 13:53:09 -0400 Pavel Tatashin <pasha.tatashin@oracle.com> wrote:
> 
> > In sparse_init() we allocate two large buffers to temporary hold usemap and
> > memmap for the whole machine. However, we can avoid doing that if we
> > changed sparse_init() to operated on per-node bases instead of doing it on
> > the whole machine beforehand.
> > 
> > As shown by Baoquan
> > http://lkml.kernel.org/r/20180628062857.29658-1-bhe@redhat.com
> > 
> > The buffers are large enough to cause machine stop to boot on small memory
> > systems.
> > 
> > These patches should be applied on top of Baoquan's work, as
> > CONFIG_SPARSEMEM_ALLOC_MEM_MAP_TOGETHER is removed in that work.
> > 
> > For the ease of review, I split this work so the first patch only adds new
> > interfaces, the second patch enables them, and removes the old ones.
> 
> This clashes pretty significantly with patches from Baoquan and Oscar:
> 
> mm-sparse-make-sparse_init_one_section-void-and-remove-check.patch
> mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix.patch
> mm-sparse-make-sparse_init_one_section-void-and-remove-check-fix-2.patch

Does this patchset still clash with those patches?
If so, since those patches are already in the -mm tree, would it be better to re-base the patchset on top of that?

Thanks
-- 
Oscar Salvador
SUSE L3
