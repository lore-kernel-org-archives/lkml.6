Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB407C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D80521533
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 03:31:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="d0XbPrB8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D80521533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389138AbeIUJSS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 05:18:18 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33471 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389062AbeIUJSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 05:18:17 -0400
Received: by mail-lj1-f194.google.com with SMTP id s12-v6so10304796ljj.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 20:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FBvYhUCjIsEgc5oBm3P1yNzLXGgDefJRo87RvXMNTYA=;
        b=d0XbPrB8/C8wONFUualC24sMyN5+VmG8cXmdq76KFuy2FQ0VrL36DVAXgrky3sQbsN
         +ySqgXYnpRdMS3EQLlJhzLcPPp4FXuA+s3X1epoqpNRPH0Csj2SOKOOSRQlqn51zFALL
         8ByuYxVKZtjXyXuExdsoXmikL5xqCbjS/ygMY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FBvYhUCjIsEgc5oBm3P1yNzLXGgDefJRo87RvXMNTYA=;
        b=XCCtg3ETFBZMszvLJMmpVa6GlFNsGj0JdMvARTBNa8oHeTbJ8HfOIMWa+ZYEC7ns0i
         9G5VWkEVuDJ6362dI0PIXk8tN2+ffBqpZ2b134puX+QipxNs3wIGcZqv2EdJQcPVi4Kt
         vmIhw4Wnmi6CLDFbmED48vwNEXiZzJmBDCLaGJB14kLp1pTZYamf0cjmi0sVIt96i0iE
         IB2W5Iy/wm8R5EIzxq5cEYreLc+1fvtYjk/RmuBLHrr7pV1ltJP9I2IJwLMuI10D1rnn
         2Cxvnf+He1oMq/FUfYJuSkmK5JnRkrfBDnKXNk3DyRsPWPi5d3R0odWSTsJ84PokiVK1
         6sVg==
X-Gm-Message-State: APzg51DtB4GENsmCKYGQsRx8PwLmLAfBj6jA0wAYxmdhoGMthDLJV9+Z
        GSoB8XWPx6xBxDX9vFT/+bH7UA2GJ7W7FMj75ELC/Q==
X-Google-Smtp-Source: ANB0VdZwvWxzZImo0gZj3dx2yo4n1pB0DyCoe7n3fhRhOdn6H13kPRy1fylgbUv7tIwOhjk14xLyCAavDGBa9h4lrdQ=
X-Received: by 2002:a2e:5810:: with SMTP id m16-v6mr200020ljb.134.1537500687082;
 Thu, 20 Sep 2018 20:31:27 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:9045:0:0:0:0:0 with HTTP; Thu, 20 Sep 2018 20:31:26
 -0700 (PDT)
In-Reply-To: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Fri, 21 Sep 2018 11:31:26 +0800
Message-ID: <CAMz4kuJx9twJ=wM5qsucV3JH_VS-AC1aWMqpQOwAMkCuKBHLRg@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     rteysseyre@gmail.com, Bjorn Andersson <bjorn.andersson@linaro.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacek and Pavel,

On 11 September 2018 at 10:47, Baolin Wang <baolin.wang@linaro.org> wrote:
> This patch adds one new led trigger that LED device can configure
> the software or hardware pattern and trigger it.
>
> Consumers can write 'pattern' file to enable the software pattern
> which alters the brightness for the specified duration with one
> software timer.
>
> Moreover consumers can write 'hw_pattern' file to enable the hardware
> pattern for some LED controllers which can autonomously control
> brightness over time, according to some preprogrammed hardware
> patterns.
>
> Signed-off-by: Raphael Teysseyre <rteysseyre@gmail.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v11:
>  - Change -1 means repeat indefinitely.
>
> Changes from v10:
>  - Change 'int' to 'u32' for delta_t field.
>
> Changes from v9:
>  - None.
>
> Changes from v8:
>  - None.
>
> Changes from v7:
>  - Move the SC27XX hardware patterns description into its own ABI file.
>
> Changes from v6:
>  - Improve commit message.
>  - Optimize the description of the hw_pattern file.
>  - Simplify some logics.
>
> Changes from v5:
>  - Add one 'hw_pattern' file for hardware patterns.
>
> Changes from v4:
>  - Change the repeat file to return the originally written number.
>  - Improve comments.
>  - Fix some build warnings.
>
> Changes from v3:
>  - Reset pattern number to 0 if user provides incorrect pattern string.
>  - Support one pattern.
>
> Changes from v2:
>  - Remove hardware_pattern boolen.
>  - Chnage the pattern string format.
>
> Changes from v1:
>  - Use ATTRIBUTE_GROUPS() to define attributes.
>  - Introduce hardware_pattern flag to determine if software pattern
>  or hardware pattern.
>  - Re-implement pattern_trig_store_pattern() function.
>  - Remove pattern_get() interface.
>  - Improve comments.
>  - Other small optimization.
> ---

Do you have any comments for the v12 patch set? Thanks.

-- 
Baolin Wang
Best Regards
