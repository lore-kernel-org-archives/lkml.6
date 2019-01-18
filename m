Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99AB4C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68FC520823
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 12:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfARMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 07:35:04 -0500
Received: from gloria.sntech.de ([185.11.138.130]:48436 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfARMfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 07:35:03 -0500
Received: from [94.134.91.123] (helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gkTMF-0001RB-Up; Fri, 18 Jan 2019 13:34:47 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Thomas Gleixner <tglx@linutronix.de>, eddie.cai.linux@gmail.com
Cc:     hjc@rock-chips.com, linux-rockchip@lists.infradead.org,
        seanpaul@chromium.org, LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [v8, 2/3] drm/rockchip: Add support for Rockchip Soc RGB output interface
Date:   Fri, 18 Jan 2019 13:34:47 +0100
Message-ID: <1636679.fMryThW7k8@phil>
In-Reply-To: <alpine.DEB.2.21.1901180131510.1647@nanos.tec.linutronix.de>
References: <20180830211207.10480-3-heiko@sntech.de> <alpine.DEB.2.21.1901180131510.1647@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Am Freitag, 18. Januar 2019, 01:40:03 CET schrieb Thomas Gleixner:
> On Thu, 30 Aug 2018, Heiko Stuebner wrote:
> > +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> > @@ -0,0 +1,173 @@
> > +//SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> > + * Author:
> > + *      Sandy Huang <hjc@rock-chips.com>
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> 
> The licensing in this file and in the corresponding header is broken.
> 
> > --- /dev/null
> > +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
> > @@ -0,0 +1,20 @@
> > +//SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> > + * Author:
> > + *      Sandy Huang <hjc@rock-chips.com>
> > + *
> > + * This software is licensed under the terms of the GNU General Public
> > + * License version 2, as published by the Free Software Foundation, and
> > + * may be copied, distributed, and modified under those terms.
> > + *
> > + * This program is distributed in the hope that it will be useful,
> > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > + * GNU General Public License for more details.
> > + */
> 
> Both files use the SPDX license identifier for GPL v2 or later, but the
> license notice is clearly v2 only.
> 
> So the copyright holder needs to decide which one. And please remove the
> boiler plate text. It's redundant.

Not sure how to proceed as I haven't seen Sandy around for quite a bit,
but the first versions didn't have a SPDX header and were GPL2-only (v1-v4)
and the SPDX header was added in v5.

So as a stopgap measure, I'd guess we could assume that the copyright
intended GPL2-only?


> Please fix ASAP, add a Fixes tag and cc stable so the inconsistency is
> fixed in 4.20 as well.

ok, once we have the direction of change set.


Heiko


