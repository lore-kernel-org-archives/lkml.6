Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A26C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEEBC2146F
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 08:54:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEEBC2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeKUT2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:28:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbeKUT2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:28:01 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A454C307D849;
        Wed, 21 Nov 2018 08:54:23 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-59.ams2.redhat.com [10.36.116.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3B778600C3;
        Wed, 21 Nov 2018 08:54:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 33C5340DB8C; Wed, 21 Nov 2018 09:54:22 +0100 (CET)
Date:   Wed, 21 Nov 2018 09:54:22 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     virtio-dev@lists.oasis-open.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v4 2/2] drm/virtio: add edid support
Message-ID: <20181121085422.mk4ob6vhwbnufqzl@sirius.home.kraxel.org>
References: <20181030063206.19528-1-kraxel@redhat.com>
 <20181030063206.19528-3-kraxel@redhat.com>
 <20181030093804.GQ21967@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030093804.GQ21967@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Wed, 21 Nov 2018 08:54:23 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:38:04AM +0100, Daniel Vetter wrote:
> On Tue, Oct 30, 2018 at 07:32:06AM +0100, Gerd Hoffmann wrote:
> > linux guest driver implementation of the VIRTIO_GPU_F_EDID feature.
> > 
> > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Like with bochs, I think drm_do_get_edid() here is overkill and fairly
> pointless.

Like with bochs it makes sense to use drm_do_get_edid(), because it
handles edid override and other common stuff.  Not that this should
actually be needed for virtual devices, but I think it still makes sense
for consistency with other drivers, and it might be handy for testing
too.

cheers,
  Gerd

