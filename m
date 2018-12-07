Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7C3C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133C420850
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 07:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="LE1NeIDO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 133C420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbeLGHHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 02:07:19 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42576 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbeLGHHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 02:07:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so2744384wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 06 Dec 2018 23:07:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YyiuP46WpSTE6NCGASujAWGOHyiZzgxsH10gdDzlOq8=;
        b=LE1NeIDOD32h9Au53IcKh2U9OIHGuGMDnB8losiAglLYexEgVY1qx3GFHZ+StKRlGK
         fZy57LMd6TA7TBSUqcF2FPj6cnMVAqN+Whs7pHEXNzlgTpQi/oVDvtT32+wfsW69ZXUQ
         8tyclOZ9hyWAKIYXJgDmAC5DX4DJ/398Twqp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YyiuP46WpSTE6NCGASujAWGOHyiZzgxsH10gdDzlOq8=;
        b=Eq1SGrw40S1bWPQeXhPx5ASyLr7pMrrkeyUMvwO5XynU2/QONyv3my/KrfoQRhrxmi
         VnSnCWVB74F5r+wlImWqPye/h7HOdwyj79tgYtN3vXGSIjL/1spNieGBFS+dZS0a0GYx
         VYd9EvdVjOB+HInnl5Ua0YyEKiCoWWEvquxzzQShDpqT9UjLMbNjlSvi89cP2DlCRyy4
         nZBaRuGgK/aHSRxYKnu1E7qzWKjEMCqOURwAWHdgrOQ8YvfO+AHmr2xN79qYjd7YolhP
         fxo+lkJ8Alu9NiyEQ6PskpzFyCgJiGwfNlg1eB14eCEFxOlYXZJHpuYQWNM8nJXUN6mw
         fXLg==
X-Gm-Message-State: AA+aEWZHeVNM5SHROtjHvXK/q6UmZVZghgawn8hYJJnIA3yhdAxyXHHT
        ccnAuD54gJIQxgH8nmAUjcwERQ==
X-Google-Smtp-Source: AFSGD/U24SYij1tngUhjp63JBPraJudHBYe+lavvyrkQO7veRc1vSjLV0/f0bp/379B2szpHj+baCg==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr854532wrq.175.1544166436615;
        Thu, 06 Dec 2018 23:07:16 -0800 (PST)
Received: from [192.168.0.40] (80.149.136.77.rev.sfr.net. [77.136.149.80])
        by smtp.googlemail.com with ESMTPSA id h129sm2380484wma.0.2018.12.06.23.07.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 23:07:15 -0800 (PST)
Subject: Re: [PATCH] clocksource/drivers/timer-imx-tpm: Specify clock name for
 timer-of
To:     Anson Huang <anson.huang@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     dl-linux-imx <linux-imx@nxp.com>
References: <1544162387-22980-1-git-send-email-Anson.Huang@nxp.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <28185755-ff84-df13-9e5d-53a9fcebd2a8@linaro.org>
Date:   Fri, 7 Dec 2018 08:07:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1544162387-22980-1-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2018 07:05, Anson Huang wrote:
> i.MX TPM needs "ipg" clock for register access and "per" clock for
> timer function, the driver gets "ipg" clock by searching the clock
> name, but timer-of initialization will get first clock in device
> tree TPM node since no clock name specified in of_clk, that means
> the "per" clock MUST be the first clock entry in device tree TPM
> node, this patch specifies clock name for of_clk to avoid this
> restriction, it makes TPM driver work properly with different sequence
> of clock entries in device tree TPM node.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied.

Thanks.

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

