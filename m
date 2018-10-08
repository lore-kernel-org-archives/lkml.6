Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E95C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1962820878
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 14:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FBK4ECFV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1962820878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726529AbeJHVNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 17:13:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:47760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbeJHVNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 17:13:08 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 84DBE2087D;
        Mon,  8 Oct 2018 14:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539007276;
        bh=yBFCdq20OoMejZezPAO4XOOsjstf0GAsOK39/+y1bZE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FBK4ECFVKOcfd/VFJTbDEcG8Um+QLdlLtWoAdNGO4EzWVmA5ZnOQg07t4SDE5+z0v
         SC+lhHxT3eFBf7JkKZ0keOswcf7DqCADqv8YzrtNUVE61hyrKDvwa58kes7/Tmw896
         4py2X2sEK9V9peqCwyHJac1BiWjt4e0WvnFe1B9s=
Date:   Mon, 8 Oct 2018 15:21:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 01/14] phy: phy-pxa-usb: add a new driver
Message-ID: <20181008132148.GC20703@kroah.com>
References: <20180822204307.13251-1-lkundrak@v3.sk>
 <20180822204307.13251-2-lkundrak@v3.sk>
 <f36abb62-e8a4-e69f-4732-95a0db466034@ti.com>
 <1981ce54ce960d21976ce71b08a8779bfeb13be4.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1981ce54ce960d21976ce71b08a8779bfeb13be4.camel@v3.sk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 07, 2018 at 08:47:28PM +0200, Lubomir Rintel wrote:
> On Tue, 2018-09-25 at 10:53 +0530, Kishon Vijay Abraham I wrote:
> > 
> > On Thursday 23 August 2018 02:12 AM, Lubomir Rintel wrote:
> > > Turned from arch/arm/mach-mmp/devices.c into a proper PHY driver,
> > > so
> > > that in can be instantiated from a DT.
> > > 
> > > Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> > 
> > Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
> > 
> > If this has to be merged via linux-phy tree, please let me know.
> 
> Yes, either linux-phy or the usb tree.
> 
> The EHCI patches have already been pulled into the usb tree, presumably
> because they got an Ack from Alan Stern. That includes "USB: EHCI:
> ehci-mv: use phy-pxa-usb" that depends on this. Perhaps the  rest of
> the patches can go via the same tree?
> 
> I haven't submitted a patchset that would have dependencies spanning
> across different subsystems before. I don't know what's usually done in
> such cases. Advice welcome.
> 
> Greg?

You can either send them through the same tree, or wait a release cycle
and get the rest in through a different one.  As I usually take the phy
tree into the USB tree for issues like this, I can take them all if you
get the phy maintainer to ack them.

thanks,

greg k-h
