Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E076C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEE82086C
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbfBTMl0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:41:26 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:53413 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727665AbfBTMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:41:25 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 15EAA20020;
        Wed, 20 Feb 2019 13:41:21 +0100 (CET)
Date:   Wed, 20 Feb 2019 13:41:20 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     thierry.reding@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        devicetree@vger.kernel.org, tomi.valkeinen@ti.com,
        robh+dt@kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/4] drm/panel: Add OSD101T2587-53TS driver
Message-ID: <20190220124120.GB18603@ravnborg.org>
References: <20190215140315.18046-1-peter.ujfalusi@ti.com>
 <20190215140315.18046-5-peter.ujfalusi@ti.com>
 <20190215180759.GA26944@ravnborg.org>
 <2398a647-be4c-15e4-3e28-36382a834dce@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2398a647-be4c-15e4-3e28-36382a834dce@ti.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=uJbq1YKnJNcGZX7w3IkA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter.

Always good to see that feedback input is used.
 
> OK.
> 
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static void osd101t2587_panel_shutdown(struct mipi_dsi_device *dsi)
> >> +{
> >> +	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
> >> +
> > Maybe call osd101t2587_panel_unprepare() here to turn off power supply?
> 
> Make sense, in this order:
> 	osd101t2587_panel_disable(&osd101t2587->base);
> 	osd101t2587_panel_unprepare(&osd101t2587->base);
> 
> But should the osd101t2587_panel_remove() do the same thing? or the
> osd101t2587_panel_disable() is redundant in the osd101t2587_panel_remove()?

I do not know the details to answer this.
In other words - I do not know if we can rely on that panel->disbale is always
called when a driver is removed.
Try to read the descriptions and maybe test it.

Other drivers do as far as I recall use disable in the remove function.

	Sam
