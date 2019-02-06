Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1BB3C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:55:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9664E2186A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:55:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Un0z7N3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730773AbfBFNzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:55:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37996 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730692AbfBFNzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:55:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id m22so2819954wml.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MXM3ziBmMKX4+HLZl6eh4etkqHwNcmVZSrPLl6IfZq8=;
        b=Un0z7N3I8Lw2Gr0AJxXP5ag28rIJN4MkZ2a/nWFY7JVfo4C39dzThELvTTYah44FEg
         /C3x8+D8iyDoMkhoqE6jNYD09vAUJfaLnI0a6Clg19RL3RA2qYDatMp6y9yU24OCpJNb
         VSoMw50a4uvs+xGXblt9CtKezoMXdMnQk7qFkBwIiEENedaDN+p9qYB11PKYQKPmIcdo
         qMxTBijlZYgk9K34FE8snJPkD3xL6ba4ZD8dU5Ou9IGhw3+1ULbL78hpJbdbtqao06v/
         xOuWmdS5br0yO/z2EBYD912jN556LkEeQefYU7XTQZaJJbwb+R+rwHiN11k7xWvRvu4v
         L0PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MXM3ziBmMKX4+HLZl6eh4etkqHwNcmVZSrPLl6IfZq8=;
        b=TftZ1FmNTwNNd03hz2p3SLdq0oSuN/hq8c9EauzDGlZuy5euOgfkm6JnEwx8Fsu2wS
         5q/SsvESnuMM+RTNQfDtqMxCFnSw2nE0N77lPcKqJldETkpjf5/W7lsvvWSLcBk+OYaE
         Io93FPOfM8DgXusqnMhC4FiBZFtNi4j32VGK+lRWByACmWnGTKGYd3InLtDnqRhFoOOu
         U6RGWFrGwvAOarwWBB5iuT63Htfc8PW6dLrfcrqM3VLPd8tk2nauOtx3AUvgHT7bllwJ
         KTZ8B1J6QIltMtosShbim/XJIrNlYNJlKU7oAlkjIO4VlEmU3QPI/m4BZ85BdxknaLsN
         Xnmw==
X-Gm-Message-State: AHQUAubosERWbJklZn2YoqcK41IhR+5ncISPsfVYnw9oIfiDR1c3Dpdt
        G9zyWvMZWWK0ikhmFtMo3Ci7fg==
X-Google-Smtp-Source: AHgI3IYbg5dsKyjmCzd5I/RZJBaYkTU3EA1XckkceeaO7epK7uDbkNdovA5c+2OojUbqPFqfybmEuw==
X-Received: by 2002:a7b:c442:: with SMTP id l2mr3346697wmi.140.1549461309826;
        Wed, 06 Feb 2019 05:55:09 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id e2sm4316823wrw.35.2019.02.06.05.55.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Feb 2019 05:55:08 -0800 (PST)
Subject: Re: [PATCH v1 1/4] clk: qcom: smd: Add XO clock for MSM8998
To:     Stephen Boyd <sboyd@kernel.org>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        bjorn.andersson@linaro.org, mturquette@baylibre.com
Cc:     marc.w.gonzalez@free.fr, andy.gross@linaro.org,
        david.brown@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1548866102-30224-1-git-send-email-jhugo@codeaurora.org>
 <1548866144-30265-1-git-send-email-jhugo@codeaurora.org>
 <154940408967.169292.15276398799323074789@swboyd.mtv.corp.google.com>
 <6e62a49a-fdb1-a087-fe83-e86aed969ae7@codeaurora.org>
 <154940592132.169292.15811923452101983358@swboyd.mtv.corp.google.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <40ae31ba-7464-22c2-5782-a225d0f17b3b@linaro.org>
Date:   Wed, 6 Feb 2019 15:55:08 +0200
MIME-Version: 1.0
In-Reply-To: <154940592132.169292.15811923452101983358@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeffrey,

On 2/6/19 00:32, Stephen Boyd wrote:
> Quoting Jeffrey Hugo (2019-02-05 14:15:16)
>> On 2/5/2019 3:01 PM, Stephen Boyd wrote:
>>> Quoting Jeffrey Hugo (2019-01-30 08:35:44)
>>>> The XO clock generally feeds into other clock controllers as the parent
>>>> for a lot of clock generators.
>>>>
>>>> Fixes: 6131dc81211c (clk: qcom: smd: Add support for MSM8998 rpm clocks)
>>>> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
>>>
>>> We've historically left out the XO clk because it causes problems where
>>> the XO vote goes away during late init because nobody references it from
>>> the rest of the clk tree and also because RPM defers probe of the system
>>> and then the console blows up when it gets a clk that can't change rate.
>>> See commit 54823af9cd52 ("clk: qcom: Always add factor clock for xo
>>> clocks") for some more info on why we removed all the workarounds and
>>> stuff around here too.
>>>
>>> So are you sure this is OK to do?
>>>   
>>>
>>
>> So, I've got pretty much everything as modules, and I haven't seen any 
>> issues.  However let me take a look at the commit you point out and see.
>>
> 
> Is the name of the clk "xo_clk_src"? That isn't the name that we were
> expecting the XO clk from RPM to be called. You might have to look back
> at the history of the rpm clk driver on the list and see when Georgi
> dropped the XO clk from it and if there was anything wrong with that. I
> can't recall if this was discussed on the list or if he just told me in
> some hallway conversation at Connect.

The problem back then was the following: The RPM clock driver has
various dependencies on other drivers (hwspinlock, smem, smd, rpmsg etc)
and may probe defer multiple times during boot. Meanwhile the GCC clocks
are registered as orphans, as their parent clock (RPM XO) is not there
yet. And when some driver calls clk_get_rate() on an orphan clock, a
bogus rate is returned. The consequence of this was that the serial
console was broken, because of the baud rate being calculated based on
this bogus clock rate.

Thanks,
Georgi
