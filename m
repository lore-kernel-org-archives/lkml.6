Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 171BAC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:38:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFFAC2088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 09:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aG6J7WkU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFFAC2088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFPJiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 05:38:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:35410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754051AbeFPJiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 05:38:04 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20F9A2088E;
        Sat, 16 Jun 2018 09:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529141883;
        bh=LPplaejVQmhLKCxyNMfzyvcyH3dKo0Fsj05SI4dLLrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aG6J7WkUTBy7TzPblRnAV23GMa5OMmu8vJpwJD/AemYzN547FKvGzXVlCXRvpiR8Z
         iYIHUsfQ9pnrpjyTHPgqMpr7Zga2ilRDftjYZ2mykPMmGdxMgw9fQfmfPn2Cxf8+rE
         0Pf6xoQbHMGJnJMGP5oqLVHGWylNoXJvx1UUDCdU=
Date:   Sat, 16 Jun 2018 11:37:40 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        linux-kernel@vger.kernel.org
Subject: Re: can we drop the comedi serial2002 drivers from staging?
Message-ID: <20180616093740.GA9816@kroah.com>
References: <20180616090645.GA3997@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180616090645.GA3997@lst.de>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 11:06:45AM +0200, Christoph Hellwig wrote:
> As far as I can tell there has been no targeted work on the driver
> since merging it at all, and since 2014 even the comedi-wide
> cleanups stopped, laving just drive by tree wide changes since.
> 
> At the same time the driver badly abuses the tty layer and is one
> of only two major abusers of the poll code for in-kernel waits.

Yeah, it's an ugly driver.  It should be rewritten to use the new serdev
api instead of trying to open a tty device node from within the kernel.

I don't object to dropping it.  Ian and Hartley, do you know of any
users of this driver anymore?

thanks,

greg k-h
