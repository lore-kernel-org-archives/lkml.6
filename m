Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7392C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9861A2086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 16:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pZiLeP7H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9861A2086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbeKJC1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 21:27:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:55046 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727941AbeKJC1M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 21:27:12 -0500
Received: from localhost (71-6-98-120.static-ip.telepacific.net [71.6.98.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4D4A02086C;
        Fri,  9 Nov 2018 16:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541781950;
        bh=akZGybghGAF9BcjuuJBWzvGoahTzsvnIV9Wtw58k0Ww=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pZiLeP7Hg9pMszwxIsHGYxgSDkmRRi3WCoCUbSxGDty6G4CnTDPMc8P2rCIiV9M2W
         ikzRaTJ+AkCTS/AYNDK5D6gd2bMlitE/ttu9gJ9mxM7mvxLQyKGst8/UfoQSikho37
         FTy+IvVjyQ7nis+3onr3QjjnXQSaoFVXkB+263fo=
Date:   Fri, 9 Nov 2018 08:45:49 -0800
From:   Greg KH <gregkh@linuxfoundation.org>
To:     shubhrajyoti.datta@gmail.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        jslaby@suse.com, jacmet@sunsite.dk,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: Re: [LINUX PATCHv3 0/9] serial-uartlite: Add support for dynamic
 allocation
Message-ID: <20181109164549.GA28175@kroah.com>
References: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539685088-13465-1-git-send-email-shubhrajyoti.datta@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 03:47:59PM +0530, shubhrajyoti.datta@gmail.com wrote:
> From: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> 
> Currently the number of uarts are configured through a Kconfig
> option Make it dynamic.
> While at it adapt to the runtime framework.
> 
> It is based a similar series on the uartps from Michal

I've applied the first 5, can you fix up the rest and resend so that
they do not cause build breakage at any point?

thanks,

greg k-h
