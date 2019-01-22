Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D48F8C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:52:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D35F21019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 18:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548183171;
	bh=RXCN/HKPeDJypHMuCve3H0NuOmqq9QOtkPfhFsOOndQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TjuuF6yE7zV290eQcBkqlXlRPBzAdxkHR+XEZmAMF8C9ib75K19n/bkk/1aNw3uOy
	 wJRDv5f1hpDVJjAUu0HmSjhE3Hswxdkjw5WsVVP+3jyGITB1tP/W28kjIpDGKDC6Ej
	 GpyWLUtWKgXavEjZot7rpI7xHB4vEAZhQq4vi20U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726208AbfAVSwu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 13:52:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:36618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbfAVSwt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 13:52:49 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 627AE2085A;
        Tue, 22 Jan 2019 18:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548183168;
        bh=RXCN/HKPeDJypHMuCve3H0NuOmqq9QOtkPfhFsOOndQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I3mv8tGRhXKaVQ5J/jGOam3MFmB75Q7zKC6LBlj7ccnNVUybMGD2FBVvTAGnvGkGo
         CbXvtS9mL6m/DMXBBo0xPrBVwOIup90Qpae9iO2KOVxDmfCyWgVrFBnb3Udt0jNH2n
         y2mPexqCrvRe/7V+Oj//fA83jz4BdaIP/lCKDWnc=
Date:   Tue, 22 Jan 2019 19:52:46 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Sven Van Asbroeck <thesven73@gmail.com>, svendev@arcx.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, lee.jones@linaro.org,
        mark.rutland@arm.com, treding@nvidia.com, david@lechnology.com,
        noralf@tronnes.org, johan@kernel.org, monstr@monstr.eu,
        michal.vokac@ysoft.com, arnd@arndb.de, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20190122185246.GA922@kroah.com>
References: <20190122152109.30488-1-TheSven73@googlemail.com>
 <20190122152109.30488-2-TheSven73@googlemail.com>
 <20190122165658.GH26416@windriver.com>
 <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4406b5-9970-211e-beef-a8b6ad60b99e@suse.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 06:12:31PM +0100, Andreas Färber wrote:
> Am 22.01.19 um 17:56 schrieb Paul Gortmaker:
> > [[PATCH v7 1/6] fieldbus_dev: add Fieldbus Device subsystem.] On 22/01/2019 (Tue 10:21) Sven Van Asbroeck wrote:
> > 
> >> Fieldbus device (client) adapters allow data exchange with a PLC aka.
> >> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
> >>
> >> They are typically used when a Linux device wants to expose itself
> >> as an actuator, motor, console light, switch, etc. over the fieldbus.
> >>
> >> This framework is designed to provide a generic interface to Fieldbus
> >> Devices from both the Linux Kernel and the userspace.
> >>
> >> Signed-off-by: Sven Van Asbroeck <TheSven73@googlemail.com>
> > 
> > [...]
> > 
> >> diff --git a/drivers/fieldbus/Kconfig b/drivers/fieldbus/Kconfig
> >> new file mode 100644
> >> index 000000000000..5c2bef950d04
> >> --- /dev/null
> >> +++ b/drivers/fieldbus/Kconfig
> >> @@ -0,0 +1,19 @@
> >> +menuconfig FIELDBUS_DEV
> >> +	bool "Fieldbus Device Support"
> > 
> > OK, so the core support is NOT tristate, ie not modular,
> 
> Is that intentional though, and if so, why?
> 
> If possible, I would much rather see it changed to tristate and leave
> all the metadata below.
> 
> > so I think...
> > 
> >> diff --git a/drivers/fieldbus/dev_core.c b/drivers/fieldbus/dev_core.c
> >> new file mode 100644
> >> index 000000000000..c816df3201bb
> >> --- /dev/null
> >> +++ b/drivers/fieldbus/dev_core.c
> >> @@ -0,0 +1,348 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Fieldbus Device Driver Core
> >> + *
> >> + */
> >> +
> >> +#include <linux/fieldbus_dev.h>
> >> +#include <linux/mutex.h>
> >> +#include <linux/module.h>
> > 
> > ...you don't need module.h here
> > 
> >> +#include <linux/device.h>
> >> +#include <linux/idr.h>
> >> +#include <linux/fs.h>
> >> +#include <linux/slab.h>
> >> +#include <linux/poll.h>
> >> +
> > 
> > [...]
> > 
> >> +
> >> +static void __exit fieldbus_exit(void)
> >> +{
> >> +	unregister_chrdev_region(fieldbus_devt, MAX_FIELDBUSES);
> >> +	class_unregister(&fieldbus_class);
> >> +}
> >> +
> >> +subsys_initcall(fieldbus_init);
> >> +module_exit(fieldbus_exit);
> > 
> > ...and the module_exit is never called, so fieldbus_exit is dead code
> > and hence both should be removed.
> > 
> >> +
> >> +MODULE_AUTHOR("Sven Van Asbroeck <TheSven73@googlemail.com>");
> >> +MODULE_AUTHOR("Jonathan Stiles <jonathans@arcx.com>");
> >> +MODULE_DESCRIPTION("Fieldbus Device Driver Core");
> >> +MODULE_LICENSE("GPL v2");
> 
> Sven, as this code appears to be all by ArcX people, any chance you can
> make it just GPL (SPDX GPL-2.0-or-later)? Only reason to have it v2-only

SPDX "GPL-2.0+" please.

> would be if this code was derived from v2-only code that can't be
> relicensed anymore.

Are you _sure_ you want v2+?  I ask as I am forced to :)

And I thought when I made the comment about this code being a module,
that would be the change, not this one forcing it not to be :(

thanks,

greg k-h
