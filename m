Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F7EC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 622DA20657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 10:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547548714;
	bh=g3X6E10yULpzWI8EFD7sHIkrn2s5QirXiCSn51N3n14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xAgh+OCb4LhHslHeUxD1w2UAZFQa8p4AWE9hjB/msXrVuuYfDHtK6BuI9wdyGygJh
	 H/k1uZePcLjYtD+6zuPfsPlhb1VN6+HA7FKPMAtbsABHttbM9ZXO3x78YmJot7E6Oo
	 U9/iOCxHEIdR0MtgLYJdqqU5tE01uiDvYyNPzUs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbfAOKic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 05:38:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:43098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728498AbfAOKic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 05:38:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8CB4620651;
        Tue, 15 Jan 2019 10:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547548712;
        bh=g3X6E10yULpzWI8EFD7sHIkrn2s5QirXiCSn51N3n14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EFLphssxC8P83Jj62jBOd/uTT03HzQzlDBl5MwvoqNwEWcHlbeS6grk4kjdUDJYwH
         kaT/TSwUmtFScIeO4kCbaALBrcLamGuB/lyv4qguh/vip3npjp5MuG3PhYDGty6Txx
         ZQz1Y5NHc+3bMCEGxt1OXJxpmO128r1fM7kwJHQ8=
Date:   Tue, 15 Jan 2019 11:38:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Alexander Kapshuk <alexander.kapshuk@gmail.com>
Subject: Re: [PATCH 1/2] staging/vboxvideo: Don't set
 FBINFO_MISC_ALWAYS_SETPAR
Message-ID: <20190115103829.GC18959@kroah.com>
References: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115102755.16183-1-daniel.vetter@ffwll.ch>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 11:27:54AM +0100, Daniel Vetter wrote:
> It's a debug hack flag useful to work around driver bugs. That's not a
> good idea for a new driver. Especially for a new drm driver.
> 
> Aside: the fbdev support should probably be converted over to the new
> generic fbdev support.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Alexander Kapshuk <alexander.kapshuk@gmail.com>
> ---
>  drivers/staging/vboxvideo/vbox_fb.c | 5 -----
>  1 file changed, 5 deletions(-)
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
