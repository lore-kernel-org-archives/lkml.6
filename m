Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD7CC6778B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86D0F2525C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h6Ouwcwk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86D0F2525C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967047AbeF2QfG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:35:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36850 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967006AbeF2QfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:35:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=iGRWW9k3PUdbvenVgd7xVPkPkxUjPaP3LaQ00bYXtno=; b=h6OuwcwkK1AGazEC9iELK/a3Q4
        wVyb8rS+0e9UeFl4/hY3FNE3CB8v4dU6wRytr63mje1Se9ADqrFxtEG/eQ1cXlDTs3PMQsX3d/vbf
        aPLwC8/8AvG6QGFOxhW9WoyQBn0BDyfikwwSEvoi8H6XUDvKlgCvnsdHaHlp79+d0z0IurZxAZZeC
        vMSfcVdKUcifIW2FBb6pTZyqoRViy1shHHQVmcMtGb4CrxN+NWQKAfRlYMHZdEDJ8BqKPPJtUWZv5
        N7N+k0lP847pKearVsDvpWGP3qaiiRwUU18qhwGq7tmkosG4Cy3R9LppvCKg57Rt6WIlWv3RrI9Xh
        iY8XGZmQ==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fYwMP-0001WT-Fj; Fri, 29 Jun 2018 16:35:02 +0000
Subject: Re: [PATCH] arc/Kconfig: include mm/Kconfig inside "ARC system
 configuration"
To:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>
Cc:     lkml <linux-kernel@vger.kernel.org>
References: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <4c84ef6c-fa71-8b74-826a-d81dac8c71e7@infradead.org>
Date:   Fri, 29 Jun 2018 09:34:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530279747-25320-1-git-send-email-rppt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/29/2018 06:42 AM, Mike Rapoport wrote:
> Otherwise mm configuration options show up in the top level menu.
> 
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

Hi Mike,

In which config tool does this matter?

For xconfig, it seems to me that this patch hides the MM menu, whereas
before this patch, the MM menu is easy to find (although it could
use some kind of heading).


> ---
>  arch/arc/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
> index e81bcd271be7..92cf06b354a8 100644
> --- a/arch/arc/Kconfig
> +++ b/arch/arc/Kconfig
> @@ -554,8 +554,6 @@ menu "Executable file formats"
>  source "fs/Kconfig.binfmt"
>  endmenu
>  
> -endmenu	 # "ARC Architecture Configuration"
> -
>  source "mm/Kconfig"
>  
>  config FORCE_MAX_ZONEORDER
> @@ -563,6 +561,8 @@ config FORCE_MAX_ZONEORDER
>  	default "12" if ARC_HUGEPAGE_16M
>  	default "11"
>  
> +endmenu	 # "ARC Architecture Configuration"
> +
>  source "net/Kconfig"
>  source "drivers/Kconfig"
>  
> 


-- 
~Randy
