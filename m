Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4999C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECF2214C5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TYmkem4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECF2214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbeIZOVP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:21:15 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:41370 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbeIZOVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:21:14 -0400
Received: by mail-io1-f67.google.com with SMTP id q4-v6so22580285iob.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HS8kCifeqHbBsveDxxv3BPwg0Rlbdx8KdB36Y6B5kfI=;
        b=TYmkem4WTLR0cqwC2Big7yZwU24j1vmgg4GjQuB69Qum8/h4vuKRpDJg9kpFNU7Z9A
         mZpMmqmQns96G3K594ykd7oCNzMqeACoQd/pXyA5a1+si5xTX+/sEyvMm3mwjXFKuV5A
         WSdCPgvYvUN4U0fjpgbOD1CWyn6U/I8Oswkb0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HS8kCifeqHbBsveDxxv3BPwg0Rlbdx8KdB36Y6B5kfI=;
        b=GEcxmZdz7/RIBY8wV8DIGB4Bqh8TfpWcQiTyOhsSlScFE7UrF33wVZ2+e4qN8lvJ29
         cOjHrbnFm7PHL/rkyfUmXzAEkyO2R9bZxq9Blgq1Ps7ORFjcZz/0wHSQupxFUKImD/XH
         TYM6uTlvfU5fbsMtM01szO/KRLHof390r5hXA0hDbp94qBKcyr0F9KHkE9nDsrjG7igD
         ZjfSzVggM9MeN+WPGaeij0Oekstcc6YTTXMQRqz104Vmw7LCv6wmqmksrhF4C05VHDV9
         LbJ0p8aLboAHL3VBc5xV5iXNStYnEblk8LUIBGy7Fpe/tq0Uja+sDNYCq4sv7TRjn8Fn
         Jmbw==
X-Gm-Message-State: ABuFfogaawQvS/7YdYKNtQtDBIXsWUkT0o/+A3AxmDyYBkPfZfF0cjQp
        FkzY1QAFsqYjClXu4XhwaqC9GShaeLdeSizLViwyiA==
X-Google-Smtp-Source: ACcGV60Z67f/mLj58258DXYxsGTXlmYeZcHlacdeGBmBLnogdn9Ow3KTVBR33szCh1hibgv89aYjCzg3qe1W8/O7l1U=
X-Received: by 2002:a6b:630a:: with SMTP id p10-v6mr4018603iog.175.1537949372316;
 Wed, 26 Sep 2018 01:09:32 -0700 (PDT)
MIME-Version: 1.0
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
 <707ebff8a188d41de374314414c8bfd927183d33.1537930252.git.baolin.wang@linaro.org>
In-Reply-To: <707ebff8a188d41de374314414c8bfd927183d33.1537930252.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 10:09:20 +0200
Message-ID: <CACRpkdYxV1OBrr6e29OTzE5QCTgt+-2yJGEuYtNM_Mw=41PSyg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] power: supply: Add Spreadtrum SC27XX fuel gauge
 unit driver
To:     Baolin Wang <baolin.wang@linaro.org>
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

On Wed, Sep 26, 2018 at 5:00 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> This patch adds the Spreadtrum SC27XX serial PMICs fuel gauge support,
> which is used to calculate the battery capacity.
>
> Original-by: Yuanjiang Yu <yuanjiang.yu@unisoc.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - Use battery standard properties to get internal resistance and ocv table.
>  - Change devm_gpiod_get_optional() to devm_gpiod_get().
>  - Add power_supply_changed() when detecting battery present change.
>  - Return micro volts for sc27xx_fgu_get_vbat_ocv().

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I see that you need to have the internal resistance as parameter to
this equation so it needs to come in. (I guess as factor/typical
internal resistance as suggested.)

IIUC this reliance on an uncertain internal resistance is the reason
why fuel gauges / coloumb counters are seen as crude ways to
estimate battery capacity, and their accuracy and reliability worsen
over the lifetime of the battery, and this is why safety-critical devices
include ways to measure the internal resistance as well.

But the hardware is as it is, and probably for some good reasons,
like cost.

Yours,
Linus Walleij
