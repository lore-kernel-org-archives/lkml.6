Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47241ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9682087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 22:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="imuc49oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC9682087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbeGNWs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 18:48:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35526 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbeGNWs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 18:48:56 -0400
Received: by mail-wr1-f66.google.com with SMTP id a3-v6so19100751wrt.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jul 2018 15:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ewblt/VgeUoLCd+NW5hsRSZYK89ITfIlLSrua0v/TBE=;
        b=imuc49oWNh/AiiNIFpPklp4o/9FAyjKDtMT7cBZS5D73dWWFiw9ZsC4f42XKd/BSgc
         R5GwWT8jo+1YkSSU34Va5ki4e4CNbq8ruPFYBoMx0C3C0TrKX1UTiiS8WQrrhLBcyTy6
         dmtl+YbdLol3yJo6Oy/xwawyUhQ3RfaAP9IXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ewblt/VgeUoLCd+NW5hsRSZYK89ITfIlLSrua0v/TBE=;
        b=t51dvkBpXLHx42RqEH71BauaEujYu5S5ROuhnmSK/OcpKJxJMSLSbgDi0/LswMFqYF
         R3Qgvz3DUrlP+6ii1baCEkHyn/9oIVFc6JgOf0YYk8iy23OjBaUckbgvB3E2uUHGd6uc
         KMGMrv0TGtWK57WnIcAJaG96fcnnHcgcL7TejGhqvW5LIfi0s6N+tR72Ir+zs59mEGpb
         jv+ZvgKDVm/D2LEZFGbZS9jZ9eje7zYvw9wfFpHKmd/lPYPrHjkovTCegCO23SY3rPoh
         DcW3do1JFn+j5Oxifvsw26djWrYwR9uE3Kybo/HpvNn7MHdb07bmrArwBZ7AKuHxRE6U
         uL7A==
X-Gm-Message-State: AOUpUlE3LMWgNwpmR2/7JoEzPQ3GsakkCbgkdNb3t2irXb1Jz5TM8r1K
        QyWut2nbYGMrWM/6GHC2TsapvQ==
X-Google-Smtp-Source: AAOMgpdOx9FcPMbZydkmceoqcz5a3/nkmAqtIhlsmMNJ2npDM7yvlWdLxQdCWdHQBEbtcBGiXwc2Xw==
X-Received: by 2002:adf:ef8c:: with SMTP id d12-v6mr8869567wro.195.1531607303253;
        Sat, 14 Jul 2018 15:28:23 -0700 (PDT)
Received: from ?IPv6:2001:41d0:fe90:b800:509e:2a16:9989:a523? ([2001:41d0:fe90:b800:509e:2a16:9989:a523])
        by smtp.googlemail.com with ESMTPSA id y14-v6sm18966120wrq.45.2018.07.14.15.28.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 15:28:22 -0700 (PDT)
Subject: Re: [PATCH v9 1/5] clocksource/drivers/timer-mediatek: Add system
 timer bindings
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530832288-8156-1-git-send-email-stanley.chu@mediatek.com>
 <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <ee816d6f-70e9-64f2-b831-6d2c1d40f16a@linaro.org>
Date:   Sun, 15 Jul 2018 00:28:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530832288-8156-2-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/2018 01:11, Stanley Chu wrote:
> This patch adds bindings of new "System Timer" on Mediatek SoCs.
> 
> Remove RTC clock in the same time because it is not used by
> both "General Purpose Timer" and "System Timer" now.
> 
> Signed-off-by: Stanley Chu <stanley.chu@mediatek.com>
> ---

I have applied the series for 4.19.

Thanks!

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

