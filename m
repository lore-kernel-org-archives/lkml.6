Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22102C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:39:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B756F26549
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 09:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hgpjI5bK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B756F26549
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753496AbeF0Jjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 05:39:32 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:38611 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752592AbeF0Jjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 05:39:31 -0400
Received: by mail-wr0-f193.google.com with SMTP id e18-v6so1325530wrs.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 02:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xSy96MQNHJMpJKvcVYXnOQs4/aUwVdNCGa8Wa0O96Y=;
        b=hgpjI5bKtE9AAZiZl0jLfrpResX29RlN1E06IuH0a9lyRE/SyfB34Cz7+wDEBXKTXh
         8wjnLMeRCdK4cBvmrRvogEcB6f7jWGhTHd7WPB9eDVNsbpE3Kf98HFIwcYBWlWUQ7d4C
         iUlM1t0aJFzW02NZPI5IWo/WLWE+pCKhPARy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xSy96MQNHJMpJKvcVYXnOQs4/aUwVdNCGa8Wa0O96Y=;
        b=rO1dJUSl1UGl3WSt59oybJSa3fo2odetU027RAOj6DGJZGDBNtcQSWxk5TZkNV5t9s
         ZdLaK2t+JQVlDo2fbcgmrG6YiPumHesUosw3yqOCH3WUryt4WrJwUQoklGNl26A7k8n0
         a2TdLxxhlNlTrNc7yJKAjsAiMGynbf5stfjlVHLzAMjgNBb9Yzm1KisPeg78urgP0G4G
         gtvZGJhDlwThQbqMrZRUkS7H0poDtlJVlZNAxIDGrdkUcfKWqTU3KFS8FX2/mJFB0NBE
         nQCGXn4e99pQl5Poy3MsScFmSdoHAZzQFAMvgyodhD3zH78Z39ngCNxwIY2q/9S6a6Go
         0Ibg==
X-Gm-Message-State: APt69E03yxzoczzBMo2SXXwk79caKEEYZsOwIPf8M0kf5wdXQ8moqVf9
        YkPdMO9tEG0DS3sPyGP4HtcO5g==
X-Google-Smtp-Source: AAOMgpeUGtfbSRsqcYquiNzAMkE2XqkFDnM4FIbA/OoIwVhdjIyzpnaE+pQi4jy16fkzldSMTIbhyA==
X-Received: by 2002:adf:b2f4:: with SMTP id g107-v6mr4598389wrd.53.1530092369859;
        Wed, 27 Jun 2018 02:39:29 -0700 (PDT)
Received: from [192.168.8.101] ([37.170.252.174])
        by smtp.googlemail.com with ESMTPSA id 13-v6sm7133629wmi.2.2018.06.27.02.39.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 02:39:28 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] clocksource/drivers/mtk_systimer: Add support for
 Mediatek SoCs
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1530086039-3763-1-git-send-email-stanley.chu@mediatek.com>
 <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2a40ec95-7352-f0c4-b394-d7b689de98ec@linaro.org>
Date:   Wed, 27 Jun 2018 11:39:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1530086039-3763-3-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/2018 09:53, Stanley Chu wrote:
> This patch adds a new clock event for the timer
> found on the Mediatek SoCs.
> 
> The Mediatek System Timer has several 32-bit timers.
> Only one timer is used by this driver as a clock event
> supporting oneshot events.
> 
> The System Timer can be run with two clocks. A 13 MHz system
> clock and the RTC clock running at 32 KHz. This implementation
> uses the system clock with no clock source divider.

Recent platforms have the arch_arm_timer and it will be always selected.

What is the benefit of adding this timer ?


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

