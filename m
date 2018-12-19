Return-Path: <SRS0=MnXf=O4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5231C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752F52184A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 07:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545204796;
	bh=FiAjbNrOkOMDIIDEEClr1VzEWgFfsOIy5pArg9stlWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pPuMI7PR3fklVW8EdvAOrMG9+VCsdyiRT2CMpCCoHBfschc6tuhMUmxw1jdS3jAK5
	 RTbxkM7oLXeieDSQbzTzzuu52tUlLpxw1KL+C8JQ7aMV96GNakG4kfzgSmgSgkB3aX
	 fF7wHlkTT3t9R0RBSyTiV6U/AJ69YzSXJGHtQ3ho=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbeLSHdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:33:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:56286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbeLSHdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 02:33:14 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E17E2184A;
        Wed, 19 Dec 2018 07:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545204794;
        bh=FiAjbNrOkOMDIIDEEClr1VzEWgFfsOIy5pArg9stlWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WnSu5Nk2Y7Tlww3/9qeQHRo1DPT2iZMxBy1ETp6eGdLFzrZ7LJz7uiUzIkXKcIMgs
         LT4spTtNoyB4kvd7wpU1d6Xoqk9APwZEShk6rcCgwp817tOdv8rgzDdFqruXEmsdI3
         x621wl00HDDVevwVzTdlfClHFzjugU6BzBhC3O/w=
Date:   Wed, 19 Dec 2018 08:32:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/17] staging: rtl8188eu: simplify null array
 initializations
Message-ID: <20181219073211.GA22266@kroah.com>
References: <20181218183451.18692-1-straube.linux@gmail.com>
 <20181218183451.18692-14-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181218183451.18692-14-straube.linux@gmail.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 07:34:48PM +0100, Michael Straube wrote:
> Simplfy initialization of null arrays to improve readability
> and save some lines.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 4 ++--
>  drivers/staging/rtl8188eu/core/rtw_xmit.c     | 6 ++----
>  2 files changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> index d3d211d8eeee..2a42f80d1970 100644
> --- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
> @@ -17,7 +17,7 @@
>  #include <mlme_osdep.h>
>  #include <recv_osdep.h>
>  
> -static u8 null_addr[ETH_ALEN] = {0, 0, 0, 0, 0, 0};
> +static u8 null_addr[ETH_ALEN] = {};
>  
>  /**************************************************
>  OUI definitions for the vendor specific IE
> @@ -5207,7 +5207,7 @@ u8 setkey_hdl(struct adapter *padapter, u8 *pbuf)
>  	struct setkey_parm *pparm = (struct setkey_parm *)pbuf;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_ext_info *pmlmeinfo = &pmlmeext->mlmext_info;
> -	u8 null_sta[] = {0x00, 0x00, 0x00, 0x00, 0x00, 0x00};
> +	u8 null_sta[ETH_ALEN] = {};

This just changed the type of the variable to a fixed size.  I'm
guessing it's ok, but it looks odd in a "cleanup patch"...

thanks,

greg k-h
