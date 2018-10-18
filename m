Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DA0C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6810A208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:57:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6810A208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbeJRN46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:56:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56976 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727328AbeJRN46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:56:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 737FB80F6B;
        Thu, 18 Oct 2018 05:57:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-238.ams2.redhat.com [10.36.116.238])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 20A672E030;
        Thu, 18 Oct 2018 05:57:39 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 667189D367; Thu, 18 Oct 2018 07:57:38 +0200 (CEST)
Date:   Thu, 18 Oct 2018 07:57:38 +0200
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Dave Airlie <airlied@gmail.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@linux.ie>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH 5/8] drm/virtio: track created object state
Message-ID: <20181018055738.g3noucn6k4qizckq@sirius.home.kraxel.org>
References: <20181001103222.11924-1-kraxel@redhat.com>
 <20181001103222.11924-6-kraxel@redhat.com>
 <CAPM=9tzpzxv9TorRDWX3=sj_=EEqu3gyU2+AyWAFVHLPzZVcew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tzpzxv9TorRDWX3=sj_=EEqu3gyU2+AyWAFVHLPzZVcew@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 18 Oct 2018 05:57:39 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 11:25:22AM +1000, Dave Airlie wrote:
> On Mon, 1 Oct 2018 at 20:33, Gerd Hoffmann <kraxel@redhat.com> wrote:
> >
> > Track whenever the virtio_gpu_object is already created (i.e. host knows
> > about it) in a new variable.  Add checks to virtio_gpu_object_attach()
> > to do nothing on objects not created yet.
> >
> > Make virtio_gpu_ttm_bo_destroy() use the new variable too, instead of
> > expecting hw_res_handle indicating the object state.
> 
> Is there a potential patch ordering issue here? If this patch changes
> the code to avoid using hw_res_handle,
> is after patches that start filling in hw_res_handle in places we
> haven't filled it in before.
> Maybe this patch should happen earlier.

Didn't run into trouble in testing, but yes, it might be an issue in
error paths.  I'll reorder the patches.

cheers,
  Gerd

