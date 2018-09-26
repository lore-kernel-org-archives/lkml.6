Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE2DC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC3382083A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:33:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QXJdkbqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC3382083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbeIZOp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:45:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46877 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727157AbeIZOp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:45:26 -0400
Received: by mail-lf1-f67.google.com with SMTP id q2-v6so12499563lfc.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sWgQF2wJUEsyW+CUeCYaTleJ3LvSVRzQqE+MmPYAtb4=;
        b=QXJdkbqi5eknCaFm1m980VPwAnhMh8TWQ8R3dvVLObJ83Soyb9a5sN71N8Ad+GLpAD
         QXZ8Axx/l10xM3hhO4OUYXjCMSlVM/ObxWj7370U4H012ULhqTLnI/5M8G5M+D2Kv2h2
         n4cOuNG2+WEk1mvav+NkccF466Q6vqIKUNUxs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sWgQF2wJUEsyW+CUeCYaTleJ3LvSVRzQqE+MmPYAtb4=;
        b=gt/vVezMS4rxBvXh5jNnfIvuR2oMKSK521eAcEVICyM37hDPQxmR2fz+XPK/IuUU+T
         kh5ug+LZLJ35Kwnsuox9WWy0lx/O6KEegmzE4r0Fe9BhljpQ+kwJ8LKHeSWJiWfX+hfN
         byOpV8bDUft9UWG2mZM6UbHFiziCuvRcdSjnU26TEkdgATikSw4uJnAWRbV+C9+YQRF4
         Svrg58x98+VTsbyw8Feyuq+kkE+2EeeyRMmZvqhLJUmGz6SFQ2Cs+l9eeg3pNMm0TVVz
         s5P6jInfGs1e/7H6+MUKAsjPVfjcudVqoXfcyzTvF5U39FHg8sBsAr7NV0pIsP+XlW09
         q0aQ==
X-Gm-Message-State: ABuFfohMo1a7VzPOEap/wq3rEfXLucarKHtgnXUoBMXCypTHQ4xvbAEA
        fuYwez9sRJUzvERbI6I+kPUgqNCvYL79z/LTw/hJrw==
X-Google-Smtp-Source: ACcGV60fwN8Ze5n/zeiRXCmx2lPFwoT2SBTIYbEBl29tBQ/RiT0baSSpsANgAQKn9Hb3yFu9OUJkwoqFGa2lQx9zYCg=
X-Received: by 2002:a19:124b:: with SMTP id h72-v6mr3290894lfi.72.1537950817022;
 Wed, 26 Sep 2018 01:33:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:95d7:0:0:0:0:0 with HTTP; Wed, 26 Sep 2018 01:33:36
 -0700 (PDT)
In-Reply-To: <CACRpkdYxV1OBrr6e29OTzE5QCTgt+-2yJGEuYtNM_Mw=41PSyg@mail.gmail.com>
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <707ebff8a188d41de374314414c8bfd927183d33.1537930252.git.baolin.wang@linaro.org>
 <CACRpkdYxV1OBrr6e29OTzE5QCTgt+-2yJGEuYtNM_Mw=41PSyg@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Wed, 26 Sep 2018 16:33:36 +0800
Message-ID: <CAMz4kuLy0inoJFav=hTmpLStMP6Tv4wHy-QQOx91z-omikXYWQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        yuanjiang.yu@unisoc.com, Mark Brown <broonie@kernel.org>,
        Craig Tatlor <ctatlor97@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 26 September 2018 at 16:09, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Wed, Sep 26, 2018 at 5:00 AM Baolin Wang <baolin.wang@linaro.org> wrote:
>
>> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
>> which is used to calculate the battery capacity.
>>
>> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>> Changes from v1:
>>  - Use battery standard properties to get internal resistance and ocv table.
>>  - Change devm_gpiod_get_optional() to devm_gpiod_get().
>>  - Add power_supply_changed() when detecting battery present change.
>>  - Return micro volts for sc27xx_fgu_get_vbat_ocv().
>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>
> I see that you need to have the internal resistance as parameter to
> this equation so it needs to come in. (I guess as factor/typical
> internal resistance as suggested.)
>
> IIUC this reliance on an uncertain internal resistance is the reason
> why fuel gauges / coloumb counters are seen as crude ways to
> estimate battery capacity, and their accuracy and reliability worsen
> over the lifetime of the battery, and this is why safety-critical devices
> include ways to measure the internal resistance as well.

Yes. Thanks for your reviewing.

>
> But the hardware is as it is, and probably for some good reasons,
> like cost.
>
> Yours,
> Linus Walleij



-- 
Baolin Wang
Best Regards
