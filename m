Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C81C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:27:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B1EC20835
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 15:27:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbfALP1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 10:27:14 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:36883 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbfALP1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 10:27:13 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1giLBl-0005RW-KK; Sat, 12 Jan 2019 16:27:09 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1giLBk-0008DA-3G; Sat, 12 Jan 2019 16:27:08 +0100
Date:   Sat, 12 Jan 2019 16:27:07 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: build failure after merge of the pwm tree
Message-ID: <20190112152707.64iubvg53ng4kvlt@pengutronix.de>
References: <20190112170117.0d4674fa@canb.auug.org.au>
 <20190112170859.2cee77d0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190112170859.2cee77d0@canb.auug.org.au>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, 

On Sat, Jan 12, 2019 at 05:08:59PM +1100, Stephen Rothwell wrote:
> On Sat, 12 Jan 2019 17:01:17 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > [Reported by "kernelci.org bot" <bot@kernelci.org>]
> 
> [Also reported by Mark Brown <broonie@kernel.org>]

And also reported by the zero-day bot
(201901110232.L51oPCXW%fengguang.wu@intel.com).

> > After merging the pwm tree, today's linux-next build (arm64-allmodconfig)
> > failed like this:
> > 
> > In file included from drivers/pwm/pwm-imx27.c:15:
> > drivers/pwm/pwm-imx27.c:292:25: error: 'imx_pwm_dt_ids' undeclared here (not in a function); did you mean 'pwm_imx27_dt_ids'?
> >  MODULE_DEVICE_TABLE(of, imx_pwm_dt_ids);

I already asked Thierry if he can fixup my commit with

	s/imx_pwm_dt_ids/pwm_imx27_dt_ids/

(as already suggested by the compiler), but it seems he didn't act on
that yet.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
