Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F63C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB65F2086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfBTLwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:52:08 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:45758 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbfBTLwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:52:08 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id CA5E180532;
        Wed, 20 Feb 2019 12:52:03 +0100 (CET)
Date:   Wed, 20 Feb 2019 12:52:02 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        devicetree@vger.kernel.org, tomi.valkeinen@ti.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/4] drm/panel: Add OSD101T2587-53TS driver
Message-ID: <20190220115202.GA18603@ravnborg.org>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
 <20190215140315.18046-5-peter.ujfalusi@ti.com>
 <20190215180759.GA26944@ravnborg.org>
 <fefcd92c-4171-ed86-28d2-4145d409a73d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fefcd92c-4171-ed86-28d2-4145d409a73d@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=xATtUWIRqsn5HY61KSsA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

On Wed, Feb 20, 2019 at 12:39:11PM +0200, Peter Ujfalusi wrote:
> Hi Sam,
> 
> On 15/02/2019 20.07, Sam Ravnborg wrote:
> >> +#include <linux/backlight.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/regulator/consumer.h>
> >> +
> >> +#include <drm/drmP.h>
> > Please do not use drmP.h in new drivers - we try to get rid of this file.
> 
> ...
> 
> >> +static int osd101t2587_panel_get_modes(struct drm_panel *panel)
> >> +{
> >> +	struct osd101t2587_panel *osd101t2587 = to_osd101t2587_panel(panel);
> >> +	struct drm_display_mode *mode;
> >> +
> >> +	mode = drm_mode_duplicate(panel->drm, osd101t2587->default_mode);
> >> +	if (!mode) {
> >> +		dev_err(panel->drm->dev, "failed to add mode %ux%ux@%u\n",
> 
> drm/drmP.h is needed for this dev_err.
drmP.h is only a set of include files and forwards today.
So you need to figure out what to replace it with.

Often removing drmP.h requires you to add more than one extra include file.

	Sam
