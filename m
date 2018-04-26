Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756907AbeDZStg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 14:49:36 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753665AbeDZStV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 14:49:21 -0400
Date: Thu, 26 Apr 2018 21:49:19 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mikulas Patocka <mpatocka@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Michal Hocko <mhocko@kernel.org>, David Rientjes <rientjes@google.com>,
        dm-devel@redhat.com, eric.dumazet@gmail.com, netdev@vger.kernel.org,
        jasowang@redhat.com, Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        linux-mm@kvack.org, edumazet@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        virtualization@lists.linux-foundation.org,
        David Miller <davem@davemloft.net>, Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [dm-devel] [PATCH v5] fault-injection: introduce kvmalloc
 fallback options
Message-ID: <20180426214011-mutt-send-email-mst@kernel.org>
References: <1524694663.4100.21.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804251830540.25124@file01.intranet.prod.int.rdu2.redhat.com>
 <20180426125817.GO17484@dhcp22.suse.cz>
 <alpine.LRH.2.02.1804261006120.32722@file01.intranet.prod.int.rdu2.redhat.com>
 <1524753932.3226.5.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804261100170.12157@file01.intranet.prod.int.rdu2.redhat.com>
 <1524756256.3226.7.camel@HansenPartnership.com>
 <alpine.LRH.2.02.1804261142480.21152@file01.intranet.prod.int.rdu2.redhat.com>
 <20180426184845-mutt-send-email-mst@kernel.org>
 <alpine.LRH.2.02.1804261202350.24656@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.1804261202350.24656@file01.intranet.prod.int.rdu2.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 12:07:25PM -0400, Mikulas Patocka wrote:
> > IIUC debug kernels mainly exist so people who experience e.g. memory
> > corruption can try and debug the failure. In this case, CONFIG_DEBUG_SG
> > will *already* catch a failure early. Nothing special needs to be done.
> 
> The patch helps people debug such memory coprruptions (such as using DMA 
> API on the result of kvmalloc).

That's my point.  I don't think your patch helps debug any memory
corruptions.  With CONFIG_DEBUG_SG using DMA API already causes a
BUG_ON, that's before any memory can get corrupted.

-- 
MST
