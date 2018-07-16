Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB873ECDFB3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5559520870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 02:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hbxi4Yil"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5559520870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbeGPCjo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 22:39:44 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35001 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727330AbeGPCjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 22:39:44 -0400
Received: by mail-oi0-f65.google.com with SMTP id i12-v6so71987459oik.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Jul 2018 19:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L/6QOPIzSay/S9pLtts2grLjSOzcUm8DnKcTaTMRV98=;
        b=hbxi4YilOA8kxxkrypHSjbDtOjGv022LQDKP0bHglj/UNQEC++0Q4dSyAordJN65t4
         tFAlwu4xPoGqaYn7MmaUQouQaIor6JCT7qUZSfrTKMErZG6XCByqJmU8w5uxddEKSTxX
         qnDe3NyCLmQ7guiw+QS+Z6Kpqfl9xy0LhEHEo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L/6QOPIzSay/S9pLtts2grLjSOzcUm8DnKcTaTMRV98=;
        b=KQiycylnKR2kuW97Q2hDAtus2xjj4ZBWY+E2U4yx6ieed5RZtE1lAqW6wrU94UjikG
         enAOSbxcj8ZiV4u86ciIw/6Sx0SJQgFjOXZFL/ngqBP5jhy+O6S5zPpnrW1rbDtJc+0e
         7GVbMPQ1N1epod79mWMPOEMMalsFisOsSACnoUFOXiH9snGPBHpI19IB4ujvYD/1Fob4
         R6w5PX0sglR+KhHJZnbqwCUEXV5CggwgbFVwVeyYVjoZEKvZRg83s3I2ksuIi911jOcp
         LTCtTk2xVKtQ1/5VbTp8zpyPjQ8U9q6otIrTsGkgK7uTq3g79+qJabcMAycCHR7c8smV
         1CWg==
X-Gm-Message-State: AOUpUlGnbOBkJEH0XAKyFnTyjZ68Q2LHSNvfGjdTjXYhS4U4pYVut7Qo
        rjXSsgJ5bhLIkQ0XYVy2caDTQFrovIYQH1M37B3n/w==
X-Google-Smtp-Source: AAOMgpfjUn2wEKfD6hHgQ7VHvP8TDnI2J64XFO3pD4xME+InS1vO/veazWpxk0Qz5tOvK+SKqkzk2QuHiaw4/+8C2iQ=
X-Received: by 2002:aca:5dc5:: with SMTP id r188-v6mr16593209oib.320.1531707281156;
 Sun, 15 Jul 2018 19:14:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:237a:0:0:0:0:0 with HTTP; Sun, 15 Jul 2018 19:14:40
 -0700 (PDT)
In-Reply-To: <20180714062916.GB13242@amd>
References: <a0b874372f9ccd0491b54c79ac63b41812efef56.1531460834.git.baolin.wang@linaro.org>
 <20180714062916.GB13242@amd>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Mon, 16 Jul 2018 10:14:40 +0800
Message-ID: <CAMz4ku+robho1J2CP-384r9PnfmCyN2WDdkLXAwQtkeDXUYijA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] leds: core: Introduce generic pattern interface
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 July 2018 at 14:29, Pavel Machek <pavel@ucw.cz> wrote:
>
>> @@ -446,4 +455,14 @@ static inline void led_classdev_notify_brightness_hw_changed(
>>       struct led_classdev *led_cdev, enum led_brightness brightness) { }
>>  #endif
>>
>> +/**
>> + * struct led_pattern - brigheness value in a pattern
>
> "brightness".

Will fix the typo. Thanks.

-- 
Baolin Wang
Best Regards
