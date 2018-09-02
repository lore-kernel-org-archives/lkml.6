Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A429EC43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C4C20841
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 09:15:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNfLdK6e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57C4C20841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbeIBNaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 09:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:33768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726003AbeIBNaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 09:30:20 -0400
Received: from archlinux (82-132-217-68.dab.02.net [82.132.217.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87FAC20841;
        Sun,  2 Sep 2018 09:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535879716;
        bh=69FKzhrE9FRzSRhD9+KzGOOka9KwAomQvmiIE8u2P10=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nNfLdK6enFIpgi9Wh73SrDainjnMKbvYD/hPdr57+fwNxRtLb3GZWriMdPWb3hZVa
         VZGvoio8UjX3RA+f0PwRBWph4qYk0EoHTQEo4KCWvRiSa4azvKBLAKQP3HnKXLO+J8
         S151vQrYBBXhVnc/SaW5Re0qhoinz6RJLlTxr7i4=
Date:   Sun, 2 Sep 2018 10:15:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Afonso Bordado <afonsobordado@az8.co>
Cc:     knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/4] iio: gyro: add device tree support for fxas21002c
Message-ID: <20180902101510.01225f8d@archlinux>
In-Reply-To: <060655b11b68d25fd855e9535df75db4b113a615.camel@az8.co>
References: <20180825211910.22929-1-afonsobordado@az8.co>
        <20180825211910.22929-2-afonsobordado@az8.co>
        <20180827181341.6563c0bf@archlinux>
        <060655b11b68d25fd855e9535df75db4b113a615.camel@az8.co>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Aug 2018 07:43:53 +0100
Afonso Bordado <afonsobordado@az8.co> wrote:

> On Mon, 2018-08-27 at 18:13 +0100, Jonathan Cameron wrote:
> > On Sat, 25 Aug 2018 22:19:08 +0100
> > Afonso Bordado <afonsobordado@az8.co> wrote:
> >   
> > > This patch adds device tree support for the fxas21002c driver,
> > > including
> > > bindings.
> > > 
> > > Signed-off-by: Afonso Bordado <afonsobordado@az8.co>  
> > 
> > Now, the devicetree bindings should not reflect just what the driver
> > uses right now, but rather describe the hardware.
> > 
> > There are interrupts on there for starters that definitely want to be
> > described from the start.  Also there is a reset line that should
> > probably
> > be here from the start.
> > 
> > Potentially also the two power supplies though that's less critical
> > (nice to have though)
> > 
> > It is also an i2c and spi part though that can probably be added
> > later as
> > we can argue we are only documenting the bindings for the device in
> > i2c mode
> > for now.
> > 
> > So what is here is fine, but I think we need to describe more.
> > 
> > It's all well understood details of how it is connected so no need to
> > have tested it with a driver to be sure it will be right.
> > 
> > Jonathan  
> 
> Ok, so i'm thinking about adding both interrupts, the reset line and
> the regulators. If i say they are optional in the device tree document,
> i shouldn't need to add any more code immediately and could just
> implement support for it later right?
> 
Absolutely, as long as you are happy to keep them optional as you
add the features to the driver.

Regulators make that easy by providing stubs (as long as you don't
need to read their voltages).  Reset and interrupts will need to be
handled explicitly by the driver.

Thanks,

Jonathan
> 

