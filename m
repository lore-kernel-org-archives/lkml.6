Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDCCC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:38:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31C1020663
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 07:38:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfANHiY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 02:38:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41372 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfANHiY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 02:38:24 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 3D3383A267;
        Mon, 14 Jan 2019 07:38:24 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-186.ams2.redhat.com [10.36.117.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D507C194A8;
        Mon, 14 Jan 2019 07:38:23 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id DF22416E03; Mon, 14 Jan 2019 08:38:22 +0100 (CET)
Date:   Mon, 14 Jan 2019 08:38:22 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Rob Clark <robdclark@gmail.com>, dri-devel@lists.freedesktop.org,
        Rob Clark <rclark@redhat.com>,
        Daniel Stone <daniels@collabora.com>,
        David Airlie <airlied@linux.ie>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Dave Airlie <airlied@redhat.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH] drm/cirrus: fix connector leak at unload
Message-ID: <20190114073822.3jzujq47cwfoizgh@sirius.home.kraxel.org>
References: <20190111140242.29002-1-robdclark@gmail.com>
 <20190111220620.GF21184@phenom.ffwll.local>
 <20190111221638.GG21184@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111221638.GG21184@phenom.ffwll.local>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Mon, 14 Jan 2019 07:38:24 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:16:38PM +0100, Daniel Vetter wrote:
> On Fri, Jan 11, 2019 at 11:06:20PM +0100, Daniel Vetter wrote:
> > On Fri, Jan 11, 2019 at 09:02:34AM -0500, Rob Clark wrote:
> > > This fixes an '*ERROR* connector VGA-2 leaked!' splat at driver unload.
> > > 
> > > Signed-off-by: Rob Clark <robdclark@gmail.com>
> > > ---
> > > Similar case to the issue that was fixed recently in drm/ast
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Actually I just pushed a patch to drm-misc-next to rename this function to
> drm_helper_force_disable_all(), so you need to respin ... My r-b still
> holds.

Fixed and queued up.

thanks,
  Gerd

