Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED9CC4321E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66A5B2086E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:44:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66A5B2086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728694AbeIJWkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:40:09 -0400
Received: from muru.com ([72.249.23.125]:55810 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbeIJWkJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:40:09 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CA02F80B6;
        Mon, 10 Sep 2018 17:49:01 +0000 (UTC)
Date:   Mon, 10 Sep 2018 10:44:53 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-omap@vger.kernel.org, sre@kernel.org, nekit1000@gmail.com,
        mpartap@gmx.net, merlijn@wizzup.org
Subject: Re: omap4: support for manually updated display
Message-ID: <20180910174453.GV5662@atomide.com>
References: <20180830090456.GA17277@amd>
 <797c13fa-7a5b-a809-7dd0-14b01a3046be@ti.com>
 <3205865.8O8aibZXye@avalon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3205865.8O8aibZXye@avalon>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Laurent Pinchart <laurent.pinchart@ideasonboard.com> [180910 12:28]:
> On Monday, 10 September 2018 14:59:23 EEST Tomi Valkeinen wrote:
> > A large omapdrm change set from Laurent was merged into drm-next, and
> > I'm certain they conflict with this series. Laurent also has continued
> > that work, and while those new patches haven't been sent for review yet,
> > I fear they'll also conflict with these.
> > 
> > So in the minimum, a rebase on top of drm-next is needed.
> > 
> > I also continue to be very worried that adding DSI support to omapdrm at
> > this stage will be a huge extra burden for Laurent's work.
> > 
> > We should transform the panel-dsi-cm.c towards the common DRM model.
> > With a quick look, there seems to be a driver for Samsung's S6E63J0X03
> > panel. So possibly all the DSI features are there in the DRM framework,
> > but someone needs to check that and start working on panel-dsi-cm.c so
> > that it's ready when we finally switch to the DRM model.
> > 
> > In my opinion, which I've also expressed before, the above work is much
> > easier to do by first changing the omapdrm to DRM model, without any DSI
> > displays, and then add the DSI command mode support. But if people
> > insist on adding the DSI support already now, I would appreciate the
> > same people working on the DSI support so that Laurent doesn't have to
> > do it all.
> 
> I want to make it clear that I don't want to claim any privilege in getting 
> patches merged first. I am however worried that, without an easy way to test 
> DSI support, and without enough time to focus on it, I would break whatever 
> would be merged now in future reworks. I would thus like to find out how to 
> collaborate on this task, hopefully to move towards usage of drm_bridge and 
> drm_panel for DSI-based pipelines.

Real users with mainline kernel with a real product should
always have priority over any ongoing clean-up.

And for testing, a bunch of real users is something you can't
beat for proper testing of code on ongoing basis!

Naturally the burden of getting the patches ready is on the people
using them for rebase and fixing comments. And Sebastian has
already agreed help with maintaining it.

I've been actually using DSI command mode support and testing
Linux next several times a week to prevent regressions from
sneaking into -rc1 in general. So now I can't test omapdrm with
next until Sebastian is done with rebasing.. Back to headless
testing then.

Anyways, I'd say let's add the DSI command mode support ASAP after
rebasing, there are at least Sebastian, Pavel and I then testing
and helping with further ongoing panel conversion work.

Regards,

Tony
