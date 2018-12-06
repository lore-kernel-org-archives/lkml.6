Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DE8C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCF3320892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544105274;
	bh=BnvNRoLWokbZ7D8FHIz2PiJW1DFp4gXWpokmm1R+sqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gVMe7uK+j+4mxEPSrW6kYzlaaBEbdKUals633stuJon3ts6dRzde94ZTjC1TfhKwl
	 wCRra0A4nMlgHZnemX06JZt7ZN7C2wkc7XqQVpQm7HffchWOoqyk1HCWZOxnWGUbwW
	 i4OkZHAW3BT6iAuzfhoMoYvyjchEBpaMYEi8I95I=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCF3320892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729561AbeLFOHx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:07:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:34926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727704AbeLFOHw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:07:52 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CEBFD20868;
        Thu,  6 Dec 2018 14:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544105272;
        bh=BnvNRoLWokbZ7D8FHIz2PiJW1DFp4gXWpokmm1R+sqI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G+oKTNUq2pYBgv1F1fzykZFuHEih20hD7sTIP309EinBnbSsOYU6bXH0mrGyZm+jx
         QiYY0MDF7ouBmteKFW2h0praLr504OKZVQXLt/+E4KyHZuzckjJDdOyRVvtqgCQ3GV
         I+HbwsvZZWeZRIL6Sh9EL5reXn53a/xHqLJkL+UM=
Date:   Thu, 6 Dec 2018 15:07:50 +0100
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
Message-ID: <20181206140750.GB18947@kroah.com>
References: <20181204220224.27324-1-TheSven73@googlemail.com>
 <20181204220224.27324-2-TheSven73@googlemail.com>
 <20181205101659.GA27058@kroah.com>
 <CAGngYiXXrrqGxTt339EP53tschLgZ82eRGvGifHQw6pg=C88+Q@mail.gmail.com>
 <20181205191724.GA434@kroah.com>
 <CAGngYiWG74nDt1_hN0-bKCDRxm-f=N-Rnjtk02Vd7dgKtGRaBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGngYiWG74nDt1_hN0-bKCDRxm-f=N-Rnjtk02Vd7dgKtGRaBA@mail.gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 05, 2018 at 05:32:19PM -0500, Sven Van Asbroeck wrote:
> Thanks :)
> 
> On Wed, Dec 5, 2018 at 2:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > Great, then call it a 'fieldbus' class, not "fieldbus_dev' class.
> 
> Small nit:
> 
> Hardware connected to a fieldbus comes in two distinct flavours:
> - clients (e.g. thermometer, robotic arm) called "fieldbus devices"
> - servers (e.g. a PLC) called "fieldbus controllers"
> 
> Their userspace APIs will probably differ quite a lot.

But servers are going to be much more rare, and odds are userspace is
not going to need to control anything with them, right?

> The userspace API created by the patch is only for clients a.k.a.
> "fieldbus devices". That's why I'm writing 'fieldbus_dev' all over the place.
> 
> For simplicity, we could change that to just 'fieldbus'. But would this get
> us in trouble when, at some point, we want to add a userspace API for
> servers a.k.a. "fieldbus controllers" ?

Ick, yeah, I guess so, but planning for future events is not something
we do well at all.  Are you sure you will need fieldbus controllers as a
class?

And as these are really devices, why not make them a "device" and a bus?
What type of topology do you have on these busses?  Are everything
"flat" and connected directly to a PCI/USB/platform device?  Or are
there multiple devices attached to a single controller?

It really feels like you want to use 'struct device' and a bus_type and
not a class here to me...

thanks,

greg k-h
