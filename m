Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29C63C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF1E7218A6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 17:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=poorly.run header.i=@poorly.run header.b="Bwfpm3Zv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbfAXRvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 12:51:39 -0500
Received: from mail-yb1-f193.google.com ([209.85.219.193]:33169 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbfAXRvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 12:51:38 -0500
Received: by mail-yb1-f193.google.com with SMTP id m132so995478ybf.0
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 09:51:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=poorly.run; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bhk8H9tazTUscD/pxPfOSKpqlrE97YOeNeJgS+fpIpw=;
        b=Bwfpm3ZvwJBNuoiQOO512dya0Ca50Djnh5X9DJiWj83E9HxSlv1LCeDvKljt1uhBct
         7vajrVVNi8zB60BrG1eGiyAhOi440TbPQ/gpPg+bD7fUoi13OP4NhutH2s2dVGP8PUM5
         K6baWaBtBSpPLwuSZW2wAxu8NdqD761dlA6MNfiSoj7ZYxNVWaouuAiVkersDvC9hb/9
         OKOsqfIz9gDAY/lmgaxaZVN+3EUKCnxIcLolGxeHq2/tx/OCmzWq8tzlYyukFscdkMdC
         1O6AeS1MyjwhS78BnO6L6bRpCMaczqAoDuaPHOIpBUu6X/y5cOxaixw7+SxUC6Dc2Oxu
         2JMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bhk8H9tazTUscD/pxPfOSKpqlrE97YOeNeJgS+fpIpw=;
        b=Zl4mIT4QwnMS5EdlpVT9V/Yg5CAYxALKONSzYCDV8w/harvQeD5FsX4aYzdbUlxfOa
         s3m+DUrVPiT3F1VNbkbSqG/Ks5KCz5aLLCbuD2gIdUeIL4LqI4MLBLLHwCvAEZ9qOGgm
         gWVQa8HKsfig35y76oUm8IX2uDtuzqdFVRIzaSrIMlYFV1gykVhkPOEzrosRBREclzay
         gqMwOYHfm3xkxwhZeNqWvFBede4IFXinfLxkYQBj3wfbund9ZzcCnVd6pzTyFPqd6KtR
         W4pUyEWa33Bb6SMsVHDyeUdNIh57xMqwWMc0pSKqp4S/z4uobsQHE0Mbl2yy7g/O3/x9
         Y8HQ==
X-Gm-Message-State: AJcUuke0noHWGdAM+CoGIPDcupzsk21szGVcbq23WSfvINOGGKqcmRaS
        4RfJgHeV4z7BSQ73Cj2m05syKw==
X-Google-Smtp-Source: ALg8bN7CWju7aKZ7fzyERIxUfdeueYjXNLIun0IiJMw/M1NCSMhfQSVZ9dbu1BMnnxaLRoFOR/Hukg==
X-Received: by 2002:a5b:b8e:: with SMTP id l14mr7239501ybq.208.1548352297839;
        Thu, 24 Jan 2019 09:51:37 -0800 (PST)
Received: from localhost ([2620:0:1013:11:89c6:2139:5435:371d])
        by smtp.gmail.com with ESMTPSA id x132sm18418801ywx.27.2019.01.24.09.51.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 09:51:37 -0800 (PST)
Date:   Thu, 24 Jan 2019 12:51:36 -0500
From:   Sean Paul <sean@poorly.run>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        padovan Gustavo <gustavo.padovan@collabora.com>,
        maxime.ripard@bootlin.com, seanpaul@chromium.org,
        hl@rock-chips.com, briannorris@chromium.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nickey.yang@rock-chips.com
Subject: Re: [PATCH v4 RESEND] drm/panel: add Kingdisplay kd097d04 panel
 driver
Message-ID: <20190124175136.GP114153@art_vandelay>
References: <20181030091528.28211-1-heiko@sntech.de>
 <fa732d7c529c28135b2c9a1ccf902d4658a53682.camel@collabora.com>
 <20190124161812.GA10550@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190124161812.GA10550@ulmo>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 05:18:12PM +0100, Thierry Reding wrote:
> On Thu, Jan 24, 2019 at 12:01:55PM -0300, Ezequiel Garcia wrote:
> > On Tue, 2018-10-30 at 10:15 +0100, Heiko Stuebner wrote:
> > > From: Nickey Yang <nickey.yang@rock-chips.com>
> > > 
> > > Support Kingdisplay kd097d04 9.7" 1536x2048 TFT LCD panel,
> > > it is a MIPI dual-DSI panel.
> > > 
> > > v4-resend:
> > > - Thierry noted missing dt-bindings for v4 but forgot that he
> > >   already had applied them one kernel release back in
> > >   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ebc950fdff6d5f9250cd5a5a348af97f7d8508df
> > > v4:
> > > - address Philipp's comments
> > >   - real range for usleep_range and
> > >   - poweroff ordering in kingdisplay_panel_prepare
> > >   - return value beautification in panel_probe
> > > - update author naming for full name
> > > v3:
> > > - address Thierry's comments
> > >   - error handling for init dsi writes in init
> > >   - unconditionally remove the panel
> > >   - don't use drm_panel_detach
> > >   - a bit of variable signednes wiggling
> > > - I did talk to ChromeOS people and the delays really should be as short
> > >   as possible, so dropped the 100ms from the delay comments
> > > v2:
> > > - update timing + cmds from chromeos kernel
> > > - new backlight API including switch to devm_of_find_backlight
> > > - fix most of Sean Paul's comments
> > >   enable/prepare tracking seems something all panels do
> > > - document origins of the init sequence
> > > - lanes per dsi interface to 4 (two interfaces). Matches how tegra
> > >   and pending rockchip dual-dsi handle (dual-)dsi lanes
> > > - spdx header instead of license boilerplate
> > > 
> > > Signed-off-by: Nickey Yang <nickey.yang@rock-chips.com>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > 
> > Hm, this v4 patch has been stalling here for *four full months*.
> > 
> > Which deity do we need to pray to get this one moving? ;-)
> > 
> > Seriously, can someone please apply this?
> 
> If you care about this driver, perhaps you'd like to review and provide
> a Reviewed-by?

Looks good to me,

Reviewed-by: Sean Paul <sean@poorly.run>

> 
> Thierry



-- 
Sean Paul, Software Engineer, Google / Chromium OS
