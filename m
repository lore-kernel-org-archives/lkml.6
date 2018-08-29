Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8563AC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:23:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C4D2205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OPXHki/Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C4D2205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeH2TUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:20:49 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38138 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeH2TUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:20:49 -0400
Received: by mail-wr1-f67.google.com with SMTP id w11-v6so5213819wrc.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IY0gVEGHUPP/YC5HSvbm84AWAm9e//NAe5JPIWq0qg0=;
        b=OPXHki/QblI9+Fi5dfC2CcjezBT3V144w+NwTuUO6gJXqdI25WlcbUo5zqa+DiOnoU
         kkCBEsJFFF+Jwi7e5nGLPfayM1/hCJGUkF7J0GlnmRjjJ/2B7zh1ae3pG5hRvaprAKSi
         2U2/1GpRvYx8dVWMiWC2Tg92IEvfjS1pY7lvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IY0gVEGHUPP/YC5HSvbm84AWAm9e//NAe5JPIWq0qg0=;
        b=pqbD9kGOS8DEj0d3dWyF+DYeQkgKMuCagh35mwwLw8O/aTiQDe+TA3i8BrBEaDHj26
         zjLiZhBZ+0BAzRk+Q4Sl3xKVcOXW6F2+2szl8ejfsr3Zan8CGKPuQUAViZj1XDCE7EEG
         l323i0LfpWUqE1+1T1QtzNf0tRO8u1nH2EMouQ771w7UGLTseO80X8gAHU9byHPLXxZU
         aOIDOpA2a3g4DXWq6xpAxzDUJs5hXrNfz1svcfmL8gsEO542hgVVeoiSCk4IcIf2XTsZ
         XA/iIElYFFiLb9iBVjq6bAnnRGkuoZpJVb8NmmU8/CBAS+TAf7nz4Yq8eOtzGKfqzRTp
         7zOg==
X-Gm-Message-State: APzg51Bjx8BH/zb90U/dINxBJGvp8YeJ2UpwUbSrnHu8udMYEDev/+ZS
        uWUSWlztwH0UILSloyOAvZ6Fsg==
X-Google-Smtp-Source: ANB0VdbJ1y0vKE9pFsMbH1l1YR2pZ91RZhmmIvm5gOy43f4h0rEWgx3NELEInrDWSS9HyP1MlQ44NA==
X-Received: by 2002:adf:facf:: with SMTP id a15-v6mr4819499wrs.74.1535556201600;
        Wed, 29 Aug 2018 08:23:21 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id t9-v6sm10216719wra.91.2018.08.29.08.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 08:23:20 -0700 (PDT)
Subject: Re: [PATCH] clocksource: Convert to using %pOFn instead of
 device_node.name
To:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org
References: <20180828015252.28511-1-robh@kernel.org>
 <20180828015252.28511-13-robh@kernel.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ab53c967-c399-414e-86ef-daff04fbd56a@linaro.org>
Date:   Wed, 29 Aug 2018 17:23:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180828015252.28511-13-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2018 03:52, Rob Herring wrote:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.
> 
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Michal Simek <michal.simek@xilinx.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---

Applied for 4.20

Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

