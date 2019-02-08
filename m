Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A79C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79D5521841
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:17:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbfBHWRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:17:42 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:32842 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfBHWRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:17:42 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 4689C804BA;
        Fri,  8 Feb 2019 23:17:35 +0100 (CET)
Date:   Fri, 8 Feb 2019 23:17:33 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Dave Airlie <airlied@linux.ie>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the drm-misc tree
Message-ID: <20190208221733.GA31440@ravnborg.org>
References: <20190208123815.64757bc5@canb.auug.org.au>
 <CAKMK7uHOJwunZ0erM31fBNi+kADoK=Y=CRpoSTx=CRKFFL596w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uHOJwunZ0erM31fBNi+kADoK=Y=CRpoSTx=CRKFFL596w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=UpRNyd4B c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=kj9zAlcOel0A:10 a=e5mUnYsNAAAA:8 a=B8yakSgep9c5vmaIpY8A:9
        a=CjuIK1q_8ugA:10 a=JAcZpAlVfFQA:10 a=Vxmtnl_E_bksehYqCbjh:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel/Stephen

Thanks for the report and the hints how to move forward to fix it.

> Sam, can you pls take a look at what komeda needs? you need to
> manually merge together drm-misc-next and drm-next first I think.

Merged the two tree and fixed build.
Undid the merge and checked that the build was still OK.

Patch sent to dri-devel:
https://lists.freedesktop.org/archives/dri-devel/2019-February/206662.html

> Dave, Maxime, Liviu: Heads up, drm-misc-next + drm-next will colide.
There was a trivial conflict when I merged, but in i915 so I just fixed
it up and kept focus on komeda.
So in other words, yes there is a conflict.

	Sam
