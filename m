Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603BC67872
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FA1214C4
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:01:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FA1214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJMAe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:34:28 -0400
Received: from mga12.intel.com ([192.55.52.136]:45207 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbeJMAe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:34:28 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Oct 2018 10:01:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,373,1534834800"; 
   d="scan'208";a="240854279"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by orsmga004.jf.intel.com with ESMTP; 12 Oct 2018 10:01:02 -0700
Date:   Fri, 12 Oct 2018 10:58:04 -0600
From:   Keith Busch <keith.busch@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCHv2] mm/gup: Cache dev_pagemap while pinning pages
Message-ID: <20181012165803.GB15490@localhost.localdomain>
References: <20181011175542.13045-1-keith.busch@intel.com>
 <CAPcyv4gGqhGpR8g-HmNzoEnMAysO5uAO+8njeAokHq2CT9x71A@mail.gmail.com>
 <20181012110020.pu5oanl6tnz4mibr@kshutemo-mobl1>
 <CAPcyv4jiWD0V1uqrPRvcGJWZr2qZ-MwrY6O=CDmqmfANhokJyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4jiWD0V1uqrPRvcGJWZr2qZ-MwrY6O=CDmqmfANhokJyw@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 09:58:18AM -0700, Dan Williams wrote:
> On Fri, Oct 12, 2018 at 4:00 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> [..]
> > > Does this have defined behavior? I would feel better with " = { 0 }"
> > > to be explicit.
> >
> > Well, it's not allowed by the standart, but GCC allows this.
> > You can see a warning with -pedantic.
> >
> > We use empty-list initializers a lot in the kernel:
> > $ git grep 'struct .*= {};' | wc -l
> > 997
> >
> > It should be fine.
> 
> Ah, ok. I would still say we should be consistent between the init
> syntax for 'ctx' in follow_page() and __get_user_pages(), and why not
> go with '= { 0 }', one less unnecessary gcc'ism.

No problem, I'll make that happen and copy your reviews/acks into the
next patch.
