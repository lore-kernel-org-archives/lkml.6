Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A22C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:36:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB61B2176F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 19:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbfAHTgP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:36:15 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:60555 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbfAHTgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:36:06 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 0D3AF20032;
        Tue,  8 Jan 2019 20:36:01 +0100 (CET)
Date:   Tue, 8 Jan 2019 20:36:00 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 07/14] drm: move EXPORT_SYMBOL_FOR_TESTS_ONLY to
 drm_util.h
Message-ID: <20190108193600.GA3367@ravnborg.org>
References: <20181230174838.32330-8-sam@ravnborg.org>
 <20190103081646.GB31320@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103081646.GB31320@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=dqr19Wo4 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=SeemID2DwRScC2BJXHQA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph

On Thu, Jan 03, 2019 at 12:16:46AM -0800, Christoph Hellwig wrote:
> On Sun, Dec 30, 2018 at 06:48:31PM +0100, Sam Ravnborg wrote:
> > +/*
> > + * Use EXPORT_SYMBOL_FOR_TESTS_ONLY() for functions that shall
> > + * only be visible for drmselftests.
> > + */
> > +#if defined(CONFIG_DRM_DEBUG_SELFTEST_MODULE)
> > +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x) EXPORT_SYMBOL(x)
> > +#else
> > +#define EXPORT_SYMBOL_FOR_TESTS_ONLY(x)
> > +#endif
> 
> Btw, why isn't this an EXPORT_SYMBOL_GPL if it is only for internal
> tests?

I did see your comment but did not include this in the
v3 of the patchset. I leave it to others to deal with this part
so the patchset are not postponed due to GPL discussions.

	Sam
