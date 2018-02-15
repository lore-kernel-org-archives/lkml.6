Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755131AbeBOIan (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 03:30:43 -0500
Received: from mail.free-electrons.com ([62.4.15.54]:44941 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755112AbeBOIal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 03:30:41 -0500
Date: Thu, 15 Feb 2018 09:30:28 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Denis OSTERLAND <denis.osterland@diehl.com>
Cc: "m.grzeschik@pengutronix.de" <m.grzeschik@pengutronix.de>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 1/4] rtc: isl1208: Fix unintended clear of SR bits
Message-ID: <20180215083028.GH8219@piout.net>
References: <20180123121801.4214-1-m.grzeschik@pengutronix.de>
 <20180123121801.4214-2-m.grzeschik@pengutronix.de>
 <20180214202610.GD8219@piout.net>
 <1518679666.5448.4.camel@diehl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1518679666.5448.4.camel@diehl.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/02/2018 at 07:27:47 +0000, Denis OSTERLAND wrote:
> Am Mittwoch, den 14.02.2018, 21:26 +0100 schrieb Alexandre Belloni:
> > On 23/01/2018 at 13:17:58 +0100, Michael Grzeschik wrote:
> > > 
> > > From: Denis Osterland <Denis.Osterland@diehl.com>
> > > 
> > > After successful
> > > sr = isl1208_i2c_set_regs(client, 0, regs, ISL1208_RTC_SECTION_LEN);
> > > sr will be 0.
> > > As a result
> > > sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR,
> > > 			sr & ~ISL1208_REG_SR_WRTC);
> > > is equal to
> > > sr = i2c_smbus_write_byte_data(client, ISL1208_REG_SR, 0);
> > > which clears all flags in SR.
> > > 
> > > Add an additional read of SR, to have value of SR in sr again.
> > > 
> > > Signed-off-by: Denis Osterland <Denis.Osterland@diehl.com>
> > > Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> > > ---
> > >  drivers/rtc/rtc-isl1208.c | 5 +++++
> > >  1 file changed, 5 insertions(+)
> > > 
> > Applied, thanks.
> > 
> You are welcome.
> 
> One question, shall we avoid resent this patch in v2 of this series?
> I ask because we are pretty far with the suggested changes.
> 

No need to resend. If necessary, you can base v2 on top of rtc-next.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
