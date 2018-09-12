Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67A39C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F8E720C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:18:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfgkQeTl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F8E720C0A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbeIMCYp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:24:45 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33389 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbeIMCYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:24:45 -0400
Received: by mail-pl1-f195.google.com with SMTP id b30-v6so1585297pla.0;
        Wed, 12 Sep 2018 14:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ltvWySZJZcsSoJmZKVg2t9N9EMWs9AIzRuRqRyNi4yM=;
        b=NfgkQeTlIOTSEku6JxS5TnnolOUlG2N0LFNVCbFlt77/nOkY2JNtKFtCugDPdhYo0G
         d9hD0/uRes0yDoyJ/28w5SbYjrX9DgEXprZ8warqcxYiNVx9JnETO1JinvM8AXIaUdW7
         +HctJULLwFgaJ3NtrFR0D4HsZvdEXcyFEw6xihgcn54Px3SvanHRsobdncR3br8IpJj2
         kYmP95B0RYr07p4Y37WkcF4AYcXKGC871xM/Mdu44fUSHBllGm47HY2OCAd3dkgEERWH
         0xE/4UW9l8yCgYhE9KlhLj+Z7PcXKCrnIlxgydrBAiMJT6q3QPupLDRlzJlPg6mkmrUt
         SyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ltvWySZJZcsSoJmZKVg2t9N9EMWs9AIzRuRqRyNi4yM=;
        b=cTHiwyDF+x2f78oospOw/IQvgToorywigyggEXo9bS8Gp7TTRYhpeD53FdRalDeODW
         ebRcs3Z5XsEiNq26YPGZDiHerb+l/NyhgWmQ1v4oQhcyLo16993NTCV8zZ0d4riUf4Xx
         /ZZidTw00Kr19LuDCdWDeg5JFv4xBWX35tVgDxw+DalM4xY3r3LUv2HC8aXJj4n5Vr7I
         Vjim+afby0uC6L/pP42PX6IRLMK/k6uP0PaR7vBhjQWxvaZaQthKZarO82rOWmAqsOSt
         yP4hPZhp7WMHpPnSKWlDAuE6K5bpUgHHoOCWlYubfWYA4ZemtJ/7kATEKec8O9S3oabD
         VTkg==
X-Gm-Message-State: APzg51D12lfwfwFe5HElUYqpBVDOF5Jw1S0rEcHd+QNXeoKI7eQOdbN7
        /fa4Le1979GL6g2+neI2iyJUA/B7
X-Google-Smtp-Source: ANB0Vdakcq6f9DEBYiMw3C2ZDcCCKf2r1mS9PsUTeIyjtBAwaDUE7g40iKG6qA3p1RAM60Ii2aPxXQ==
X-Received: by 2002:a17:902:8d8c:: with SMTP id v12-v6mr4123765plo.94.1536787103776;
        Wed, 12 Sep 2018 14:18:23 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id b73-v6sm3411890pfj.93.2018.09.12.14.18.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 14:18:23 -0700 (PDT)
Date:   Wed, 12 Sep 2018 14:18:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Jagdish Tirumala <t.jag587@gmail.com>
Cc:     wim@linux-watchdog.org, yamada.masahiro@socionext.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: diag288_wdt: pointer location foo * bar should
 be foo *bar
Message-ID: <20180912211822.GA12970@roeck-us.net>
References: <20180912172907.1802-1-t.jag587@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180912172907.1802-1-t.jag587@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 10:29:07AM -0700, Jagdish Tirumala wrote:
> Fix the following checkpatch error:
> 
> ERROR: pointer location foo * bar should be foo *bar
> FILE: drivers/watchdog/diag288_wdt.c:202
> 
> Signed-off-by: Jagdish Tirumala <t.jag587@gmail.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/diag288_wdt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/diag288_wdt.c b/drivers/watchdog/diag288_wdt.c
> index 806a04a676b7..046333d1beb2 100644
> --- a/drivers/watchdog/diag288_wdt.c
> +++ b/drivers/watchdog/diag288_wdt.c
> @@ -199,7 +199,7 @@ static int wdt_ping(struct watchdog_device *dev)
>  	return ret;
>  }
>  
> -static int wdt_set_timeout(struct watchdog_device * dev, unsigned int new_to)
> +static int wdt_set_timeout(struct watchdog_device *dev, unsigned int new_to)
>  {
>  	dev->timeout = new_to;
>  	return wdt_ping(dev);
> -- 
> 2.17.1
> 
