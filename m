Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3513AC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E39DA2086D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:02:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E39DA2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbeH2L6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 07:58:22 -0400
Received: from mail.bootlin.com ([62.4.15.54]:42271 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726656AbeH2L6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 07:58:21 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8034C20795; Wed, 29 Aug 2018 10:02:41 +0200 (CEST)
Received: from windsurf (AAubervilliers-681-1-53-19.w90-88.abo.wanadoo.fr [90.88.170.19])
        by mail.bootlin.com (Postfix) with ESMTPSA id 10BED206EE;
        Wed, 29 Aug 2018 10:02:31 +0200 (CEST)
Date:   Wed, 29 Aug 2018 10:02:29 +0200
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     aditya@kobol.io,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        gauthier@kobol.io, Alban Browaeys <alban.browaeys@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dennis@ausil.us, Ralph Sennhauser <ralph.sennhauser@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH RESEND 1/2] gpio: mvebu: Add support for multiple PWM
 lines per GPIO chip
Message-ID: <20180829100229.7566e0db@windsurf>
In-Reply-To: <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
References: <1533522556-55055-1-git-send-email-aditya@kobol.io>
        <1533522556-55055-2-git-send-email-aditya@kobol.io>
        <CACRpkda2qXxyEj+y8DaZ-_PWcj3pBGtvVAac8qaFCnC0LTNkNA@mail.gmail.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

On Wed, 29 Aug 2018 09:54:04 +0200, Linus Walleij wrote:
> On Mon, Aug 6, 2018 at 4:31 AM Aditya Prayoga <aditya@kobol.io> wrote:
> 
> > Allow more than 1 PWM request (eg. PWM fan) on the same GPIO chip.
> >
> > based on initial work on LK4.4 by Alban Browaeys.
> > URL: https://github.com/helios-4/linux-marvell/commit/743ae97
> > [Aditya Prayoga: forward port, cleanup]
> > Signed-off-by: Aditya Prayoga <aditya@kobol.io>  
> 
> It would be awesome to get some feedback from the MVEBU maintainers
> on this patch set.
> 
> Who are most active on Marvell stuff these days? Thomas?

Andrew Lunn did the initial support for PWM in this driver, and he
outlined in the commit log the limitation of his first implementation:

    However, there are only two sets of PWM configuration registers for
    all the GPIO lines. This driver simply allows a single GPIO line per
    GPIO chip of 32 lines to be used as a PWM. Attempts to use more
    return EBUSY.

Andrew, perhaps you could review the patch posted by Aditya, since you
already looked at PWM support on mvebu platforms ?

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
