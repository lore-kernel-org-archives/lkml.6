Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753287AbeCPKSY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 06:18:24 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:29095 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750982AbeCPKSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 06:18:22 -0400
Subject: Re: [PATCH] ARM: davinci: DA8XX: fix oops in USB PHY driver due to
 stack allocated platform platform_data
To: David Lechner <david@lechnology.com>,
        <linux-arm-kernel@lists.infradead.org>
CC: Kevin Hilman <khilman@kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        <linux-kernel@vger.kernel.org>
References: <1521136976-32730-1-git-send-email-david@lechnology.com>
From: Sekhar Nori <nsekhar@ti.com>
Message-ID: <382a269a-f486-8c1a-23b2-9620a01a073c@ti.com>
Date: Fri, 16 Mar 2018 15:47:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1521136976-32730-1-git-send-email-david@lechnology.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 March 2018 11:32 PM, David Lechner wrote:
> This fixes a possible kernel oops due to using stack allocated platform
> data for the USB PHY driver on DA8XX devices. If the platform device
> probe is deferred, then we get a corrupt pointer for the platform data.
> 
> We now use a global static struct for the platform data so that the
> platform data pointer does not get written over.
> 
> Tested on OMAP-L138 LCDK board using legacy board file.

Oops. That should have been caught in review.

> 
> Fixes: 9b504750923cb ("ARM: davinci: da8xx: Add USB PHY platform device")

The offending commit seems to be bdec5a6b5789 ("ARM: da8xx: use platform
data for CFGCHIP syscon regmap") in my tree which should be in
linux-next. I don't think we have this issue in mainline. Right?

> Signed-off-by: David Lechner <david@lechnology.com>

Thanks,
Sekhar
