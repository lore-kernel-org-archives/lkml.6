Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3A91C282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B82A820879
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548144497;
	bh=Tx1VyRaTE7bypEWdfSczzyr6fSDtoLb1NlyG9736/cU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pFy6Qb9xAsEycB7enEvHMwtIqadWJe6crTrCNMrQF30JVWfG0XrXx1bBzXZlNG0Qn
	 yCI6tsC6awa3W0Tr8ZDbg1D2imDRt/TW4TI3PzsfICF1L+x96+uvIaOp9H6XPaUCb/
	 0WuwYqldwyjd88YuQtAbc5D8yZ5ZEYZgOM3fu604=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbfAVIIQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 03:08:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727374AbfAVIIP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 03:08:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CF52C2084C;
        Tue, 22 Jan 2019 08:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548144495;
        bh=Tx1VyRaTE7bypEWdfSczzyr6fSDtoLb1NlyG9736/cU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPfCagNJvRzUUtHeDQE7HDC0dt1muUr7mGjjTtN1LUj2MHMWtL5Rs5Kc1XUYxZ31R
         negMbaTNJ1kgxnGOhfn4jmEaEKOe34y8zvE4Wc46EQlVEiiJGAs9V1G+5YeC1Se5/i
         bnyzj68GE1skZrd1wCmcTWzG7xUEWTFr3IF9D7NY=
Date:   Tue, 22 Jan 2019 09:08:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yinbo Zhu <yinbo.zhu@nxp.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Xiaobo Xie <xiaobo.xie@nxp.com>,
        Jerry Huang <jerry.huang@nxp.com>,
        Ran Wang <ran.wang_1@nxp.com>,
        Ramneek Mehresh <ramneek.mehresh@freescale.com>,
        Nikhil Badola <nikhil.badola@freescale.com>,
        Suresh Gupta <suresh.gupta@freescale.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] usb: fsl: Set USB_EN bit to select ULPI phy
Message-ID: <20190122080813.GA21793@kroah.com>
References: <20190121102601.4735-1-yinbo.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190121102601.4735-1-yinbo.zhu@nxp.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 10:25:00AM +0000, Yinbo Zhu wrote:
> From: Nikhil Badola <nikhil.badola@freescale.com>
> 
> Set USB_EN bit to select ULPI phy for USB controller version 2.5
> 
> Signed-off-by: Nikhil Badola <nikhil.badola@freescale.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> ---
> Change in v2:
> 		replace Yinbo.Zhu with Yinbo Zhu 
> 
>  drivers/usb/host/ehci-fsl.c |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)

This patch doesn't apply against my usb-next branch, what did you
generate it against?

thanks,

greg k-h
