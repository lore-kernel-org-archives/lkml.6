Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BBEC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:48:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3165E206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 20:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m3FYUOCy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726478AbfBUUsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 15:48:22 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53950 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbfBUUsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 15:48:21 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so10264413wmg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 12:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=V5alSsq1h6+bkerIheAmI9Uk+NAO2rEaGe6VpEOgjAg=;
        b=m3FYUOCyP9EwqRDWgYlnVOnMiUSaK6HsCUmRW2gqyQldZe95BN3MRVRBdxQBwR9CKE
         VRCL7L5d++zNie6Z8ut2/zpkfzpoxSBn+aWd2AtrEqfHbmTB+fpAktXsC3wBjwuD4X//
         nhkPzicvsGYsLeOxhNzL5BBD48mmndwxkSveC+J0WlbrroTJ2x+BsAjq5I4rF2CwxnkK
         jqQOZCwjJL5Xl8vLbewkhxIaMx7ve7ke12zTseySU1IKVoVpYCbS3aE04p8QEQedoS9T
         MwdY0oda3xyMANNfimuorItsfqkndpxMsbSNJ9qgVvMYTUE3LF461RtXcu3Sq5wDCljv
         gBTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=V5alSsq1h6+bkerIheAmI9Uk+NAO2rEaGe6VpEOgjAg=;
        b=m1ymGWBhBfyUpJbPkxmoNZGfmd/+XhHUfkyFzxjqYHVjp+at77wMahD3GE4DDWT8FN
         AEg1evDtId0xzIQpwTLbjgIXRBg75/mmGaLOqBllCFPN3OE830jv27HSH4PvOeUceQg+
         xoZaRp/QGeQiLzbgkiepIk0u50MWeBevUag25feVDxF4+scNcLEce8vz5ZxIagAFPE/a
         arudYqntBbqbnUb33nPV4JC1X2/xBuWaCmPKa9xxRE03hw/gzvDO+hU+1pd4dMdaupYP
         jPc+K9a51LzL0JYQRALG4gIVspEncu0fNrWxrbQ3JaN1ArLS130lzRbhEUmejNtTyxxB
         PZ6A==
X-Gm-Message-State: AHQUAubwzG4ROJAeX1Xe6l2a6VWjTMDTukwjgewo+Aq9MGKYVMHbazhD
        /jSaTXfagnFCk8jzEmac3jTVgJUEtXg=
X-Google-Smtp-Source: AHgI3IZ1kGGlmSzdLTaRCwJTFMCRYgRF61V3grSTb87yJRi4tdBcH5kV87wpPg+rR47YZmZJzFUFsw==
X-Received: by 2002:a1c:7d8b:: with SMTP id y133mr232364wmc.7.1550782099546;
        Thu, 21 Feb 2019 12:48:19 -0800 (PST)
Received: from [192.168.0.41] (222.51.92.92.rev.sfr.net. [92.92.51.222])
        by smtp.googlemail.com with ESMTPSA id c1sm21526144wrw.7.2019.02.21.12.48.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 12:48:18 -0800 (PST)
Subject: Re: [PATCH][RESEND] Make ARM_TIMER_SP804 depend on (ARM || ARM64)
To:     David Abdurachmanov <david.abdurachmanov@gmail.com>,
        tglx@linutronix.de, linux-kernel@vger.kernel.org
References: <20190221160648.29785-1-david.abdurachmanov@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <cf0a7334-c347-b254-f80d-93640f201b20@linaro.org>
Date:   Thu, 21 Feb 2019 21:48:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190221160648.29785-1-david.abdurachmanov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2019 17:06, David Abdurachmanov wrote:
> Resending to incl. a proper mailing list and maintainers (not suggested
> by scripts/get_maintainer.pl)
> 
> This is only used on arm and arm64 platforms. Other timers also seem
> to depend on (ARM || ARM64).
> 
> After I moved Fedora/RISCV kernel to 5.0.0-0.rc2 it keeps asking me to
> add CONFIG_ARM_TIMER_SP804=n to my config. This patch resolved the issue.
> 
> Signed-off-by: David Abdurachmanov <david.abdurachmanov@gmail.com>
> ---
>  drivers/clocksource/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
> index a9e26f6a81a1..7593d80e1c88 100644
> --- a/drivers/clocksource/Kconfig
> +++ b/drivers/clocksource/Kconfig
> @@ -369,7 +369,7 @@ config ARM_GLOBAL_TIMER
>  
>  config ARM_TIMER_SP804
>  	bool "Support for Dual Timer SP804 module"
> -	depends on GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP
> +	depends on (ARM || ARM64) && GENERIC_SCHED_CLOCK && CLKDEV_LOOKUP

What about adding the COMPILE_TEST option:

bool "Support for Dual Timer SP804 module" if COMPILE_TEST

but not add the ARM || ARM64 dependency ?

>  	select CLKSRC_MMIO
>  	select TIMER_OF if OF
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

