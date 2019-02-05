Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DDAC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:04:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96A2A20823
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 22:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729757AbfBEWES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 17:04:18 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:52700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725921AbfBEWER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 17:04:17 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D0F2CA840;
        Tue,  5 Feb 2019 22:04:16 +0000 (UTC)
Date:   Tue, 5 Feb 2019 14:04:15 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, keith.busch@intel.com
Subject: Re: [PATCH v10 1/3] mm: Shuffle initial free memory to improve
 memory-side-cache utilization
Message-Id: <20190205140415.544ae2876ee44e6edb8ca743@linux-foundation.org>
In-Reply-To: <154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <154899811208.3165233.17623209031065121886.stgit@dwillia2-desk3.amr.corp.intel.com>
        <154899811738.3165233.12325692939590944259.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 21:15:17 -0800 Dan Williams <dan.j.williams@intel.com> wrote:

> +config SHUFFLE_PAGE_ALLOCATOR
> +	bool "Page allocator randomization"
> +	default SLAB_FREELIST_RANDOM && ACPI_NUMA
> +	help

SLAB_FREELIST_RANDOM is default n, so this patchset won't get much
runtime testing.

How about you cook up a (-mm only) patch which makes the kernel default
to SLAB_FREELIST_RANDOM=y, SHUFFLE_PAGE_ALLOCATOR=y (or whatever) to
ensure we get a decent amount of runtime testing?  Then I can hold that
in -mm (and -next) until we get bored of it?

