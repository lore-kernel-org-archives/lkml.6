Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752404AbeEPNzN (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 09:55:13 -0400
Received: from mail.bootlin.com ([62.4.15.54]:45786 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751389AbeEPNzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 09:55:12 -0400
Date: Wed, 16 May 2018 15:55:00 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alessandro Zummo <a.zummo@towertech.it>, y2038@lists.linaro.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rtc: vr41xx: remove mktime usage
Message-ID: <20180516135500.GE3254@piout.net>
References: <20180420161433.3721192-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420161433.3721192-1-arnd@arndb.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 20/04/2018 18:14:24+0200, Arnd Bergmann wrote:
> This driver uses mktime() and rtc_time_to_tm() to convert between time
> values. This works fine on 64-bit kernels over the whole supported
> range, and the vr41xx chip is a 64-bit MIPS implementation, but it is
> inconsistent because it doesn't do the same thing on 32-bit kernels that
> overflow in 2106 or 2038.
> 
> Changing it to use mktime64/rtc_time64_to_tm() should have no visible
> impact on vr41xx but gets us closer to removing the 32-bit interfaces.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/rtc/rtc-vr41xx.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 

I've applied the series a while ago. It should be noted that mktime64
will fail on 32bit platforms in year 21000 or so but I pretty sure it is
not worth fixing. My understanding is that the kernel will fail in April
2262 anyway as ktime_t will overflow.

Note that I will be following up with multiple series adding proper
rtc HW range, removing set_mmss and rtc_time_to_tm/rtc_tm_to_time64.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
