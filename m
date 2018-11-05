Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 208DDC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4A1F2085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 14:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N1zy0Pxy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4A1F2085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729572AbeKEXuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 18:50:15 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43873 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbeKEXuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 18:50:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id y3-v6so9445308wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 06:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QccGvrQh7Yk0N0CYfBIrL6yeyGdTXixeZBLjFSeHOWI=;
        b=N1zy0PxyAIKZzLwGUOq8IHZQHg2cv1tbnrN8GfBhycZwrD0BN9zGxGKRDZGjSfk6AT
         /FutrdA629zkzzkoi+NoUByVm19fzc0U9ixjZPjsWW+qQSgRMdm5RayK1QKVWfQrpAoC
         SrwCXhxL0O2l5JXelYBDE4p4jbIUixX1Wa+WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QccGvrQh7Yk0N0CYfBIrL6yeyGdTXixeZBLjFSeHOWI=;
        b=d+2ymUdmo19TtbNIRt73tP4h2hwVAS77rAR+59kgo/FXHr36je0IzffEVjl1p0jCpv
         2O795RZN6v5A3EE54imZSAoaEvtKYSIVC7f6877PRYEWg+zKQDXLVbl+Egpqjm/KFbu3
         JszGigePqxkRiATL59B/LUENNvsGA9z38wfrT0OQ74fBtPmn7PZrC1oh/1a7VZtANVaQ
         TWhEuBb836RBn+3AhA5eT3QxURAka4d4S5ntOo8f8ImvaZ1CEACrsEn4CejqqtPrsmr3
         ENtD+54P8fLuvYirKma4cYHlBV7VqjiU8wwgXouPwd8rfzSrwcYYkgTsgE0OLvHRukDw
         Id2A==
X-Gm-Message-State: AGRZ1gKA4pcE2NNQwvHr28794WXG0bZMP7CCyTx41ecXImwAO3JKS/2H
        YrET71eCT+mtwgKHJRiX9SOhBA==
X-Google-Smtp-Source: AJdET5cMU9eepl/HHA5SW6misnK9od9xKF5vcz2TmzeF175MrKuYtR2DRQ+JMvRf+YUMCz8v185oKg==
X-Received: by 2002:adf:bf10:: with SMTP id p16-v6mr18937965wrh.235.1541428214392;
        Mon, 05 Nov 2018 06:30:14 -0800 (PST)
Received: from [192.168.0.40] (119.151.136.77.rev.sfr.net. [77.136.151.119])
        by smtp.googlemail.com with ESMTPSA id r73-v6sm36207526wmb.37.2018.11.05.06.30.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 06:30:13 -0800 (PST)
Subject: Re: [PATCH] clocksource: imx-gpt: remove unnecessary irq protection
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20181105141511.30657-1-peron.clem@gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <daf4fbee-b433-62c7-9dc6-e6fff058568d@linaro.org>
Date:   Mon, 5 Nov 2018 15:30:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181105141511.30657-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2018 15:15, Clément Péron wrote:
> shutdown and oneshot are already protected against irq interruptions
> 
> Signed-off-by: Clément Péron <peron.clem@gmail.com>
> ---

Applied, thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

