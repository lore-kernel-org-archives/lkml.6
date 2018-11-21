Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E1EBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E612F2075B
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:44:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E612F2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390225AbeKVJUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:20:31 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:38464 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387447AbeKVJUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:20:30 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2067E8E3;
        Wed, 21 Nov 2018 22:44:05 +0000 (UTC)
Date:   Wed, 21 Nov 2018 14:44:04 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     john.hubbard@gmail.com
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: Re: [PATCH] mm/gup: finish consolidating error handling
Message-Id: <20181121144404.efdab6dbccd7780034a55e1d@linux-foundation.org>
In-Reply-To: <20181121081402.29641-2-jhubbard@nvidia.com>
References: <20181121081402.29641-1-jhubbard@nvidia.com>
        <20181121081402.29641-2-jhubbard@nvidia.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 00:14:02 -0800 john.hubbard@gmail.com wrote:

> Commit df06b37ffe5a4 ("mm/gup: cache dev_pagemap while pinning pages")
> attempted to operate on each page that get_user_pages had retrieved. In
> order to do that, it created a common exit point from the routine.
> However, one case was missed, which this patch fixes up.
> 
> Also, there was still an unnecessary shadow declaration (with a
> different type) of the "ret" variable, which this patch removes.
> 

What is the bug which this supposedly fixes and what is that bug's
user-visible impact?

