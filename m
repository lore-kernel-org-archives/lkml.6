Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75A1C4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88CFF20866
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 12:24:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="EbDmiEOt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88CFF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbeIJRSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 13:18:21 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:52494 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728357AbeIJRST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 13:18:19 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 204E857;
        Mon, 10 Sep 2018 14:24:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1536582267;
        bh=E9hjhMv5RUBibOU8G/HI+xSlQMUvCtSNjZvVmRt4mss=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EbDmiEOtHRlXF8GhCrM4y09ZznT+mUKJIHWq4YxZ7JAmovx9TX3erDxmm33S5/Ase
         NQx9F8BK9UGfQ1y9ZPoue1oWq13Ff6I7vYHc2jgn6Mu/37aKigISRX5ylUGAVSiD6V
         M2icAfpvbkyRq4lxGt3WEjSs3Y49IQhSWq0RcvqU=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc:     Pavel Machek <pavel@ucw.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org,
        nekit1000@gmail.com, mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: omap4: support for manually updated display
Date:   Mon, 10 Sep 2018 15:24:37 +0300
Message-ID: <3205865.8O8aibZXye@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
References: <20180830090456.GA17277@amd> <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Monday, 10 September 2018 14:59:23 EEST Tomi Valkeinen wrote:
> Hi Pavel,
> 
> (dropping Dave, no need to spam him)
> 
> On 30/08/18 12:04, Pavel Machek wrote:
> > Hi!
> > 
> > There's neat series of patches on
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap.git/log/
> > ?h=droid4-pending-v4.19
> > 
> > They enable display support for my hardware. As you can imagine,
> > display is rather important for a cellphone.
> > 
> > Tomi, can you take the patches? I can resubmit them in email, or
> > shuffle them to another branch without mfd changes, or clean them up
> > etc...
> 
> A large omapdrm change set from Laurent was merged into drm-next, and
> I'm certain they conflict with this series. Laurent also has continued
> that work, and while those new patches haven't been sent for review yet,
> I fear they'll also conflict with these.
> 
> So in the minimum, a rebase on top of drm-next is needed.
> 
> I also continue to be very worried that adding DSI support to omapdrm at
> this stage will be a huge extra burden for Laurent's work.
> 
> We should transform the panel-dsi-cm.c towards the common DRM model.
> With a quick look, there seems to be a driver for Samsung's S6E63J0X03
> panel. So possibly all the DSI features are there in the DRM framework,
> but someone needs to check that and start working on panel-dsi-cm.c so
> that it's ready when we finally switch to the DRM model.
> 
> In my opinion, which I've also expressed before, the above work is much
> easier to do by first changing the omapdrm to DRM model, without any DSI
> displays, and then add the DSI command mode support. But if people
> insist on adding the DSI support already now, I would appreciate the
> same people working on the DSI support so that Laurent doesn't have to
> do it all.

I want to make it clear that I don't want to claim any privilege in getting 
patches merged first. I am however worried that, without an easy way to test 
DSI support, and without enough time to focus on it, I would break whatever 
would be merged now in future reworks. I would thus like to find out how to 
collaborate on this task, hopefully to move towards usage of drm_bridge and 
drm_panel for DSI-based pipelines.

-- 
Regards,

Laurent Pinchart



