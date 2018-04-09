Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeDINvM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 09:51:12 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeDINvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 09:51:10 -0400
Date: Mon, 9 Apr 2018 06:51:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>, Chao Yu <yuchao0@huawei.com>,
        Minchan Kim <minchan@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Chris Fries <cfries@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Message-ID: <20180409135104.GA23434@infradead.org>
References: <20180409015815.235943-1-minchan@kernel.org>
 <20180409024925.GA21889@bombadil.infradead.org>
 <20180409030930.GA214930@rodete-desktop-imager.corp.google.com>
 <20180409111403.GA31652@bombadil.infradead.org>
 <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
 <7706245c-2661-f28b-f7f9-8f11e1ae932b@huawei.com>
 <20180409124852.GE21835@dhcp22.suse.cz>
 <20180409134114.GA30963@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180409134114.GA30963@bombadil.infradead.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 06:41:14AM -0700, Matthew Wilcox wrote:
> It's worth noting that this is endemic in filesystems.

For the rationale in XFS take a look at commit ad22c7a043c2cc6792820e6c5da699935933e87d
