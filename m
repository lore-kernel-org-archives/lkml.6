Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E2CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E965E206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 11:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbfAPL2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 06:28:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389759AbfAPL2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 06:28:02 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 533962DB737;
        Wed, 16 Jan 2019 11:28:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-117-186.ams2.redhat.com [10.36.117.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BBBAB1048102;
        Wed, 16 Jan 2019 11:28:01 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id F2EF716E03; Wed, 16 Jan 2019 12:28:00 +0100 (CET)
Date:   Wed, 16 Jan 2019 12:28:00 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Frediano Ziglio <fziglio@redhat.com>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVER FOR QXL VIRTUAL GPU" 
        <spice-devel@lists.freedesktop.org>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [Spice-devel] [PATCH 1/3] drm/qxl: add mode/framebuffer check
 functions
Message-ID: <20190116112800.v73xmxedt4b3gktj@sirius.home.kraxel.org>
References: <20190116083521.22673-1-kraxel@redhat.com>
 <20190116083521.22673-2-kraxel@redhat.com>
 <636470684.58090538.1547630691403.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <636470684.58090538.1547630691403.JavaMail.zimbra@redhat.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Wed, 16 Jan 2019 11:28:02 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +static int qxl_check_mode(struct qxl_device *qdev,
> > +			  unsigned int width,
> > +			  unsigned int height)
> > +{
> > +	if (width * height * 4 > qdev->vram_size)
> 
> Is someone checking for integer overflows already?

Need to have a look.  This is just ...

> > -	if (bo->surf.stride * bo->surf.height > qdev->vram_size) {
> > -		DRM_ERROR("Mode doesn't fit in vram size (vgamem)");
> > -		return -EINVAL;
> > -	}

... that check moved into the new function.

cheers,
  Gerd

