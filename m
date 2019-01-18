Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0198C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE1F020657
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfARAkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:40:13 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48142 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725982AbfARAkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:40:12 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkICZ-0002SR-PO; Fri, 18 Jan 2019 01:40:03 +0100
Date:   Fri, 18 Jan 2019 01:40:03 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Heiko Stuebner <heiko@sntech.de>
cc:     hjc@rock-chips.com, linux-rockchip@lists.infradead.org,
        seanpaul@chromium.org, LKML <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [v8, 2/3] drm/rockchip: Add support for Rockchip Soc RGB output
 interface
In-Reply-To: <20180830211207.10480-3-heiko@sntech.de>
Message-ID: <alpine.DEB.2.21.1901180131510.1647@nanos.tec.linutronix.de>
References: <20180830211207.10480-3-heiko@sntech.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sandy, Heiko,

On Thu, 30 Aug 2018, Heiko Stuebner wrote:

> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
> @@ -0,0 +1,173 @@
> +//SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Author:
> + *      Sandy Huang <hjc@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

The licensing in this file and in the corresponding header is broken.

> --- /dev/null
> +++ b/drivers/gpu/drm/rockchip/rockchip_rgb.h
> @@ -0,0 +1,20 @@
> +//SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Copyright (C) Fuzhou Rockchip Electronics Co.Ltd
> + * Author:
> + *      Sandy Huang <hjc@rock-chips.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */

Both files use the SPDX license identifier for GPL v2 or later, but the
license notice is clearly v2 only.

So the copyright holder needs to decide which one. And please remove the
boiler plate text. It's redundant.

See also Documentation/process/license-rules.rst

Please fix ASAP, add a Fixes tag and cc stable so the inconsistency is
fixed in 4.20 as well.

Thanks,

	tglx
