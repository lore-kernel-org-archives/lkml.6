Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EF53C32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 611B02082D
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 23:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 611B02082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730685AbeKEIcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 03:32:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:43049 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730390AbeKEIcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 03:32:09 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wA4NEwbC010015;
        Sun, 4 Nov 2018 17:14:59 -0600
Message-ID: <365d8b24f1c6a28c32998924a95b6a2a74655526.camel@kernel.crashing.org>
Subject: Re: radeon vs radeonfb Mobility quirks (Thinkpad X32)
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Eric Wong <e@80x24.org>, David Airlie <airlied@linux.ie>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Date:   Mon, 05 Nov 2018 10:14:57 +1100
In-Reply-To: <20181104042328.jzavn47y2wloprbs@untitled>
References: <20181104042328.jzavn47y2wloprbs@untitled>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.1 (3.30.1-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-11-04 at 04:23 +0000, Eric Wong wrote:
> Looking at drivers/video/fbdev/aty/radeon_pm.c, I notice it sets
> a D2 sleep mode for my X32:
> 
>         BUGFIX("IBM Thinkpad X31/X32",
>                PCI_VENDOR_ID_IBM, 0x052f,
>                radeon_pm_d2, NULL),
> 
> Which I suspect is what allows "radeonfb" to work for me
> 
> But I can't find the corresponding quirk in drivers/gpu/drm/radeon/,
> so I now believe a missing quirk is the cause of this problem
> with the "radeon" driver.
> 
> I poked around but couldn't figure out what changes to make to
> the "radeon" driver to enable the corresponding, but I'm willing
> to test patches.
> 
> Setting "dynpm" in /sys/**/power_method didn't seem to change
> things, either.
> 
> Help greatly appreaciated.  Thanks
> 
> 
> I've mainly been using the X32 as a server this decade so didn't
> use suspend/hibernate so I didn't investigate until recently
> (because my netbook died).

There's a whole pile of power management stuff for ancient laptops that
never quite made it from radeonfb to the radeon DRM driver... sadly it
also prevents sleep on old PowerBooks but I haven't had many complaints
so...

The code for D2 and D3 on those old things is reasonably self
contained, it shouldn't be that hard to move it over I suppose.

Cheers,
Ben.


