Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FB9C64EB0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E86214DA
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 22:04:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E86214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbeJJFXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 01:23:04 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:56538 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbeJJFXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 01:23:04 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC268C4D;
        Tue,  9 Oct 2018 22:04:02 +0000 (UTC)
Date:   Tue, 9 Oct 2018 15:04:01 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Rik van Riel <riel@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 3/4] mm: workingset: add vmstat counter for shadow nodes
Message-Id: <20181009150401.c72cde05338c1ec80a4b8701@linux-foundation.org>
In-Reply-To: <20181009184732.762-4-hannes@cmpxchg.org>
References: <20181009184732.762-1-hannes@cmpxchg.org>
        <20181009184732.762-4-hannes@cmpxchg.org>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  9 Oct 2018 14:47:32 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> Make it easier to catch bugs in the shadow node shrinker by adding a
> counter for the shadow nodes in circulation.
> 
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
> ---
>  include/linux/mmzone.h |  1 +
>  mm/vmstat.c            |  1 +
>  mm/workingset.c        | 12 ++++++++++--
>  3 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
> index 4179e67add3d..d82e80d82aa6 100644
> --- a/include/linux/mmzone.h
> +++ b/include/linux/mmzone.h
> @@ -161,6 +161,7 @@ enum node_stat_item {
>  	NR_SLAB_UNRECLAIMABLE,
>  	NR_ISOLATED_ANON,	/* Temporary isolated pages from anon lru */
>  	NR_ISOLATED_FILE,	/* Temporary isolated pages from file lru */
> +	WORKINGSET_NODES,

Documentation/admin-guide/cgroup-v2.rst, please.  And please check for
any other missing items while in there?


