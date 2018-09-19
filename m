Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CD24C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:46:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 069842098A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 04:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 069842098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730688AbeISKWI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 06:22:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726044AbeISKWI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 06:22:08 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8E6BC88310;
        Wed, 19 Sep 2018 04:46:03 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-56.phx2.redhat.com [10.3.116.56])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E432808C1;
        Wed, 19 Sep 2018 04:46:02 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 8CB5F3B1; Wed, 19 Sep 2018 06:46:00 +0200 (CEST)
Date:   Wed, 19 Sep 2018 06:46:00 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Jiandi An <jiandi@amd.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        Dave Airlie <airlied@linux.ie>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>,
        "Singh, Brijesh" <brijesh.singh@amd.com>
Subject: Re: [virtio-dev] [PATCH 2/2] drm/virtio: add iommu support.
Message-ID: <20180919044600.utvnu5l6fvvi2qi4@sirius.home.kraxel.org>
References: <20180829122026.27012-1-kraxel@redhat.com>
 <20180829122026.27012-3-kraxel@redhat.com>
 <CAPM=9tyXc41DAkgjCRojrqH28qkirxgrpgNmrwu4WAeLpg7tAw@mail.gmail.com>
 <9bf20fa1-3752-edd1-588c-e38cd166c3af@amd.com>
 <20180912072541.nagfrr2dgy34szcx@sirius.home.kraxel.org>
 <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5684a3fc-3605-7bb0-b0be-418c2ae702b5@amd.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 19 Sep 2018 04:46:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> buffer.  I tried to put a dma_sync_sg_for_device() on virtio_gpu_object obj->pages-sgl
> before VIRTIO_GPU_CMD_TRANSFER_TO_HOST_2D is sent.  This fixes the kernel console path.

That should be the right place.

> Once display manger is kicked off for example (sudo systemctl start lightdm.service) and
> resource id 3 gets created from user space down, it still gives a blank black screen.

Hmm.  I'd suspect there is simply a code path missing.  Can you send the
patch you have?

cheers,
  Gerd

