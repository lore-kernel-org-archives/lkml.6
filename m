Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 83BAFC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 404A9208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 16:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404A9208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=siol.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936108AbeFMQFb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 12:05:31 -0400
Received: from mailoutvs36.siol.net ([185.57.226.227]:50495 "EHLO
        mail.siol.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S935524AbeFMQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 12:05:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTP id 2E0A45213D2;
        Wed, 13 Jun 2018 18:05:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psrvmta12.zcs-production.pri
Received: from mail.siol.net ([127.0.0.1])
        by localhost (psrvmta12.zcs-production.pri [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Rb2ilXWrJxaR; Wed, 13 Jun 2018 18:05:26 +0200 (CEST)
Received: from mail.siol.net (localhost [127.0.0.1])
        by mail.siol.net (Zimbra) with ESMTPS id 734A6520E52;
        Wed, 13 Jun 2018 18:05:26 +0200 (CEST)
Received: from jernej-laptop.localnet (unknown [194.152.15.144])
        (Authenticated sender: 031275009)
        by mail.siol.net (Zimbra) with ESMTPA id C6616521384;
        Wed, 13 Jun 2018 18:05:25 +0200 (CEST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@siol.net>
To:     linux-sunxi@googlegroups.com, maxime.ripard@bootlin.com
Cc:     wens@csie.org, robh+dt@kernel.org, airlied@linux.ie,
        gustavo@padovan.org, maarten.lankhorst@linux.intel.com,
        seanpaul@chromium.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [linux-sunxi] Re: [PATCH v2 24/27] drm: of: Export drm_crtc_port_mask()
Date:   Wed, 13 Jun 2018 18:04:24 +0200
Message-ID: <1909375.AJdhpVkKnf@jernej-laptop>
In-Reply-To: <20180613073605.gnhcwrywooxhyryj@flea>
References: <20180612200036.21483-1-jernej.skrabec@siol.net> <20180612200036.21483-25-jernej.skrabec@siol.net> <20180613073605.gnhcwrywooxhyryj@flea>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne sreda, 13. junij 2018 ob 09:36:05 CEST je Maxime Ripard napisal(a):
> On Tue, Jun 12, 2018 at 10:00:33PM +0200, Jernej Skrabec wrote:
> > Function is useful when drm_of_find_possible_crtcs() can't be used and
> > custom parsing is needed. This can happen for example when there is a
> > node with multiple muxes between crtc and encoder.
> > 
> > Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > ---
> > 
> >  drivers/gpu/drm/drm_of.c | 4 ++--
> >  include/drm/drm_of.h     | 8 ++++++++
> >  2 files changed, 10 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_of.c b/drivers/gpu/drm/drm_of.c
> > index 1fe122461298..2e9cea3287b2 100644
> > --- a/drivers/gpu/drm/drm_of.c
> > +++ b/drivers/gpu/drm/drm_of.c
> > @@ -22,8 +22,8 @@ static void drm_release_of(struct device *dev, void
> > *data)> 
> >   * Given a port OF node, return the possible mask of the corresponding
> >   * CRTC within a device's list of CRTCs.  Returns zero if not found.
> >   */
> > 
> > -static uint32_t drm_crtc_port_mask(struct drm_device *dev,
> > -				   struct device_node *port)
> > +uint32_t drm_crtc_port_mask(struct drm_device *dev,
> > +			    struct device_node *port)
> 
> It should probably be exported too?

Yes, of course. It will be in next version.

Best regards,
Jernej



