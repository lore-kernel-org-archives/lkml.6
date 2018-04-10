Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752831AbeDJL45 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 07:56:57 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41892 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752788AbeDJL4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 07:56:55 -0400
Date: Tue, 10 Apr 2018 04:56:51 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        Christopher Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Jan Kara <jack@suse.cz>,
        Chris Fries <cfries@google.com>,
        linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: workingset: fix NULL ptr dereference
Message-ID: <20180410115651.GA22118@bombadil.infradead.org>
References: <20180409111403.GA31652@bombadil.infradead.org>
 <20180409112514.GA195937@rodete-laptop-imager.corp.google.com>
 <7706245c-2661-f28b-f7f9-8f11e1ae932b@huawei.com>
 <20180409144958.GA211679@rodete-laptop-imager.corp.google.com>
 <20180409152032.GB11756@bombadil.infradead.org>
 <20180409230409.GA214542@rodete-desktop-imager.corp.google.com>
 <20180410011211.GA31282@bombadil.infradead.org>
 <20180410023339.GB214542@rodete-desktop-imager.corp.google.com>
 <20180410024152.GC31282@bombadil.infradead.org>
 <20180410025903.GA38000@rodete-desktop-imager.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410025903.GA38000@rodete-desktop-imager.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:59:03AM +0900, Minchan Kim wrote:
> Okay, I hope this version clear current concerns.

It doesn't.  The right place to warn about GFP_ZERO used with a
constructor is _slab_, like the patch I already sent.  We have no idea
what other places might have the same bug, and slab is the only place
to catch that.
