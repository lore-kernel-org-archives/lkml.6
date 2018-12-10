Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63623C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27DBC2081F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SHriinnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27DBC2081F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbeLJWBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:01:09 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43848 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727880AbeLJWBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:01:09 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so12063864wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jE3YaurLKrANqIArezdqrdA9GwVFy5uKBn/15VSkZzY=;
        b=SHriinnOqt9ex5S0cxMTAD+pHdbDn4+9eXR6TENQcTK15utM51ba53iMhb+X10ODNG
         OQD+sFhKCsHlvkZgUgQmeQ/Z0aMaYPeAXSErTNFVKBCCuJDM6PqOSZ/IZ1JyfTLK1V63
         sv2hwVJgD/nXA/8mthpGS/ftg1sg5rD9TjmM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jE3YaurLKrANqIArezdqrdA9GwVFy5uKBn/15VSkZzY=;
        b=P2fX1J3P/dXi6BhVWNoypbHcJ90ASH+q40tTA6kqcBFX/y4Ky8NkvrueJtFpYKvB8N
         hwxKEfruvcB6fijnNZrdwfhT3jYAvwicp/JdzyLyoa2uIQ64NfiRsrOaiBGTD7Qz4KLl
         JrHn+umWXHkoN+OBEUctoAfi/IsDEJoXtN56wJzqkcXz/tVsJIuccfR89CoGtnFJzISs
         0SjLsXhl2STgUCn+dXmAGvx1woi3F7Mqm9rxcvKjAjY859sUa2TsQKhvKMw3JpSPlzsN
         66QGqGwwtztUABPVKRMLhLdjiDp65i4eOEOdJS2kcoE0S/On/4R4K6Y4prupR61aH6B8
         x/bw==
X-Gm-Message-State: AA+aEWZEINCsHucHwiT/WrJRH9+YEo/SDBjQpx2qPiXuUAU6fte5Ng+O
        qMvHEiDm7OGCHGK+ArQxX24l2ipQ+Aw=
X-Google-Smtp-Source: AFSGD/VAQpzWQB/X44LNg+IzFIVbXjqSmS7EsTJmKE9017Gvrazc/ovv0hNNifkz2Bb/U/buZzNgyg==
X-Received: by 2002:adf:e54a:: with SMTP id z10mr10936985wrm.238.1544479266798;
        Mon, 10 Dec 2018 14:01:06 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id e12sm305393wmf.22.2018.12.10.14.01.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 14:01:06 -0800 (PST)
Subject: Re: [PATCH] thermal: st: fix Makefile typo
To:     Arnd Bergmann <arnd@arndb.de>, Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        David HERNANDEZ SANCHEZ <david.hernandezsanchez@st.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181210215738.2189126-1-arnd@arndb.de>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <59bfdb2c-9d60-9b32-aece-1f699515c3aa@linaro.org>
Date:   Mon, 10 Dec 2018 23:01:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181210215738.2189126-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/12/2018 22:57, Arnd Bergmann wrote:
> When STM32_THERMAL is enabled, this overrides all previously
> enabled files in the same directory, as seen from this link failure:
> 
> ERROR: "st_thermal_pm_ops" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!
> ERROR: "st_thermal_register" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!
> ERROR: "st_thermal_unregister" [drivers/thermal/st/st_thermal_syscfg.ko] undefined!
> 
> The correct syntax in Makefile requires using += instead of :=.
> 
> Fixes: 1d6931556073 ("thermal: add stm32 thermal driver")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>  drivers/thermal/st/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/st/Makefile b/drivers/thermal/st/Makefile
> index b2b9e9b96296..243ca7881b12 100644
> --- a/drivers/thermal/st/Makefile
> +++ b/drivers/thermal/st/Makefile
> @@ -1,4 +1,4 @@
>  obj-$(CONFIG_ST_THERMAL)		:= st_thermal.o
>  obj-$(CONFIG_ST_THERMAL_SYSCFG)		+= st_thermal_syscfg.o
>  obj-$(CONFIG_ST_THERMAL_MEMMAP)		+= st_thermal_memmap.o
> -obj-$(CONFIG_STM32_THERMAL)		:= stm_thermal.o
> \ No newline at end of file
> +obj-$(CONFIG_STM32_THERMAL)		+= stm_thermal.o
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

