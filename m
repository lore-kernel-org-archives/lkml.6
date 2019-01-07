Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B643C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C736F2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 16:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tronnes.org header.i=@tronnes.org header.b="mYA2r7EA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbfAGQJr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 11:09:47 -0500
Received: from smtp.domeneshop.no ([194.63.252.55]:38939 "EHLO
        smtp.domeneshop.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727002AbfAGQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 11:09:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org; s=ds201810;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject; bh=WzQPNPhgX8UEb2GQ5JFf00sfU1gB6VVpRjTDfLNUCz0=;
        b=mYA2r7EANJV4OI8GWtBjfVJSNg7l2/KnrJkZjWaisMGxPB1I2BDoiEQqiZdbceEfmpsdNHzM5hNmgt/yJIAgIQ71rzY7s6+Vbe1gAFlgd1GPwRaWDYvk8aaFSI5x6VGMHfb35qVL1hDdnaH5wQygecTpS2EHrFf8d+WC7Ia4QPTiGJzS6IGw/rM5aevk9mFTG4Z6wpLiLKt9LBYDA9JIDo1X+ya4NuhsYoOWsFBrdcPZzfJgYWcVrgYeSGuMekgBUWBEbb7S4IIRNxnABlQeCV8tl6btg3iNNfYq/CQbS0Wn/XHb4NEzPmLKCit+p9mzoDvx3eY8rnKI5W1BCkrk4w==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:64536 helo=[192.168.10.174])
        by smtp.domeneshop.no with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <noralf@tronnes.org>)
        id 1ggXTF-0004pp-GV; Mon, 07 Jan 2019 17:09:45 +0100
Subject: Re: [PATCH v2 13/14] drm/tinydrm: do not reply on drmP.h from
 drm_gem_cma_helper.h
To:     Sam Ravnborg <sam@ravnborg.org>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        David Lechner <david@lechnology.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Eric Anholt <eric@anholt.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
References: <20181230174838.32330-14-sam@ravnborg.org>
From:   =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <e09b7e53-3099-48a4-fab5-75fda1661abd@tronnes.org>
Date:   Mon, 7 Jan 2019 17:09:41 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181230174838.32330-14-sam@ravnborg.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Den 30.12.2018 18.48, skrev Sam Ravnborg:
> drmP.h was the only header file in the past and a lot
> of files rely on that drmP.h defines everything.
> The goal is to one day to delete drmP.h and
> as a step towards this it will no longer be included in the
> headers files in include/drm/
> 
> To prepare tinydrm/ for this add dependencies that
> othwewise was pulled in by drmP.h from drm_gem_cma_helper.h
> 
> To avoid that tinydrm.h became "include everything",
> push include files to the individual drivers.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "Noralf Trønnes" <noralf@tronnes.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Eric Anholt <eric@anholt.net>
> Cc: David Lechner <david@lechnology.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---

Thanks for doing this dep fix series:

Reviewed-by: Noralf Trønnes <noralf@tronnes.org>
