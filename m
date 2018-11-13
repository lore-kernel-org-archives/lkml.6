Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D47CC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148AE21780
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 06:57:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 148AE21780
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730984AbeKMQyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 11:54:12 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52337 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbeKMQyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 11:54:11 -0500
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gMSda-0001UJ-Qk; Tue, 13 Nov 2018 07:57:26 +0100
Received: from ukl by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1gMSdZ-0001Mk-Ml; Tue, 13 Nov 2018 07:57:25 +0100
Date:   Tue, 13 Nov 2018 07:57:25 +0100
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Bamvor Jian Zhang <bamv2005@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] gpio: mockup: fix indicated direction
Message-ID: <20181113065725.mxc6i22c4wmu32de@pengutronix.de>
References: <20181109115424.pe4w26nmt6xplzto@pengutronix.de>
 <CAMRc=Mdf1GHR0_7uQ4PFFCwL9p3NyKBDMSBkipR826BhTYpz=g@mail.gmail.com>
 <20181109131036.v6d645ojv6jr7v3y@pengutronix.de>
 <CAMRc=Mf18udrM=2=SZHMg3M2akcccPXb7Fr81vXODpNgjf+uJw@mail.gmail.com>
 <20181109143950.gy7swu6vgaqgg7dw@pengutronix.de>
 <CAMRc=McF482n+57e6Vz9H1dEQ5QS+4p88SYg6ZjNuUMYZx6t3Q@mail.gmail.com>
 <20181109170323.6b2nj5vvtwu3d5ee@pengutronix.de>
 <CAMRc=MfY7c21NOBNnVgXKimywXHFifwek5B76Y_3DgmM_hBbgw@mail.gmail.com>
 <20181111165917.zrbg3xbhlitto7xs@pengutronix.de>
 <CAMRc=Mfs_Wwm9bW121iMLrAAfuYhhekQnFRHYZBYU=Ry_dEKwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfs_Wwm9bW121iMLrAAfuYhhekQnFRHYZBYU=Ry_dEKwg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Bartosz,

On Mon, Nov 12, 2018 at 03:14:31PM +0100, Bartosz Golaszewski wrote:
> > > As I said before: it is and should be fixed in this specific case.
> > > This isn't real hardware.

Not being "real hardware" is hardly an argument that matters here.

> > Not sure if we agree here yet. What do you want to fix? The driver or
> > the test?
> >
> > In my eyes test driven development is great. But if something breaks
> > because the test is wrong, please don't "fix" the system to repair the
> > test, but modify the test to be able to handle reality.
> >
> 
> No, we don't have an agreement. You think I should fix the test, I
> think the dummy driver should continue behaving like before.

It's arguable if after your patch the driver behaves as before. IMHO the
initial direction was output from the start before. This was just
shadowed by the an inconsitency that was fixed some time ago.

> Given that there's no real hardware behind, the direction of newly
> created dummy lines has always been deterministic - input. Certain
> tests have been relying on it. I want to keep on doing it. There's no
> harm. It's not broken logic as the very purpose of this module is to
> allow for easy testing of the UAPI.
> 
> So unless something *else* is wrong with this patch, I intend to push
> it upstream.

Note I don't oppose to the patch as is. Just the motiviation is wrong
and I'd do both: Modify the mockup driver to start with direction=input
and modify the tests to not expect this.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
