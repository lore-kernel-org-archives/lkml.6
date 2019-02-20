Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D46AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DEC520859
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 23:09:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CIiH7otv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbfBTXJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 18:09:54 -0500
Received: from merlin.infradead.org ([205.233.59.134]:50432 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfBTXJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 18:09:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bAGeGQdbTQcThkbLqat/4p15AtaqYmAUjW3rFUStPds=; b=CIiH7otvk8l4exqvhiMF3WtDtP
        iZFJBCIOV5stoUAIW4rFsnk/hpMjiL0ygh4UGi93GX0vu05koksWPfL+d0EbvSxIOe9lu+IUFwbjx
        482+Ydm3BOVMiedUIOjC864F1Y/iYmXXJtpg74KUbWlxYQN7bPKwJIbYHMSynjwYtRch/MypRDPP4
        AeYS8Ky1OEmsNqno5C3aqgr3cUT5eCqGc7mR0JhX6ZNXBAr7bxzd6AN0rldOpECFoo2bwCz5hXXzN
        Y1v31ri2CpUJq9YJPPrSohYKzVvDDxi+1HVo1M6uqiw/S6FZ88IyHXetCRFigM112r8Yupe92/Ubg
        b5gA/Dbg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gwazl-000449-Hy; Wed, 20 Feb 2019 23:09:41 +0000
Subject: Re: [PATCH -next] platform/chrome: Fix Kconfig dependencies for
 wilco_ec
To:     Nick Crews <ncrews@chromium.org>, bleung@chromium.org,
        enric.balletbo@collabora.com
Cc:     linux-kernel@vger.kernel.org, dlaurie@chromium.org,
        sfr@canb.auug.org.au
References: <20190220221128.48476-1-ncrews@chromium.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <420e6e26-6270-e577-6bbc-3ebe884168b5@infradead.org>
Date:   Wed, 20 Feb 2019 15:09:36 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20190220221128.48476-1-ncrews@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/20/19 2:11 PM, Nick Crews wrote:
> In the initial version of the Wilco EC Driver, the
> dependency order was wrong. It before was possible to
> select CONFIG_WILCO_EC and CONFIG_CROS_EC_LPC without
> having CONFIG_CROS_EC_LPC_MEC. This was wrong, since
> WILCO_EC depends upon CONFIG CROS_EC_LPC_MEC, not the
> other way around.
> 
> Fixes: 1733c32834e5d1 ("platform/chrome: Add new driver for Wilco EC")
> Signed-off-by: Nick Crews <ncrews@chromium.org>

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

Thanks.

> ---
>  drivers/platform/chrome/Kconfig          | 2 +-
>  drivers/platform/chrome/wilco_ec/Kconfig | 3 +--
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 462eb9dfa4f2..b69561050868 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -95,7 +95,7 @@ config CROS_EC_LPC
>  
>  config CROS_EC_LPC_MEC
>  	bool "ChromeOS Embedded Controller LPC Microchip EC (MEC) variant"
> -	depends on CROS_EC_LPC || WILCO_EC
> +	depends on CROS_EC_LPC
>  	default n
>  	help
>  	  If you say Y here, a variant LPC protocol for the Microchip EC
> diff --git a/drivers/platform/chrome/wilco_ec/Kconfig b/drivers/platform/chrome/wilco_ec/Kconfig
> index 20945a301ec6..c6bc4e8f3062 100644
> --- a/drivers/platform/chrome/wilco_ec/Kconfig
> +++ b/drivers/platform/chrome/wilco_ec/Kconfig
> @@ -1,7 +1,6 @@
>  config WILCO_EC
>  	tristate "ChromeOS Wilco Embedded Controller"
> -	depends on ACPI && X86
> -	select CROS_EC_LPC_MEC
> +	depends on ACPI && X86 && CROS_EC_LPC_MEC
>  	help
>  	  If you say Y here, you get support for talking to the ChromeOS
>  	  Wilco EC over an eSPI bus. This uses a simple byte-level protocol
> 


-- 
~Randy
