Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F63FC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0F3720864
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 06:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F3720864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756857AbeFPGDS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 02:03:18 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:38801 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751407AbeFPGDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 02:03:16 -0400
X-IronPort-AV: E=Sophos;i="5.51,229,1526335200"; 
   d="scan'208";a="332048613"
Received: from abo-154-110-68.mrs.modulonet.fr (HELO [192.168.0.15]) ([85.68.110.154])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jun 2018 08:03:14 +0200
Date:   Sat, 16 Jun 2018 08:03:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     Hyunil Kim <thtlwlsmsgkfla@gmail.com>
cc:     gregkh@linuxfoundation.org, davem@davemloft.net,
        colin.king@canonical.com, johannes.berg@intel.com,
        Linyu.Yuan@alcatel-sbell.com.cn, keescook@chromium.org,
        tvboxspy@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: fix line over 80 characters
In-Reply-To: <1909265.MoDodiKBI3@os-virtualbox>
Message-ID: <alpine.DEB.2.20.1806160802390.2380@hadrien>
References: <1909265.MoDodiKBI3@os-virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Jun 2018, Hyunil Kim wrote:

> *fix checkpatch.pl warnings:
>  WARNING: line over 80 characters

Describe what you do and why, rather than just saying "Fix".  Often
something can be fixed in multiple ways.

julia

>
> Signed-off-by: Hyunil Kim <thtlwlsmsgkfla@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
> index 74c5865..2111e01 100644
> --- a/drivers/staging/rtl8192u/r8192U_core.c
> +++ b/drivers/staging/rtl8192u/r8192U_core.c
> @@ -2044,7 +2044,10 @@ static bool GetNmodeSupportBySecCfg8192(struct net_device *dev)
>  		return false;
>  	} else if ((wpa_ie_len != 0)) {
>  		/* parse pairwise key type */
> -		if (((ieee->wpa_ie[0] == 0xdd) && (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) || ((ieee->wpa_ie[0] == 0x30) && (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
> +		if (((ieee->wpa_ie[0] == 0xdd) &&
> +		    (!memcmp(&(ieee->wpa_ie[14]), ccmp_ie, 4))) ||
> +		    ((ieee->wpa_ie[0] == 0x30) &&
> +		    (!memcmp(&ieee->wpa_ie[10], ccmp_rsn_ie, 4))))
>  			return true;
>  		else
>  			return false;
> --
> 2.7.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
