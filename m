Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACE2C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60F1320B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 21:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfAaVDR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 16:03:17 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:34954 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbfAaVDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 16:03:17 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 306C880480;
        Thu, 31 Jan 2019 22:03:13 +0100 (CET)
Date:   Thu, 31 Jan 2019 22:03:12 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Sean Paul <sean@poorly.run>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stefan Mavrodiev <stefan@olimex.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/19] drm/panel: drmP.h removal and DRM_DEV*
Message-ID: <20190131210312.GA8947@ravnborg.org>
References: <20190131192619.9763-1-sam@ravnborg.org>
 <20190131200723.GZ114153@art_vandelay>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131200723.GZ114153@art_vandelay>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=tJRMQ8IxFmv1hn5U_dgA:9 a=CjuIK1q_8ugA:10
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean.

> Hey Sam,
> Thanks for the patchset, this will make dmesg grepping easier! One comment, and
> you're going to hate me for it: Why use DRM_DEV* instead of DRM_*?
> 
> When I introduced DRM_DEV, it was to cover the case where there are multiple
> instances of the same driver (ie: dual-channel mipi, multiple crtcs, etc). I
> suppose that _could_ happen in the panel space, but it seems more unlikely than
> not.

The rationale for using DRM_DEV* are solely that if a struct device * is avalible,
then we can use this to provide more information about the origin of the logging.

I have not testet it - but from browsing the code I could not see that
DRM_ERROR and friends picked up the module name.
If DRM_ERROR is the right choice I will redo the patches - no problem.

But if we loose the module name then the DRM_DEV* variants are preferable IMO.

Note: I missed DRM_DEV_WARN(), so I left one dev_warn() in the code.

	Sam
