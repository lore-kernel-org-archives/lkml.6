Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F2BC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30522208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 07:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TcW1nE/K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30522208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729238AbeK0SoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 13:44:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:60454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbeK0SoE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 13:44:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A76520873;
        Tue, 27 Nov 2018 07:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543304824;
        bh=VOUZVm+M6ynB92zawdUpHZncJfii4t/hF9/tp6sLaz0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TcW1nE/KN/qnujPWhNA6rMrCN6QGiS9I3FVKNr+BHhLqNFpsC6iGrm8Cw5orraTnQ
         qnbllMt6LxqNNdhBj2viq7nlwzOUXpmWFulE0ty4Lp5QYwkENQx3jLsP0zun5oGmQv
         O/vv1z+xFoPLde5i3COVy8vah049EpUO6GO4pXls=
Date:   Tue, 27 Nov 2018 08:47:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     thesven73@gmail.com
Cc:     svendev@arcx.com, robh+dt@kernel.org, linus.walleij@linaro.org,
        lee.jones@linaro.org, mark.rutland@arm.com, afaerber@suse.de,
        treding@nvidia.com, david@lechnology.com, noralf@tronnes.org,
        johan@kernel.org, monstr@monstr.eu, michal.vokac@ysoft.com,
        arnd@arndb.de, john.garry@huawei.com, geert+renesas@glider.be,
        robin.murphy@arm.com, paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        stuyoder@gmail.com, maxime.ripard@bootlin.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH anybus v4 1/7] fieldbus_dev: add Fieldbus Device
 subsystem.
Message-ID: <20181127074702.GE13965@kroah.com>
References: <20181121150709.6030-1-TheSven73@googlemail.com>
 <20181121150709.6030-2-TheSven73@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181121150709.6030-2-TheSven73@googlemail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 10:07:03AM -0500, thesven73@gmail.com wrote:
> Fieldbus device (client) adapters allow data exchange with a PLC aka.
> "Fieldbus Controller" over a fieldbus (Profinet, FLNet, etc.)
> 
> They are typically used when a Linux device wants to expose itself
> as an actuator, motor, console light, switch, etc. over the fieldbus.
> 
> This framework is designed to provide a generic interface to Fieldbus
> Devices from both the Linux Kernel and the userspace.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>

License nit:

> --- /dev/null
> +++ b/drivers/fieldbus/dev_core.c
> @@ -0,0 +1,355 @@
> +// SPDX-License-Identifier: GPL-2.0

That's great, but then you write:

> +MODULE_LICENSE("GPL");

Which means "GPLv2+".  So this MODULE_LICENSE() should be "GPL v2",
right?

thanks,

greg k-h
