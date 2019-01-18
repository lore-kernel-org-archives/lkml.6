Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1004C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:06:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03E72087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 09:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547802364;
	bh=gUhewpGD5oCBLYurpEeIQYx6FEZgt9AuANPSWBUfsdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=v/JIM1HHnTV7VljXHDirNIOXlQXUwmFWhlP76IGOBe/KwdDrfnuw5qWL4NSfDaOUW
	 Ei7zt24IvFmvgs/VLNBXUC1dAdUcpvzuGBxziOaBaCQOM5TCCXM+0shSmkkOVsrt0/
	 sT0rwl776AK8A3xSOc/lVvXiqGNWQWlIev65axIw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbfARJGD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 04:06:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:55974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725924AbfARJGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 04:06:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 791792086D;
        Fri, 18 Jan 2019 09:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547802362;
        bh=gUhewpGD5oCBLYurpEeIQYx6FEZgt9AuANPSWBUfsdw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ihFgh5h18/xU6Kd9SbylbDcCOjonZJjY9or7Koz7wQRJ7/8NHfb4StHRWhVZ0m5Vu
         J/lLRZNdDLaFv1x1nhCbK0O8QnTYeQsUHdv2O0OS6jQxxd8Y66lny1MrLfc2o/dNUH
         I4JEkOlj1c/ye5mIR9jLz8TSAaOY2P67zSkOGfpE=
Date:   Fri, 18 Jan 2019 10:05:59 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE
Message-ID: <20190118090559.GA11182@kroah.com>
References: <20190114201608.17514-1-lkundrak@v3.sk>
 <20190118085226.GB9572@kroah.com>
 <6f756e0e84275266848dab28866a9250bc43088b.camel@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f756e0e84275266848dab28866a9250bc43088b.camel@v3.sk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 09:56:53AM +0100, Lubomir Rintel wrote:
> On Fri, 2019-01-18 at 09:52 +0100, Greg Kroah-Hartman wrote:
> > On Mon, Jan 14, 2019 at 09:16:08PM +0100, Lubomir Rintel wrote:
> > > This fixes autoloading the module by the OF compatible string.
> > > 
> > > Fixes: 813e18b18a87 ("USB: EHCI: ehci-mv: add DT support")
> > > Cc: stable@vger.kernel.org # v4.19+
> > 
> > Wait, why 4.19?  813e18b18a87 is in 4.20, not 4.19, so why would this
> > matter to 4.19 at all?
> 
> You're right.
> 
> Sorry. (I've naively used "git describe 813e18b18a87" to guess the
> release this went to, failing to realize that the commit went to main
> tree via merge. I guess I should've done a git tag --contains instead.)

Thanks for verifying, I'll fix that up too.

thanks,

greg k-h
