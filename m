Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF07FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9814A20865
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 05:02:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9814A20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392085AbeKVPjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 10:39:41 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:59712 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732537AbeKVPjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 10:39:41 -0500
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net [24.6.170.16])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E013AA92;
        Thu, 22 Nov 2018 05:02:00 +0000 (UTC)
Date:   Wed, 21 Nov 2018 21:01:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, stable@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: use swp_offset as key in shmem_replace_page()
Message-Id: <20181121210159.3a5fb6946e460c561fdec391@linux-foundation.org>
In-Reply-To: <20181121215442.138545-1-yuzhao@google.com>
References: <20181119010924.177177-1-yuzhao@google.com>
        <20181121215442.138545-1-yuzhao@google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Nov 2018 14:54:42 -0700 Yu Zhao <yuzhao@google.com> wrote:

> We changed key of swap cache tree from swp_entry_t.val to
> swp_offset. Need to do so in shmem_replace_page() as well.

What are the user-visible effects of this change?

> Fixes: f6ab1f7f6b2d ("mm, swap: use offset of swap entry as key of swap cache")
> Cc: stable@vger.kernel.org # v4.9+

Please always provide the user-impact information when fixing bugs.  This
becomes especially important when proposing -stable backporting.

Hugh said

: shmem_replace_page() has been wrong since the day I wrote it: good
: enough to work on swap "type" 0, which is all most people ever use
: (especially those few who need shmem_replace_page() at all), but broken
: once there are any non-0 swp_type bits set in the higher order bits.

but we still don't have a description of "broken".

Thanks.
