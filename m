Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B63CFC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:47:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F07920C0C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 20:47:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F07920C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731329AbeHBWkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 18:40:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35562 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729639AbeHBWkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 18:40:12 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.9.92])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 588D3AD2;
        Thu,  2 Aug 2018 20:47:24 +0000 (UTC)
Date:   Thu, 2 Aug 2018 13:47:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     vdavydov.dev@gmail.com, mhocko@suse.com, aryabinin@virtuozzo.com,
        ying.huang@intel.com, penguin-kernel@I-love.SAKURA.ne.jp,
        willy@infradead.org, shakeelb@google.com, jbacik@fb.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: Move check for SHRINKER_NUMA_AWARE to
 do_shrink_slab()
Message-Id: <20180802134723.ecdd540c7c9338f98ee1a2c6@linux-foundation.org>
In-Reply-To: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
References: <153320759911.18959.8842396230157677671.stgit@localhost.localdomain>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Aug 2018 14:00:52 +0300 Kirill Tkhai <ktkhai@virtuozzo.com> wrote:

> In case of shrink_slab_memcg() we do not zero nid, when shrinker
> is not numa-aware. This is not a real problem, since currently
> all memcg-aware shrinkers are numa-aware too (we have two:
> super_block shrinker and workingset shrinker), but something may
> change in the future.

Fair enough.

> (Andrew, this may be merged to mm-iterate-only-over-charged-shrinkers-during-memcg-shrink_slab)

It got a bit messy so I got lazy and queued it as a separate patch.

btw, I have a note that https://lkml.org/lkml/2018/7/7/32 was caused by
this patch series.  Is that the case and do you know if this was
addressed?

