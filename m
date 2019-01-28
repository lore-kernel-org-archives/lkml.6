Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C43C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D598C2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="JIW5HELR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733147AbfA1RJz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:09:55 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:49332 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730854AbfA1RJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:09:53 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0SH9o8Q105009;
        Mon, 28 Jan 2019 11:09:50 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548695390;
        bh=L3bC1rdNxvepYohSSJmwMH/r5k0psWXAjIEmn5XzzNY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=JIW5HELR9w6Cj/3FzuX7x1fjo09yctO1/WXnVtMiLONoETG7XRrRJDwMhkPCKm5lC
         OUr2F+lmn9RbVGEHWuHDW9j2xkogpaLaMrURJMPbiz/lucHzsJfVrGRR/hUXAwF+KE
         eZ4gdbEOkEI/Pgos10zm0u3mV1FtU4/j9A6M7dEI=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0SH9ovo124497
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 11:09:50 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 28
 Jan 2019 11:09:50 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 28 Jan 2019 11:09:50 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0SH9otG031329;
        Mon, 28 Jan 2019 11:09:50 -0600
Date:   Mon, 28 Jan 2019 11:09:50 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 177/258] usb: musb: dsps: fix runtime pm for
 peripheral mode
Message-ID: <20190128170950.GA29630@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-177-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190128155924.51521-177-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, Jan 28, 2019 at 10:58:03AM -0500, Sasha Levin wrote:
> From: Bin Liu <b-liu@ti.com>
> 
> [ Upstream commit 54578ee883e34d2d1c518d48f1c1e2dd3f387188 ]
> 
> Since the runtime PM support was added in musb, dsps relies on the timer
> calling otg_timer() to activate the usb subsystem. However the driver
> doesn't enable the timer for peripheral port, then the peripheral port is
> unable to be enumerated by a host if the other usb port is disabled or in
> peripheral mode too.
> 
> So let's start the timer for peripheral port too.
> 
> Fixes: ea2f35c01d5e ("usb: musb: Fix sleeping function called from invalid context for hdrc glue")
> Acked-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/musb/musb_dsps.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 1e6d78b1334e..403eb97915f8 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -181,9 +181,11 @@ static void dsps_musb_enable(struct musb *musb)
>  
>  	musb_writel(reg_base, wrp->epintr_set, epmask);
>  	musb_writel(reg_base, wrp->coreintr_set, coremask);
> -	/* start polling for ID change in dual-role idle mode */
> -	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE &&
> -			musb->port_mode == MUSB_OTG)
> +	/*
> +	 * start polling for runtime PM active and idle,
> +	 * and for ID change in dual-role idle mode.
> +	 */
> +	if (musb->xceiv->otg->state == OTG_STATE_B_IDLE)
>  		dsps_mod_timer(glue, -1);
>  }
>  
> @@ -254,6 +256,10 @@ static int dsps_check_status(struct musb *musb, void *unused)
>  				musb->xceiv->otg->state = OTG_STATE_A_IDLE;
>  				MUSB_HST_MODE(musb);
>  			}
> +
> +			if (musb->port_mode == MUSB_PERIPHERAL)
> +				skip_session = 1;
> +
>  			if (!(devctl & MUSB_DEVCTL_SESSION) && !skip_session)
>  				musb_writeb(mregs, MUSB_DEVCTL,
>  					    MUSB_DEVCTL_SESSION);

This backport won't apply to stables cleanly. I have sent the manual
backport [1] for v4.9+ a few weeks ago.

[1] https://marc.info/?l=linux-usb&m=154696698103763&w=2

Regards,
-Bin.
