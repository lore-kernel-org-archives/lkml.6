Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD430C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A60D92147D
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 09:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="RzwevFhS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60D92147D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729303AbeKUTzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 14:55:46 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36558 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726001AbeKUTzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 14:55:45 -0500
Received: by mail-wm1-f68.google.com with SMTP id s11so4993316wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 01:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=XKmh1IIXFSmr5fNZOGb5jyyWn9hMkpJdKJVrQf69U88=;
        b=RzwevFhSFv3rHOg1ZKmKJ/AuKEEfadAV0o/zkOoWGtceIWL3clYD77Mnb/sp1Fgidh
         NKbF7UW/lorLiNURflhAPy2UJTujBzAStv0qK3c+avPBmhDJLXK8jj+khXSbWd+WJbJb
         RzIvTEyYYk4p4+hIH2VvYEjaeD9hP8u7hWCEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XKmh1IIXFSmr5fNZOGb5jyyWn9hMkpJdKJVrQf69U88=;
        b=hUA1ANI+qQDhvM5BeVlAxmGZhz69PNSgnRL9l7YsRIRn9xhOSqKpdrzDgH0gYXmUkH
         YbFKlTYLYZsze6/brYOmu09jI8wjUOBWvcsQOZjdFINhwvA9DYdYepVUlmpmxBL8nmRc
         cw6kMgH7bCd1wGXLX/GZCTZPit646quxXgRyCrSZNh66L1jFUlqzK1+Td/IWfJGqkmWR
         cQ5QHSO3HCRqQ1jpSLFbBuQRcIL4n8zPVRs6gs+dk5rcsPNj9NTTGfFpn0gEd9cJDPok
         serlGZTE17W6yatz090uHWv79kiYHhPICDi6tXhY1a64QbtZczrcreviJn0uNO3pHbeZ
         NoVA==
X-Gm-Message-State: AA+aEWaXKFjP6UmOjc0PJWFD0evP62QiOJIZhvaYzNBKm+rdzjaQi5Tl
        CqMLgS9BniF90OfkK2KElhMl3w==
X-Google-Smtp-Source: AJdET5d1NQeBQDeNIitmALwz6NpMhXlA/Bx7/5PiJ7wMHmXxcTZ9v+H44jO0dw33Yx+7in4Qi7yEJg==
X-Received: by 2002:a1c:7e8e:: with SMTP id z136mr5424570wmc.140.1542792121909;
        Wed, 21 Nov 2018 01:22:01 -0800 (PST)
Received: from [192.168.0.19] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id l3sm23153734wru.36.2018.11.21.01.22.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 01:22:01 -0800 (PST)
Subject: Re: [PATCH 1/2] ASoC: sdm845: Update slot_width for Quaternary TDM
 port
To:     Rohit kumar <rohitkr@codeaurora.org>, plai@codeaurora.org,
        bgoswami@codeaurora.org, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, rohkumar@qti.qualcomm.com
References: <1542354118-23360-1-git-send-email-rohitkr@codeaurora.org>
 <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <15985969-695c-2e5e-88b5-f798395d1319@linaro.org>
Date:   Wed, 21 Nov 2018 09:22:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <1542354118-23360-2-git-send-email-rohitkr@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 16/11/18 07:41, Rohit kumar wrote:
> Change slot_width for quaternary TDM port to 16 and
> update bclk rate for TDM and MI2S interfaces
> accordingly.
> 
> Signed-off-by: Rohit kumar <rohitkr@codeaurora.org> > ---
>   sound/soc/qcom/sdm845.c | 9 +++++----
>   1 file changed, 5 insertions(+), 4 deletions(-)
> 

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
