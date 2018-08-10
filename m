Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205CDC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA71223AF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 13:38:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMHzJvwx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA71223AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeHJQIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 12:08:49 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33402 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727767AbeHJQIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 12:08:49 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so4436701pgv.0;
        Fri, 10 Aug 2018 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJAtOyICmfBVF+2b9xRivOif51fkG1+/sq3UV/VsgYE=;
        b=mMHzJvwxGB7AXDylGbZuMBslUOOZwXnRPH4dwRAq8tQkwgvxTEPK6h06oqtlLTad4X
         maT4gqaWAuSgx98NdIZ+OJr35SXBhATGpw2Yp9jVHidRFzQHy07AcOIzdj6vwNCzWV//
         qk8TX3FeHAf26HEPRaakcU8tNAyustf98nEWgfhfpJS1FgB6tB65kdd1e3jQKKEytkOg
         MOPewg+AOns5thxhTCRchrkCCCYuS4EDKN1ocMTLz1GZIP10BNMSMpTLgH4mREbTF3zO
         ZrE/PR7LTYqbFGrRB4MOctUJ+7qsryZZJM7K4Zf/0bqhhUw8/+vV7HMVkZP/ZO+UWHRU
         F8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJAtOyICmfBVF+2b9xRivOif51fkG1+/sq3UV/VsgYE=;
        b=UzMI++1fZOvSI/SFv0UgedC/n4rWuCflRAxDr+efZqHBHsQ699k3HpuTmL5qf5htwU
         +WFVN9zo3XQt6jzIw1NDWMDgY/zMsRlB5x7d+4Dk38rWl0/u59xXdvPgJgcRVMqmwqnw
         1eTe7uqHqJnrWX6kXxYhLu9/fE0Iy9yOwctP/TvvnI5g2U9M7S0MPB19oSjD6LOjXAgl
         wgnMTsYsBE+UmSh7Rw6p9roNP/rUrv45dMfgrTRktpY9GRGKNXrktGU98Y0yWlW24iH8
         qJvw/VILeNA8MVx+O8iW3WEGFzJsCWtTdRFpRaWlH+8G+mEHATjjyX4Vh0uhVWPHktcK
         0xPg==
X-Gm-Message-State: AOUpUlF+UayMZhNUD/ePHfSFqRBiFNiDgNdGgMpVzSEEISNJnD8JmC55
        Tld+MfbTtWX0N3YBdR/rAgcBn3qz
X-Google-Smtp-Source: AA+uWPwqAfy+TcZ7ruvNU2CyF7IpyyCeJNEH1u2AOxkwgF2kTC1HvHrCAAIgIsRALm2sSsFFrVOSEg==
X-Received: by 2002:a65:6243:: with SMTP id q3-v6mr6357017pgv.273.1533908331762;
        Fri, 10 Aug 2018 06:38:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a20-v6sm19279646pfc.14.2018.08.10.06.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:38:51 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:38:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 11/24] watchdog: jz4740: Drop dependency on
 MACH_JZ47xx, use COMPILE_TEST
Message-ID: <20180810133850.GD29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-12-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 11:44:01PM +0200, Paul Cercueil wrote:
> Depending on MACH_JZ47xx prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> On other architectures, this driver can still be built, thanks to
> COMPILE_TEST. This is used by automated tools to find bugs, for
> instance.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>  v5: New patch
> 
>  v6: No change
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 834222abbbdb..13a46cfa69b0 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1475,7 +1475,7 @@ config INDYDOG
>  
>  config JZ4740_WDT
>  	tristate "Ingenic jz4740 SoC hardware watchdog"
> -	depends on MACH_JZ4740 || MACH_JZ4780
> +	depends on MIPS || COMPILE_TEST
>  	depends on COMMON_CLK
>  	select WATCHDOG_CORE
>  	select INGENIC_TIMER
> -- 
> 2.11.0
> 
