Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE5FC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 659DF214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 10:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfAJKQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 05:16:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42444 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfAJKQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 05:16:14 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7535A83F3E;
        Thu, 10 Jan 2019 10:16:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-203.ams2.redhat.com [10.36.116.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 112E1104810D;
        Thu, 10 Jan 2019 10:16:14 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 41C8F16E03; Thu, 10 Jan 2019 11:16:13 +0100 (CET)
Date:   Thu, 10 Jan 2019 11:16:13 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@redhat.com>,
        andr2000@gmail.com, David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVER FOR BOCHS VIRTUAL GPU" 
        <virtualization@lists.linux-foundation.org>
Subject: Re: [PATCH v3 14/15] drm/bochs: drop old fbdev emulation code
Message-ID: <20190110101613.yo4ewkhy3nxs3do3@sirius.home.kraxel.org>
References: <20190110082845.3453-1-kraxel@redhat.com>
 <20190110082845.3453-15-kraxel@redhat.com>
 <faf265e5-8f47-f652-5b19-d55fd4ed7d67@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faf265e5-8f47-f652-5b19-d55fd4ed7d67@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.27]); Thu, 10 Jan 2019 10:16:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Hi,

> > -	drm_fb_helper_set_suspend_unlocked(&bochs->fb.helper, 1);
> 
> The generic fbdev emulation doesn't take care of suspend/resume. You
> could do this:
> drm_fb_helper_set_suspend_unlocked(drm_dev->fb_helper, 1);

Additional to drm_mode_config_helper_suspend() I assume?
Does the call order matter?

> >  	drm_helper_resume_force_mode(drm_dev);
> 
> The docs for this function has this to say:
> * This function is deprecated. New drivers should implement atomic mode-
> * setting and use the atomic suspend/resume helpers.
> 
> Maybe you can use drm_mode_config_helper_suspend/resume() instead like
> suggested in the drm_fbdev_generic_setup() docs.

That should work, yes.  The driver is simple enough ;)

cheers,
  Gerd

