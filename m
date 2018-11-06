Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54AEC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC862085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tg7ScJWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EC862085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbeKFSBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 13:01:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:38024 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729021AbeKFSBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 13:01:09 -0500
Received: by mail-wm1-f67.google.com with SMTP id l2-v6so10636736wmh.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 00:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UfgEHqgMmSDUA7JDV2vBWKG4DJWqI1xVPli68TbIJ7I=;
        b=Tg7ScJWR1f13kv5i5hfbnzPDIoWcd6BN4/aZ1fdryhlqp5VUR81UqT/3yvh1HpPf9c
         VttPjWwW0V2WNU5x5zfeSzgRS1lMfe/PJjttPkb/VPJVk59JxX4tO3OmtGaUgUBKr45e
         aezd4dqUKitbz6ZWp2VKYj56yKVsNa2F5Q4UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UfgEHqgMmSDUA7JDV2vBWKG4DJWqI1xVPli68TbIJ7I=;
        b=gDCMPqvqVNa1IE9UuPqZsxkSKc+AIsKL9quUDSoHhhjHm+r/5c0lZC/su5sQfgOkEb
         vF9XXt3NCkaf0/gRIi3cRV51SlOrG55rYsOBKc6hp5hXzn9+mXb7PmcX4nuKBrsXWr2n
         NOBdQvGDDlxgT+Wq+6C/o6pKfLJK2laNco+LVRpfEE4XANQbMLfNFdMb0mK+Sfz4GDlS
         MfkNrvBaEuExW/6/ptpm4TVjBfwc5BcnndKrBjI6eq6RJd5AzhKjAEG3NCsXfTPjlOxc
         tHfErCGjnF/YKPuhUbOgQn50pCwBCifaNC9rX17FhXhDgru61M2aiEqRP5GQ9iL+jSjX
         gzOw==
X-Gm-Message-State: AGRZ1gLyA7kjsT/twjN+a9D+HOvfu2C/tKzLb3mm+oLtX0NLwenQx7hB
        XKiuDfHZxVcI0/srcHix0NR71A==
X-Google-Smtp-Source: AJdET5e4xlBLvfs1OZK5gMXOZDVE5NIpyffAbmd7xCPiNdCyffP5JE6IKtuNNp3R5ybECPvygkjUeg==
X-Received: by 2002:a1c:9b4e:: with SMTP id d75-v6mr1234915wme.62.1541493421242;
        Tue, 06 Nov 2018 00:37:01 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id b204-v6sm444923wmh.0.2018.11.06.00.37.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Nov 2018 00:37:00 -0800 (PST)
Subject: Re: [PATCH] MAINTAINERS: add maintainer for C-SKY drivers
To:     Guo Ren <ren_guo@c-sky.com>, marc.zyngier@arm.com, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org
References: <1541490330-11616-1-git-send-email-ren_guo@c-sky.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <d91ca1c2-f938-e122-61e8-a6f38120e3d6@linaro.org>
Date:   Tue, 6 Nov 2018 09:36:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1541490330-11616-1-git-send-email-ren_guo@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 08:45, Guo Ren wrote:
> There are two intc drivers and two clocksource drivers, also include
> related dt-bindings' documentations.
> 
> Signed-off-by: Guo Ren <ren_guo@c-sky.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>  MAINTAINERS | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f485597..fb7286a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3217,6 +3217,11 @@ T:	git https://github.com/c-sky/csky-linux.git
>  S:	Supported
>  F:	arch/csky/
>  F:	Documentation/devicetree/bindings/csky/
> +F:	drivers/irqchip/irq-csky-*
> +F:	Documentation/devicetree/bindings/interrupt-controller/csky,*
> +F:	drivers/clocksource/timer-gx6605s.c
> +F:	drivers/clocksource/timer-mp-csky.c
> +F:	Documentation/devicetree/bindings/timer/csky,*
>  K:	csky
>  N:	csky
>  
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

