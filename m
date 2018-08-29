Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E567EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 605932054F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 15:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="K5K5TN7l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 605932054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbeH2TPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 15:15:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52014 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbeH2TPI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 15:15:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id y2-v6so5681175wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 08:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k5vp2QWmWGDZnmvP3St72L04RTxHEk/ByvJ/UzqoLOM=;
        b=K5K5TN7lqq0UtUPEqQQCGp0qMpta52hvGCQ6uUtql7WN32O546L1DaFhB8X9itTvTG
         eG+boEz97nsl2UhM/yHeMwARz5AzVTkdOWgEi/rEFme1GjCkJ+eM6j9tzoWgFm/DTa2P
         fUTi0NYmHq9DH3Yw0GlvMyliZzO67dcuIq3Yc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k5vp2QWmWGDZnmvP3St72L04RTxHEk/ByvJ/UzqoLOM=;
        b=UWUjIehr2na7NdBmc/9MTvl8XZSTfWNluvKkeWahzGlOQsheZjdAX9PBsEsUv8Bw30
         XAfE2mTsKA0tQTLKFaQNG/CQy778UanHkwwlqKW9MuoPsXNV26mcQPypZhmn6ITntODc
         RB8hE5ysyJrK4eWPYagCJDc8UdhI84ccY2vXu5db7Yhj7+B5566cDkhqOU9WRuRz66za
         fkC8TA3iJS9axS+ilxPw+CGKyIf0okRR60epDsf5w+GPfZlsqRCnHVr6GRPGC6BaD44s
         bznajGh4VMZVmXkSYvuKuX1pJOC1XtDacwC+48RB3g0FjCe/Yvn8bCrNdmLZ0Usfo1fv
         6eMw==
X-Gm-Message-State: APzg51AV5L9F19moD9VemFfllnL0rnZNafOsOLpOVDafcW6V0WsyBlu5
        GO7RsdWS5AF501VWxTvchlZU0Q==
X-Google-Smtp-Source: ANB0VdaDslWqGy/SZG03jBs1Pvzh6ozOhPbqgYyiuD+Ix0Ij77MiV6/QDA4cjftP3PPBkrrVOcE5ZQ==
X-Received: by 2002:a1c:b84e:: with SMTP id i75-v6mr4264956wmf.158.1535555862447;
        Wed, 29 Aug 2018 08:17:42 -0700 (PDT)
Received: from [192.168.0.22] (sju31-1-78-210-255-2.fbx.proxad.net. [78.210.255.2])
        by smtp.googlemail.com with ESMTPSA id r1-v6sm4025395wmg.9.2018.08.29.08.17.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Aug 2018 08:17:41 -0700 (PDT)
Subject: Re: [PATCH v2] clocksource: ti-32k: Add CLOCK_SOURCE_SUSPEND_NONSTOP
 flag for non-am43 SoCs
To:     Keerthy <j-keerthy@ti.com>, tglx@linutronix.de
Cc:     lokeshvutla@ti.com, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, baolin.wang@linaro.org,
        d-gerlach@ti.com, tony@atomide.com, grygorii.strashko@ti.com,
        t-kristo@ti.com
References: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <f9d76b45-99c4-577a-64ff-7d4a0183af37@linaro.org>
Date:   Wed, 29 Aug 2018 17:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1533734099-1398-1-git-send-email-j-keerthy@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2018 15:14, Keerthy wrote:
> The 32k clocksource is NONSTOP for non-am43 SoCs. Hence
> add the flag for all the other SoCs.
> 
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Keerthy <j-keerthy@ti.com> 
> Acked-by: Tony Lindgren <tony@atomide.com>
> ---

Applied for 4.19-rc2

Thanks

  -- Daniel


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

