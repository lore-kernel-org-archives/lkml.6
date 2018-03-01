Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163384AbeCAXiQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 18:38:16 -0500
Received: from mail-it0-f50.google.com ([209.85.214.50]:56017 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163159AbeCAXiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 18:38:11 -0500
X-Google-Smtp-Source: AG47ELslt+DXgXdBQpRcyzEVtqEP95hZ5lVRKdF9ib3hnQbSu7fnvuwuZV1rzBw/casY/jNxVRsYww==
Date: Thu, 1 Mar 2018 15:38:08 -0800 (PST)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Andrew Morton <akpm@linux-foundation.org>
cc: Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, compaction: drain pcps for zone when kcompactd
 fails
In-Reply-To: <20180301152737.62b78dcb129339a3261a9820@linux-foundation.org>
Message-ID: <alpine.DEB.2.20.1803011535280.173043@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803010340100.88270@chino.kir.corp.google.com> <20180301152737.62b78dcb129339a3261a9820@linux-foundation.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Andrew Morton wrote:

> On Thu, 1 Mar 2018 03:42:04 -0800 (PST) David Rientjes <rientjes@google.com> wrote:
> 
> > It's possible for buddy pages to become stranded on pcps that, if drained,
> > could be merged with other buddy pages on the zone's free area to form
> > large order pages, including up to MAX_ORDER.
> 
> I grabbed this as-is.  Perhaps you could send along a new changelog so
> that others won't be asking the same questions as Vlastimil?
> 
> The patch has no reviews or acks at this time...
> 

Thanks.

As mentioned in my response to Vlastimil, I think the case could also be 
made that we should do drain_all_pages(zone) in try_to_compact_pages() 
when we defer for direct compactors.  It would be great to have feedback 
from those on the cc on that point, the patch in general, and then I can 
send an update.
