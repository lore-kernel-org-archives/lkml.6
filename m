Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB88C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82CA222A4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 21:40:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394922AbfBMVk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 16:40:56 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:37164 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbfBMVk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 16:40:56 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 558871389;
        Wed, 13 Feb 2019 21:40:55 +0000 (UTC)
Date:   Wed, 13 Feb 2019 13:40:53 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Pavel Tatashin <pavel.tatashin@microsoft.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mel Gorman <mgorman@techsingularity.net>,
        Aaron Lu <aaron.lu@intel.com>,
        Network Development <netdev@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>
Subject: Re: [PATCH] mm: page_alloc: fix ref bias in page_frag_alloc() for
 1-byte allocs
Message-Id: <20190213134053.3198c33f926f51163dd78256@linux-foundation.org>
In-Reply-To: <CAG48ez2Qo7N-+=y=eFhzw9HfYS3HODAY-zLaubFMGyXEV_nwpg@mail.gmail.com>
References: <20190213204157.12570-1-jannh@google.com>
        <20190213125906.eae96c18fe585e060aaf0ef7@linux-foundation.org>
        <CAG48ez2Qo7N-+=y=eFhzw9HfYS3HODAY-zLaubFMGyXEV_nwpg@mail.gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Feb 2019 22:11:58 +0100 Jann Horn <jannh@google.com> wrote:

> > This is probably more a davem patch than a -mm one.
> 
> Ah, sorry. I assumed that I just should go by which directory the
> patched code is in.
> 
> You did just add it to the -mm tree though, right? So I shouldn't
> resend it to davem?

Yes, please send to Dave.  I'll autodrop the -mm copy if/when it turns
up in -next.

