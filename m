Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFC6C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBBAE20868
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 18:11:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBBAE20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbeLGSL5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 13:11:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726223AbeLGSL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 13:11:57 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CA61B30B96EF;
        Fri,  7 Dec 2018 18:11:56 +0000 (UTC)
Received: from redhat.com (ovpn-124-251.rdu2.redhat.com [10.10.124.251])
        by smtp.corp.redhat.com (Postfix) with SMTP id B586D82EC6;
        Fri,  7 Dec 2018 18:11:43 +0000 (UTC)
Date:   Fri, 7 Dec 2018 13:11:42 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Tiwei Bie <tiwei.bie@intel.com>
Cc:     jasowang@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        virtio-dev@lists.oasis-open.org, wexu@redhat.com,
        jfreimann@redhat.com, maxime.coquelin@redhat.com
Subject: Re: [RFC 0/3] virtio_ring: define flags as shifts consistently
Message-ID: <20181207131058-mutt-send-email-mst@kernel.org>
References: <20181207084842.13133-1-tiwei.bie@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207084842.13133-1-tiwei.bie@intel.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Fri, 07 Dec 2018 18:11:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2018 at 04:48:39PM +0800, Tiwei Bie wrote:
> This is a follow up of the discussion in this thread:
> https://patchwork.ozlabs.org/patch/1001015/#2042353

How was this tested? I'd suggest building virtio
before and after the changes, stripped binary
should be exactly the same.


> Tiwei Bie (3):
>   virtio_ring: define flags as shifts consistently
>   virtio_ring: add VIRTIO_RING_NO_LEGACY
>   virtio_ring: use new vring flags
> 
>  drivers/virtio/virtio_ring.c     | 100 ++++++++++++++++++-------------
>  include/uapi/linux/virtio_ring.h |  61 +++++++++++++------
>  2 files changed, 103 insertions(+), 58 deletions(-)
> 
> -- 
> 2.17.1
