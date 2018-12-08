Return-Path: <SRS0=1bfu=OR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD523C04EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 768422081C
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Dec 2018 13:28:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 768422081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeLHN2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Dec 2018 08:28:52 -0500
Received: from mga05.intel.com ([192.55.52.43]:4529 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbeLHN2w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Dec 2018 08:28:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Dec 2018 05:28:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,330,1539673200"; 
   d="scan'208";a="124140398"
Received: from btwcube1.sh.intel.com (HELO dpdk-tbie) ([10.67.104.173])
  by fmsmga002.fm.intel.com with ESMTP; 08 Dec 2018 05:28:50 -0800
Date:   Sat, 8 Dec 2018 21:26:57 +0800
From:   Tiwei Bie <tiwei.bie@intel.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [RFC 0/3] virtio_ring: define flags as shifts consistently
Message-ID: <20181208132656.GA29772@dpdk-tbie>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
 <20181207131058-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181207131058-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 01:11:42PM -0500, Michael S. Tsirkin wrote:
> On Fri, Dec 07, 2018 at 04:48:39PM +0800, Tiwei Bie wrote:
> > This is a follow up of the discussion in this thread:
> > https://patchwork.ozlabs.org/patch/1001015/#2042353
> 
> How was this tested? I'd suggest building virtio
> before and after the changes, stripped binary
> should be exactly the same.

Sure, I will do the test with scripts/objdiff.

> 
> 
> > Tiwei Bie (3):
> >   virtio_ring: define flags as shifts consistently
> >   virtio_ring: add VIRTIO_RING_NO_LEGACY
> >   virtio_ring: use new vring flags
> > 
> >  drivers/virtio/virtio_ring.c     | 100 ++++++++++++++++++-------------
> >  include/uapi/linux/virtio_ring.h |  61 +++++++++++++------
> >  2 files changed, 103 insertions(+), 58 deletions(-)
> > 
> > -- 
> > 2.17.1
