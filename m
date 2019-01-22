Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EE3C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3460A20855
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548172399;
	bh=UoYFTV7LQfmr7V412KhH4h+aiFQlVDpDzGep74U3fnA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kqbkytkWXYDI6J2yqCs+0HtmYBkdSonmcy97oWZyyhfSr9OJ4B6CdJ+nTj8YmHjcG
	 tSFGS16zhlxPuVFu7clWZprJEr/rI095yCrR76IR+zqog8b0cNX0XjNGeF1/B0OAWW
	 65Ed+GorbOZ64eJq3mPYkvkNwT80BOFDELl45apo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729204AbfAVPxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 10:53:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728734AbfAVPxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 10:53:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E97C20854;
        Tue, 22 Jan 2019 15:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548172397;
        bh=UoYFTV7LQfmr7V412KhH4h+aiFQlVDpDzGep74U3fnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UsrMlstZ6UZoZqVtMY5HP7KjWws0qAX6DI2SZG+qtCGDSJdZVhzPd0HFDD+H+FILE
         Pv48AuNpO6bAloHHroN61cA6jbXgmKrfXrrBpCuUcFBgqb/+5A5Pz6NGv15WYxCTPP
         LgJlTmHe4Rfq6ThEtV6FsOrTM9ILrw4trHsasoNs=
Date:   Tue, 22 Jan 2019 16:53:14 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH] power: qos: no need to check return value of
 debugfs_create functions
Message-ID: <20190122155314.GB20142@kroah.com>
References: <20190122152151.16139-48-gregkh@linuxfoundation.org>
 <CAJZ5v0jLeZfsmX12g6r0zXCt9dTjD0TnJ03+Sntt6i2f-PxsGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jLeZfsmX12g6r0zXCt9dTjD0TnJ03+Sntt6i2f-PxsGw@mail.gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 04:30:38PM +0100, Rafael J. Wysocki wrote:
> On Tue, Jan 22, 2019 at 4:25 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > When calling debugfs functions, there is no need to ever check the
> > return value.  The function can work or not, but the code logic should
> > never do something different based on this.
> >
> > Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> > Cc: Len Brown <len.brown@intel.com>
> > Cc: Pavel Machek <pavel@ucw.cz>
> > Cc: linux-pm@vger.kernel.org
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> All of these changes are fine by me and I can take the patches
> touching the code maintained by me, so please let me know.

Please take them!

thanks,

greg k-h
