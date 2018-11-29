Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1980CC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D410821019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EkFVLZMa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D410821019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeK3BQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:16:09 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34714 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbeK3BQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:16:09 -0500
Received: by mail-wr1-f66.google.com with SMTP id j2so2062155wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 06:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=TIMzsWiuFXNQn+25PMCI//XNjDk8aXC2Z+rFkgxvJII=;
        b=EkFVLZMaHBzN9S2e1A/U2ZbqKTG6FSXB2hIHii0QldQ289MrYyzCRysJr7nX2vxY9u
         OGZCksnbudHfK4OdqQdXeSXfA3J6yB1ctvMPCfEMjnBkAIFMzq6ReqmQC8zvsWupH1yh
         cPCfKQFrNf31O+Y+ZcZoLO3grR4Kvb0djErAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TIMzsWiuFXNQn+25PMCI//XNjDk8aXC2Z+rFkgxvJII=;
        b=uL8MYORE0WfcuukTEfiNyyOIvzCdMT57iRn1kisoXTxQV+eZSkqysgCrttrMfa46s6
         MwcX4H9nEFgCoabwTxHGu+M8xn+6hOtGP5KGPcHCbTPWDeRi3RRZxHp/DUbtM/1L69yv
         F+MVWRZGcJEmjHiMLHBsYH/DUnX+4WXuKognBi9TcNZMdOmS6Gd1s2SuFi1+ASJyI4qV
         0F2kpNN6Ia73XRIr6iHs1zpkE5RTM21Jynk0KRO+dHUx8UGzk4jDfskx/5RvS/yl/E0c
         1JA/jVLsTFXh7+uyUbD1bOYG6PLx8q+JFsQQcigvgbU50mNUOQsJOWDc/S/bMkAEk7hD
         S9kQ==
X-Gm-Message-State: AA+aEWaWAE9jJ7CCP90w/BcnBQC0hl1O5u/FhfuRGOWnfkn3QDwk/yUA
        BvqE35Z4JJkrzzAwkGM7+Kdebg==
X-Google-Smtp-Source: AFSGD/XA01RUSd+sBzsDJhS8CCWdn2+vMePBKxNOYT4hgJAdGX4V3IHSz2/K44Sk32UAcYfcgZagYw==
X-Received: by 2002:adf:e911:: with SMTP id f17mr1663595wrm.126.1543500638593;
        Thu, 29 Nov 2018 06:10:38 -0800 (PST)
Received: from [192.168.86.29] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id e19sm4644695wrc.25.2018.11.29.06.10.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 06:10:37 -0800 (PST)
Subject: Re: [RFC PATCH v3 3/4] irqchip: gic-v3: Add quirk for msm8996 secured
 registers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     marc.zyngier@arm.com, sudeep.holla@arm.com, tglx@linutronix.de,
        jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, rnayak@codeaurora.org,
        sboyd@kernel.org, srini@kernel.org, nicolas.dechesne@linaro.org,
        ctatlor97@gmail.com, vkoul@kernel.org
References: <20181112103340.24702-1-srinivas.kandagatla@linaro.org>
 <20181112103340.24702-4-srinivas.kandagatla@linaro.org>
 <20181128233327.GE24969@minitux>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <86b0d75b-c604-f2ad-e147-270942e05409@linaro.org>
Date:   Thu, 29 Nov 2018 14:10:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20181128233327.GE24969@minitux>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/11/18 23:33, Bjorn Andersson wrote:
> Given that the change request introducing this restriction looks quite
> generic and that we've heard reports of other shipping platforms having
> the same restriction, could we make this slightly more generic?
> 
> I.e. dropping the MSM8996 from the flag name and perhaps use a bool
> property in devicetree to toggle the flag, instead of adding compatibles
> as we figure out which Qualcomm platforms has this restriction.
If I understand the dt compatible thing correctly. Am not expecting 
other platforms to add new compatible string. If the gic-v3 of that SoC 
is compatible with msm8996, they should be able to use the same 
compatible string!

--srini
