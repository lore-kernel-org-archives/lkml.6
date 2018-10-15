Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E95EAC04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A07BB2089D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDvknGP4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A07BB2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbeJPCEM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:04:12 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39432 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726704AbeJPCEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:04:12 -0400
Received: by mail-pf1-f196.google.com with SMTP id c25-v6so10095790pfe.6;
        Mon, 15 Oct 2018 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=al1+B05sGcY3II+9DfVYdXC51m997/UXoi6R1H3Tzt0=;
        b=BDvknGP4U+89os9vBmu/+bey0MlgEqjwa5q3I7M+Z+BPfaQvXW6dp9ZEojMq09mj5V
         TcidpEq+yMpSy/aRBerskMKKoYgXfJE6HzQCnnDrd7X8EoUHo4l3tnkFT/ElChWnS/lP
         5YLCsvQUt86xb65v/UaBt+64LQMektyhT/5bF/n/HNaOZw//Xmer6fEVN440AVUUV52g
         qA8I3saCjV7K5i3SXjfDRdQGLfJIm8ISYGSF2XE/NhBkDJ3r37LJVSSHtYM3797bwrLf
         GJ5dzRJ1De7r1xigz8kpg2LY/YOUGrsJztz3W4swWClw0/4pqwxdK15apCGitZs1lptF
         go8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=al1+B05sGcY3II+9DfVYdXC51m997/UXoi6R1H3Tzt0=;
        b=VYD1CTLd53/7MA4I+kXVELdjecGRvpx8b6y85UhlfBiYm7tx6FqVbYY6U6suP9d+U6
         fcB00mjl3DxFWTtS2wynJwMIhU5FMoE8V9YRi5OAPcPW2jZgiqtSFa+Oz1QV/IJ//G55
         bO5NE6ZvfrILbxTzHmta4nElp1MQeMZEoCLMqet2wY7MLx3pey1qry58fFfp66VBacLA
         CZSAyMPBBP8BY/GOHBoPNLlXy/l9A5XUXH4h1FxeklyZ0UICBMSOn0dPziwsj29QnjM/
         QY3MxKRZ1FXVqcsmAviIx3EnY0aToIVx88w8fAfwkmD56InrcEDBvrX+a0p7kjXrr/pK
         3qog==
X-Gm-Message-State: ABuFfogzOROEHtGbgjw3YLjMOfrbbz6WYhueBleCZTQpH/HHksZBBRcP
        w2Thg98xcbFON77++oazGik=
X-Google-Smtp-Source: ACcGV60znm8Ldt8Z9/Isd4mV+PjmyW2aWgU6C6mYOlsUEXYwCVSguSkLbXPy6pm9H6OydoYOhCHUxw==
X-Received: by 2002:a63:2f42:: with SMTP id v63-v6mr2907375pgv.202.1539627470130;
        Mon, 15 Oct 2018 11:17:50 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id v185-v6sm10294306pfv.48.2018.10.15.11.17.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 11:17:48 -0700 (PDT)
Date:   Mon, 15 Oct 2018 11:17:46 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Charles Keepax <ckeepax@opensource.wolfsonmicro.com>,
        Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
Subject: Re: [PATCH] input: touchscreen: fix wm97xx-ts exit path
Message-ID: <20181015181746.GA127224@dtor-ws>
References: <c522fb84-20cd-39e6-bd2d-79ed8709fd5d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c522fb84-20cd-39e6-bd2d-79ed8709fd5d@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2018 at 10:06:18AM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Loading then unloading wm97xx-ts.ko when CONFIG_AC97_BUS=m
> causes a WARNING: from drivers/base/driver.c:
> 
> Unexpected driver unregister!
> WARNING: CPU: 0 PID: 1709 at ../drivers/base/driver.c:193 driver_unregister+0x30/0x40
> 
> Fix this by only calling driver_unregister() with the same
> condition that driver_register() is called.
> 
> Fixes: ae9d1b5fbd7b ("Input: wm97xx: add new AC97 bus support")
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Robert Jarzmik <robert.jarzmik@free.fr>
> Cc: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: patches@opensource.cirrus.com
> Cc: linux-input@vger.kernel.org

Applied, thank you.

> ---
>  drivers/input/touchscreen/wm97xx-core.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> --- lnx-419-rc7.orig/drivers/input/touchscreen/wm97xx-core.c
> +++ lnx-419-rc7/drivers/input/touchscreen/wm97xx-core.c
> @@ -929,7 +929,8 @@ static int __init wm97xx_init(void)
>  
>  static void __exit wm97xx_exit(void)
>  {
> -	driver_unregister(&wm97xx_driver);
> +	if (IS_BUILTIN(CONFIG_AC97_BUS))
> +		driver_unregister(&wm97xx_driver);
>  	platform_driver_unregister(&wm97xx_mfd_driver);
>  }
>  
> 
> 

-- 
Dmitry
