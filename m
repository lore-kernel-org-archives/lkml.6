Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA0FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:41:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C726206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 15:41:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547653282;
	bh=+3PG3IK2edMeoT6w1/IFZlSoI9BG0OaYxAP5Q9Xr4qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eSzkydwNCfMaLve6gt/6eSBgeIDCjrGKE/Y9QNtHxxmMTUQfW1x/cv4NYFRWI17Rg
	 hfDGL16kP9O2ZHWs/plOTSZCsNXinuSN9+pjNIS9XaLh235DdYNkPovwpJrhLYJ3cW
	 3DkGBQti0pb+Axn741NbRq80sevYw04vlEM3pZ44=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394177AbfAPPlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 10:41:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:49660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731042AbfAPPlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 10:41:19 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E887B20675;
        Wed, 16 Jan 2019 15:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547653279;
        bh=+3PG3IK2edMeoT6w1/IFZlSoI9BG0OaYxAP5Q9Xr4qw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IjLSCnAohMFu6wvpFcvs5N+nO3Pk/aFj4k18EK19QccB1wEj5cBbNCAfV61D8Xxbw
         I3AkugYaArROVv2kYwrlHYp6DuiX+bH8pQnIQibDSQX+2IbyT5XJE75aOTAlk5T7C7
         gLQAjVx2dZM6AqrCIjleyqZ8WotwSxNIFWPOz6xE=
Date:   Wed, 16 Jan 2019 16:41:16 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Arnaud Patard <arnaud.patard@rtp-net.org>
Subject: Re: [PATCH] staging/xgifb: Needs to be converted to a drm driver
Message-ID: <20190116154116.GD871@kroah.com>
References: <20190116100440.10071-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190116100440.10071-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 11:04:40AM +0100, Daniel Vetter wrote:
> The fbdev subsystem is closed for new drivers, those need to become
> drm ones (which generally results in smaller drivers nowadays, with
> the massive amounts of shared infrastructure and helper libraries drm
> has).
> 
> Although given the lack of progress since 2010, maybe time to ditch it
> from staging outright?
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/staging/xgifb/TODO | 3 +++
>  1 file changed, 3 insertions(+)

No one has done anything with this code for over the past year, so I'll
just go delete it, after applying this patch, so that if it does get
reverted, the TODO item will stay :)

thanks,

greg k-h
