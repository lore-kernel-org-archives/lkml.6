Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFEFC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8B82087E
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 08:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547801509;
	bh=QhfAGOc6zD0jWRYuA1zlpncav37wZ0FmtnI0QBtuQ00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TE5LP4b4n/CP3t/cTvAu39FFjhO67wTTL3Kmwd9f5v8q+SMUWxQOOhmYNvDi81h/W
	 0QMs6GE2V4354caHKa/MPOTww7tSJrHRMkFnQjhHJFYmmQo9OZQGsWw3N/a9yB+dbE
	 nul1S3GAlq5hYCXMmlryfyzF3RgVei+fvdYTK1fM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfARIvr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 03:51:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:52484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727349AbfARIvr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 03:51:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A3F920855;
        Fri, 18 Jan 2019 08:51:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547801506;
        bh=QhfAGOc6zD0jWRYuA1zlpncav37wZ0FmtnI0QBtuQ00=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xr1bRxtJ5y7gQPGSWlfCXDgpuxte1Sww5A6Luh7s1m11bbtJ67mEQHYvtYZAHPR3o
         dinLHcM9OCRYdki7SEgBlsfVXkOvJMeaA4r6uzgSI4yugI9gWIYg/m9BuTSp4DL2cR
         FJrAAJqlO+fzmGkWyWAHZ9zf1LhL/37yXn3tBgWw=
Date:   Fri, 18 Jan 2019 09:51:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Alan Stern <stern@rowland.harvard.edu>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] USB: EHCI: ehci-mv: add MODULE_DEVICE_TABLE
Message-ID: <20190118085144.GA9572@kroah.com>
References: <20190114201608.17514-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114201608.17514-1-lkundrak@v3.sk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 09:16:08PM +0100, Lubomir Rintel wrote:
> This fixes autoloading the module by the OF compatible string.
> 
> Fixes: 813e18b18a87f31c5b216ea7546127deac3ae1ae

In the future, this type of line should be written as:
Fixes: 813e18b18a87 ("USB: EHCI: ehci-mv: add DT support")

I'll change this in the patch, but next time be more careful.

thanks,

greg k-h
