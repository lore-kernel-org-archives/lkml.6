Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B5E6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 596E2223CB
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 16:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XM3UWuvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 596E2223CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390080AbeKQCTU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 21:19:20 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33840 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbeKQCTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 21:19:20 -0500
Received: by mail-lj1-f193.google.com with SMTP id u6-v6so20776137ljd.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 08:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/LGl1kcDwTjPdhfQ+NizgCox/U/MMM6r0d41XfHMaLc=;
        b=XM3UWuvgBqmc8/pjJKu0MEDjzG/oEg6UJye4tDXS3Z/1NCeiny4NJhSHjBhRQTPfvB
         eHD7SgBcB0vrkAjfchnkORR0EJUPK7eIMo3bbY/pfiz0y+L+eyjkIRiiQtIwcUvSKgoS
         EZbuLGmRDePFw9huqpl7MgrNG6ztBB7u+87VY5HBTa0Sm9bFIEbrcfTXhnzOxyLX454K
         Zzr/M4ixG1mCujA+H0q69+xXziBH7m6nCJYrK84T0ZibWK+pDqWDQwPsPz/y+vfpf1kM
         m+Ijs6aSit+1YCufLz1XIzuHvYXVgeQWIMgxBejvEV/NJgZs53g1D/eTwPbD7pjs5zBL
         pgxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/LGl1kcDwTjPdhfQ+NizgCox/U/MMM6r0d41XfHMaLc=;
        b=IB221v2NT3bU/CzlmsmvIbi5B0dGiKzrQIZFjIQdM2U/E0a1az/3J9YWzdmXMOPKx0
         p491KL35eQi0PZQ3erKN9Ek8w3J+9iHtDBY1fTWj4gRywIJ4eI/FgHDrU1nB20lZYRVL
         DNrF9UjTlRMyfHM6G8XTpbfmVGBgwP4ko4M3cDDp6vco9qUyfz6wXEFb2Lot5lhL7+Pr
         lNmRiIN93g23xF6IiUiNL77hQWKRlguv1Lo4Qvz4p673cBOcYzm5KVCnFjO/e5dQ0q8d
         UE1iEBP9/TspaXn57Mbi/ADOSNUz0QRz1h3zBqQC67fUXciTdhpAftxzgPsFjjFRqRri
         Xl9g==
X-Gm-Message-State: AGRZ1gIA/tWNZq1OddY2uVHrXqgrP0vm0HPZiylo0NmndYiHhDx6IBHX
        meGIx6efnPaoQuOM4avkDfA=
X-Google-Smtp-Source: AFSGD/VFsQLjh6eIwevYA6hR+4r/ZFuGADNLBbiVxsLsFq+/aNKO1IiFTFJIYxn86Sdxw+9Dl9KF0Q==
X-Received: by 2002:a2e:8347:: with SMTP id l7-v6mr439250ljh.152.1542384381233;
        Fri, 16 Nov 2018 08:06:21 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id i127-v6sm1226610lji.3.2018.11.16.08.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 08:06:20 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gNgdS-0003wk-Uf; Fri, 16 Nov 2018 17:06:23 +0100
Date:   Fri, 16 Nov 2018 17:06:22 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Nishad Kamdar <nishadkamdar@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: arche-platform: Switch to the gpio
 descriptor interface
Message-ID: <20181116160622.GQ19900@localhost>
References: <20181116151740.GA12250@nishad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181116151740.GA12250@nishad>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 16, 2018 at 08:47:44PM +0530, Nishad Kamdar wrote:
> Use the gpiod interface instead of the deprecated
> old non-descriptor interface.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
> ---

Always include a change log here after the cut-off line so we know what
changed since previous versions.

Also include the patch revision in the Subject (e.g. "[PATCH v3]
staging: greybus: ...").

>  drivers/staging/greybus/arche-platform.c | 120 ++++++++---------------
>  1 file changed, 42 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> index 4c36e88766e7..a826a1835628 100644
> --- a/drivers/staging/greybus/arche-platform.c
> +++ b/drivers/staging/greybus/arche-platform.c
> @@ -8,10 +8,9 @@
>  
>  #include <linux/clk.h>
>  #include <linux/delay.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/init.h>
>  #include <linux/module.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_platform.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> @@ -45,14 +44,15 @@ enum svc_wakedetect_state {
>  
>  struct arche_platform_drvdata {
>  	/* Control GPIO signals to and from AP <=> SVC */
> -	int svc_reset_gpio;
> +	struct gpio_desc *svc_reset;
> +	struct gpio_desc *svc_sysboot;
>  	bool is_reset_act_hi;
> -	int svc_sysboot_gpio;
> -	int wake_detect_gpio; /* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */
> +	struct gpio_desc *wake_detect;
> +	/* bi-dir,maps to WAKE_MOD & WAKE_FRAME signals */

I'm not commenting on the rest, but comments never go underneath what
they apply to.

Just keep the current comment here, even if it's placement is a bit odd
and makes the line be longer than 80 cols.

Johan
