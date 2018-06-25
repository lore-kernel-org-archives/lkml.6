Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A747C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B9D25530
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 07:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FHsHdFdg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12B9D25530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752540AbeFYHeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 03:34:10 -0400
Received: from mail-wr0-f171.google.com ([209.85.128.171]:34578 "EHLO
        mail-wr0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752462AbeFYHeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 03:34:08 -0400
Received: by mail-wr0-f171.google.com with SMTP id a12-v6so12540843wro.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jun 2018 00:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Z3iEYKdPzUIaqgrIQXnQlNikaGL6QxHuYNuyrCN3HIw=;
        b=FHsHdFdgioaprZSd1GPBc0G4BwrH4kXSIpttW0agBaZD3j6ROu7hLGUNoW3+I/jtVY
         r5NcjT5axIYnT6CUwuLs55s61LeXjlBR7nUdEGCYT/qcSpGMBevCyvTRjAskCa07Usoi
         F7ue6AE7z00/1Jt31NjwuQ0E9hasgv5rZOp8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Z3iEYKdPzUIaqgrIQXnQlNikaGL6QxHuYNuyrCN3HIw=;
        b=grn/g+KFwFn+u/D1xSuvWpL5278H8TTp/nR92EI7twn8QJb5eKKRbQpO1ySjvjoQFs
         6+OgygOgCdhGEjD19IkdAv2fY0tYJW4dWQvaM5do1erwgpli70DCreQdpUgpEmmy23hn
         6BQQIp/96M6X5EfkJAah4KQk4AxyUnJuoGXVJ2WC3NElx6ufDX9UZFDUAxsY7kpTD/Km
         zFgxrXfdIVW/X//8jgau3TNgxkbE9wXsMftlXZPBRlc8tK+006jEKWI+o8c7ISViLVkN
         Ku+PyVnXJfNSGYsugTjGBR8mRUssNOlt4By3DXiioDwBEdQ/MwVW0PMU3zm+28bmL+LF
         KM6w==
X-Gm-Message-State: APt69E2Ri8NStyU/kd5fpCmsr0W/A5aalAsmM6LWMUg8Txo9zmykTYJt
        GWfrD6dJ0teykIMtC9vmXHNH1A==
X-Google-Smtp-Source: ADUXVKIgfvM9eGspltAYFJrssWqluAXKqitmthBzlvOfx67oEnqXkbHKEl2P1IRcBnssVDvjKzfCSw==
X-Received: by 2002:adf:8650:: with SMTP id 16-v6mr9637775wrw.73.1529912047092;
        Mon, 25 Jun 2018 00:34:07 -0700 (PDT)
Received: from [192.168.8.101] ([37.169.34.115])
        by smtp.googlemail.com with ESMTPSA id f133-v6sm7779496wme.42.2018.06.25.00.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 00:34:06 -0700 (PDT)
Subject: Re: Add system timer driver for Mediatek SoCs
To:     Stanley Chu <stanley.chu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com
References: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <dd36b094-b11c-e6ef-a0fc-b039785e74f2@linaro.org>
Date:   Mon, 25 Jun 2018 09:34:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1529910601-15005-1-git-send-email-stanley.chu@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/06/2018 09:09, Stanley Chu wrote:
> This patch adds a new driver for system timer on the Mediatek SoCs.

Please elaborate why we need yet another timer.

Is this timer present on all Mediatek platform ? Does it always co-exist
with the existing one ?




-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

