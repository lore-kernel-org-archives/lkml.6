Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34194C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBB0E20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 01:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="IHx5Y5JW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBB0E20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbeKRLor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 06:44:47 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:45408 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeKRLor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 06:44:47 -0500
Received: by mail-wr1-f54.google.com with SMTP id v6so6585236wrr.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Nov 2018 17:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=j+83GtuUbXNA9QIzutyusPx3JuWIOhE3wWUbaOeWX50=;
        b=IHx5Y5JWI9Aes6kJT7lp5W5ePy7swMotVkq02vlZ1m8Xdhnl2CiI9NSIOJrqrTlhqn
         OqfDmiuq05c9EJLd2lk8F7dG40/SEeq9VS82gC3x2H+6ZA4VrkbgFHLy7OA1p0elX3jq
         OPeaEo97vyYB0Bz5/j41OBJlsKAI//RrhUxmI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=j+83GtuUbXNA9QIzutyusPx3JuWIOhE3wWUbaOeWX50=;
        b=JpU+TyuhKEKLWVO+bpNpqNtjMljkD7UexvzObWh16731bozyW+S9uY3bK4q5MVRm2O
         /HHQ+v9hKtmkxEKsSS/PfKNs4buEcNoRGYhyZZhO9s/UPvIt86amOGt/Wr93JaJN5T/Q
         yns3bWRTf+P/fTFxJX3ByJWIFIaONj5Hd5odf+CW5seJBThTDgMvRCFODsgGt9jgk3wu
         KLY31Saa6DnfJPN8GtvHyufusbc7IiEzbzxw5txKTYOlW2wRTRtNcTi9GucHaQqRKNLn
         vUGvXUiwSSYFdlTwY+D4KysJr/A5dLIr5onLE/QWB36tkvWhNsFmWwqUsHgb0qp7LWDM
         0Wsg==
X-Gm-Message-State: AA+aEWbyaO76tptF9UBK4l0iD5QLie+nQgoqVfLLdTsmXTfB7sgnsYX2
        896TG5XcWAzUiiyhAD1GrzJ0Q1bPo5o=
X-Google-Smtp-Source: AFSGD/VqsSpCuxjClNE0nPaX0kNb0X5synZUdBR6TzPhFJA9AxgOiFhPafax/Gld6ClCE/CBz8kavw==
X-Received: by 2002:a5d:4652:: with SMTP id j18mr4501399wrs.279.1542504369523;
        Sat, 17 Nov 2018 17:26:09 -0800 (PST)
Received: from [192.168.0.40] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id j199sm16737869wmf.13.2018.11.17.17.26.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 17 Nov 2018 17:26:08 -0800 (PST)
Subject: Re: [PATCH] clockevents/drivers/tegra20: Remove obsolete inclusion of
 <asm/smp_twd.h>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20181115100037.17706-1-geert+renesas@glider.be>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <0f432792-cdaa-e1bd-1357-326b08ce0a83@linaro.org>
Date:   Sun, 18 Nov 2018 02:26:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181115100037.17706-1-geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/11/2018 11:00, Geert Uytterhoeven wrote:
> As of commit da4a686a2cfb077a ("ARM: smp_twd: convert to use CLKSRC_OF
> init"), this header file is no longer used.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
Applied.

Thanks!

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

