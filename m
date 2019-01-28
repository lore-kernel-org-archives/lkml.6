Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8468DC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53DAA2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFOBGMu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbfA1S0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:26:24 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35384 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbfA1S0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:26:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id p8so8106642plo.2;
        Mon, 28 Jan 2019 10:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YOcmwQlKPN9MiF5h6pIEWRpv7xX2xeADc3Nuk8weeXI=;
        b=PFOBGMu58AD9AhlHEEPLpGJtxPeGq1cop3Yf1y80MRjw4sv8oEn7AZlcYYJ6zI/AY/
         WNTV8m+U52NOQKWi6yJtdQI4cixFKyMQ12BSWliuo6jawtQG9a2ePqiz3um0x8WY0vQe
         nOrk0eiac/4VuxAsMb71DDOoIQUHLhYz8QsAAvwnfmB1iZv1KzRZCFkC73a0yOnqVfk9
         gsYUgYzBvojFdRtN+Yw7NwvEwC+fIZdHNwGqH/4nYLEeYy7IHhyRkskYoQeFvupvtNHy
         9CHxhiAMSvgVDH3eztkAQsFXC3lW/0ukJPRLR4LrAWuU6bzxAwZDKZ7UniYzwUB9q7ph
         fayw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YOcmwQlKPN9MiF5h6pIEWRpv7xX2xeADc3Nuk8weeXI=;
        b=EG6cEZKjoGGhfV3GX1UkrQxQ6aFEIENO4D6KupNJdD0ezuA2GEKaNRMoJegkNH8Ef6
         XX3/UNQ1+rzRryy3kskzVqykW74Z3vp3LzAuHA+3fhxCV2psJWWKkaJvkiUwkc7ZrqU5
         j5Nlj41TM77nvcsOFQqHhfMruOKXkVBTP3YWW3wBgUu5s6wOIYTXJd4wXCtniXcfQAYD
         CfbAMyMB0UXhx8e/swZVyn3nMWLUalp5j742HtYKNksivhpwwm/XSAZ2kJ7QY94C0bw2
         reXS3Ot+zng7zGb95UKE9YySk2s076t+FBXQI/6wwAgqIYpKWUWf9RGmo4YEa3z1f/o7
         kphA==
X-Gm-Message-State: AJcUukeGnx+Mcimc74WJ0kGkypaePI4dYUVlSJlFpay7Dr9QhCTBHLzR
        YB0BOzGiVb3pL1cN8J43maQ=
X-Google-Smtp-Source: ALg8bN7JQ6pGzxAoezBg+e0GF/yCM6uB4Y0pBY3pgIJL2KEUqaF2KBj27M/wOQhGiL2QOk8Onv1R8w==
X-Received: by 2002:a17:902:6909:: with SMTP id j9mr22120187plk.196.1548699983044;
        Mon, 28 Jan 2019 10:26:23 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id s190sm45252222pfb.103.2019.01.28.10.26.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 10:26:22 -0800 (PST)
Date:   Mon, 28 Jan 2019 10:26:20 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stefan Agner <stefan@agner.ch>
Cc:     arnd@arndb.de, peng.fan@nxp.com, linux-imx@nxp.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] input: keyboard: allow to select IMX SNVS Power Key
 driver for i.MX 7D
Message-ID: <20190128182620.GB30191@dtor-ws>
References: <20190128160305.22398-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190128160305.22398-1-stefan@agner.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 05:03:05PM +0100, Stefan Agner wrote:
> The i.MX SNVS Power Key driver supports the i.MX 7D SoC family too.
> Allow to enable the i.MX SNVS Power Key driver even if only i.MX 7D
> SoC is selected.
> 
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Applied, thank you.

> ---
>  drivers/input/keyboard/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/Kconfig b/drivers/input/keyboard/Kconfig
> index 4713957b0cbb..a878351f1643 100644
> --- a/drivers/input/keyboard/Kconfig
> +++ b/drivers/input/keyboard/Kconfig
> @@ -420,7 +420,7 @@ config KEYBOARD_MPR121
>  
>  config KEYBOARD_SNVS_PWRKEY
>  	tristate "IMX SNVS Power Key Driver"
> -	depends on SOC_IMX6SX
> +	depends on SOC_IMX6SX || SOC_IMX7D
>  	depends on OF
>  	help
>  	  This is the snvs powerkey driver for the Freescale i.MX application
> -- 
> 2.20.1
> 

-- 
Dmitry
