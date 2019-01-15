Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A020BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67CD220657
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 17:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547572818;
	bh=10T/hCSxMRGjFJWkPUS1dzuSg92fevw/x0U8NnuZmbU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xNaCHD1p1BpW5ZTT/2LmuGIXilfP54agRPXG1ejWY90YIxezDYxMCAVB0ouB8JGF6
	 E/EyHB7qE7gXYK67q9GG47lREBVRgsbKk6ai1sEfeYdf0qRS3ADlF8BruRJ9P8KPvb
	 JcpG+TtPLKuZcztt4pPHUfw2q+lwmxdeEDvp7Zxs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733273AbfAORUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 12:20:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:49700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730278AbfAORUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 12:20:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A138820657;
        Tue, 15 Jan 2019 17:20:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547572816;
        bh=10T/hCSxMRGjFJWkPUS1dzuSg92fevw/x0U8NnuZmbU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LVYnKQ8+od5liHIl4RMCzoqdXy9y5fliK4Ra3vxZRbx3i0kMBcvngxSIU5ufng1ou
         /h+MKOndXjxe+g/58Ug3Y1Mx4WbFG0q+8rOpB3SSyCauRC2cBUbAn9kP0WIC4IXZEC
         rUhx9BSXlwdkztiR72gX+1eiS0aymfgJmMy1JX/c=
Date:   Tue, 15 Jan 2019 18:20:09 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     George Hilliard <thirtythreeforty@gmail.com>
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        NeilBrown <neil@brown.name>, sergio.paracuellos@gmail.com
Subject: Re: [PATCH v3] staging: Mediatek: Use individual config flags in
 Makefile
Message-ID: <20190115172009.GB30853@kroah.com>
References: <20190115153000.GA15206@kroah.com>
 <20190115170221.26693-1-thirtythreeforty@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115170221.26693-1-thirtythreeforty@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 10:02:21AM -0700, George Hilliard wrote:
> These drivers can be useful on other MT76xx SoCs, which have compatible
> peripherals.  The drivers were selectable in Kconfig, but they were
> quietly excluded from the build because the SOC_MT7621 chip was not
> selected.  So, make the Makefiles use the same flags as Kconfig for
> these drivers.
> 
> mt7621-dma and mt7621-dts are left alone because they truly do require
> that SoC.
> 
> I have personally confirmed that the mt7621-spi driver works on the
> MT7688, which was what prompted this change.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: devel@driverdev.osuosl.org
> Cc: NeilBrown <neil@brown.name>
> Cc: sergio.paracuellos@gmail.com
> Signed-off-by: George Hilliard <thirtythreeforty@gmail.com>
> ---
>  drivers/staging/Makefile                | 14 +++++++-------
>  drivers/staging/mt7621-pci-phy/Makefile |  2 +-
>  drivers/staging/mt7621-pci/Makefile     |  2 +-
>  3 files changed, 9 insertions(+), 9 deletions(-)

What changed from v2 and v1?  That always goes below the --- line.

Please fix that up and resend v4.

thanks,

greg k-h
