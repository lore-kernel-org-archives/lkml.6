Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EDEC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:47:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA3C3218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549043257;
	bh=hsPvYFCPMdiKvw17X5Dr3THbnD1SM5Sq3zpQmLiVkI0=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=psicoD1vezSbLfo4LGMbg8SC8qV2lTBUTRKplEx2nxG4KjgIpz0AjEFnkXrfWqRF8
	 8tA4hjvl0aTndnYVKRhYj2Tu8+nTBotCW5EcmtbP4ZPWI3UxV45tnbhKnyHRGvRoAU
	 RFpdOcj1RFq9ntDPwrts7Q8/3ZUEkYV9HCwr2Vf8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730834AbfBARrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 12:47:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:49192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728114AbfBARrf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 12:47:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C3FD218AC;
        Fri,  1 Feb 2019 17:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549043255;
        bh=hsPvYFCPMdiKvw17X5Dr3THbnD1SM5Sq3zpQmLiVkI0=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=X/hCiZwZ7wSK9i0V8/JaUxfSDf0fwosw6cfRUOX9bV/l7Me1re5ZWH/mu+065kcaD
         XELhhi+FWgl65YCry69/8OjijQX/KIVjm2mYgNVq8kgznSYP65mPZsaxTqjdxuOYbB
         kKWb+TaTqw1xc0qd/GvaV5y1YvZjbl+piR/vmOLM=
Date:   Fri, 1 Feb 2019 18:47:32 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Sam Ravnborg <sam@ravnborg.org>, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Hans de Goede <hdegoede@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sean Paul <sean@poorly.run>, intel-gfx@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/5] staging/vboxvideo: prepare for drmP.h removal
 from drm_modeset_helper.h
Message-ID: <20190201174732.GA17542@kroah.com>
References: <20190126122527.11647-1-sam@ravnborg.org>
 <20190126122527.11647-2-sam@ravnborg.org>
 <20190201173749.GF3271@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201173749.GF3271@phenom.ffwll.local>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 06:37:49PM +0100, Daniel Vetter wrote:
> On Sat, Jan 26, 2019 at 01:25:23PM +0100, Sam Ravnborg wrote:
> > The use of drmP.h is discouraged and removal of it from
> > drm_modeset_helper.h caused vboxvideo to fail to build.
> > 
> > This patch introduce the necessary fixes to prepare for the
> > drmP.h removal from drm_modeset_helper.h.
> > 
> > In the files touched sort the include files
> > 
> > Build tested on x86 and arm allmodconfig / allyesconfig.
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: Hans de Goede <hdegoede@redhat.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Hi Greg,
> 
> Ack for merging this through drm-misc? I think we've defacto-maintained
> vboxvideo in drm anyway this release ...

Sorry, feel free to just always take this type of stuff without my ack,
I can merge around you if I ever have any problems.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
