Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752175AbeC1HBu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:01:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:59226 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750774AbeC1HBs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:01:48 -0400
Date: Wed, 28 Mar 2018 09:01:45 +0200
From: Michal Hocko <mhocko@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        linux-mm@kvack.org, pbonzini@redhat.com, liliang.opensource@gmail.com,
        yang.zhang.wz@gmail.com, quan.xu0@gmail.com, nilal@redhat.com,
        riel@redhat.com, huangzhichao@huawei.com
Subject: Re: [PATCH v29 1/4] mm: support reporting free page blocks
Message-ID: <20180328070145.GB9275@dhcp22.suse.cz>
References: <1522031994-7246-1-git-send-email-wei.w.wang@intel.com>
 <1522031994-7246-2-git-send-email-wei.w.wang@intel.com>
 <20180326142254.c4129c3a54ade686ee2a5e21@linux-foundation.org>
 <5AB9E377.30900@intel.com>
 <20180327063322.GW5652@dhcp22.suse.cz>
 <20180327190635-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327190635-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 27-03-18 19:07:22, Michael S. Tsirkin wrote:
> On Tue, Mar 27, 2018 at 08:33:22AM +0200, Michal Hocko wrote:
> > > > > + * The function itself might sleep so it cannot be called from atomic
> > > > > + * contexts.
> > > > I don't see how walk_free_mem_block() can sleep.
> > > 
> > > OK, it would be better to remove this sentence for the current version. But
> > > I think we could probably keep it if we decide to add cond_resched() below.
> > 
> > The point of this sentence was to make any user aware that the function
> > might sleep from the very begining rather than chase existing callers
> > when we need to add cond_resched or sleep for any other reason. So I
> > would rather keep it.
> 
> Let's say what it is then - "will be changed to sleep in the future".

Do we really want to describe the precise implementation in the
documentation? I thought the main purpose of the documentation is to
describe the _contract_. If I am curious about the implementation I can
look at the code. As I've said earlier in this patchset lifetime. This
interface is rather dangerous because we are exposing guts of our
internal data structures. So we better set expectations of what can and
cannot be done right from the beginning. I definitely do not want
somebody to simply look at the code and see that the interface is
sleepable and abuse that fact.
-- 
Michal Hocko
SUSE Labs
