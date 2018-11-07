Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91ECC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:04:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EE452086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 12:04:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IA3yH2X4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EE452086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730665AbeKGVeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 16:34:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:42992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726560AbeKGVeJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 16:34:09 -0500
Received: from localhost (unknown [104.153.224.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA4AD2085B;
        Wed,  7 Nov 2018 12:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541592245;
        bh=Qf5o5F81K4Lumc5aQb66GfQ443ZQX2ttEU+VZfnWpVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IA3yH2X4FdJMYtGTlgr5s92r7Isxqd5yZ5DpZfPRoRMffBXX9rxJeGYKNRYdaGGXO
         OTbPvGZ1JVoumTikdrNLDO0dWmQyXPSUjBPFQRlrx0ehmUFUIgj4Bs1LquLp8vfNIt
         wNH1lAjX+pEnhEbJvVMiqDAuCBMCKM9V9kyK0zbI=
Date:   Wed, 7 Nov 2018 12:26:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     nicolas@autobyte.com.br
Cc:     linux@rasmusvillemoes.dk, pure.logic@nexus-software.ie,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Subject: Re: [PATCH] staging: mt7621-mmc: Add blank line after declaration
Message-ID: <20181107112650.GA29485@kroah.com>
References: <20181107004242.1486-1-nfraprado@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181107004242.1486-1-nfraprado@protonmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 06, 2018 at 10:42:42PM -0200, nicolas@autobyte.com.br wrote:
> From: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
> 
> Correct the following warning from checkpatch.pl:
> 
> WARNING: Missing a blank line after declarations
> +		struct msdc_host *host = mmc_priv(mmc);
> +		msdc_pm(state, (void *)host);
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@protonmail.com>
> 
> ---
> 
> Hi, this is my first commit. Let me know if there's anything I can do
> better.
> ---
>  drivers/staging/mt7621-mmc/sd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/staging/mt7621-mmc/sd.c b/drivers/staging/mt7621-mmc/sd.c
> index 0379f9c96..7b66f9b0a 100644
> --- a/drivers/staging/mt7621-mmc/sd.c
> +++ b/drivers/staging/mt7621-mmc/sd.c
> @@ -1797,6 +1797,7 @@ static void msdc_drv_pm(struct platform_device *pdev, pm_message_t state)
>  
>  	if (mmc) {
>  		struct msdc_host *host = mmc_priv(mmc);
> +
>  		msdc_pm(state, (void *)host);
>  	}

This patch is fine, and I'll take it, but can't this be written a lot
simpler:
	if (mmc)
		msdc_pm(state, mmc_priv(mmc));

that looks better, don't you think?

thanks,

greg k-h
