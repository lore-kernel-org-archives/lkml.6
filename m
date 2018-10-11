Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678C0C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1797720841
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 14:39:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1797720841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeJKWHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 18:07:02 -0400
Received: from mga14.intel.com ([192.55.52.115]:62383 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728442AbeJKWHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 18:07:01 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Oct 2018 07:39:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,368,1534834800"; 
   d="scan'208";a="81790255"
Received: from btwcube1.sh.intel.com (HELO debian) ([10.67.104.158])
  by orsmga006.jf.intel.com with ESMTP; 11 Oct 2018 07:35:59 -0700
Date:   Thu, 11 Oct 2018 22:34:43 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com,
        zhihong.wang@intel.com
Subject: Re: [virtio-dev] Re: [PATCH net-next v2 0/5] virtio: support packed
 ring
Message-ID: <20181011143443.GA18183@debian>
References: <f5ef0393-cf02-0795-a51a-8783ee300037@redhat.com>
 <20180911053726.GA7472@debian>
 <20180912121457-mutt-send-email-mst@kernel.org>
 <20180913085919.GA42049@fbsd1.sh.intel.com>
 <98d6bd4d-45e2-4207-e961-782f649e0139@redhat.com>
 <20181010103335-mutt-send-email-mst@kernel.org>
 <20181011121221.GA27106@debian>
 <20181011094705-mutt-send-email-mst@kernel.org>
 <20181011141331.GA11650@debian>
 <20181011101656-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181011101656-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 11, 2018 at 10:17:15AM -0400, Michael S. Tsirkin wrote:
> On Thu, Oct 11, 2018 at 10:13:31PM +0800, Tiwei Bie wrote:
> > On Thu, Oct 11, 2018 at 09:48:48AM -0400, Michael S. Tsirkin wrote:
> > > On Thu, Oct 11, 2018 at 08:12:21PM +0800, Tiwei Bie wrote:
> > > > > > But if it's not too late, I second for a OUT_OF_ORDER feature.
> > > > > > Starting from in order can have much simpler code in driver.
> > > > > > 
> > > > > > Thanks
> > > > > 
> > > > > It's tricky to change the flag polarity because of compatibility
> > > > > with legacy interfaces. Why is this such a big deal?
> > > > > 
> > > > > Let's teach drivers about IN_ORDER, then if devices
> > > > > are in order it will get enabled by default.
> > > > 
> > > > Yeah, make sense.
> > > > 
> > > > Besides, I have done some further profiling and debugging
> > > > both in kernel driver and DPDK vhost. Previously I was mislead
> > > > by a bug in vhost code. I will send a patch to fix that bug.
> > > > With that bug fixed, the performance of packed ring in the
> > > > test between kernel driver and DPDK vhost is better now.
> > > 
> > > OK, if we get a performance gain on the virtio side, we can finally
> > > upstream it. If you see that please re-post ASAP so we can
> > > put it in the next kernel release.
> > 
> > Got it, I will re-post ASAP.
> > 
> > Thanks!
> 
> 
> Pls remember to include data on performance gain in the cover letter.

Sure. I'll try to include some performance analyses.

