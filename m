Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935058AbeBNU0Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 15:26:24 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:38186 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbeBNU0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 15:26:22 -0500
Date: Wed, 14 Feb 2018 21:26:10 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: a.zummo@towertech.it, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@roeck-us.net, jdelvare@suse.com, kernel@pengutronix.de,
        Denis.Osterland@diehl.com
Subject: Re: [PATCH 1/4] rtc: isl1208: Fix unintended clear of SR bits
Message-ID: <20180214202610.GD8219@piout.net>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-2-m.grzeschik@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123121801.4214-2-m.grzeschik@pengutronix.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/2018 at 13:17:58 +0100, Michael Grzeschik wrote:
> From: Denis Osterland <Denis.Osterland@diehl.com>
> 
> After successful
> sr = isl1208_i2c_set_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN);
> sr will be 0.
> As a result
> sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR,
> 			sr & ~ISL1208_REG_SR_WRTC);
> is equal to
> sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR, 0);
> which clears all flags in SR.
> 
> Add an additional read of SR, to have value of SR in sr again.
> 
> Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/rtc/rtc-isl1208.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
