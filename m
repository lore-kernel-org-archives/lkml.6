Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85861C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E8072171F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 10:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbeLZKyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 05:54:38 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:39497 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbeLZKyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 05:54:38 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 49B1A20020;
        Wed, 26 Dec 2018 11:54:34 +0100 (CET)
Date:   Wed, 26 Dec 2018 11:54:32 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        sabyasachi.linux@gmail.com, airlied@linux.ie,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        jrdr.linux@gmail.com
Subject: Re: [PATCH] drm/bridge/panel: Remove duplicate header
Message-ID: <20181226105432.GA27553@ravnborg.org>
References: <20181224143218.GA3170@hp-pavilion-15-notebook-pc-brajeswar>
 <1891132.39bZHgSTRL@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1891132.39bZHgSTRL@avalon>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=pGLkceISAAAA:8 a=alanDeyDmt5WozxOKVMA:9
        a=JJunJ5Z9GtMrTd9o:21 a=zcd7iZ9w-JfMGnwq:21 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brajeswar

> On Monday, 24 December 2018 16:32:18 EET Brajeswar Ghosh wrote:
> > Remove drm/drm_panel.h which is included more than once
> > 
> > Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> > ---
> >  drivers/gpu/drm/bridge/panel.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/bridge/panel.c b/drivers/gpu/drm/bridge/panel.c
> > index 7cbaba213ef6..402b318eeeb2 100644
> > --- a/drivers/gpu/drm/bridge/panel.c
> > +++ b/drivers/gpu/drm/bridge/panel.c
> > @@ -15,7 +15,6 @@
> >  #include <drm/drm_crtc_helper.h>
> >  #include <drm/drm_encoder.h>
> >  #include <drm/drm_modeset_helper_vtables.h>
> > -#include <drm/drm_panel.h>
> 
> While at it, how about sorting headers alphabetically to make sure this won't 
> happen again ?

Even better would be to address the todo item:
"Clean up the DRM header mess" (see Documentation/gpu/todo.rst)

In other words - replace the include of "drmP.h" with the relevant header files.
Sorted, as suggested by Laurent.

	Sam
