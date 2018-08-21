Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4325AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D71BF217D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqOBsa0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D71BF217D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbeHVDUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 23:20:23 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:33983 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727027AbeHVDUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 23:20:23 -0400
Received: by mail-pf1-f193.google.com with SMTP id k19-v6so88303pfi.1;
        Tue, 21 Aug 2018 16:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=xQa4W453HOYm+HYSQWRP1WcgEKdRR6OI9b5kZb5ClwQ=;
        b=dqOBsa0+36JyvogrQ6kPyqntOcKlBzPl1pmwi9OppT1KWg14/jFhf4sDI24SEl9O66
         rtnSRKSWuEHDcKiHKuVKPBwqwIk2w9UQarpHxTrwm59cgYuPNct/pCZciM0qPKYBVHcs
         vv2R8WmWIS6f+xNJlb7/LSybGwJYEFJPZ08oKzYNF1w3kdZuyvqvk+M3OQAs9Ii0GxGY
         OjYZTXQI4PdhyXIcfFKflxq3vRX9UwdsHT7x1B2WdmqfNMc979goYG6SHwW12RZAVj6R
         KzrJ9FogIbUYaC7Rnc+Isk0JK/TQ6m4cmqCX9mTt3TuKfb5VFjBOhB3vTZZbR1AtvRTb
         mFEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=xQa4W453HOYm+HYSQWRP1WcgEKdRR6OI9b5kZb5ClwQ=;
        b=VTNPiTKeNr/Wu9kpEabyWEsdGybOyU+rpN5M94apkCNmxx5lq+GsIZ2g9zAE/zS1cu
         oF2fxG/gWqpimv//IQE9blCIJqrHQbnWJGYBIaxjExzJGOSpOAn3UnyFh8q+vJba9/V1
         3EExsN018RUs8sMZvX5BY/tLCj0Vkz3D66lfLE1qtf8V/OpZXJ4mUabNVAg/vo0fmq0q
         s4pruBZz0Cfzvkt9P++NGC7Z0JJcR/8XJSUixNFx8MvRabS/X9QwJoO7WEfag/1JnEXx
         8fVs8Y8TbQqz/4cGl+MJ1kH4E1CY3a1hDNvVhC4w67QiMv1xl+BkVJfk7xryA5tgBm+j
         N9ug==
X-Gm-Message-State: AOUpUlFGs1PHju96JJy9c1UOE787dPJ5H8jcLumugOJvAa2JBqyQT0VD
        E3EbBKf9vUssJxYM6hepeEBxjM2k
X-Google-Smtp-Source: AA+uWPyi9JLCrJsjDv1WMxqTerYKZeX6DkxGSCX9zFUzS9cCRycO9dNkHiiJyyYatCnhUipGD1t4rQ==
X-Received: by 2002:a62:89d8:: with SMTP id n85-v6mr54869206pfk.83.1534895884820;
        Tue, 21 Aug 2018 16:58:04 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id t21-v6sm113712pfi.73.2018.08.21.16.58.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 16:58:03 -0700 (PDT)
Date:   Tue, 21 Aug 2018 16:58:02 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Kuninori Morimoto <kuninori.morimoto.gx@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/11] watchdog: use SPDX identifier for Renesas drivers
Message-ID: <20180821235802.GA28717@roeck-us.net>
References: <20180821220233.9202-1-wsa+renesas@sang-engineering.com>
 <20180821220233.9202-12-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821220233.9202-12-wsa+renesas@sang-engineering.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 12:02:24AM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> To be applied individually per subsystem tree. Morimoto-san, could you maybe
> ack this with your Renesas address?
> 
>  drivers/watchdog/renesas_wdt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/watchdog/renesas_wdt.c b/drivers/watchdog/renesas_wdt.c
> index 88d81feba4e6..84bb9d328180 100644
> --- a/drivers/watchdog/renesas_wdt.c
> +++ b/drivers/watchdog/renesas_wdt.c
> @@ -1,12 +1,9 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Watchdog driver for Renesas WDT watchdog
>   *
>   * Copyright (C) 2015-17 Wolfram Sang, Sang Engineering <wsa@sang-engineering.com>
>   * Copyright (C) 2015-17 Renesas Electronics Corporation
> - *
> - * This program is free software; you can redistribute it and/or modify it
> - * under the terms of the GNU General Public License version 2 as published by
> - * the Free Software Foundation.
>   */
>  #include <linux/bitops.h>
>  #include <linux/clk.h>
> -- 
> 2.11.0
> 
