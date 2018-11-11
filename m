Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 092CCC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B64812148E
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhntjI7f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B64812148E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbeKLDaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:47758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729222AbeKLDaZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:30:25 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D504D21104;
        Sun, 11 Nov 2018 17:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541958076;
        bh=LZ0v4QOseCgZ7v5+gWewyvB4emKr0o8ZoXTEvXNzirM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YhntjI7f+K2DzsvRLjeaLmCfSi7dezA12ooxW0dfHQEDPFg1Vr2t96mFzgnMPIvdU
         Y9dnoyMFLdQku2HgDzqfe4C0BULQtds6Lj/AYMAf+as18pB0ZFZaXrVs279umLd/M5
         YJNRdjXwBEMvFfE+PfK6XTsR2zAYH6IYcARatmZE=
Date:   Sun, 11 Nov 2018 09:41:14 -0800
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     "Luis R . Rodriguez" <mcgrof@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, patchwork-lst@pengutronix.de,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/2] firmware: add nowarn variant of
 request_firmware_nowait()
Message-ID: <20181111174114.GA18543@kroah.com>
References: <20181105170232.28777-1-l.stach@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181105170232.28777-1-l.stach@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 05, 2018 at 06:02:31PM +0100, Lucas Stach wrote:
> Device drivers with optional firmware may still want to use the
> asynchronous firmware loading interface. To avoid printing a
> warning into the kernel log when the optional firmware is
> absent, add a nowarn variant of this interface.
> 
> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> ---
>  drivers/base/firmware_loader/main.c | 85 ++++++++++++++++++++---------
>  include/linux/firmware.h            | 12 ++++
>  2 files changed, 70 insertions(+), 27 deletions(-)

0-day blew up over this, so can you fix that up and resend the series?

thanks,

greg k-h
