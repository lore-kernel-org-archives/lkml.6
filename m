Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B60EC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B35512148C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 07:28:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35512148C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727557AbeIXN3N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 09:29:13 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:53131 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726172AbeIXN3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 09:29:13 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1g4LI6-0007QK-Uz; Mon, 24 Sep 2018 09:28:22 +0200
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1g4LHr-0006b1-TU; Mon, 24 Sep 2018 09:28:07 +0200
Date:   Mon, 24 Sep 2018 09:28:07 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Tony Prisk <linux@prisktech.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        "moderated list:ARM/ACTIONS SEMI ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] clocksource/drivers: Unify the names to timer-*
 format
Message-ID: <20180924072807.xjxdrvtjeoa3wsch@pengutronix.de>
References: <1537762569-18657-1-git-send-email-daniel.lezcano@linaro.org>
 <20180924062828.4yh3aumcuiihojgu@pengutronix.de>
 <7451938d-c600-f070-d1c7-1c77f79518b0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7451938d-c600-f070-d1c7-1c77f79518b0@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2018 at 08:31:26AM +0200, Daniel Lezcano wrote:
> On 24/09/2018 08:28, Uwe Kleine-König wrote:
> > On Mon, Sep 24, 2018 at 06:15:17AM +0200, Daniel Lezcano wrote:
> >> In order to make some housekeeping in the directory, this patch renames
> >> drivers to the timer-* format in order to unify their names.
> >>
> >> There is no functional changes.
> >>
> >> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >> ---
> >>  MAINTAINERS                               |  10 +-
> >>  drivers/clocksource/Makefile              |  26 +-
> >>  drivers/clocksource/cadence_ttc_timer.c   | 543 ------------------------------
> >>  drivers/clocksource/fsl_ftm_timer.c       | 376 ---------------------
> >>  drivers/clocksource/owl-timer.c           | 173 ----------
> >>  drivers/clocksource/qcom-timer.c          | 258 --------------
> >>  drivers/clocksource/time-armada-370-xp.c  | 416 -----------------------
> >>  drivers/clocksource/time-efm32.c          | 287 ----------------
> >>  drivers/clocksource/time-lpc32xx.c        | 314 -----------------
> >>  drivers/clocksource/time-orion.c          | 192 -----------
> >>  drivers/clocksource/time-pistachio.c      | 218 ------------
> >>  drivers/clocksource/timer-armada-370-xp.c | 416 +++++++++++++++++++++++
> >>  drivers/clocksource/timer-cadence-ttc.c   | 543 ++++++++++++++++++++++++++++++
> >>  drivers/clocksource/timer-efm32.c         | 287 ++++++++++++++++
> >>  drivers/clocksource/timer-fsl-ftm.c       | 376 +++++++++++++++++++++
> >>  drivers/clocksource/timer-lpc32xx.c       | 314 +++++++++++++++++
> >>  drivers/clocksource/timer-orion.c         | 192 +++++++++++
> >>  drivers/clocksource/timer-owl.c           | 173 ++++++++++
> >>  drivers/clocksource/timer-pistachio.c     | 218 ++++++++++++
> >>  drivers/clocksource/timer-qcom.c          | 258 ++++++++++++++
> >>  drivers/clocksource/timer-versatile.c     |  44 +++
> >>  drivers/clocksource/timer-vf-pit.c        | 204 +++++++++++
> >>  drivers/clocksource/timer-vt8500.c        | 168 +++++++++
> >>  drivers/clocksource/timer-zevio.c         | 218 ++++++++++++
> >>  drivers/clocksource/versatile.c           |  44 ---
> >>  drivers/clocksource/vf_pit_timer.c        | 204 -----------
> >>  drivers/clocksource/vt8500_timer.c        | 168 ---------
> >>  drivers/clocksource/zevio-timer.c         | 218 ------------
> >>  28 files changed, 3429 insertions(+), 3429 deletions(-)
> > 
> > Wow, with git format-patch -M this should look much smaller and so
> > easier to review.
> 
> Yes, I forgot the option :/

I think you want:

	git config diff.renames true

or a newer git (>= 2.9, which enabled that by default).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
