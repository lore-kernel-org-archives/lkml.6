Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D4C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D7B72098A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="G4AgVLUB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7B72098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbeIYRbL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 13:31:11 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38575 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728421AbeIYRbL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 13:31:11 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so21335363ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 04:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=C1vtzp9N5qytn1NTTvs1cPPo4V4r95mCgGBEtEWGh30=;
        b=G4AgVLUBj1UARvuaO33IcGzb7nxaui7gzbr51Ly8BeY1KT/K0OMDGGNTDV2kZ9sKEI
         +suwuuJlAMJHf3DyvWiAteeqMSFXwpQLA4O8oV/ahXwPHyCjU1NZvlYy264JEa4F8szu
         7b9oV1xBcQiS34Jss1ZQThmCeMs0m/ubskPdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=C1vtzp9N5qytn1NTTvs1cPPo4V4r95mCgGBEtEWGh30=;
        b=S4nJWYQfAEYHCy/EU1ZZVQFT6hRgQXIBctt/Fwb0PQFO0MKlKxSd0xMwj3GJN/TDYX
         NC/wwfxtxE+I5mIDylr5pyusYrdCWaSjMjPLlr8nRUWq1SL9A0rGaqcLHFCkmFcDKv0E
         QkGF5rzsmKd7W4agSBYY1qDNgpxE1yzR6R8ukrLjAq7dVkUBM//vw/QH/HRtS3/jLQsZ
         Heg/p0TOkfuzOgNMQacvRLcc0IslMWgtl7/aLOCf2Av/Xtrk5OY/tyulOLkSPWRRs8f3
         Xm+p57+DSKkJVklMt6PWHfOLh1Dqzo5dskZtrjxAi5kCWDEFwmrtNkILbctCN++jfffD
         c9UQ==
X-Gm-Message-State: ABuFfoitYoTi78Pgj5JBKsJXwZ9ttFYptnTNG0pbHcyyO5DPWBGQAloC
        zVDSihqw5hrvHFtaUVMkIUjaZw7wrq5ZHXsRm4yW3A==
X-Google-Smtp-Source: ACcGV60gCiQD5ugx68yv/zPms82VCL+QuvxvDKq+vS6L0AFyGYY7gZRupIMVxPesct2dgnX0HekqIGkXfyWn6QexTss=
X-Received: by 2002:a2e:9d7:: with SMTP id 206-v6mr460613ljj.127.1537874644508;
 Tue, 25 Sep 2018 04:24:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Tue, 25 Sep 2018 04:24:03
 -0700 (PDT)
In-Reply-To: <20180924235452.GI2523@minitux>
References: <67ebebf02edd6d8ee42a13b139733e9cc680ea86.1536631975.git.baolin.wang@linaro.org>
 <20180924235452.GI2523@minitux>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 25 Sep 2018 19:24:03 +0800
Message-ID: <CAMz4kuL-MeTuYjADGU+ajczwtnidQ54wEgctBQN_PC28-7gszQ@mail.gmail.com>
Subject: Re: [PATCH v12 1/2] leds: core: Introduce LED pattern trigger
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>, rteysseyre@gmail.com,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 September 2018 at 07:54, Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
> On Mon 10 Sep 19:47 PDT 2018, Baolin Wang wrote:
> [..]
>> diff --git a/Documentation/ABI/testing/sysfs-class-led-trigger-pattern b/Documentation/ABI/testing/sysfs-class-led-trigger-pattern
> [..]
>> +What:                /sys/class/leds/<led>/hw_pattern
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a hardware pattern for the LED, for LED hardware that
>> +             supports autonomously controlling brightness over time, according
>> +             to some preprogrammed hardware patterns.
>> +
>> +             Since different LED hardware can have different semantics of
>> +             hardware patterns, each driver is expected to provide its own
>> +             description for the hardware patterns in their ABI documentation
>> +             file.
>> +
>> +What:                /sys/class/leds/<led>/repeat
>> +Date:                September 2018
>> +KernelVersion:       4.20
>> +Description:
>> +             Specify a pattern repeat number. -1 means repeat indefinitely,
>> +             other negative numbers and number 0 are invalid.
>> +
>> +             This file will always return the originally written repeat
>> +             number.
>
> This captures the infinite case much better, thanks!
>
> Given that 0 is described as invalid, does this imply that setting a new
> pattern the repeat will be disabled? And hence if my hardware supports
> only infinite or no-repeat setting a new pattern is the way to disable
> further repeats (rather than just setting repeat = 0)?

It won't. A new pattern setting will not affect your infinite or
no-repeat setting.

> Regardless, I believe the semantics of these two files will work fine
> for my Qualcomm LPG driver.

Thanks.

-- 
Baolin Wang
Best Regards
