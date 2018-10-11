Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F468C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBD3A20652
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 13:48:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBD3A20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbeJKVQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 17:16:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727417AbeJKVQF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 17:16:05 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3595830C4198;
        Thu, 11 Oct 2018 13:48:49 +0000 (UTC)
Received: from redhat.com (ovpn-125-61.rdu2.redhat.com [10.10.125.61])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6676C6114A;
        Thu, 11 Oct 2018 13:48:48 +0000 (UTC)
Date:   Thu, 11 Oct 2018 09:48:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20181011094705-mutt-send-email-mst@kernel.org>
References: <20180907012225.GA32677@debian>
 <20180907084509-mutt-send-email-mst@kernel.org>
 <20180910030053.GA15645@debian>
 <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
 <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
 <20181010103335-mutt-send-email-mst@kernel.org>
 <20181011121221.GA27106@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181011121221.GA27106@debian>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.45]); Thu, 11 Oct 2018 13:48:49 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 08:12:21PM +0800, Tiwei Bie wrote:
> > > But if it's not too late, I second for a OUT_OF_ORDER feature.
> > > Starting from in order can have much simpler code in driver.
> > > 
> > > Thanks
> > 
> > It's tricky to change the flag polarity because of compatibility
> > with legacy interfaces. Why is this such a big deal?
> > 
> > Let's teach drivers about IN_ORDER, then if devices
> > are in order it will get enabled by default.
> 
> Yeah, make sense.
> 
> Besides, I have done some further profiling and debugging
> both in kernel driver and DPDK vhost. Previously I was mislead
> by a bug in vhost code. I will send a patch to fix that bug.
> With that bug fixed, the performance of packed ring in the
> test between kernel driver and DPDK vhost is better now.

OK, if we get a performance gain on the virtio side, we can finally
upstream it. If you see that please re-post ASAP so we can
put it in the next kernel release.

-- 
MST
