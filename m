Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2566C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:17:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3471208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 19:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544037449;
	bh=DI7943zfEYGbiG43+j0Qql3rr7Vb7zmXxJjbrhVve00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Uqn2lbG5qXoj66x9nN2MofU8sPl/MKEeoijDPd/n94HV3o64F+BYmw58SAY88I9jD
	 9VxtFvL+OQz0SaRDFA6ue0SaK3br5cqCeFakqLk+UJip6QIcKAT/p1Yhozqsn/8hDx
	 qQ49EbHJtgEYllsiNY+oxH+7KQjksglw7bjaW0Gg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3471208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbeLETR2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 14:17:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:40826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727943AbeLETR1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 14:17:27 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8029120850;
        Wed,  5 Dec 2018 19:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544037447;
        bh=DI7943zfEYGbiG43+j0Qql3rr7Vb7zmXxJjbrhVve00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ywxAb2qdIS+CQk0Ss6hCzXcsVQIZdPjEyb0gfz7P+kTHMw+uXTxjscTVER5XsJ3ZD
         LOjDm3iN3BJlUBldpmhTqrUNf1UptDS+QyZsDaC/m8NkWsZCgD8i5MDYWa5GCTRyN9
         4bPv97BJdIn3vXtcConmr/Tt4RfrLeSKKe4NpAuU=
Date:   Wed, 5 Dec 2018 20:17:24 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Sven Van Asbroeck <svendev@arcx.com>, robh+dt@kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>, mark.rutland@arm.com,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        treding@nvidia.com, David Lechner <david@lechnology.com>,
        noralf@tronnes.org, johan@kernel.org,
        Michal Simek <monstr@monstr.eu>, michal.vokac@ysoft.com,
        Arnd Bergmann <arnd@arndb.de>, john.garry@huawei.com,
        geert+renesas@glider.be, robin.murphy@arm.com,
        paul.gortmaker@windriver.com,
        sebastien.bourdelin@savoirfairelinux.com, icenowy@aosc.io,
        Stuart Yoder <stuyoder@gmail.com>, maxime.ripard@bootlin.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/6] fieldbus_dev: add Fieldbus Device subsystem.
Message-ID: <20181205191724.GA434@kroah.com>
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-2-TheSven73@googlemail.com>
 <20181205101659.GA27058@kroah.com>
 <CAGngYiXXrrqGxTt339EP53tschLgZ82eRGvGifHQw6pg=C88+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiXXrrqGxTt339EP53tschLgZ82eRGvGifHQw6pg=C88+Q@mail.gmail.com>
User-Agent: Mutt/1.11.0 (2018-11-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 10:39:56AM -0500, Sven Van Asbroeck wrote:
> Hello Greg, thanks for the feedback!
> 
> On Wed, Dec 5, 2018 at 5:17 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > And why is this a class and not just a "normal" device and bus?  Devices
> > live on busses, not generally as a class.  Can your devices live on
> > different types of busses (USB, PCI, etc.)?
> 
> This patchset can be a bit confusing, because it doesn't just add support for a
> single fieldbus device - it proposes a general fieldbus subsystem.

Great, then call it a 'fieldbus' class, not "fieldbus_dev' class.

Devices can belong to a bus, or a class, so you are fine here.

> Fieldbus devices from different vendors can sit on the usb, i2c, pci, etc.
> buse, but they all register as a fieldbus device, via fieldbus_dev_register(),
> and show up as a fieldbus class member.

ok, I'm just complaining about your name in sysfs, not your code :)

I think what you did here is correct from a logic point of view.

> Userspace can then enumerate all fieldbus devices connected to the system by
> looking at the class. Without having to know which bus they happen to be
> connected to.

Sounds reasonable.

nice work,

greg k-h
