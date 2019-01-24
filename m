Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E77AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511B3218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548354307;
	bh=nQB4ghqSNu1d8/f6NzXY7Y9vGm0WkLX78lMHzoJPEB8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tajmbucmDgMTWrrm41KZLWn1X5DoYc7J863gbcRbIMLXZSL+pFw63OA2CmdXxFpa2
	 YqITFLSebdI2pOHup+/bQ0Re5H9TnaF0CwhJ8qsZkcRTFee7YckA+UiLek5kxqgLhJ
	 7zsItpHJ8j1BZbasQuYW2064HctiErlWLdFzSGBc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfAXSZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:25:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:48864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725909AbfAXSZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:25:05 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B77EE2184C;
        Thu, 24 Jan 2019 18:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548354304;
        bh=nQB4ghqSNu1d8/f6NzXY7Y9vGm0WkLX78lMHzoJPEB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OQgsF48mBcWaiSPIFpVBzmu8aze+CCn9hL3ZL+Y0S2v5WV3qnFBSmTq7TjP0IXgar
         lPDJj1Pu9iwzrasbp5zqdPsGj//Jy2Zmulw3xrTdXfgFqghVT/nilVp6wC6UOiA4pU
         2csuUYik4c7Kl5X+4Kyi4uAh02DdEZ3VtslcnlX8=
Date:   Thu, 24 Jan 2019 19:25:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190124182502.GA18351@kroah.com>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
 <20190122165658.GH26416@windriver.com>
 <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
 <20190122185246.GA922@kroah.com>
 <CAGngYiU2kLqQq5qkcxda9m__VWx62bsC=+ni4HAGMsOAxAtUzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiU2kLqQq5qkcxda9m__VWx62bsC=+ni4HAGMsOAxAtUzw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 24, 2019 at 01:07:58PM -0500, Sven Van Asbroeck wrote:
> On Tue, Jan 22, 2019 at 1:52 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > SPDX "GPL-2.0+" please.
> >
> > > would be if this code was derived from v2-only code that can't be
> > > relicensed anymore.
> >
> > Are you _sure_ you want v2+?  I ask as I am forced to :)
> >
> 
> The licencing choice confuses me. Why would I choose a different
> licence to what the Linux kernel itself is provided under?

The Linux kernel is provided under "GPLv2" not "GPLv2+"

"GPLv2" means "GPLv2 only"

"GPLv2+" means "Any version of the GPL that the FSF decides to create
from now until the end of time."

> If I did pick a different one, what are the tradeoffs between GPLv2 and GPLv2+ ?

That is for you and your lawyers to discuss :)

thanks,

greg k-h
