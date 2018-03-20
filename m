Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751597AbeCTU0U (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 16:26:20 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:36457 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751269AbeCTU0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 16:26:17 -0400
X-Google-Smtp-Source: AG47ELuZ/c1GAKfkZjyMQCOO1/9d6UG2eCJJz6xozyZoQvQxiCWAc6gaGaPL+kD9faac7H/XuzUg2g==
Date: Tue, 20 Mar 2018 13:26:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To: Vlastimil Babka <vbabka@suse.cz>
cc: Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, page_alloc: wakeup kcompactd even if kswapd cannot
 free more memory
In-Reply-To: <224545ab-9859-6f37-f58a-d5e04371258c@suse.cz>
Message-ID: <alpine.DEB.2.20.1803201325530.167205@chino.kir.corp.google.com>
References: <alpine.DEB.2.20.1803111659420.209721@chino.kir.corp.google.com> <224545ab-9859-6f37-f58a-d5e04371258c@suse.cz>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Mar 2018, Vlastimil Babka wrote:

> > Kswapd will not wakeup if per-zone watermarks are not failing or if too
> > many previous attempts at background reclaim have failed.
> > 
> > This can be true if there is a lot of free memory available.  For high-
> > order allocations, kswapd is responsible for waking up kcompactd for
> > background compaction.  If the zone is now below its watermarks or
>                                          not ?
> 

Good catch, Andrew please let me know if you would like a resend to 
correct this.
