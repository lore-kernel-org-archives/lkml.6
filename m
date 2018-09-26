Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BF5C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28CB32082C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 08:00:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="isOMcTQ5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28CB32082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbeIZOM0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 10:12:26 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:50825 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbeIZOMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 10:12:25 -0400
Received: by mail-it1-f194.google.com with SMTP id j81-v6so1775908ite.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 01:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BqACATKMnsXu5MClIMk0CeKzY8X21wBn/ky+o7hh2wI=;
        b=isOMcTQ5X1Hux37Oqpw7cMNsZBQrVqVuQHovmpDeWZBKTBEOo45XRUI/N4FalbohDR
         /+6oM+35/9Z2NYs7WaBqMPF65ryp2f8MQec/Ng5CtTDpC+l0xFSqlspQ5vYXAEMg+umd
         Bc6UGJV1do19K/h/CsV9SixeSgr6w1Ma7xHTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BqACATKMnsXu5MClIMk0CeKzY8X21wBn/ky+o7hh2wI=;
        b=CE0Grmzih1syZ00xqBitYvDz6vOYsW4UsGtZn1mYVL1oD0tbHWhmi0eZ0Mmn+52jbL
         vug5TzrCUbnyDTI8idgUsyroZ4aP848hF8dPtJqrZ1YA5PkgglnpXciVqECPG5ob1DMs
         jA89+WQXt1yuXFIrNhHo3ZiRFH5zPZcl+WxkOtBGdrBZfp+F0H6mbFGwHpLXZJ9erVNO
         oWC23eQlkpF1O78WeG4hZIWsM/JfW+zGrYqaky/Xv1VAgGGSl3jspDdhMf0PP4bmJdDq
         8h9kZkqRHbPWGYun5NxzCoSbAYLjc6/uqaUf88vwXYTTzchGAXJwFcCvOB0E3sg0UK7b
         d3Hw==
X-Gm-Message-State: ABuFfohZcKb4iMc58ZYHIrclg7lO7dkQOofX7MUlQykehnBpPBSEw/UR
        nrN3iyW69OrfZi8SvGai5kit0pCPdGICatEWfwETYQ==
X-Google-Smtp-Source: ACcGV61/dSlwHMTpGHkIKsJ10jY4MyLb4+rxKW9SadV4OYcGjKwPLQOc7SzFLqws3uxTUNsJRqgv+f/GPjCWC/aVYP8=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr4535661jab.87.1537948845418;
 Wed, 26 Sep 2018 01:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
In-Reply-To: <358665e3f4f9ec105dc2f8a2dc6dd98dbe761fae.1537930252.git.baolin.wang@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 26 Sep 2018 10:00:33 +0200
Message-ID: <CACRpkdY3YsXsJy0OwGYLuB+x32hbkAHum4w5KQTCGoi-OXt-QA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] power: supply: core: Introduce one property to
 present the battery internal resistance
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

On Wed, Sep 26, 2018 at 4:59 AM Baolin Wang <baolin.wang@linaro.org> wrote:

> Introduce one property to present the battery internal resistance for battery
> information.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
> Changes from v1:
>  - New patch in v2.

I'm a bit confused by the physics in this patch.

The internal resistance of a battery is not a constant in its life cycle,
this varies over the age of the battery, and the reason I thing is
chemical residuals accumulating on the anode and cathode inside
the battery and the energy storage medium aging. (Plus/minus my
ignorance about how batteries actually work.)

AFAIK the fact that the internal resistance varies is of high
importance for people developing algorithms of battery capacity
and longevity. Such that some (hardware) capacity monitors go
to great lengths to measure with high precision the current
internal resistance of the battery for their algorithms.

Sorry for making things more complex, but should it be named
"factory-internal-resistance-micro-ohms" or
"typical-internal-resistance-micro-ohms"?

Yours,
Linus Walleij
