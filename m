Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3B4C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 775B82184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548259231;
	bh=WNcPrA8d4jp+LjCXSOnL++hrAaDRb8mCvTrVbMBtK+o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=awWQgfldYWTkpUY79uq1G/P+gDzIC81TTR3MSFlxdkaZoFmb1X9QrAQXXTeKxa/3/
	 51/3WLd87/Z6e010gZ/8cgXNnDZvol//T+wDsqAo4a+XAFUM0Rchu0/engVQm//Hyy
	 q9PCawRdJCuxjxl+bGbrkyQqcYJlI9kpFpCTjpDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbfAWQAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:00:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:43966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbfAWQAW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 11:00:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C4D2620449;
        Wed, 23 Jan 2019 16:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548259222;
        bh=WNcPrA8d4jp+LjCXSOnL++hrAaDRb8mCvTrVbMBtK+o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hrz3/yTNePN5XCeC9Fq9b7lfDY1s11Qbiu2p8JRgekZW5lZ9smwKqAE88CDD0saNH
         OzsX4jZYVNnYE+Tm6OeEmSFYmgawzQEz6W4elNtvITtLutVRQniXW/3+U5pn/s6AqH
         wb994eRuK6hRfNp4MXOzLj/luzliZyDP9N0Rfj5A=
Date:   Wed, 23 Jan 2019 17:00:19 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.gong@linux.intel.com
Cc:     atull@kernel.org, dinguyen@kernel.org,
        linux-kernel@vger.kernel.org, todd.riffel@intel.com,
        Richard Gong <richard.gong@intel.com>
Subject: Re: [PATCHv1] firmware: intel_stratix10_service: add hardware
 dependency
Message-ID: <20190123160019.GB4764@kroah.com>
References: <1548258476-16821-1-git-send-email-richard.gong@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548258476-16821-1-git-send-email-richard.gong@linux.intel.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 23, 2019 at 09:47:56AM -0600, richard.gong@linux.intel.com wrote:
> From: Richard Gong <richard.gong@intel.com>
> 
> Add a Kconfig dependency to ensure Intel Stratix10 service layer driver
> can be built only on the platform that supports it.
> 
> Signed-off-by: Richard Gong <richard.gong@intel.com>
> ---
>  drivers/firmware/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
> index f754578..cac16c4 100644
> --- a/drivers/firmware/Kconfig
> +++ b/drivers/firmware/Kconfig
> @@ -218,7 +218,7 @@ config FW_CFG_SYSFS_CMDLINE
>  
>  config INTEL_STRATIX10_SERVICE
>  	tristate "Intel Stratix10 Service Layer"
> -	depends on HAVE_ARM_SMCCC
> +	depends on ARCH_STRATIX10 && HAVE_ARM_SMCCC

That's lame, what about building for testing?

And is this needed now, for 5.0-final, or can it wait for 5.1?  What
changed to require this?

tahnks,

greg k-h
