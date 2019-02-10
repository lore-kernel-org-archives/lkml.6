Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8B0C282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:33:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955402146F
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 21:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfBJVde (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 16:33:34 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:37901 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbfBJVde (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 16:33:34 -0500
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gswj4-0006G4-VQ; Sun, 10 Feb 2019 22:33:22 +0100
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gswj2-0007GC-4B; Sun, 10 Feb 2019 22:33:20 +0100
Date:   Sun, 10 Feb 2019 22:33:20 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>, thierry.reding@gmail.com,
        robh+dt@kernel.org, mark.rutland@arm.com, alexandre.torgue@st.com,
        mcoquelin.stm32@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        vilhelm.gray@gmail.com, linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH 4/4] iio: counter: stm32-lptimer: Add power management
 support
Message-ID: <20190210213320.fs5kzezyzwd6akpx@pengutronix.de>
References: <1549370429-19116-1-git-send-email-fabrice.gasnier@st.com>
 <1549370429-19116-5-git-send-email-fabrice.gasnier@st.com>
 <20190209162133.65e6fd93@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190209162133.65e6fd93@archlinux>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 09, 2019 at 04:21:33PM +0000, Jonathan Cameron wrote:
> On Tue, 5 Feb 2019 13:40:29 +0100
> Fabrice Gasnier <fabrice.gasnier@st.com> wrote:
> 
> > Add suspend/resume PM sleep ops. When going to low power, disable
> > active counter. Only active counter should be resumed: don't touch
> > disabled counter, as it may be used by other LPTimer MFD child driver.
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> I think this looks fine.  I'm not totally sure if patches 3,4 are
> separable from 1,2 though so please let me know whether I should take
> these now, or let all 4 go in together via some path?

I'd say these are orthogonal, so if you are happy with patches 3 and 4
you can take them without bothering for patches 1 and 2.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
