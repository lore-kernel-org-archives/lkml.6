Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C24CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5558A2408F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 08:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d36K3RgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5558A2408F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934451AbeGDIni (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 04:43:38 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40863 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933050AbeGDIl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 04:41:28 -0400
Received: by mail-wr0-f195.google.com with SMTP id t6-v6so4450720wrn.7
        for <linux-kernel@vger.kernel.org>; Wed, 04 Jul 2018 01:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SY0bY6e63LD/+pmaO/g2UMIUwsVRUSxVO3M4oq7KIVg=;
        b=d36K3RgBzvK/Cck64Ai6f3/XK85re9ruDhAezF4wgObdyKZRhctXrJxBzRBviFURNk
         cxGtdaNQSGaOgoHTON7uZnNB06laQlNkqQHcSAoB94KSXntnU0p/SsAsRMNgGqLNNGp7
         0sCP1ceX9gqNNbfGD2eXFcnOBKr8LX0uwjAco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SY0bY6e63LD/+pmaO/g2UMIUwsVRUSxVO3M4oq7KIVg=;
        b=MYVj2P5PHxqchipR+GXQWrR+nk4sH0WEEnnmwxE330IsX4jkw4I6zy4iZp0Z3UYOJd
         Jpp1ddBCWcpq9peZ9lagItGjNalRofwP94Hs5KKbLjTT4crJHI2vsHpVtn3L/rb2VXVp
         OwMqlWja75kO2u0DhOxsUYuGEXEBwVZrfO6fkufNcVziYY/4DzZ+ERr+fl0oHPZ4Kf+R
         MzwKw6cH1Yt3sMm6a0dn2fbnJb/l02+3B/9mlZyU7eFUugRACC+ousa5yq5QEAG15SPK
         Z9/tVr+FMVAPQ9EZvdu1DVcW4q8/l4gjk1wOFVvgHIC1DIoDI9qGu74ZqV4OGqfiwFqh
         ki+Q==
X-Gm-Message-State: APt69E2F1LhuxJ63iqoRkpx+B0TzPzvjoQVdZhQMJxJjjv1s/nSdgZYg
        Z5YxgZCCYOH+mmbckbDkSlYFBmUab6g=
X-Google-Smtp-Source: AAOMgpcbymgZKhpkHy64M5Ofp/bkHuqVKsw+7YmTwBR5bspwUcYjf0rYC1PZXdMYGXlaNKLz/FeCXw==
X-Received: by 2002:a5d:46c6:: with SMTP id g6-v6mr847435wrs.76.1530693686884;
        Wed, 04 Jul 2018 01:41:26 -0700 (PDT)
Received: from [192.168.8.101] ([37.173.73.209])
        by smtp.googlemail.com with ESMTPSA id r140-v6sm5931206wmd.27.2018.07.04.01.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 01:41:25 -0700 (PDT)
Subject: Re: [PATCH 0/2] Allwinner A64 timer workaround
To:     Samuel Holland <samuel@sholland.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Mark Rutland <Mark.Rutland@arm.com>
References: <20180511022751.9096-1-samuel@sholland.org>
 <2c16d5ab-38f7-8f3e-875c-19e8032f440a@arm.com>
 <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <439ea6ab-9834-64d5-2aff-1a4ac7e3890d@linaro.org>
Date:   Wed, 4 Jul 2018 10:41:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <bdfb1a31-2c4a-d258-7bf6-aaab8cee4663@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2018 20:42, Samuel Holland wrote:
> On 07/03/18 10:09, Marc Zyngier wrote:
>> On 11/05/18 03:27, Samuel Holland wrote:
>>> Hello,
>>>
>>> Several people (including me) have experienced extremely large system
>>> clock jumps on their A64-based devices, apparently due to the architectural
>>> timer going backward, which is interpreted by Linux as the timer wrapping
>>> around after 2^56 cycles.
>>>
>>> Investigation led to discovery of some obvious problems with this SoC's 
>>> architectural timer, and this patch series introduces what I believe is
>>> the simplest workaround. More details are in the commit message for patch
>>> 1. Patch 2 simply enables the workaround in the device tree.
>>
>> What's the deal with this series? There was a couple of nits to address, and 
>> I was more or less expecting a v2.
> 
> I got reports that people were still occasionally having clock jumps after
> applying this series, so I wanted to attempt a more complete fix, but I haven't
> had time to do any deeper investigation. I think this series is still beneficial
> even if it's not a complete solution, so I'll come back with another patch on
> top of this if/once I get it fully fixed.
> 
> I'll prepare a v2 with a bounded loop. Presumably, 3 * (max CPU Hz) / (24MHz
> timer) ≈ 150 should be a conservative iteration limit?
> 
> Also, does this make sense to CC to stable?

I understand a partial fix is better than nothing but if you can narrow
down the issue and provide patches to fix it in one shot that would be
awesome.





-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

