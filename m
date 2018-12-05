Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E995C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C026920879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="y0H/WKgI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C026920879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbeLER1D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:27:03 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:36751 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeLER1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:27:02 -0500
Received: by mail-it1-f195.google.com with SMTP id c9so21456703itj.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Dec 2018 09:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Y0JPiAN+MBquXGfcJsu1JHXuGc4PyL3a4dgPwNvkMYo=;
        b=y0H/WKgIG3fgpLuvX1P/6QIfqMmu3n8qDBR5XkzCgiibl8hKJ0mzZ5jrA1YKg6MBP3
         fNFyqsHyzvhIz3m8MD1wXzw/0eapZy9CJyVJ2BuqUnZait/20SoOx3mHpRTE0J04ARQT
         pH+3diooIJka0Q/pjSO1pyFeg4UZpTK4B6AX3WBaushjf9RhtUGRdNtaCb6yxNpXSIKF
         rSzyuTKnnSrhIzhUfLIu6rZ2xDXC1veiBcwLLjq5xhSW4XaMFMPLjBkDRb4KIE9s0iyr
         KC6fy01zZa4IMt64xDp//xGHfUPCyqX004da1J37r8+8UmpDP5SrNA7CODEbo9RKvGSj
         fKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Y0JPiAN+MBquXGfcJsu1JHXuGc4PyL3a4dgPwNvkMYo=;
        b=DTFLCnpS7qVKOZuv3vmbuT3Eq3tVU868o2RKHisQid6s1ZPaKhGPcGpwc+EYV7zgiF
         EIqwhVRJePygNNLUHZk0JYPvYpKpBJn9cCr/qH5+dU7Fc7lfIBkXA/gPlD7vwzSpB8pM
         Uhj0CKHB4XiGLfLOsRaWlaF566m9kYlwW+sVr9q32gdKoeyXIbbvdeiUoRPxFXK2CF0e
         xSq9kro6i/uUuJEnEUu7+5IDPRfeuZu79Gwe2YE34s68HMn5TkZ64RgnLbcYyCLoF2ug
         qwzWtt6fr7yWR8nCd0Qt857IAws043guuS/fKmGLECHuZcSsrg6vrH5x0ohuu2iTWGXr
         w11w==
X-Gm-Message-State: AA+aEWbBt2Ip3OU8xaoIITgXXz+Dshr1rvOIRtbvWbN1XfnZM310slIs
        85rtmHa8RNkBMIyMLjwYtF7IkGN0gHc=
X-Google-Smtp-Source: AFSGD/XjdAwBPI21SMkwWG4mJrZXybV70GhbDKyTZP0ySTSrBTD13kc2ysIUzffRFKzqAecq7Q2qew==
X-Received: by 2002:a02:4511:: with SMTP id y17mr22357236jaa.56.1544030820781;
        Wed, 05 Dec 2018 09:27:00 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t194sm10545943iof.3.2018.12.05.09.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 09:26:59 -0800 (PST)
Subject: Re: [PATCH v6 00/14] block: always associate blkg and refcount
 cleanup
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181205171039.73066-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <4505f5f5-144d-39aa-24ac-477604c43212@kernel.dk>
Date:   Wed, 5 Dec 2018 10:26:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181205171039.73066-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/18 10:10 AM, Dennis Zhou wrote:
> Hi everyone,
> 
> This is a minor update addressing the feedback from Mike and Josef.
> 
> v6:
> 0005: Address Mike's feedback for the flush bio comment.
> 0006: Add a WARN_ONCE() for blkg fallback suggested by Josef.

Thanks Dennis, applied for 4.21.

-- 
Jens Axboe

