Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D640C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C97B206B6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBUPJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:09:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44780 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725858AbfBUPJO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:09:14 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4249630821BF;
        Thu, 21 Feb 2019 15:09:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-228.ams2.redhat.com [10.36.116.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA8C65D6A6;
        Thu, 21 Feb 2019 15:09:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 7728A11A9A; Thu, 21 Feb 2019 16:09:12 +0100 (CET)
Date:   Thu, 21 Feb 2019 16:09:12 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        "open list:INTEL DRM DRIVERS excluding Poulsbo, Moorestow..." 
        <intel-gfx@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [PATCH v2 1/2] drm: move i915_kick_out_vgacon to drm_fb_helper
Message-ID: <20190221150912.yytlcxxwv7qodaf3@sirius.home.kraxel.org>
References: <20190221113534.20764-1-kraxel@redhat.com>
 <20190221113534.20764-2-kraxel@redhat.com>
 <64292443-e784-5c15-9e3b-d52afc861991@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64292443-e784-5c15-9e3b-d52afc861991@tronnes.org>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Thu, 21 Feb 2019 15:09:14 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > +int drm_fb_helper_kick_out_vgacon(void);
> > +
> 
> Don't you need a dummy version as well for this one, like how it's done
> for the other functions, to cover the case when DRM_FBDEV_EMULATION is
> not selected?

Good question.

I guess it makes sense to kick out vgacon even with CONFIG_FB=n.

But when integrating this into
drm_fb_helper_remove_conflicting_pci_framebuffers() as suggested by
Daniel this isn't going to fly ...

cheers,
  Gerd

