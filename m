Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1CE9C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB215206A3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 07:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550907898;
	bh=aGvlpN37P3p8qZGTKmwvgAEiyJzVsBTEheGR1UySqpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tqIy1NYHFCGyUoGOQokVb2fuCgQCyPP2Ke4kFQYqndepnXjTI4sMG4VEd3UFMsM20
	 jfivTl7ShJfBeg9c0/ERWuvK+KwyzdsxvltNpIbid+D8eBC7e6Z2MXMg+19Qz1RH8R
	 +O5ALJ7fqD5wT5EeZRuC5EwDqiVMxnWlw/vddLmo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbfBWHnY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 02:43:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:49352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725868AbfBWHnX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 02:43:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91995206A3;
        Sat, 23 Feb 2019 07:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550907803;
        bh=aGvlpN37P3p8qZGTKmwvgAEiyJzVsBTEheGR1UySqpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wSGBOOH4WiMHZjrBqAIuYFAqHOL52IE41cY6x557PLI5AEiyyFK0esaA1+k75Bru/
         dJnLmsRkseBdAej8xaz1kGjgLR27NEQNKjzewc/ozjXGh4QBd20NLI+gaZKuUpJyvP
         b088+2l2WdeUgS5QFb4OPhYRw+coB5rTjPMvRWCY=
Date:   Sat, 23 Feb 2019 08:43:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bo YU <tsu.yubo@gmail.com>
Cc:     sergio.paracuellos@gmail.com, quytelda@tamalin.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        yuzibode@126.com
Subject: Re: [PATCH] staging/ks7070: Removed unused varibale
Message-ID: <20190223074320.GA921@kroah.com>
References: <20190223063939.18261-1-tsu.yubo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190223063939.18261-1-tsu.yubo@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 23, 2019 at 01:39:39AM -0500, Bo YU wrote:
> From: Bo Yu <tsu.yubo@gmail.com>
> 
> Compiling the kernel with W=1 results in the following warning:
> 
> drivers/staging/ks7010/ks_hostif.c:465:6: warning: variable ‘mib_val_type’
> set but not used [-Wunused-but-set-variable]
>   u16 mib_val_type;
> 
> drivers/staging/ks7010/ks_hostif.c:464:6: warning: variable ‘mib_val_size’
> set but not used [-Wunused-but-set-variable]
>     u16 mib_val_size;
> 
> drivers/staging/ks7010/ks_hostif.c:786:6: warning: variable ‘result_code’
> set but not used [-Wunused-but-set-variable]
>       u16 result_code;
> 
> Remove these variables.
> 
> Rebase on next-20190222
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sergio Paracuellos <sergio.paracuellos@gmail.com>
> Cc: Quytelda Kahja <quytelda@tamalin.org>
> 
> Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
> ---
>  drivers/staging/ks7010/ks_hostif.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/ks7010/ks_hostif.c b/drivers/staging/ks7010/ks_hostif.c
> index d938b0997a53..913d8996437a 100644
> --- a/drivers/staging/ks7010/ks_hostif.c
> +++ b/drivers/staging/ks7010/ks_hostif.c
> @@ -461,13 +461,9 @@ void hostif_mib_get_confirm(struct ks_wlan_private *priv)
>  	struct net_device *dev = priv->net_dev;
>  	u32 mib_status;
>  	u32 mib_attribute;
> -	u16 mib_val_size;
> -	u16 mib_val_type;
>  
>  	mib_status = get_dword(priv);
>  	mib_attribute = get_dword(priv);
> -	mib_val_size = get_word(priv);
> -	mib_val_type = get_word(priv);

The function get_word() actually does something to the priv structure,
so you just broke the driver :(

>  
>  	if (mib_status) {
>  		netdev_err(priv->net_dev, "attribute=%08X, status=%08X\n",
> @@ -783,9 +779,7 @@ void hostif_ps_adhoc_set_confirm(struct ks_wlan_private *priv)
>  static
>  void hostif_infrastructure_set_confirm(struct ks_wlan_private *priv)
>  {
> -	u16 result_code;
>  
> -	result_code = get_word(priv);
>  	priv->infra_status = 1;	/* infrastructure mode set */
>  	hostif_sme_enqueue(priv, SME_MODE_SET_CONFIRM);

Same here, odds are you just broke things :(

Please be more careful.

greg k-h
