Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06875ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B42F7208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 07:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="a57V5Zpr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B42F7208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbeGMHoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 03:44:08 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56248 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeGMHoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 03:44:08 -0400
Received: by mail-wm0-f67.google.com with SMTP id v128-v6so7779621wme.5
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 00:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=inEJkudTgPtrZByS8gRL3z1zV6xmqVfAm7yBMtanpOY=;
        b=a57V5ZprFzphjByM0guRg4kaGBL67ADW6bWycvrt48TvA16jgG+QUParZL3ZSpawrh
         YXJ11tmWo2O/TLF6QxsTwBRpiy6pCGwJIoYjvVwhlhfGDNjFgXjZhF74HTJ83Fdevjt6
         e3tBKyEOdGf6H3OkQDBn+ZkKxxBIG/6AkjOEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=inEJkudTgPtrZByS8gRL3z1zV6xmqVfAm7yBMtanpOY=;
        b=Jadjso4q4eh33rvDHqTAIUgj7RCSEY6SAyK1E0dLw7cBrxuAZYiOjMW6h1wuXKIodt
         XgHv0RFxdrobHoGk2zjNLGhafwE7Nexz0+BqeJ7M1nX1uQzbr+rvhVmvl6qWgb+gJWWc
         Q/+OkGbwbz0Mm7WhGJtZ1iyDWbHItNDuYVjvTchVxWeoLIqZQXbfjiE/NdfShhx4FNyk
         5Rmm/df2TEo14hq5SCxcs2sO6IxS0QQh4ObipWwNQvl8FQdOLn1QFN0XFe6mLGQhNg0q
         6OEIoqdOvlWXHB6JInfD1/mT85Z/rKo+HVGA2HXNX+jjURbrviKiphdCn0BjfHCiRXhB
         ltDg==
X-Gm-Message-State: AOUpUlE50m6nybPRE8eGVtB/G4c0Ef4LlzaCT6hwLHM/3fX0RObrTAFW
        30BpuiYJ1WwUq9ULSjwuVVTZhWaJfeg=
X-Google-Smtp-Source: AAOMgpfZD3Ucww+PUZfjivtr4j7r1WUNYLewgEhCN6jHW2p+//AUkBnEkhsF5WxvlJ7B4xh7I9WBZQ==
X-Received: by 2002:a1c:1983:: with SMTP id 125-v6mr3328973wmz.79.1531467044999;
        Fri, 13 Jul 2018 00:30:44 -0700 (PDT)
Received: from dell ([2.27.167.87])
        by smtp.gmail.com with ESMTPSA id g4-v6sm19759789wrq.32.2018.07.13.00.30.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 00:30:44 -0700 (PDT)
Date:   Fri, 13 Jul 2018 08:30:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andrey Smirnov <andrew.smirnov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: Re: [PATCH 1/6] mfd: rave-sp: Remove unused defines
Message-ID: <20180713073042.GM4641@dell>
References: <20180707024108.32373-1-andrew.smirnov@gmail.com>
 <20180707024108.32373-2-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180707024108.32373-2-andrew.smirnov@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Jul 2018, Andrey Smirnov wrote:

> Remove unusded defines that are a leftover from earlier iterations of
> the driver.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: cphealy@gmail.com
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
> ---
>  drivers/mfd/rave-sp.c | 10 ----------
>  1 file changed, 10 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
