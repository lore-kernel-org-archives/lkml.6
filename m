Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92BC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C1A0208E9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 13:12:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C1A0208E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGLNWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 09:22:04 -0400
Received: from mx2.suse.de ([195.135.220.15]:45144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726762AbeGLNWE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 09:22:04 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D868CAE9B;
        Thu, 12 Jul 2018 13:12:31 +0000 (UTC)
Date:   Thu, 12 Jul 2018 15:12:29 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     wei.w.wang@intel.com, virtio-dev@lists.oasis-open.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        virtualization <virtualization@lists.linux-foundation.org>,
        KVM list <kvm@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        liliang.opensource@gmail.com, yang.zhang.wz@gmail.com,
        quan.xu0@gmail.com, nilal@redhat.com,
        Rik van Riel <riel@redhat.com>, peterx@redhat.com
Subject: Re: [PATCH v35 1/5] mm: support to get hints of free page blocks
Message-ID: <20180712131229.GM32648@dhcp22.suse.cz>
References: <1531215067-35472-1-git-send-email-wei.w.wang@intel.com>
 <1531215067-35472-2-git-send-email-wei.w.wang@intel.com>
 <CA+55aFz9a=D-kquM=sG5uhV_HrBAw+VAhcJmtPNz+howy4j9ow@mail.gmail.com>
 <5B455D50.90902@intel.com>
 <CA+55aFzqj8wxXnHAdUTiOomipgFONVbqKMjL_tfk7e5ar1FziQ@mail.gmail.com>
 <20180711092152.GE20050@dhcp22.suse.cz>
 <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFwku2tDH4+rfaC67xc4-cEwSrXgnQaci=e2id5ZCRE9JQ@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Hmm this one somehow got stuck in my outgoing emails]

On Wed 11-07-18 09:23:54, Linus Torvalds wrote:
[...]
> So I'm open to new interfaces. I just want those new interfaces to
> make sense, and be low latency and simple for the VM to do. I'm
> objecting to the incredibly baroque and heavy-weight one that can
> return near-infinite amounts of memory.

Mel was suggesting a bulk page allocator a year ago [1]. I can see only
slab bulk api so I am not sure what happened with that work. Anyway
I think that starting with what we have right now is much more
appropriate than over design this thing from the early beginning.

[1] http://lkml.kernel.org/r/20170109163518.6001-5-mgorman@techsingularity.net
-- 
Michal Hocko
SUSE Labs
