Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D699C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAB821741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="pKLf0Loe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbfA1RHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:07:55 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:33944 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387474AbfA1RHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 12:07:54 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0SH7pXX086305;
        Mon, 28 Jan 2019 11:07:51 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1548695271;
        bh=g1EDDCYbaWFJ4rqTrPvRsYtK75Z1m+jjFm9rhhawDZI=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=pKLf0LoeaD2uhuU+lf9hP13z34F7MjIBsnXgxMdoSVUpcrXPZLW1aBbxGh+h6Onq8
         pwpxqFb1an3ozE2fdTRd3DzowuGRmPiEXvMTMuL2QghG4QqmDk6qD9pQAB+NCTP1xr
         A659IMCYu7jxtLNj7KEcqJxhGCAbtzZNuaZaYbOA=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0SH7pLK041094
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 28 Jan 2019 11:07:51 -0600
Received: from DFLE102.ent.ti.com (10.64.6.23) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 28
 Jan 2019 11:07:33 -0600
Received: from dlep33.itg.ti.com (157.170.170.75) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 28 Jan 2019 11:07:33 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0SH7X2u005546;
        Mon, 28 Jan 2019 11:07:33 -0600
Date:   Mon, 28 Jan 2019 11:07:33 -0600
From:   Bin Liu <b-liu@ti.com>
To:     Sasha Levin <sashal@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>
Subject: Re: [PATCH AUTOSEL 4.19 176/258] usb: musb: dsps: fix otg state
 machine
Message-ID: <20190128170733.GK18982@uda0271908>
Mail-Followup-To: Bin Liu <b-liu@ti.com>, Sasha Levin <sashal@kernel.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
References: <20190128155924.51521-1-sashal@kernel.org>
 <20190128155924.51521-176-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190128155924.51521-176-sashal@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sasha,

On Mon, Jan 28, 2019 at 10:58:02AM -0500, Sasha Levin wrote:
> From: Bin Liu <b-liu@ti.com>
> 
> [ Upstream commit 6010abf2c2c0e382d7e8ee44bd11f343aae90cce ]
> 
> Due to lack of ID pin interrupt event on AM335x devices, the musb dsps
> driver uses polling to detect usb device attach for dual-role port.
> 
> But in the case if a micro-A cable adapter is attached without a USB device
> attached to the cable, the musb state machine gets stuck in a_wait_vrise
> state waiting for the MUSB_CONNECT interrupt which won't happen due to the
> usb device is not attached. The state is stuck in a_wait_vrise even after
> the micro-A cable is detached, which could cause VBUS retention if then the
> dual-role port is attached to a host port.
> 
> To fix the problem, make a_wait_vrise as a transient state, then move the
> state to either a_wait_bcon for host port or a_idle state for dual-role
> port, if no usb device is attached to the port.
> 
> Signed-off-by: Bin Liu <b-liu@ti.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/usb/musb/musb_dsps.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/musb/musb_dsps.c b/drivers/usb/musb/musb_dsps.c
> index 23a0df79ef21..1e6d78b1334e 100644
> --- a/drivers/usb/musb/musb_dsps.c
> +++ b/drivers/usb/musb/musb_dsps.c
> @@ -227,8 +227,13 @@ static int dsps_check_status(struct musb *musb, void *unused)
>  
>  	switch (musb->xceiv->otg->state) {
>  	case OTG_STATE_A_WAIT_VRISE:
> -		dsps_mod_timer_optional(glue);
> -		break;
> +		if (musb->port_mode == MUSB_HOST) {
> +			musb->xceiv->otg->state = OTG_STATE_A_WAIT_BCON;
> +			dsps_mod_timer_optional(glue);
> +			break;
> +		}
> +		/* fall through */
> +
>  	case OTG_STATE_A_WAIT_BCON:
>  		/* keep VBUS on for host-only mode */
>  		if (musb->port_mode == MUSB_HOST) {

This backport won't apply to stables cleanly. I have sent the manual
backport [1] for v4.9+ a few weeks ago.

[1] https://marc.info/?l=linux-usb&m=154696800204159&w=2

Regards,
-Bin,
